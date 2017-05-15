# Career Quest

This is an application for organizing your job search!  Users can create unique accounts, and store and access data for all things job-related in their career quest. Visit the site here! heroku.com...

## Authors

* Asia Kane
* Grady Shelton
* Jennifer Kinsey
* Spencer Alan Ruiz

schema as of 1:30pm 5/15
![schema](/public/img/schema.png)

### Prerequisites

Web browser with ES6 compatibility
Examples: Chrome, Safari

Ruby 2.4.1
Bundler

### Installing

Clone this repo by typing into the terminal:
```
$ git clone https://github.com/spenceralan/career_quest.git
```

In a new terminal window, start postgres in the background:
```
$ postgres
```

Navigate to this project directory in the terminal. Then type:
```
$ rake db:schema:load
```

In a new terminal tab, start the sinatra server by typing:
```
$ruby app.rb
```
Sinatra will now make this project available in your browser by going to localhost:4567.

## Specifications

| behavior |  input   |  output  |
|----------|:--------:|:--------:|
|add new new user profile with encrypted password| username: "grady" email: garysmith@epicodus.com password: ****** |new account created!|
|add a new job posting you're interested in| Awesome Programming Gig | Success!|
|add company for open positions| Awesome Programming Company | New Programming Company Added! |
|Add contacts within these companies | Jane Doe- senior programmer at Awesome Company | success! |
|Keep track of your correspondence with your contacts! | interview scheduled for next Tuesday| Your schedule has been updated! |
|Update your application status! | Offer made!| Success! |

## Screenshots

**Store Page:**
![Image ofScreenshot](public/img/.png)

**Brand Page:**
![Image ofScreenshot](public/img/.png)


## Built With

* Ruby
* Sinatra
* HTML
* CSS
* Bootstrap https://getbootstrap.com/
* ES6
* Active-Record


## License

MIT License

Copyright (c) 2017

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
