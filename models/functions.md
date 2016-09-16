# Functions file

The functions file is an auxiliar file to complete the definition and implementation of the functions of the schema. It is not mandatory but it is recommended for ensure the code maintainability. Hooks and methods for the model are typically programmed here.

Always this file has to be called with the parameter _schema_.

```javascript
module.exports = function (schema) {
    schema.methods.myCustomMethod = function (cb) {
        cb("Hello World");
    };
    
    schema.pre('save', function(next){
        this.myField = "Hello World";
        next();
    };
};
```

This simple example provides a aynchronous function myCustomMethod to the Mongoose model and a hook previous to the save step that adds the field 'myField'.
