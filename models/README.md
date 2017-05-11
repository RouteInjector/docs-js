# Models

Models implement the data of your application. Each model represents an entity in your system (and in your database) for example User, Product or Order. Models in Route Injector are a mix between JSON Schema and Mongoose schemas. They store the different fields that your entity will have as well as some logic that are highly coupled with the data, for example validation. 

Depending on the complexity of your models you will need different files:

* [schema.js](./schema.md)
* [injector.js](./injector.md)
* [functions.js](./functions.md)

In addition to this files, an index.js should be in each model folder.

```
module.exports.modelName = 'User';
module.exports.collection = 'my_users';
module.exports.schema = require('./schema').getSchema();
```
This file basically loads the schema and provides basic information for the model:

* modelName: This is the name of the model. 
* schema: This is the JSON schema of the model, typically required from the schema.js file.
* collection: This optional field allows to specify the name of the Mongo collection to use. This can be used also for having two schemas that use the same collection. [This technique](http://stackoverflow.com/questions/14453864/use-more-than-one-schema-per-collection-on-mongodb) allows to generate multiple "views" from the same collection hiding the unnecessary information. 
* baseModel: This optional field can be used to generate discriminator models. See this [example](https://github.com/RouteInjector/demo-js/tree/master/demo/mo/person). 

## Relationships

Relationships between your models can be implemented with three diferent mechanisms: references, denormalized references and dependencies.

[References](./references.md) is similar to the relational concept where you store an identifier of a foreign collection in a field in your model. When you access a model you can "populate" the reference. That means, ask mongo for some/all fields of the referenced model and join this information to the JSON of the current model. This operation can be expensive on time depending on the number of references but you keep only a copy of the information so there is no possibility of inconsistency.

[Denormalization](./denormalize.md) allows to improve the performance of your system in some cases. The idea is to keep a copy of the most common fields of the referenced model in a mixed field of the model. This way when you retrieve the model typically you don't need to access the referenced model, so GET operation is typically faster. On the other hand when you modify fields on the referenced model you have to "propagate" this changes to all the denormalized copies, so updates will be more expensive. The usage of references or denormalized references will depend on the expected API usage of your model.

Finally, [dependencies](./dependencies.md) allow to make fields depend on other fields. For example if you modify the country in a form, probably the city should be modified also. Dependency mechanism tries to make this automatic in the backoffice.

In the [Howto](../howto/README.md) section you can also find some ideas of how to configure the models.
