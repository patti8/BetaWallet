// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "@popperjs/core"

import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

import * as bootstrap from 'bootstrap'
window.bootstrap = bootstrap