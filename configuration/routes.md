# Routes configuration
## Configuration file
This is the global configuration file for all the routes of the application

* __prefix__: The prefix (if exists) of all the auto generated routes
* __customRoutes__: An array containing the route folders that the engine should load. For more information see section [routes](../routes/custom.md)
* __customMiddlewares__: An array containing the middleware folders that the engine should load. For more information see section [routes](../routes/custom.md)

## Example
```javascript
module.exports = {
    prefix: '/api01',
    customRoutes: ['routes'],
    customMiddlewares: ['middlewares']
};
```