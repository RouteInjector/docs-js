# Denormalization
Denormalize the references from ObjectID to plain mongo object embedded in the field.

```javascript
denormalized: {type: mongoose.Schema.Types.Mixed, ref:'User', denormalize:['login','rank']},
```
It is also recommended to enable *propagation*, i.e when the referenced model is updated, the fields denormalized will be also updated.

```javascript
denormalized: {type: mongoose.Schema.Types.Mixed, ref:'User', denormalize:['login','rank'], propagate: true},
```
Instead of Mixed types, the notation ```{}``` can also be used. So, this definition is also equivalent:

```javascript
denormalized: {type: {}, ref:'User', denormalize:['login','rank'], propagate: true},
```
## Renaming fields in denormalization

By using the fields ```source``` and target the fields in the referenced model can be renamed in the denormalized field. 

```javascript
user: {
    type: {},
    ref: "User",
    denormalize: [
      { source: "name.displayName", target: "displayName" },
      "niceName",
      "rank",
      "role",
      { source: "profile.social.web", target: "web" },
      { source: "profile.social.webName", target: "webName" },
      { source: "profile.social.instagram", target: "instagram" },
      { source: "profile.social.twitter", target: "twitter" }
    ]
 }
```

## Using non ObjectId identifiers

It is also possible to use denormalize to reference a different identifier in the referenced model. The following example uses niceName as an additional identifier.

```javascript
favorites: [{ type: String, ref: "Recipe", denormalize: "niceName" }]
```

This will be stored in the database as this:

```javascript
"favorites": [
  "arroz-con-pollo",    
  "ternera-en-salsa-strogonoff-variante"
]
```

## Plain denormalization

The ```plain``` field controls if the referenced fields are stored inside the denormalized field or outside it. Notice in the following example that displayName and rank are defined both as denormalization and fields to allow the backoffice to manage them.

```javascript
comments: [{
  _id: false,
  id: false,
  niceName: {
    type: String,
    ref: "User",
    denormalize: [
      { source: "name.displayName", target: "displayName" },
      "rank"
    ],
    plain: true,
    title: "User",
    class: "col-md-7"
  },
  date: { type: Date, class: "col-md-5" },
  displayName: { type: String, class: "hidden", readonly: true },
  rank: { type: String, class: "hidden", readonly: true },
  text: {
    type: String,
    format: "textarea",
    rows: 3,
    class: "col-md-12"
  }
}]
```
In the database this schema will be stored as following:

```javascript
[
  {
    "niceName": "user1",
    "displayName": "User One",
    "date": ISODate("2017-04-17T09:25:56.634Z"),
    "text": "Bonne recette ...",
  },
  {
    "niceName": "user2",
    "displayName": "User Two",
    "rank": "user",
    "date": ISODate("2017-10-26T09:29:40.925Z"),
    "text": "Nice recipe ...",
  }
]
```
      
      
