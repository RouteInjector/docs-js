# Custom routes
## Define a custom route
To define a custom route you have to export a function called _route_. The input parameter is a typical express router, which can be used to define custom express routes.

Remember to configure in the file config/routes.js (see [routes configuration](../configuration/routes.md)) the folders containing the custom routes. Each file should contain only one _route_ function with the custom routes
## Example of custom routes file
```javascript
module.exports.route = function(router){
    router.get('/myCustomRoute/:myParam', function(req, res){
        console.log("My param is", req.params.myParam);
        res.render('index');
    });
};
```

## Define a custom middleware
To define a custom middleware you have to export a function called _middleware_. The input parameter is a typical express application, which can be used to define custom express middlewares.

Remember to configure in the file config/routes.js (see [routes configuration](../configuration/routes.md)) the folders containing the custom middlewares. Each file should contain only one _middleware_ function with the custom middlewares
## Example of custom middleware file
```javascript
module.exports.middleware = function(application){
    application.use(function(req, res, next){
        console.log("My url is", req.url);
        next();
    });
};
```