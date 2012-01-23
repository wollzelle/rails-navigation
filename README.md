# Rails Navigation

A simple way to add navigation to your Rails application.

## Installing

Add to your `Gemfile`:

    gem 'rails-navigation'

## Usage

In `app/controllers/things_controller.rb`:

    class ThingsController < ApplicationController

      def show
        @thing = Thing.find(params[:id])
        add_navigation :nav => :main, :title => @thing.name, :url => thing_path(@thing)
      end

    end

In `app/views/layouts/application.html.erb`:

    <%= navigation(:main) %>
    <%= navigation(:main, :p) %>   # define the wrap tag you want, default is :li

## Acknowledgments

- Based on rails-breadcrumbs by Francesc Esplugas Marti: https://github.com/fesplugas/rails-breadcrumbs

Copyright (c) 2012 Wollzelle GmbH, released under the MIT license.