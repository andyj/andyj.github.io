Areference for me more than anything else for duplicating hash(str,"SHA-256") in node.js

```javascript
var crypto = require('crypto');

var pwd = "Password1!";

var hash = function(str){
  return crypto.createHash('sha256').update(pwd).digest('hex').toUpperCase()
}

console.log( hash(pwd) );
```