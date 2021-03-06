$(document).ready(function(){

  $('#leader_search').bind('keyup', function() {
    $.getJSON( "/search_users.json?search=" + $('#leader_search').val(), function(data) {
      var items = [];
      $.each( data, function( key, val ) {
        var add_leader_button = "<button class='add_leader btn btn-info btn-xs' data-leader_id=" + val.id + ">Add leader</button>";
        items.push( "<li id='" + key + "'>" + val.firstname + " " + val.lastname + " " + add_leader_button +"</li>" );
      });
      $("#leaders").empty();
      $( "<ul/>", {
        "class": "my-new-list",
        html: items.join( "" )
      }).appendTo( "#leaders" );

    });
  });

});
