# Prerequisites
## node.js
In windows the required version in node must be greater than v0.10.33 (Recommended v0.12.00 or higher). On Unix systems (Linux/Mac...) the lowest tested version is v0.10.33.
Proceed to http://nodejs.org in order to download latest stable. We know that versions 0.10.32 and 0.11.14 have some problems with mongoose connections in Windows. The v0.12.00 fixes these issues.

## npm
The required version of npm is greater than 2.0.0 in order to enable git capabilities. Depending on the node.js version, default npm will work,
if not, you can update the version with the following command:

    sudo npm -g update npm

## MongoDB
[MongoDB](http://mongodb.org) is used as a database backend. Any 2.x or superior version will work.

## bower
[Bower](http://bower.io) is used for manging the client-side dependencies. If you install in user-mode, this dependency is automatically installed by
npm. If using the developer-mode, you should install it:

    sudo npm -g install bower

