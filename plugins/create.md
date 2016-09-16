# Plugin creation

## Step 1. Create plugin directory

The skeleton of a plugin directory is like the following tree:

```
plugin/
├── models
├── routes
├── pages
├── index.js
├── package.json
└── plugin.json
```

## Step 2. Create the package.json file

```
{
  "name": "<string>",
  "version": "<version>",
  "author": [
    {
      "name": "<string>",
      "email": "<email>"
    }
  ],
  "dependencies": { ... },
  "description": "<string>",
  "main": "index.js"
}

```


## Step 3. Create the plugin.json file

```
{
  "name": "PluginName",
  "models": "*",
  "routes": [
    "routes"
  ]
}
```

## Step 4. Plugin functions

```
// (1)
module.exports.init = function (injector, pluginConfig) {

    // (2)
    module.exports.newModel = function(modelName, schema, cb){
        ...
        return cb();
    }

    // (3)
    module.exports.preInject = function(app, cb) {
        app.get(...
        ...

        return cb();
    }

    // (4)
    module.exports.postInject = function(app, cb) {
        app.get(...
        ...
        return cb();
    }
}
```

1. **Init:** It is called just when RouteInjector is loading your plugin. The function parameters are an injector instance and the configuration you defined in bin/www
2. **New model:** Once a model calls *mongoose.model("<string>", <schema>)* this function will be called. Here you can add Mongoose plugins, middlewares or even change model schema. Call the callback once finished
3. **Pre inject:** In this function, an express *app* will be passed along with a callback. Here you can attach middlewares before RouteInjector injects the CRUD based of the Schema. Perfect for overriding or changing a route-behaviour.
4. **Post inject:** In this function, an express *app* will be passed along with a callback. Here you can attach middlewares after RouteInjector injects the CRUD based of the Schema.
