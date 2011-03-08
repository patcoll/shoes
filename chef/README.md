# Using Chef to Build Shoes

Shoes can use Chef to build Shoes.

What is Chef? From the web site:

> Chef is an open source systems integration framework built to bring the benefits of configuration management to your entire infrastructure. You write source code to describe how you want each part of your infrastructure to be built, then apply those descriptions to your servers. The result is a fully automated infrastructure: when a new server comes on line, the only thing you have to do is tell Chef what role it should play in your architecture.

In this case Chef handles the installation and management of Shoes dependencies in an elegant way.

Written for Mac OS X 10.6 (Snow Leopard), but could be adapted for more platforms.

## Prerequisites

Uses MacPorts and Chef. Assumes:

* A working RVM environment
* Chef supports passing options to the MacPorts package provider. Currently an [outstanding issue][1]. To get this to work until this issue is fixed:

        git clone git://github.com/patcoll/chef.git /path/to/chef-read-only
        cd /path/to/chef-read-only
        git branch --track CHEF-2089 origin/CHEF-2089
        git checkout CHEF-2089
        git pull origin CHEF-2089
    
    * Uncomment chef in `Gemfile` and change the path:
    
            gem "chef", :path => "/path/to/chef-read-only/chef"

### Install MacPorts

Install MacPorts by downloading and installing the appropriate package [here][2].

RECOMMENDED: Make your user own and have writable everything under `/opt/local` so `sudo` isn't necessary for using MacPorts (`port`) or Chef (`chef-solo`):

    sudo chown -R $USER /opt/local
    sudo chmod -R 755 /opt/local

If you don't perform this step, you'll have to use `sudo` for executing `port` and `chef-solo` commands.

Make sure you update the MacPorts package lists by issuing a `selfupdate`:

    port selfupdate

### Install Chef

Run:

    bundle

This should install gem dependencies in your existing RVM environment.

## Building Shoes

To install dependencies and build Shoes:

    bundle exec chef-solo -ldebug -c chef/solo.rb -j chef/node.json

The `-ldebug` is to see all output in case something goes wrong.

## TODO

Chef could be a solid basis for a Shoes continuous integration server that could test building Shoes with multiple rubies on multiple platforms. Some blockers for accomplishing this:

1. Splitting out each package Shoes depends on into separate Chef recipes. This would enable:
    * More explicit dependencies (e.g. `pango` has an explicit dependency on `cairo`, `mechanize` depends on `nokogiri` which depends on `libxml2`, etc.)
    * Documenting and scripting out each dependency's install process cross-platform with a more easily understandable DSL.

[1]: http://tickets.opscode.com/browse/CHEF-2089
[2]: http://www.macports.org