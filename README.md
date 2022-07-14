# Xen-Electronics

XenElectronic is one of electronics and home appliance store. To improve customers’ growth for their
business, the manager of the store plans to build a web application where customers can purchase their
products online.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Ruby 3.1.x
```
sudo apt-get install ruby-full
```
Rails 7.x.x
```
gem install rails
```

Node 16.16.0

### Installing


##### BE
```
cd be
bundle install
rails db:setup
rake dummies:user
rake dummies:categories
rake dummies:products
rails s
```

#### FE
```
cd fe
npm install
npm start
```

## Running the tests

```
cd be
rake spec
```

## Deployment

you can access it 
* [Frontend](https://xen-electronics-kh3xuaq7i-chakraskun.vercel.app/) email = "test@gmail.com", password = "password"
* [Backend - API Docs using Swagger - OAS3](https://xen-electronic-backend.herokuapp.com/api-docs/index.html)

## Built With

* [Rails](https://rubyonrails.org/) - backend
* [React](https://reactjs.org/) - frontend


## Authors

* **Chakras Andika** 


## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
