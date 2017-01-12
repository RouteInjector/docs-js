# Application

This configuration file contains general setting for the application.

## Definition
* __name__: The name of the application
* __logo__: The logo of the application
* __logo__: The favicon of the application
* __statics__: Array containing an object for configure the static folders of the project. The object contains:
  * url: The url for mapping the folder
  * folder: The relative path from the application directory of the folder to be mapped

The order of the statics array is the order that will be applied in express statics.
* __view_engine__: Engine to use for frontend page rendering 
* __enableCors__: Enable Cross-Origin Resource Sharing (CORS) that enables open access across domain-boundaries
* __notFound__: How to process 404 errors. If not set, a simple JSON message is shown. If set to a URL, then you are redirected to it. If set to 'disabled' no process is done, so this behaviour can be set in main startup file (bin/www).
  
## Example
```javascript
module.exports = {
    name: "My Application",
    logo: "/assets/images/logo_small.png",
    favicon: "/assets/images/logo_small.png",
    statics: [
        {
            url: '/',
            folder: 'public'
        }
    ],
    view_engine: 'jade',
    enableCors: true
};
```

## Angular example

This configuration disables not found handler and process 404 errors in startup file. It redirects to index.html standard requests (allowing Angular routes to work) and redirects to a snapshot folder for correct SEO crawlers behaviour.  


application.js
```javascript
module.exports = {
    name: "My Application",
    logo: "/assets/images/logo_small.png",
    favicon: "/assets/images/logo_small.png",
    statics: [
        {
            url: '/',
            folder: 'public'
        }
    ],
    view_engine: 'jade',
    enableCors: true,
    notFound: 'disabled'
};
```

bin/www
```javascript
var routeinjector = require('route-injector');
var path = require('path');
var snapshotUtils 	 = require('./../utils/snapshotUtils.js');

routeinjector.start(function() {
	 snapshotUtils.startSeoTasks();

	 routeinjector.app.get("/*",  function(req, res) {
		  if(snapshotUtils.isCrawler(req)) {
			   var temp = req.url.replace('?_escaped_fragment_=/', '');
			   var route = path.join(__dirname, '..', '/snapshots', temp);
			   res.sendFile('index.html', { root: route });
		  } else {
			   var route = path.join(__dirname, '..', '/public', '/dist');
			   res.sendFile('index.html', { root: route });
		  }
	 });
});
```

TODO This behaviour can be included in a 'angular' mode?

