# Adding a new REST primitive to Route Injector

This documents how the validate primitive has been added to RI. New primitives can easily be added to the framework.

## Implementing the API

In the folder /lib/engine/routeinjector/rest/ lay the different files that implement the REST primitives, typically one primitive per folder.
We have copied the get.js file to validate.js and used it as a template. The basically contain the function that will be injected for each model for providing the REST primitive.


```javascript
module.exports.getByField = function (Model) {

	 return function (req, res) {
		// This is the code to be executed when the rest primitive is called.
     }
}	 
```

The exported function is renamed to validate and the following code is added to it. It gets all the _id of the documents in the database for the given folder, and uses an async map to call the validateItem function with this id. The results of the function are put in the map that it is filtered to remove the null elements, and after all the items are processed a json is sent to the browser. Notice that the log and statusCode libraries should be used as well the gConfig object can provide additional injected information in addition to the Mongoose Model passed to the function.

```javascript
var gConfig = Model.injector();
 
Model.find({},{id:1}, function(err, results) {
	if(err) {
		log.error(err);
		res.statusCode = statusCode.InternalServerError();
		res.json(err.message);
		return res.end();
	}
 
    async.map(results, function(item, cb) {
    	validateItem(Model, item.get("_id"), cb);
    }, function(err, results) {
    	results = results.filter(function(r) { return r!=null; });
        res.json({count: results.length, data: results});
        res.end();
    });
});
```

The validateItem retrieves a Mongoose document by the id and uses the mongoose method validate() to check if the document validates all the embedded rules. The result of this function is passed to the callback of the function.

```javascript
function validateItem(Model, id, cb) {
	Model.findOne({_id: id}, function(err, r) {
		if(err) {
			log.error(err);
			res.statusCode = statusCode.InternalServerError();
			res.json(err.message);
			return res.end();
		}
		r.validate(function(err) {
			if(err) {
				cb(null, {id: id, error: err});
			} else {
				cb(null,null);
			}
		});
	});
}
```

The final result is:

```javascript
var Q = require('q');
var statusCode = require('statusCode');
var utils = require('../utils');
var async = require('async');

var injector = require('../../../');
var _ = require('lodash');
var log = injector.log;
var mongoose = injector.mongoose;

module.exports.validate = function (Model) {

    return function (req, res) {

        function validateItem(Model, id, cb) {
          Model.findOne({_id: id}, function(err, r) {
              if(err) {
                log.error(err);
                res.statusCode = statusCode.InternalServerError();
                res.json(err.message);
                return res.end();
              }
              r.validate(function(err) {
                if(err) {
                    //cb(null, {id: id, region: r.get("region"), niceName: r.get("niceName"), error: err});
                    cb(null, {id: id, error: err});
                } else {
                    cb(null,null);
                }
              });
          });
        }

        var gConfig = Model.injector();

        Model.find({},{id:1}, function(err, results) {
            if(err) {
                log.error(err);
                res.statusCode = statusCode.InternalServerError();
                res.json(err.message);
                return res.end();
            }

            async.map(results, function(item, cb) {
                validateItem(Model, item.get("_id"), cb);
            }, function(err, results) {
                results = results.filter(function(r) { return r!=null; });
                res.json({count: results.length, data: results});
                res.end();
            });
        });
    };

};
```

## Making it injectable

The previous code is functional but while not be injected automatically by RI. For adding this, the file /lib/engine/routeinjector/inject.js should be modified. The function routeMiddleware adds the diferent routes for each model. For example the following code is on charge of adding the import API:

```javascript
if (modelConf.import.disable != true) {
	var plural = modelConf.plural || path + 's';
	log.debug("Inject route: import " + plural + '/import');
	var importMiddleware = routeMiddlewares("import");
	app.post(prefix + '/' + plural + '/import', importMiddleware, importDocuments(Model));
}
```
If the model configuration does no disable the import API the plural name is calculated and a middleware is added to the application object in the POST /<model>s/import route. Notice that also the optional importMiddleware are added to the route if present. 

Adding the same behaviour for our new API is easy:

```javascript
if(modelConf.validate.disable != true) {
	var plural = modelConf.plural || path + 's';
	log.debug("Inject route: validate " + plural + '/import');
	app.get(prefix + '/' + plural + '/validate', validateDocuments(Model));
}
```

validateDocument function is required at the beginning of the file with all the other rest APIs.

```javascript
var getByField = require('./rest/get').getByField;
var post = require('./rest/post').post;
var putByField = require('./rest/put').putByField;
var deleteByField = require('./rest/delete').deleteByField;
var getNDocuments = require('./rest/search').getNDocuments;
var getNDocumentsPost = require('./rest/search').getNDocumentsPost;
var exportDocuments = require('./rest/export').export;
var importDocuments = require('./rest/import').import;
var validateDocuments = require('./rest/validate.js').validate;
```

TODO This API right now does not provide support for additional middlewares.

## Configurate the model to use it

Finally, the models in the user application should instructed to inject the validate API. This is typically done in the <app>/models/<model>/injector.js file.

```javascript
var backoffice = require('./backoffice');

module.exports = {
    id: "_id",
    path: "basic",
    plural: "basics",
    displayField: "niceName",
    extraDisplayFields: ["array","url"],
    get: { },
    post: {
        roles:["user"]
    },
    put: {
        roles:["user", "admin"]
    },
    delete: {
        roles:["user"]
    },
    search: {
        roles:["user"]
    },
    export: {
        roles:["user"]
    },
    import: {
        roles:["user"]
    },
    validate: {},
    backoffice: backoffice,
    form:{
        items:['*']
    }
};
```
Notice the "validate: {}" line that enables the validate API with default parameters.

## Adding custom ID and sharding management

Given a Model, Model.injector() retrieves the injector configuration for the specific model. This configuration includes things like different ID for a Model or sharding keys. For this specific API it is interesting that in addition to the mongoose identifier, if the user has specified an additional identifier or sharding key this information is shown also in the response JSON for easier human understanding.

```javascript
var config = Model.injector();
var additionalId = (config.id != '_id') ? config.id : undefined;
var shardKey = (config.shard && config.shard.shardKey) ? config.shard.shardKey : undefined;
```

The previous code gets the configuration and get the additional ID and sharding key. Take into account that this data is always the same for the same Model, so instead of calculating them for each request it is better to pre-calculate it outside the lambda for improving the performance:

```javascript
module.exports.validate = function (Model) {

    //HERE is faster
    var config = Model.injector();
    var additionalId = (config.id != '_id') ? config.id : undefined;
    var shardKey = (config.shard && config.shard.shardKey) ? config.shard.shardKey : undefined;

    return function (req, res) {
        //Than not HERE
        ...
    }
};
```

Finally we use this variables for adding the required information to the response JSON. Notice that the mongoose document can be also be accessed through the [ ] operator, i.e in our code r[additionalId].

```javascript
function validateItem(Model, id, cb) {
	Model.findOne({_id: id}, function (err, r) {
		if (err) {
			log.error(err);
			res.statusCode = statusCode.InternalServerError();
			res.json(err.message);
			return res.end();
		}
		r.validate(function (err) {
			if (err) {
				err.stack = undefined;
				for (var i in err.errors) {
					err.errors[i].stack = undefined;
					err.errors[i].properties = undefined;
				}
				var o = {id: id};
				if(additionalId) {
					o[additionalId] = r[additionalId];
				}
				if(shardKey) {
					o[shardKey] = r[shardKey];
				}
				o.error = err;
				cb(null, o);
			} else {
				cb(null, null);
			}
		});
	});
}
```

