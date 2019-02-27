## References

References allow to specify that a field in a model is connected to a concrete document in other collections. For example a Worker model can have a company field that "points to" or references the company where he works in the Company collection.

```javascript
company :{type: ObjectId, ref: "Company"}
``` 
In the database will be only stored the identifier of the referenced element.

```javascript
{
  "_id": ObjectId("5c7439a947d2102f88ae717a"),
  "name": "Juan",
  "surname": "Lopez",
  "company": ObjectId("5c74393347d2102f88ae7179"),
  "__v": 0
}
```
By default, RouteInjector will use the main identifier of the referenced model as identifier but in some cases you can reference a document by using other application defined [identifier](./denormalize.md#using-non-objectid-identifiers).

### Changing the default identifier

In [injector.js](./injector.md) we can control the identifier that RI uses as a default identifier, typically will be set to ```_id```, the id that Mongo uses by default in all collections.

```javascript
id: "_id"
```
It is possible to change it other field, but in this case the ```type``` attribute of the reference should match the type of the new identifier, i.e if we choose to use a String identifier:

```javascript
company :{type: String, ref: "Company"}
```
And the Company model and injector configuration must be updated accordingly.

*injector.js*
```javascript
id: "name"
```
*schema.js*
```javascript
name: {type: String, unique: true, required: true, editOnCreate: true}
```


### Limitations of the references 

Route-Injector also supports [denormalization](./denormalize.md) that in addition to the identifier, it also stores a copy of some of the fields. This allows faster queries and also some listing capabilities.

More specifically, you can use a reference, keep only the ObjectID, populate the needed fields and list them. But, you *cannot* sort on this fields because the populated fields are added later. On the other hand, if you use a denormalization, you can sort on this fields because in fact they are present in the database.

