# Injector file
## Backend configuration
```javascript
id: "name",
path: "path",
single: false,
plural: "paths",
displayField: "title",
extraDisplayFields: ["date", "fullName"],
isSingle: false
```

## Backoffice configuration
```javascript
var backoffice = require('./backoffice.js');

//Later in the configuration json...
backoffice: backoffice
```

The object backoffice contains all the functions that are defined in dependsOn fields in the current model.

```javascript
module.exports = {
    calculateFullName: function (name, surname, send) {
        send(name + " " + surname);
    },
    calculateAge: function(birthYear, send){
        send(actualYear - birthYear);
    }
};
```

## Sharding
```javascript
shard: {
    shardKey: "languages",
    shardValues: ["es_ES","en_EN"]
}
```

## Routes
### Images
Image routes can be replaced by custom user routes.

```javascript
images:{
    get: f.getImage,
    post: f.postImage,
    delete: f.deleteImage
}
```

These routes are express routes, thus, the definition must be

```javascript
module.exports.getImage = function(req, res){
    res.end();
};
```

### REST
#### Endpoints
```javascript
get: {},
post: {},
put: {},
delete: {},
export: {},
import: {},
search: {}
``` 

##### GET
Get a single document
##### POST
Post a single document
##### PUT
Update a single document
##### DELETE
Delete a single document
##### Search API
Search inside a collection. It creates two routes:
* GET /plural
* POST /plural

The POST route enables the user to query against a mongo collection.

A basic query of a search POST is:

```javascript
{
    query: { name: 'bill'},
    limit: 10,
    skip: 10,
    sortBy: "field"
}
```

##### Export API
Export a collection

The available formats of file are:
* __CSV__: Standard CSV format
* __JSON__: A single JSON containing all the collection documents
* __JSONs ZIP__: ZIP file containing all the JSONs. Exports one JSON per document.
* __Excel__: Standard Microsoft Excel format

##### Import API
Imports a collection

The available formats of file are:
* __CSV__: Standard CSV format
* __JSON__: A single JSON containing all the collection documents
* __JSONs ZIP__: ZIP file containing all the JSONs. Exports one JSON per document.
* __Excel__: Standard Microsoft Excel format

#### Enable / Disable
Each API can be enabled or disabled by means of a boolean _disabled_. Also can be disabled if is not present in the json.

#### Access rights
If the auth module is enabled (in [environment configuration](../configuration/environment.md)) you can define the grants needed for this route or API.
For example:

```javascript
get: {},
post: {
    roles: ['user']
},
put: {
    roles: ['user']
},
delete: {
    roles: ['admin']
}
```

### Profiles
The behavior of the APIs can be modified by means of the profiles. You can define as many profiles as you need with the following syntax:

```javascript
search: {
    profiles: {
        _default: {
            //Some specific configuration
        }
    }
}
```

### Projections
Route Injector also supports Mongoose projections in order to resolve a model reference to a value. You can define it
with the following syntax:

```javascript
search: {
    profiles: {
        _default: {
            projection: ['propertyOfRefToResolve']
        }
    }
}
```

#### Database
This configuration allows the user to change different parameters of the mongo query

* __query__: An _always-present_ query in all the transactions. Also is appended to another queries if exist
* __projection__: The projection of the database output. Appended to existing projections
* __options__: The options object of the mongoose API. Appended to existing options

```javascript
search: {
    profiles: {
        _default: {
            mongo: {
                projection: {name: 1, title: 1}
            }
        }
    }
}
```
#### Hooks
The available hooks are:

* __middlewares__: Array of express middlewares that run just before the route. They must follow the syntax of an express middleware
  ```javascript
  myMiddleware = function(req, res, next){
    //Do some stuff here
    next();
  }
  ```
* __Pre database__: Array of methods executed just before the access to the database. Each method must follow the syntax below
  ```javascript
  myPreMiddleware = function(Model, req, res, next){
    //Do some stuff here
    next();
  }
  ```

* __Post database__: Array of methods executed just after the access to the database. Each method must follow the syntax below
  ```javascript
  myPostMiddleware = function(config, req, res, doc, next){
    //In config is stored the injector configuration of the route
    //Do some stuff with the doc and the configuration here
    
    // If first argument of next is not null, an error has occured
    next(null, config, req, res, doc);
  }
  ```

* __Error callbacks__: Array of methods executed when an error occurs. Each method must follow the syntax below
  ```javascript
  myErrorMiddleware = function(req, error, next){
    //Handle the error
    next();
  }
  ```

* __After send__: Array of methods executed after the response is sent to the client. Each method must follow the syntax below
  ```javascript
  myPostSendCallback = function(doc){
    //Do some stuff with the stored document "doc"
  }
  ```

The syntax for the definition of these hooks in the injector configuration file is:

```javascript
put: {
    profiles: {
        middleware: [function1, function2],
        _default:{
            pre: [function3],
            post: [function4, function5],
            error: [function6],
            postSend: [function7, function8]
        }
    }
}
```

## Tabs
TO BE REDEFINED ....
```javascript
form: {
    tabs: [
        {
            title: "General information",
            items: ["title", "name", "category"]
        },
        {
            title: 'Extra',
            items: ['date', 'fullName', 'languages']
        }
    ]
}
```

## Graphs
```javascript
graphs: [
    {
        type: 'punchcard',
        title: "User vs time",
        dateField: "date",
        groupBy: "type"
    },
    {
        type: "bargraph",
        title: "Age counter",
        groupBy: "country",
        groupMode: "select",
        query: {"age": {$exists: true},
        xAxisField: "age"
    }
]
```

## Extra actions
```javascript
 extraActions: [{
        title: "My first action",
        path: '/myfirstaction',
        method: 'POST',
        type: 'form',
        data: { mydata: 3}
    }, {
        title: "My second action",
        path: '/mysecondaction',
        method: 'GET',
    }]
```


## Complete Example

```javascript
var backoffice = require('./backoffice');
var f = require('./imageFunctions);

module.exports = {
    id: "name",
    path: "path",
    plural: "paths",
    displayField: "title",
    extraDisplayFields: ["date", "fullName"],
    isSingle: false,
    section: "My Section",
    shard: {
        shardKey: "languages",
        shardValues: ["es_ES","en_EN"]
    },
    images:{
        get: f.getImage,
        post: f.postImage,
        delete: f.deleteImage
    },
    get: {},
    post: {
        roles: ['user']
    },
    put: {
        roles: ['user']
    },
    delete: {
        roles: ['admin']
    },
    export:{
        disabled: true //Same as undefine "export"
    },
    search: {
        profiles: {
            _default: {
                mongo: {
                    projection: {name: 1, title: 1}
                }
            }
        }
    },
    form: {
        tabs: [
            {
                title: "General information",
                items: ["title", "name", "category"]
            },
            {
                title: 'Extra',
                items: ['date', 'fullName', 'languages']
            }
        ]
    },
    graphs: [
        {
            type: 'punchcard',
            title: "User vs time",
            dateField: "date",
            groupBy: "type"
        },
        {
            type: "bargraph",
            title: "Age counter",
            groupBy: "country",
            groupMode: "select",
            query: {"age": {$exists: true},
            xAxisField: "age"
        }
    ],
    extraActions: [{
            title: "My first action",
            path: '/myfirstaction',
            method: 'POST',
            type: 'form',
            data: { mydata: 3}
        }, {
            title: "My second action",
            path: '/mysecondaction',
            method: 'GET',
    }],

    backoffice: backoffice
};
```
