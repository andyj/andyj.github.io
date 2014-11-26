
Introduction
For an introduction to Git and how to install, please refer to the introduction tutorial.

This article will teach you how to use Git when you want to deploy your application. While there are many ways to use Git to deploy our application, this tutorial will focus on the one that is most straightforward. I assume you already know how to create and use a repository on your local machine. If not, please refer to this tutorial.

When you use Git, the workflow generally is toward version control only. You have a local repository where you work and a remote repository where you keep everything in sync and can work with a team and different machines. But you can also use Git to move your application to production.

Server Setup
Our fictitious workspace:

Your server live directory: /var/www/domain.com

Your server repository: /var/repo/site.git

What should we do if we want to push to site.git and at the same time make all the content available at /var/www/domain.com?

Creating Our Repository
Login to your VPS from command line and type the following:

cd /var
mkdir repo && cd repo
mkdir site.git && cd site.git
git init --bare
--bare means that our folder will have no source files, just the version control.

Hooks
Git repositories have a folder called 'hooks'. This folder contains some sample files for possible actions that you can hook and perform custom actions set by you.

Git documentation define three possible server hooks: 'pre-receive', 'post-receive' and 'update'. 'Pre-receive' is executed as soon as the server receives a 'push', 'update' is similar but it executes once for each branch, and 'post-receive' is executed when a 'push' is completely finished and it's the one we are interested in.

In our repository if you type:

ls
You will see a few files and folders, including the 'hooks' folder. So let's go to 'hooks' folder:

cd hooks
Now, create the file 'post-receive' by typing:

cat > post-receive
When you execute this command, you will have a blank line indicating that everything you type will be saved to this file. So let's type:

#!/bin/sh
git --work-tree=/var/www/domain.com --git-dir=/var/repo/site.git checkout -f
When you finish typing, press 'control-d' to save. In order to execute the file, we need to set the proper permissions using:

chmod +x post-receive
You can see on the documentation that 'git-dir' is the path to the repository. With 'work-tree', you can define a different path to where your files will actually be transferred to.

The 'post-receive' file will be looked into every time a push is completed and it's saying that your files need to be in /var/www/domain.com.

Local Machine
Let's create our local repository. You should change the path and name to whichever you choose. If you are on a VPS, just type:

exit
And create your repo:

cd /my/workspace
mkdir project && cd project
git init
Then we need to configure the remote path of our repository. Tell Git to add a remote called 'live':

git remote add live ssh://user@mydomain.com/var/repo/site.git
Here we should give the repository link and not the live folder.

Let's assume that we have some great work ready in this folder. We should do the usual steps of adding the files and commit with a message:

git add .
git commit -m "My project is ready"
Just to remember, the dot after 'git add' means you are adding all files to stage. After 'git commit' we have '-m' which means we will type a message. To complete, we just 'push' everything to the server. We use the 'live' alias that we used when setting the remote.

git push live master
Counting objects: 7, done.Delta compression using up to 4 threads.Compressing objects: 100% (7/7), done.Writing objects: 100% (7/7), 10.56 KiB, done.Total 7 (delta 0), reused 0 (delta 0)To ssh://user@mydomain.com/var/repo/site.git* [new branch]      master -> master
Here we tell Git to push to the 'live' remote on the 'master' branch. To understand more about branches and how to use it you can read this tutorial.

Beta
What if you don't want to deploy everything in one step? Maybe you want to test it first and have a beta directory.

One of the ways to do that is create another repository. Let's log in again in our VPS and create our directory:

cd /var/www/
mkdir beta
To create our repository:

cd /var/repo
mkdir beta.git && cd beta.git
git init --bare
Again we should create the 'post-receive' file because we want to see our project in the beta directory:

cd hooks
cat > post-receive
Type the content of the file:

#!/bin/sh
git --work-tree=/var/www/beta --git-dir=/var/repo/beta.git checkout -f
Press 'control-d' to save.

Let's go back to our local repository:

exit
cd /my/workspace/project
So now we can set another remote pointing to our beta repository:

git remote add beta ssh://user@mydomain.com/var/repo/beta.git
With this, we can have a two step process. First we push to beta and check, and if everything is fine we push to live:

git add .
git commit -m "New version"
git push beta master
And later:

git push live master
Going Live From the Server
Maybe you have a team working in the same project and you want that others can also decide that it's time to go live. To do this, we can link the beta and live repository on the server. Log in to your VPS and type:

cd /var/repo/beta.git
git remote add live ../site.git
So now you can push from beta to live on the server:

cd /var/repo/beta.git
git push live master
Congratulations! Your VPS is now set to automatically deploy with Git!
