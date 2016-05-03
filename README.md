General Backend Template Project
===================================

**If you need Vagrant + Ansible version, please check [vagrant_ansible](https://github.com/intellectsoft-uk/symfony-skeleton/tree/vagrant_ansible) branch.**

## Usage

Well... it's basically that's simple:

```
$ composer create-project intellectsoft/backend-skeleton target-directory
```

Then simple wizard will be started to finish project configuration. It will change project name in `composer.json`, for docker-compose and set correct namespaces.

## What's included

This is our day-to-day backend dev stack

 - Pre-configured PHP 7 FPM and CLI
 - Pre-configured Nginx 1.9
 - PostgreSQL 9.4
 - Symfony 3.0 standard edition
 - Doctrine ORM 2.5
 - FosRestBundle
 - Behat and PhpSpec as testing frameworks

## Required software

 - Docker 1.10+
 - Docker-compose 1.7+
 - Docker-machine 0.7+

### Docker

All environment isolated from host system via Docker containers.

For understanding of how Docker works please read this articles:

 - [About Docker](http://www.wintellect.com/devcenter/paulballard/what-developers-need-to-know-about-docker)
 - [Visualizing Docker Containers and Images](http://merrigrove.blogspot.com.by/2015/10/visualizing-docker-containers-and-images.html)
 - [Docker Documentation](https://docs.docker.com/engine/misc/)
 - [Docker Compose Documentation](https://docs.docker.com/compose/)

PHP container uses `boot.sh` as default command. It runs migrations ono startup.

### For MAC OSX users

To run Docker images you should have linux kernel. This could be a tiny problem for Mac OSX users. We recommend to use [docker-machine](https://docs.docker.com/v1.8/installation/mac/) or [dinghy](https://github.com/codekitchen/dinghy).

### Shortcuts

To simplify your life, you can use shortcuts available in `support/shortcuts` shell script. To make it even more easy to use, just add path to this directory in your `PATH` env variable (in `.bashrc` or `.bash_profile`):

```
export PATH=./support/shortcuts:$PATH
```

By doing this, you will be able to use short versions of commands:

```bash
php                         # run command in php container
console                     # symfony console running via docker container
psql                        # connects psql to your database using containers
composer                    # shortcut for running composer (with php7 in separate docker container)
phpspec                     # shortcut for running PhpSpec
behat                       # shortcut for running Behat in test environment
```

## Development

To start dev environment, first you need to install project dependencies via composer. You could use your local composer or by running `composer install --ignore-platform-reqs` command.

After this, just run `compose up` and you are ready to go.

### Testing

To run test suites you can use `support/scripts/run_tests` script, or use phpspec/behat separately (see aliases section).

### XDebug

This projects template also includes xdebug extensions for remote debugging. To debug your application in PhpStorm you should configure remote server and [set path mapping](https://www.jetbrains.com/phpstorm/help/override-server-path-mappings-dialog.html) to `/srv` directory.

In production environment xdebug is disabled.

## Build and Deployment



### HTTPS support

This skeleton includes config for SSL. To make your API available by https, just pass certificate and key with volumes and bind 443 port:

```
services:
    # ...
    front:
        # ...
        ports:
            - 80:80
            - 443:443
        volumes:
            - "/certs/your_certificate.crt:/certs/domain.crt:ro"
            - "/certs/your_private_key.key:/certs/domain.key:ro"
```

And that's it.
