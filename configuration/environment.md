# Environment configuration

The _env_ folder contains different configuration files each one for each environment of the application.

Each file will be mapped with its name as an environment. Use the environment variable __RI_ENV__ for load one configuration or another. The default configuration is development (which is the file development.js)

## Database
Configuration of the Mongo database to use.
* __endpoint__: ip and port of the database
* __name__: name of the database
* __debug__: Enable or disable debug messages (from mongo)

## Bind 
Configuration about the binding of the server socket.
* __port__: The binding port of the application
  
## Images
* __path__: The root path where the images will be saved
* __cache__: The root path where the cache of the images will be saved

## Auth
Enables or disables the authorization in the application. By default, the auth mode is based on a bearer authentication based on user tokens.

## Restrictions
Restrictions allows the developer to specify black lists or white lists in models, shards or roles for each configuration. If restrictions object is not provided all items are loaded and available.

```javascript
restrictions: {
    whitelist: {
        shards: ["es_ES"],
        roles: ["user"],
        routes: ["get", "post"]
    },
    blacklist:{
        models: ['Logs', 'User']
    }
}
```

## Example
Here it is a typical configuration:

```javascript
module.exports = {
   database: {
       endpoint: "localhost:1234",
       name: "my_database",
       debug: false
   },
   bind: {
       port: 9000
   },
   images: {
       path: __dirname + "/../../image",
       cache: __dirname + "/../../image/.cache"
   },
   auth: true,
   restrictions: {
       whitelist: {
           shards: ["es_ES"],
           roles: ["user"]
       },
       blacklist:{
           models: ['Logs', 'User']
       }
   }
};
```
