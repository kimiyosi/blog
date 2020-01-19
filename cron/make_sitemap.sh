#!/bin/bash

export RAILS_ENV=production
RUBY_HOME=$HOME/.rbenv/bin
export PATH=$RUBY_HOME/bin:$PATH
rails_root=$HOME/approot/

cd $rails_root
rails runner batch/make_sitemap.rb
