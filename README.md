## About Slab Code - Projects

It is a technical test for the process of linking to the Slab Code company

## Steps to install it

### Clone the Repository
```
git clone https://github.com/juan9009/slabcode-projects.git
```

### Run composer install from the project root
```
composer install
```

### Upload the database (this could have been done with migrations)

The file is in the **database** folder and it is called **proyectos.sql**


### Configure your .env file for database connection
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=projects
.
.
.
```

### Clear cache if you see it necessary
```
php artisan config:cache

php artisan config:clear
```

### Run laravel virtual server
```
php artisan serve
```

## APIS's Doc is located at
http://127.0.0.1:8000/api/docs
[APIS's Doc](http://127.0.0.1:8000/api/docs)

## Postman APIS Collection
[Download](https://www.getpostman.com/collections/826911b25bacddaad02b)
