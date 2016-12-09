# PHP_CodeSniffer
A Chassis extension to install and configure [PHP_CodeSniffer](http://pear.php.net/package/PHP_CodeSniffer) with [WordPress Coding Standard Sniffs](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards) on your server.

## Usage
1. Add this extension to your extensions directory. `git clone git@github.com:Chassis/phpcs.git extensions/phpcs`
2. Run `vagrant provision`
3. Php_Codesniffer with WordPress Coding Standards has been installed on your Chassis VM!

## Why install this on Chassis?

This extension is handy so you can run precommit hooks with git that run phpcs tests on your Chassis box.

For instance you can add a file called `precommit` inside your `.git/hooks` folder with the following:

	#!/bin/sh
    
    /usr/local/bin/vagrant ssh -- -t 'cd /vagrant/content/; grunt precommit;'

If your project has a precommit grunt task it will run those tests and only let you commit if those tests pass.
