Using Apache to password protect a single file


I'm going to use the terminal screen for this and assume you're on *nix but it should be quite simple to take to your operating system


My webroot is at /var/www/securefile/public. The url and page I am trying to proctect is http://securefile.local/secureme.html

Create a text file called .htpasswd away from your webroot. Using my example I'm going to put it in /var/www/securefile/.htpasswd The point is that it shouldn't be able to access it via a url

Next on the terminal line call htpasswd i.e. $ htpasswd -b passwdfile username
$ htpasswd -b /var/www/securefile/.htpasswd andyjarrett


We now need to create (or update if there already) a .htaccess file at
/var/www/securefile/public/.htaccess and add the following

# Link to your .htpasswd file
AuthUserFile /var/www/securefile/.htpasswd
# Name of the page you are securing
AuthName "My secure page test"

# Type of auth
AuthType Basic
# Page your are securing
<Files "secureme.html">
 require valid-user
</Files>

Once you've saved .htaccess test that the password works by accessing the URL, in my example I'll go to http://securefile.local/secureme.html

