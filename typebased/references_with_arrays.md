# Typebased References with Arrays


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
        employees: Number
    }
```

The typebased generation will produce three new endpoints that will be like the followings:

1. *GET* **/company/:company_id/owner**
> **Result:**
```js
{
    niceName: String,
    birth: Date
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
3. *POST* **/user/:user_id/companies/owner**
> **Query:**
```js
{
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