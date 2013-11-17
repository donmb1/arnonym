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
//= require bootstrap
//= require turbolinks
//= require_tree .



$(document).ready(function() {
	var intId = 0;
    $("#add").click(function() {
        intId++;
        var fieldWrapper = $("<div class=\"row\"><div id=\"fieldWrapper" + intId + "\"/>");
        var fInput = $("<div class=\"col-md-10\"><div class=\"input-group\"><span class=\"input-group-addon\">@</span><input type=\"text\" placeholder=\"jonny@pollify.de\" class=\"form-control\" name=\"mail_friends[email]["+ intId + "]\"/></div></div>");
        var removeButton = $("<div class=\"col-md-2\"><input type=\"button\" class=\"remove btn btn-danger\" value=\"-\" /></div>");
        removeButton.click(function() {
            $(this).parent().remove();
        });
		if (intId < 20) {
        	fieldWrapper.append(fInput);
	        fieldWrapper.append(removeButton);
	        $("#email_fields").append(fieldWrapper);
		}
    });
});
