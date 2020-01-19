#!/bin/bash

export RAILS_ENV=production
RUBY_HOME=$HOME/.rbenv/bin
export PATH=$RUBY_HOME/bin:$PATH
rails_root=$HOME/approot/

cd $rails_root
rails runner batch/export_category.rb
rails runner batch/export_sub_category.rb
rails runner batch/export_tag.rb
rails runner batch/export_image.rb
rails runner batch/export_report.rb
