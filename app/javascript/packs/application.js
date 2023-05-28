import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap';
import '../stylesheets/application';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on ("turbolinks:load", function(){
  setTimeout(function () {
    $("#flash_msg").hide();
  }, 3000);
});
