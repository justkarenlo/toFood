$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
 $('.delete-video').on('click', function(){
  event.preventDefault();
  var url = $(this).attr("href");
  var clicked_element = $(this);
  $.ajax ({
    url: url,
    type: "POST",
    data: {"_method": "DELETE"},
    success: function () {
      $(clicked_element).parent().remove();
    },
    error: function () {
      console.log("Oops that didn't quite work out right.")
    }
  })
 });

 $('.delete-list').on('click', function(){
  event.preventDefault();
  var url = $(this).attr("href");
  var clicked_element = $(this);
  $.ajax ({
    url: url,
    type: "POST",
    data: {"_method": "DELETE"},
    success: function () {
      debugger;
      $(clicked_element).parent().parent().remove();
    },
    error: function () {
      console.log("Oops that didn't quite work out right.")
    }
  })
 });


});
