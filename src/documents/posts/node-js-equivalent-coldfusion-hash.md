---
title: "Node.js Equivalent to ColdFusions hash()"
isPage: true
date: 2014-11-18 23:30
---


Areference for me more than anything else for duplicating hash(str,"SHA-256") in node.js

```javascript
var crypto = require('crypto');

var pwd = "Password1!";

var hash = function(str){
  return crypto.createHash('sha256').update(pwd).digest('hex').toUpperCase()
}

console.log( hash(pwd) );
```