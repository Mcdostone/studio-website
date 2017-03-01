## Studio's website

Once uppon a time in the Studio club at TELECOM Nancy,
a guy who wanted to share pictures and videos around him. So, he decided to make a website!


### Ruby On Rails is awesome

#### Backend
The website is built with RoR !

    Rails 5.0.1
    ruby 2.3.1p112 (2016-04-26) [x86_64-linux-gnu]


 SQLite3 is used the DB.

    3.11.0 2016-02-15


AWS S3 is used for the storage of files.


#### Frontend

We used [VueJS 2.0](https://vuejs.org/) for the front-end side (mainly for the lightbox)

[MaterializeCSS](http://materializecss.com/) and compass are used for the CSS design.


### Installation

Install Ruby, Ror and SQLite3! Don't forget to configure your DB !

    git clone git@github.com:Mcdostone/studio-website.git
    cd studio-website
    bundle install                        # Install gems
    npm install                           # Installing JS dependancies


After that, you have to create the *secrets.yml* file in the following folder:

    cat studio-website/config/secrets.yml

    development:
      secret_key_base: XXXXX
      GOOGLE_CLIENT_ID: XXXXXXXXXXXX
      GOOGLE_CLIENT_SECRET: XXXXX
      AWS_ACCESS_KEY_ID: XXXXXX
      AWS_SECRET_ACCESS_KEY: XXXX
      AWS_REGION: XXXX
      AWS_HOST: https://XXXX.amazonaws.com
      AWS_ENDPOINT: https://XXXX.amazonaws.com
      AWS_BUCKET_NAME: xXXX
      #......


Everything should works now, last steps are:

    rails db:create && rails db:migrate   # Prepare the DB
    foreman start                         # Launch rails && webpack server

#### Tests

RSpec is used for units tests. There is not enough tests for this project, If someone want participate for this task, it will be a pleasure !


### Features

The aim of this website is to easily access to the media! For the first version, the website is composed of 4 main parts:

 - public part, the only accessible part if you're not a TN student
 - "All" part, where all media are displayed
 - "Albums" part where media are grouped by a album (for example: Gala 2016)
 - "Types" part where media are sorted by their types (photos, videos, posters...)



An admin dashboard was created for administrators (CRUD media/types/albums/users, ban, reports, tags, likes...)

There are 3 levels of authorization for a user: viewer, author and admin

For a viewer, possible actions are:
 - Custom his nickname
 - Like a medium
 - Tag a medium
 - Show media
 - Report a medium

for an author, possible actions are
 - All actions of a viewer
 - Access to the dashboard admin

for an admin, possible actions are:
 - All actions of an author
 - Some others tricks (I let your explore the code...)


## Deployement

We used [Capistrano](http://capistranorb.com/) for the deployement.

/!\\ WIP /!\\

## Licence

See the [LICENCE file !](https://github.com/Mcdostone/studio-website/blob/master/LICENSE)


## authors

[@Mcdostone](https://github.com/Mcdostone), Yann Prono

[@Kompass](https://github.com/Kompass), Nicolas Kirchner

[@Quentin-bruel](https://github.com/Quentin-Bruel), Quentin Bruel
