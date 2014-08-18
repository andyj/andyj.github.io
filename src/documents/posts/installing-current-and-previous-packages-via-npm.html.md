---
title: "Installing Current And Previous Packages Via NPM"
isPage: true
date: 2014-08-18 23:59
---
When coming from Java/CFML to Node.js one of the first tools you come across is the package manager. This allows you to download/add packages globally to your environment or locally to your project (locally is the default way).

###How to locally install a package

If you had a single project that used Coffee Script you should change your current directory to your application root directory and run `$ npm install coffee-script`. This will grab you the latest copy, create a **node_modules** directory, only if it doesn’t already exist, and install the coffe-script module within it.

###How to globally install a package
You might want to use coffee-script for all your projects. At which point you add the `-g` flag, so your command becomes `$ npm install -g coffee-script`. This will put the package in **/usr/local/lib/node_modules**.

###Installing a previous version
When you start development you could be using version 1.82 of a package but in a couple of months when you bring on another developer they could be on v2.01 which breaks your app. To get around this you can choose which version of a specific module to install by using `$ npm install [package name]@[version]`. So your new developer would use `$ npm install [package name]@1.82`.

If the v1 branch is still maintained for bugs etc you can change your call using a wild card to get the latest version by using any of the following
`$ npm install [package name]@1.x`
`$ npm install [package name]@1.8x`
`$ npm install [package name]@<2.0`

You can take this further (though I haven't found a need for this yet) by  defining the versions like this:
`$ npm install [package name]@">=1.82 <2.0"

###Updating or uninstalling a package

As easy as it is to install you can update or uninstall a package either locally or globally
`$ npm update -g [package name]`
`$ npm update [package name]`
`$ npm uninstall -g [package name]`
`$ npm uninstall [package name]`