# Standalone pages configuration

## Step 1. Create pages directory

First of all create a directory named *pages* in your application root directory.
```
demo/
├── bin
├── config
├── image
├── images
├── models
├── pages <---------- This is where you will put your pages
├── public
├── routes
└── views
```

## Step 2. Create your first page

Inside *pages* directory you must create a second directory, this will contain the resources of your page.
Each directory inside **pages** represents a single page.

## Step 3. Define your page

To integrate pages with the backoffice you need to create a new directory named *public*. This folder will be available
through the internet. Javascript and Style files will be automatically added to the Backoffice page if they are located inside public folder.

Apart from the public folder, you must create an *index.js* file, which will be the descriptor of your page

```
demo/pages/
├── example
    ├── index.js
    └── public
        ├── example.js
        └── index.html
```

### Index.js's content
```
module.exports = {
    cname: 'www.example.com', // If you want that page to be rendered in a different domain, just set your cname here.
    menu: { // If menú is present, this page will be included on the backoffice side menu
        title: "MyPage Tile",
        section: "this is a section"
        url: "http://www.example.com"
    }
};
```

## Step 4. Add your page

Inside public directory you can add as many files as you want to show your page.