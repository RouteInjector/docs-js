# Installation

This framework is based on NodeJS and AngularJS. First, be sure that you have installed the [prerequisites](./prerequisites.html). There are two
different installation mechanisms. 

The first mechanism is thought for developers that modify the framework and the second one for end-users that use it like a library.

## User Installation

A [yeoman](http://yeoman.io/) generator is [available](./generator.html) for simplifying this procedure.

Add the following dependencies in your a package.json: 

```json
{
  "name": "Example app",
  "version": "0.0.1",
  "scripts": {
    "start": "node bin/www"
  },
  "dependencies": {
    "mongoose": "LearnBoost/mongoose",
    "mongoose-injector": "http://147.83.113.200:1234/package/mongoose-injector/latest",
    "mongoose-jsonform": "http://147.83.113.200:1234/package/mongoose-jsonform/latest",
    "route-injector": "http://147.83.113.200:1234/package/route-injector/latest",
    "statusCode": "http://147.83.113.200:1234/package/statusCode/latest",
    "ejs":"*"
  }
}
```

When you install the dependencies, all the required modules will be installed.

```bash
npm install
```

You can start your application.

```bash
npm start
```

## Developer Installation

Only follow the next steps:
```bash
    git clone git@bitbucket.org:ondho/mycook-console.git
    cd mycook-console
    npm install
    cd lib/engine/public/admin
    bower install
    cd ../../../..
    cd app/mycook-console
    node bin/www
```
