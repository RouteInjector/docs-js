# Auth configuration

TALK ABOUT THE REQ.USER FIELD !!

## Login
The object login is composed by:

* __stateless__: Boolean indicating whether the auth mode is statefull or stateless (default to true: stateless)
* __key__: The field that the system will take as the _username_ field
* __password__: The field that the system will take as the _password_ field
* __model__: An array of model names indicating where the login system has to search the users or identities
* __function__ _(Optional)_: Custom function for login users. The definition of the custom funcion must be:
```javascript 
function(key, password, callback)
```
The callback must apply 3 parameters: (statusCode, outMessage, userObject)

## Oauth (GERARD)
## Crypto

## Tokens
* __token.secret__: The secret user for signing the token
* __token.fields__: The fields that the signed token will contain. These fields will be available in the application when the user is logged in
* __token.publicFields__: The fields that will be returned to the user when a success login happens
* __token.expiresInMinutes__: The expiration time in minutes of the token
* __token.logoutInMillis__: The maximum time of inactivity before the user is logged out
* __token.magicTokens__: An object containing the specific tokens that the application will always accept. For example:
```javascript
"token.magicTokens": {
   "magicToken1": {
       "name": 'admin',
       "displayName": 'admin',
       "role": 'admin'
   },
   "magicToken2": {
       "name": 'user',
       "displayName": 'user',
       "role": 'user'
   }
}
```

## Example
```javascript
module.exports = {
   login: {
       stateless: true, // Keep state (tokens and its timers) allowing logout
       key: "niceName",
       password: "password",
       model: ["User"],
       function: customLogin
   },
   crypt_key: 'encryption secret',
   sign_key: 'signing secret',
   storage: storage,
   authorize_uri: '/oauth/authorize',
   access_token_uri: '/oauth/token',
   token_expiration: 3600,
   refresh_token: true,
   persist_refreshtoken: true,
   persist_accesstoken: true,
   debug: true,
   "token.secret": "mySecret",
   "token.fields": ['_id', 'email', 'role', 'niceName'],
   "token.publicFields": ['role'],
   "token.expiresInMinutes": 1440, //Expiration time -> 1 day
   "token.logoutInMillis": 600000, //Inactivity time to force logOut -> 10 minutes
   "token.magicTokens": {
       "magicToken1": {
           "name": 'admin',
           "displayName": 'admin',
           "role": 'admin'
       },
       "magicToken2": {
           "name": 'user',
           "displayName": 'user',
           "role": 'user'
       }
   }
};
```