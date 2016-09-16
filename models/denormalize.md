# Denormalization
Denormalize the references from ObjectID to plain mongo object embedded in the field.

```javascript
denormalized: {type: mongoose.Schema.Types.Mixed, ref:'User', denormalize:['login','rank']},
```
