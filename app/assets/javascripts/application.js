// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui

//= require turbolinks
//= require bootstrap
//= require_tree .

var time = new Date().getTime();
     $(document.body).bind("mousemove keypress", function(e) {
         time = new Date().getTime();
     });

     function refresh() {
         if(new Date().getTime() - time >= 180000) 
             window.location.reload(true);
         else 
             setTimeout(refresh, 15000);
     }

     setTimeout(refresh, 15000);

$(document).ready(function(){
    $(window).scroll(function() {
    if ($(this).scrollTop()) {
        $('#backtop').fadeIn();
    } else {
        $('#backtop').fadeOut();
    }
});
})

