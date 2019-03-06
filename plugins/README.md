# Plugins

Plugins are used to override or extend Route Injector functionalities or join common use cases in a library that can be attached easily.

The capabilities of a plugin can like ones that a normal project configuration have:

 * Modify schemas of existing application models (ie: add an info field to a schema)
 * Add new Models to a project
 * Add custom routes to project
 * Add custom pages to project


First of head to [Create a Plugin](create.html)

## Initialize a plugin

Typically RI plugins are initialized in the main file of the RI application ```./bin/www```. The function ```routeinjector.loadPlugin()``` is used to load a plugin in RI. The second parameter to this function is optional and are the parameters to the plugin.

It is important to note that some predefined models from the plugin can be redefined or updated here, in special the injector.js attributes of a model. This is done in the ```routeinjector.start()``` callback.

```javascript
#!/usr/bin/env node

const routeinjector = require('route-injector');
const STORE_ACTIVE = routeinjector.config.env.store;

if (STORE_ACTIVE) {
  routeinjector.loadPlugin('ri-store', {
    modelNames: {
      "User": "Customer"
    }
  });
}

routeinjector.start(function () {
  if(STORE_ACTIVE){
    // Adds voucher.code to the injector definition of the ri-store plugin :)
    Order.injector().extraDisplayFields .push("voucher.code");
    
    // Also valid
    Order.injector().extraDisplayFields = ["state", "total", "customerValue.email", "date", "customerValue.name", "customerValue.lastName", "voucher.code"];
  }
});
```
