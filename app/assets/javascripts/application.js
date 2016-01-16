// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require bootstrap.min

$(document).ready(function() {
	//Add Comment 
	$("a.add-comment").click(function(){
		$("#photo-id").val($(this).data("photo"))
		$("#myModal").modal({});
	});

	$("#save-comment").click(function(){
		var comment = $("#comment").val();
		if ( comment == "" ) {
			alert ("Please enter your comment.");
			return false;
		}
		var photo_id = $("#photo-id").val();
		$.post("/photos/comment.js", {comment: comment, photo_id: photo_id});
	});


	//View Comments 
	$("a.view-comment").click(function(){
		$("#photo-id").val($(this).data("photo"))
		var photo_id = $("#photo-id").val();
		$.post("/photos/view_comments", {photo_id: photo_id});
		$("#viewCommentModal").modal({});
	});
});
