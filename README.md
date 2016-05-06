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

After this, just run `docker-compose up` and you are ready to go.

### Testing

To run test suites you can use `support/scripts/run_tests` script, or use phpspec/behat separately (see aliases section).

### XDebug

This projects template also includes xdebug extensions for remote debugging. To debug your application in PhpStorm you should configure remote server and [set path mapping](https://www.jetbrains.com/phpstorm/help/override-server-path-mappings-dialog.html) to `/srv` directory.

In production environment xdebug is disabled.

## Build and Deployment

To build images you could simple run `docker-compose build`. To simplify process we provide you a simple bash script which is placed in `support/scripts/build`. This script will prepare dependencies, build, tag and push images on your registry. Please note that `docker login` should be performed before build & deploy.

### Continuous Integration

You may want to use CI server as part of your development workflow to automate all this build/deployment routine. We suggest you to have separate build and deploy jobs to be more scalable.

For example, if you want to pass some secure sensitive data inside your container, it's better not to do this in `Dockerfile`. Instead of it, pass it into container only on start (certificates and keys via volumes and tokens and password via `-e` option of `docker run`).

To handle ENV variables more easily we recommend you to inject them into your CI deploy job and they will be interpolated in `docker-compose.yml`.

### Deployment

We recommend to use docker-machine for host provisioning and deployment. Since docker uses client-side architecture, we could just switch to remote docker-demon with docker-machine. In this case deployment process is very simple:

```
eval $(docker-machine env $YOUR_REMOTE_HOST)

export COMPOSE_FILE=docker-compose.yml:docker-compose.prod.yml

docker-compose pull
docker-compose up -d
```

The only limitation, is that if your project requires multiple machines, this option is working only for swarm cluster.

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
