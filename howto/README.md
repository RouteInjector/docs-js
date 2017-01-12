# How-to?

### 1. How to order the elements in the form?

In the file injector.js can be specified how the fields are rendered in the backoffice:

```
form: {
    tabs: [
        {
            title: "General information",
            items: ["title", "name", "category"]
        },
        {
            title: 'Extra',
            items: ['date', 'fullName', 'languages']
        }
    ]
}
```
When this form parameter is not set, all the fields are shown in the same order that they are defined the schema. If present, tabs field specify the upper tabs to separate the fields when they are many in the model. If a field is not specified in the items, then the field is not shown.

This configuration also allows to generate bootstrap rows.

```
form: {
    tabs: [
        {
            title: "General information",
            items: [["title", "name"], "category"]
        },
        {
            title: 'Extra',
            items: ['date', 'fullName', 'languages']
        }
    ]
}
```

In this second example, title and name are rendered in their own bootstrap row (notice the extra [ .. ]).


### 2. How to add a title to an array or object field in a model?

Go to the injector.js file and add a key in the form like:

```javascript
[
  ...
	{key:"array", title: "This is the title of the array"},
  ...
]
```

### 3. How to add extra html in the form?

Also in the injector.js file add:

```javascript
[
  ...
	{type: "help", helpvalue: "<h4>Download app</h4>"}]
  ...
]
```

### 4. How to set the height of the tiny mce editor:

In schema.js, we can add the configuration of tinymce. Next a typical one is shown:

```javascript
..
var commonTinyCfg = {
        valid_elements: 'p[id|name|class],b[id|name|class],a[id|name|href|rel|title|target],strong[id|name],' +
        'h1[id|name],h2[id|name],h3[id|name],h4[id|name],h5[id|name],h6[id|name],' +
        'table[id|name],tr[id|name],td[id|name],thead[id|name],tfooter[id|name],tbody[id|name],' +
        'img[src|alt|title|width|height|name|class],' +
        'ul[id|name],ol[id|name],li[id|name],em[id|name],iframe[src|width|height|name|align|frameborder|allowfullscreen]',
        entity_encoding: "raw",
        style_formats_merge: true,
        content_css: "css/my_css.css",
        style_formats: [{
            title: 'Custom', items: [
                {title: 'Outstanding', block: 'p', classes: 'oustanding'},
                {title: 'Caption', block: 'p', classes: 'caption'},
                {title: 'Legal', block: 'p', classes: 'legal'}
            ]
        }
        ],
        formats: {
            alignleft: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'alignleft',exact:true, wrapper:false},
            aligncenter: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'aligncenter', exact:true, wrapper:false},
            alignright: {selector: 'p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img', classes: 'alignright',exact:true, wrapper:false}
        },
        tinyvision: {
            source: '/images.json',
            upload: function () {
                console.log("Uploading images...");
            }
        },
        code_dialog_width: 1600,
        code_dialog_height: 760
    },
```

This configurarion can be shared between different models or fields that use the same 

```javascript
...
description: {
	type:String,
	format: 'html',
	tinymceOptions: commonTinyCfg,
	class:"col-md-6"
}
...
```

We should modify code_dialog_height parameter, but currently it is now working :?

