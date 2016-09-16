# Backoffice configuration

This configuration file keeps specific settings for the generated backoffice.

* __itemsPerPage__: Number of elements by default in the listings.
* __assetsFolder__: 
* __loaderFile__: 
* __home__: 

```javascript
module.exports = {
    itemsPerPage: 50,
    assetsFolder: 'backoffice',
    loaderFile: 'backoffice/order.js'
    //home: 'templates/myhome.html'
};
```

TODO: This settings are really available in the backoffice.js ???

```javascript
module.exports = {
   name: 'MyCook Console',
   favicon: "/swagger/images/logo_small.png",
   logo: '/swagger/images/logo_small.png'
};

```
