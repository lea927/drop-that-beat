# Drop that beat app   
![build](https://github.com/lea927/drop-that-beat/actions/workflows/rspec.yml/badge.svg)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

![Drop that beat app](https://user-images.githubusercontent.com/79251819/136054424-c82d19df-477b-4dbc-8f23-0185d0658d44.png)
The developers created this app to bond with their love of music. We hope that users will enjoy listening to their favorite music and learn other songs they can tune into 😃 🎵🎵🎵

## Features 🎵🎵🎵

- Create and edit an account
- Create, edit and delete a game rooms. Game rooms created are accessible to other registered users.
- Search tracks and add those tracks in the game room. 🎵
- Search playable game rooms by searching the artist
- Play game rooms created by other users 
- Earn points while playing the game 💰

#### Note
- _Only confirmed accounts will be able to use the application. An email confirmation will be sent upon registration to verify your account._
- _You cannot play rooms you have created_

## Built With 

- [Ruby on Rails](https://rubyonrails.org/)
- [Bootstrap](https://getbootstrap.com/)
- [JQuery](https://jquery.com/)

# Table of Contents
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

# Getting Started
## Prerequisites
🔙  [Table of Contents](#table-of-contents)

- Ruby 2.7.2
  ```bash
    $ asdf plugin add ruby
    $ asdf install ruby 2.7.2
  ```
  For more details, see [ruby documentation](https://www.ruby-lang.org/en/documentation/installation/)
- NodeJS 12.18.3
  ```bash
    $ asdf plugin add nodejs
    $ bash -c '`${ASDF_DATA_DIR:=$HOME/`.asdf}/plugins/nodejs/bin/import-release-team-keyring'
    $ asdf install nodejs 12.18.3
  ```
- Yarn 1.22.4
  ```bash
    $ asdf plugin add yarn
    $ asdf install yarn 1.22.4
  ```
- Rails 6.0.3.4
  ```bash
    $ gem install rails
  ```
- Postgresql
  ```bash
    $ asdf plugin add postgres
    $ asdf install postgres latest
  ```

## Installation
🔙  [Table of Contents](#table-of-contents)

1. Clone the repo 
  ```
    $ git clone https://github.com/lea927/drop-that-beat.git
    $ cd drop-that-beat
  ```
2. Install ruby gems dependencies
  ```
    $ bundle install
  ```
3. Install webpacker
  ```
    $ rails webpacker:install
  ```
4. Set up environment variables
  Using [dotenv](https://github.com/bkeepers/dotenv)
  Contact the developer(sensitive data)
5. Setup database
  ```
  $ rake db:setup
  ```
6. Run the test suite to verify that everything is working correctly
  ```
  $ rspec
  ```
## Usage

🔙  [Table of Contents](#table-of-contents)

Running the application in your localhost or access the deployed application:

Link: [Drop that beat](https://drop-that-beat.herokuapp.com/)
```
  $ rails server
```
When accessing the application, you can use the credentials below to try the features available.
```
username: testuser
password: testuser
```
# Contributing

🔙  [Table of Contents](#table-of-contents)

1. Fork it (https://github.com/lea927/drop-that-beat)
![Fork project](https://user-images.githubusercontent.com/79251819/136222616-e9a78e32-a886-4356-93d7-093bd48f0c03.png)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add feature to ...')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request

Alternatively see the GitHub documentation on [creating a pull request](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)

You can suggest additional features or report bugs in the [issues pages](https://github.com/lea927/drop-that-beat/issues). Templates are available to be populated based on the type of issue (feature/bug/user story)
