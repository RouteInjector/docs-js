# Typebased References


Supose the following case (schemas), where a company holds the reference of the owner, which is an entrepreneur.

**Entrepreneur.js**
```js
{
        niceName: String,
        birth: Date,
}
```

**Company.js**
```js
{
        niceName: String,
        owner: {type: ObjectId, ref: 'Entrepreneur'},
        employees: Number,
        location: String
    }
```

Supose that the following entries are added into the database:

**Entrepreneur**
```js
{
    "_id": "5706768af830c3fe1022c2fd",
    "birth": "2016-04-07T15:00:00.000Z",
    "niceName": "Antonio"
}
```

**Company Yulpan**
```js
{
    "_id": "570676d298e5e50f11804011",
    "niceName": "Yulpan",
    "owner": "5706768af830c3fe1022c2fd",
    "employees": 2,
    "location": "Spain"
}
```
**Company Stainstan**
```js
{
    "_id": "570cfe5972c7f91232f9fde7",
    "niceName": "Stainstan",
    "owner": "5706768af830c3fe1022c2fd",
    "employees": 12,
    "location": "Belgium"
}
```

The typebased generation will produce three new endpoints that will be like the followings:

1. *GET* **/company/:company_id/owner**
> **Result:** This returns the owner of the company which is resolved from the id.
```js
{
    niceName: String,
    birth: Date
}
```
> **Example:** *GET* **/company/570676d298e5e50f11804011/owner**
```js
{
    "_id": "5706768af830c3fe1022c2fd",
    "birth": "2016-04-07T15:00:00.000Z",
    "niceName": "Antonio"
}
```
2. *GET* **/user/:user_id/companies/owner**
> **Result:**
```js
{
    "status": {
        "count": # Number of total in database,
        "search_count": # Number in this result
    },
    "result": [
        {
            niceName: String,
            owner: {type: ObjectId, ref: 'Entrepreneur'},
            employees: Number
        }
    ]
}
```
> **Example:** *GET* **/user/5706768af830c3fe1022c2fd/companies/owner**
```js
{
  "status": {
    "count": 2,
    "search_count": 2
  },
  "result": [{
        "_id": "570676d298e5e50f11804011",
        "niceName": "Yulpan",
        "owner": "5706768af830c3fe1022c2fd",
        "employees": 2,
        "location": "Spain"
    },
    {
        "_id": "570cfe5972c7f91232f9fde7",
        "niceName": "Stainstan",
        "owner": "5706768af830c3fe1022c2fd",
        "employees": 12,
        "location": "Belgium"
    }]
}
```
3. *POST* **/user/:user_id/companies/owner**
> **Body:**
```js
{
    "query": {
    }
}
```
> **Result:**
```js
{
    "status": {
        "count": # Number of total in database,
        "search_count": # Number in this result
    },
    "result": [
        {
            niceName: String,
            owner: {type: ObjectId, ref: 'Entrepreneur'},
            employees: Number
        }
    ]
}
```
> **Examples body:**
```js
{
    "query": {
        "niceName": {
            "$regex": "spa",
            "$options": "i"
        }
    },
    "limit": 20,
    "skip": 0
}
```
> **Examples result:**
```js
{
    "status": {
        "count": 2,
        "search_count": 1
    },
    "result": [{
        "_id": "570676d298e5e50f11804011",
        "niceName": "Yulpan",
        "owner": "5706768af830c3fe1022c2fd",
        "employees": 2,
        "location": "Spain"
    }]
}
```