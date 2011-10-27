// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

Occupyist = {
  time_on_site: 0,
  countdown_time: 0,

  init: function() {
    $('.today').fadeTo("slow", 0.2, function() {
      $(this).fadeTo("slow", 1);
    });
    
    $(".today").each(function() {
      // $(this).find('.status').pulse({opacity:[1,0]}, 200, 3, );
    });
    $("#search").submit();
    $(".button").click(Occupyist.toggle_links);
    $("li.event").hover(Occupyist.toggle_countdown);
    Occupyist.setup_countdown();
  },
  
  toggle_links: function() {
    var $links = $(this).next('.links');
    if($links.find('.secondary').length > 0) {
      $links.toggle('fast', function() {});
      return false;
    }
    return true;
  },
  
  toggle_countdown: function(e) {
    state = (e.type == "mouseenter")
    $(this).find('.formatted-time').toggle(!state);
    $(this).find('.timestamp').toggle(state);
  },

  setup_countdown: function() {
    $('.status').each(function() {
      var timestamp = $(this).find('.timestamp').attr('value');
      var start_time = new Date(parseInt(timestamp * 1000));
      $(this).find('.timestamp').countdown({until: start_time, compact: true, format: 'yowdHMS'});
    });
    var next_timestamp = $('#next-event').attr('value'); 
    var next_time = new Date(parseInt(next_timestamp * 1000));
    $('#next-event').countdown({until: next_time, compact: true, format: 'yowdHMS'});
  },
};

$(document).ready(function() {
  Occupyist.init();
});
