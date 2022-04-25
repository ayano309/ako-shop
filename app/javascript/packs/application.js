// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
window.jQuery = window.$ = require('jquery')
import $ from 'jquery';
import "popper.js";
import "bootstrap";
import "../stylesheets/application" 
import '@fortawesome/fontawesome-free/js/all'
import "packs/jquery.jpostal.js"

require("../packs/jquery_raty")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// 郵便番号での住所自動入力
// 郵便番号での住所自動入力
$(document).on('turbolinks:load', function() {
  return $('#user_postal_code').jpostal({
    postcode: ['#user_postal_code'],
    address: {
      '#user_prefecture_code': '%3',
      '#user_city': '%4',
      '#user_street': '%5%6%7',
    },
  });
});