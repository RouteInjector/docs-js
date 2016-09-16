# Dependencies
Depends On triggers a user-defined function when an specific field changes its value. The definition in the schema is:

```javascript
myfield: {type:String, dependsOn: {field: "name", func: "myfunc", params:['name', ‘age’]}},
```

* __myfield:__ the name of the field
* __type: String__ type of the field
* __dependsOn:__ indicates that the value of the field depends on the value of another field
* __field: ‘name’__ the field that ‘myfield’ depends on
* __func: ‘myfunc’__ function that will be executed when the field ‘name’ has changed
* __params: [‘name’,’age’]__ the input params of the function ‘myfunc’. This attribute can be an array, a single value or empty (when params is empty, the input param of the function is the field that depends on, in this case ‘name’)

The implementation of the function has to be done with exactly the same name that in the schema definition. Also the number of parameters has to be the same as defined in dependsOn plus the callback parameter “send”, which notifies the result of the field:

```javascript
module.exports.myfunc: function(name, age, send){
    send(name + “ “ + age);
}
```

Finally, the injector configuration file has to handle the functions developed by the user with the tag “backoffice”. This object has to contain the functions that dependsOn will execute.

```javascript
backoffice: require("./backoffice.js")
```
