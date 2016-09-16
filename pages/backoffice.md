# Backoffice pages configuration

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
Each directory inside **pages** represents a single angular page.

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
    backoffice: true // True if it's a backoffice integrated page.
    url: 'url/:variable', // This is the url used in Angular-Router. Define yours here.
    template: 'stats/index.html', // Specify your main template here. Attention because you must omit public directory
    controller: 'CustomController', // This is the controller which renders the above template. Specify only the controller's name.
    menu: { // If menú is present, this page will be included on the side menu.
        title: "MyPage Tile", // The desired name shown on the left
        section: "" // Specify the section name
        clickTo: url/ // This is an option parameter. You can set which is the linked URL of the menu
    }
};
```

## Step 4. Add your page

Inside public directory you can add as many files as you want. Remember that they must be angularjs files (templates, controllers, providers, etc).

Also remember that CSS and JS files will be automatically added on the backoffice, so be ware of using bower inside public dir. It will add libraries and sources and will mess up the whole backoffice.