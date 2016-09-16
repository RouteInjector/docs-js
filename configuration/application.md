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
