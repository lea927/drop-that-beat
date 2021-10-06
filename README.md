# Drop that beat app

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
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

# Getting Started
## Prerequisites
🔙  [Table of Contents](#table-of-contents)

- ruby
  ```
  # Insert installation instruction here
    Ruby 2.7.2
  ```
- rails
  ```
  # Insert installation instruction here
    Rails 6.0.3.4
  ```
- nodejs
  ```
  # Insert installation instruction here
    NodeJS 12.18.3
  ```
- yarn
  ```
  # Insert installation instruction here
    Yarn 1.22.4
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
4. Setup database
  ```
  $ rake db:setup
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
## Testing

🔙  [Table of Contents](#table-of-contents)

Automated testing using RSpec was performed to verify the project requirements. You can run the test suites through the following: 
  ```
    $ rspec
  ```

# Contributing

🔙  [Table of Contents](#table-of-contents)

1. Fork it (https://github.com/lea927/drop-that-beat)
![Fork project](https://user-images.githubusercontent.com/79251819/136222616-e9a78e32-a886-4356-93d7-093bd48f0c03.png)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add feature to ...')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request

You can suggest additional features or report bugs in the [issues pages](https://github.com/lea927/drop-that-beat/issues). Templates are available to be populated based on the type of issue (feature/bug/user story)

# License

