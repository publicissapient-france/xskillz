Xskillz



#How to prepare

You need a Google Developer credentials to access the OAUTH API. 

Go to the [Google Developer Console |https://console.developers.google.com/].

Create a named **"xskillz"**

Once created, go to menu item **API & Auths / Credentials** with the following elements

* **Authorized JavaScript Origins**: https://xskillz.herokuapp.com
* **Authorized Redirect URI**: http://localhost:3000/auth/google/callback

In your ***.profile***, export two variables: 

* **GOOGLE_ID**: with the CLIENT_ID
* **GOOGLE_SECRET**: with CLIENT_SECRET

You need running a running instance of:

* **mongoDB** : needed by mean.js to store users info
* **neo4j**: need to store anything else`

NEO4J admin UI is available on [localhost:7474](http://localhost:7474)


#How to fetch dependencies

server dependencies

	npm install

client dependencies

	bower install

#How to run 

Launch the server for [localhost:3000](http://localhost:3000)

	grunt