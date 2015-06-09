Xskillz



#How to prepare

You need a Google Developer credentials to access the OAUTH API. 

Go to the [Google Developer Console |https://console.developers.google.com/].

Create a new project named **"xskillz"** ID is indifferent.

Once created, go to menu item **APIs & Auth** then **Credentials** and create a **new client ID** in **OAuth** with the following elements

* **Authorized JavaScript Origins**: https://xskillz.herokuapp.com
* **Authorized Redirect URI**: http://localhost:3000/auth/google/callback

In your ***.profile***, export two variables: 

* **GOOGLE_ID**: with the CLIENT_ID
* **GOOGLE_SECRET**: with CLIENT_SECRET

Installs: 

* brew install neo4j
* brew install mongodb

You need running mongo and neo4j:

* **mongoDB** : needed by mean.js to store users info
  * To run mongodb, you need at least java 7
  * Also, you need the following folder created : sudo mkdir -p /data/db
* **neo4j**: need to store anything else`

Start mongo and neo4j:

* sudo mongod
* neo4j start

NEO4J admin UI is available on [localhost:7474](http://localhost:7474)


#How to fetch dependencies

server dependencies

	npm install

client dependencies
(if you don't have bower : npm install -g bower)

	bower install

#How to run 

Launch the server for [localhost:3000](http://localhost:3000)

	grunt


# NEO4J queries

Top 25 des profils les moins remplis
    MATCH (a)-[:`HAS`]->(b) RETURN a.email,COUNT(b) order by count(b) asc LIMIT 25

Xebians sans manager
    MATCH (x:XEBIAN) WHERE NOT(()-[:IS_MANAGER_OF]->x) RETURN x.email ORDER BY x.email;
