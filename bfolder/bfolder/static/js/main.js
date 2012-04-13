/*
 * jQuery File Upload Plugin JS Example 6.5.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload();

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
        'option',
        'redirect',
        window.location.href.replace(
            /\/[^\/]*$/,
            '/cors/result.html?%s'
        )
    );
        
        $('#fileupload').fileupload('option', {
            url: '/upload',
            maxFileSize: 5000000,
            acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
            resizeMaxWidth: 1920,
            resizeMaxHeight: 1200}
            )
	    //function what clear fields after loading
	    $('#fileupload').bind('fileuploaddone', function(e, data){
	        $('#files_list').html('');
	        })
	   ////////////
	       $('#fileupload').fileupload({
                    formData: {example: 'test'}
                });

            
            $('#fileupload').bind('fileuploadsubmit', function (e, data) {
                    // The example input, doesn't have to be part of the upload form:
                    var inputs = data.context.find(':input');
                    if (inputs.filter('[required][value=""]').first().focus().length) {
													        return false;
													    }
                    //data.formData = {example: title};
 					data.formData = inputs.serializeArray();
                });
                
});
