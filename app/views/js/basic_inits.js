jQuery(function($) {
  $(".wysiwyg-editor").wysiwyg();  

  // Ignore useless links
  $("a[href='#']").click(function(event) { event.preventDefault(); });
});
