---
title: "NPM not found when using NVM"
isPage: true
date: 2014-08-07 23:30
---
Had an issue with NPM not found with an install of Node.js via NVM. Tried `` $ which npm `` and that didn't return anything. As much as I like a puzzle sometimes its easier to start again.

	$ rm -R ~/.npm
	$ rm -R ~/.nvm
	$ rm -R ~/.bower

Then head back to [github.com/creationix/nvm](https://github.com/creationix/nvm) and install again.

Don't forget to add `nvm alias default 0.10` to make sure NPM/Node is loading with each new terminal window.