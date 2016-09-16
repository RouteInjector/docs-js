# Globals configuration

## Description

The globals configuration file contains a set of Booleans indicating where a part of the engine is globally accessible or not

The available components are:

* __logger__: The internal logger of the engine
* __models__: The user defined models
* __app__: The application object
* __express__: The express object (also doing require('express') is available)
* __mongoose__: The mongoose instance (also doing require('mongoose') is available)
* __env__: The environment configuration of the application
* __security__: The Security module of the engine

## Example

```javascript
module.exports = {
   logger: false,
   models: true,
   app: false,
   express: false,
   mongoose: false,
   env: false,
   security: true
};
```