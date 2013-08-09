$(document).ready(function() {
  $('#pick_deck input').on('click', function(e){
    var value = e.toElement.value;
    window.location = "/rounds/"+value;
  });

});
