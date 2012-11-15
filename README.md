# doyoulikeart

===================================

### Local Setup

Open terminal.

Type => 

```
$ bundle install
$ rake mm:s
```

Click => <http://localhost:8888>


---

### Technologies

This project uses the following technologies:

* [Middleman](http://middlemanapp.com "Title")
* [Backbone](http://backbonejs.org "Title")
* [Isotope](http://isotope.metafizzy.co "Title")

### Deployment

##### Versioning
- [Unversioned Development Builds](#build_unversioned)
- [Versioned Staging Builds](#build_versioned)
- [Tagged Production Builds](#build_tagged)

##### Heroku
- [Setup](#heroku_setup)
- [Deployment](#heroku_deployment)

##### Azure
- [Setup](#gae_setup)
- [Deployment](#gae_deployment)

---

## Deployment

#### <a id="build_unversioned">Unversioned Development Builds</a>

The build can be compiled without incrementing the build version Id with the following command:

```
$ rake mm:build:development
```

#### <a id="build_versioned">Versioned Staging Builds</a>

The build can be versioned manually with the following command:

```
$ rake version:increment
```

The build will be versioned automatically when compiling a Staging build for release using the following command:

```
$ rake mm:build:staging
```

Each build has a version number that is always visible on the client as long as the `console` object exists. 

E.g. `Build Version => v6`

When in testing and production phases, build version Ids should correspond with the names of the released build versions to the Staging and Production environments in Jira. 

These associations need to be made by the Release Manager.

#### <a id="build_tagged">Tagged Production Builds</a>

Once the `develop` branch has been merged successfully into the `master` branch, the build can be tagged in with the following command:

```
$ rake version:tag
```

In order for the production release tags to make it to the origin (GitHub) repository, you must use the following command:

```
$ git push origin master --tags
```

### Azure : <span style="color:red"> **TODO**</span>

#### <a id="gae_setup">Setup</a>

#### <a id="gae_deployment">Deployment</a>

---

### Heroku : <span style="color:red"> **UNTESTED**</span>

<span style="color:red">The strategy of hosting of static files with Rack cache on Heroku became unstable at some point during development and testing.</span>

<span style="color:red">Certain files would not compile on the remote hosting environment that worked locally. Due to the intermittent and unusual nature of these problems it is not recommended that this hosting solution be used for QA testing or production hosting.</span>

#### <a id="heroku_setup">Setup</a>

##### Update Your Gemset

This will install the heroku gem and all its dependencies.

```
$ rm -r Gemfile.lock
$ bundle install
```

##### Sign up for Heroku

<https://api.heroku.com/signup>

```
UN: firstname.lastname@akqa.com
PW: ***Your**Heroku**Password***
```

#### <a id="heroku_deployment">Deployment</a>

##### Add your Heroku accounts

1. Go to: https://github.com/ddollar/heroku-accounts
2. Read instructions for +auto+ adding accounts.
3. Add one account called "work" for your firstname.lastname@akqa.com account.
4. Add another account called "ops" for:

```
UN: /////////////////////
PW: /////////////////////
```

##### Add private SSH keys

```
$ ssh-add ~/.ssh/identity.heroku.work
$ ssh-add ~/.ssh/identity.heroku.ops
```

##### Set default Heroku project account

```
$ heroku accounts:set ops
```

##### Add your Ops SSH key to Heroku

```
$ heroku keys:add ~/.ssh/identity.heroku.ops.pub
```

##### Adding existing remotes

Run this command before attempting to deploy. It will **add** the git remote repositories.

```
$ rake heroku:utils:add_remotes
```

##### Creating nonexistent remotes

Run this command before attempting to deploy. It will **create** the git remote repositories.

**Only use this command if applications have not been previously created.**

```
$ rake heroku:utils:create_apps
```

You will then have the ability to deploy to all Heroku apps.

##### Running your app locally

Run this command to host your app instance locally:

```
$ rake heroku:s
```

The app will be visible here : <http://localhost:5000>

##### Environments

###### Review : <http://review-project-boilerplate.herokuapp.com>

This build is used for internal and external reviews. This build should be stable. The expectation is that this build will only be updated for scheduled reviews.

The following command will always:

1. Deploy the `develop` branch.

```
$ rake heroku:deploy:review
```

###### Dev : <http://dev-project-boilerplate.herokuapp.com>

<span style="color:red">**Do not share this build outside of the development team.**</span>

This build is used for development testing.

The following command will always:

1. Deploy the `develop` branch.

```
$ rake heroku:deploy:development
```

In order to deploy a "feature" or "hotfix" branch run this command: 

```
$ rake heroku:deploy:development[branch_name]
```

---