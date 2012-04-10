<html>
    <head>
        <meta charset="utf-8">
        <meta name='yandex-verification' content='430203cf93d14992' />
        <title>Pixchan.org - хостинг мемов</title>
        <link rel="stylesheet" href="static/css/bootstrap.css">
        <script src="static/js/jquery-1.7.2.min.js"></script>
        <script src="static/js/bootstrap.js"></script>
        <script src="static/js/common.js"></script>
        <script src="static/js/jquery-ui-1.8.18.custom.min.js"></script>
        <link rel="stylesheet" href="static/css/smoothness/jquery-ui-1.8.18.custom.css">
        <link rel="stylesheet" href="static/css/jquery.fileupload-ui.css">
    </head>
    
    <body style="background-color: #F8F8F8;">
        <div class="container">
        	<div class="row">
        		
        		<!-- JQUERY UPLOAD START HERE -->
        		<div class="span12" style="margin-top: 20px;">
				   <form id="fileupload" action="/upload" method="POST" enctype="multipart/form-data">
				        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
				        <div class="row fileupload-buttonbar">
				            <div class="span7">
				                <!-- The fileinput-button span is used to style the file input field as button -->
				                <span class="btn btn-success fileinput-button">
				                    <i class="icon-plus icon-white"></i>
				                    <span>Добавить файл</span>
				                    <input type="file" name="files[]" multiple>
				                </span>
				                <button type="submit" class="btn btn-primary start">
				                    <i class="icon-upload icon-white"></i>
				                    <span>Загрузить</span>
				                </button>
				                <!--
				                <button type="reset" class="btn btn-warning cancel">
				                    <i class="icon-ban-circle icon-white"></i>
				                    <span>Cancel upload</span>
				                </button>
				                <button type="button" class="btn btn-danger delete">
				                    <i class="icon-trash icon-white"></i>
				                    <span>Delete</span>
				                </button>
				                <input type="checkbox" class="toggle">
				                -->
				            </div>
				            
				            <div class="span5">
				                <!-- The global progress bar -->
				                <div class="progress progress-success progress-striped active fade">
				                    <div class="bar" style="width:0%;"></div>
				                </div>
				            </div>
				        </div>
				        <!-- The loading indicator is shown during image processing -->
				        <div class="fileupload-loading"></div>
				        <br>
				        <!-- The table listing the files available for upload/download -->
				        <table class="table table-striped">
				        	<tbody class="files" id="files_list" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody>
				        </table>
				    </form>
        		</div>
        		<!-- JQUERY UPLOAD ENDS HERE-->
        		
            	<div class="span6" style="vertical-align: baseline;">
            			<div style="margin-top: 40px; font-family: Verdana, Geneva, Arial, Helvetica, sans-serif; font-size: 14px;">
            			<b>pixChan</b> — это сервис хранения картинок для имиджборд.<br>
            			Здесь можно хранить свои олдфажные паки "колобков", рожь и прочих butthurt'ов.
            			Все пикчи участвуют в рейтинге и поиске.<br>
            			Для того чтобы загрузить картинку необходимо указать ее название, пожалуйста выбирайте
            			осмысленные названия, чтобы можно было удобно пользоваться поиском.<br> 
            			Так же сразу можно загрузить несколько картинок если удерживать Ctrl.<br> 
            			Надеюсь тебе понравится <b>Аноним</b>.
            			</div>
            	</div>
            	<div class="span6"><img src="static/img/2ch_tian_logo_small_small.jpg"></div>
            	<% link_attr={"class": "btn small"} %>  
  				<% curpage_attr={"class": "btn primary small disabled"} %>  
  				<% dotdot_attr={"class": "btn small disabled"} %> 
            	<div class="span12">
            		<div class="ui-widget">
	            		<form class="well form-search" method="post">
	            			<center>
		            			<input type="text" class="input-large search-query" name="q" style="width: 600px; height: 40px; font-size: 22px;">
		            			<button class="btn" type="submit" style="height: 40px; width: 60px;">
		            				<i class="icon-search"></i>
		            			</button>
	            			</center>
	            		</form>
            		</div>
            		${pager.pager(format="$link_previous ~2~ $link_next",
            										symbol_previous="<<",
            										symbol_next=">>",
            										link_attr=link_attr,
            										curpage_attr=curpage_attr,
            										dotdot_attr=dotdot_attr)}
                	<center>
	                	<table>
							${makerow(pager.items[:5])}
							${makerow(pager.items[5:10])}
							${makerow(pager.items[10:15])}
							${makerow(pager.items[15:])}
	                	</table>
                	</center>
          	</div>
        </div>
        
		        <div class="footer">
					<span style="text-align: center;"><b>Smart Media Machines &copy;</b></span>
		        </div>
		        
	       <!-- JavaScripts for file upload-->
        <script>
        var fileUploadErrors = {
            maxFileSize: 'Файл очень большой',
            minFileSize: 'Файл очень маленький',
            acceptFileTypes: 'Загрузка только картинок',
            maxNumberOfFiles: 'Слишком большое количество файлов',
            uploadedBytes: 'Слишком большой размер загрузки',
            emptyResult: 'Хуйня какая-то'
        };
        </script>
        
        <!-- The template to display files available for upload -->
        <script id="template-upload" type="text/html">
        {% for (var i=0, files=o.files, l=files.length, file=files[0]; i<l; file=files[++i]) { %}
            <tr class="template-upload fade">
                <td class="preview"><span class="fade"></span></td>
                <td class="name">{%=file.name%}</td>
                <td class="size">{%=o.formatFileSize(file.size)%}</td>
                //target field can be declarated here
                <td>
                	<label>название*:</label>
                	<input type="text" name="title" style="height: 30px;" id="pic_title">
                </td>

                {% if (file.error) { %}
                    <td class="error" colspan="2"><span class="label label-important">Error</span> {%=fileUploadErrors[file.error] || file.error%}</td>
                {% } else if (o.files.valid && !i) { %}
                    <td>
                        <div class="progress progress-success progress-striped active"><div class="bar" style="width:0%;"></div></div>
                    </td>
        
                    <td class="start">{% if (!o.options.autoUpload) { %}
                        <button class="btn btn-primary" style="display:none;">
                            <i class="icon-upload icon-white"></i> Выгрузить
                        </button>
                    {% } %}</td>
                {% } else { %}
                    <td colspan="2"></td>
                {% } %}
                <td class="cancel">{% if (!i) { %}
                    <button class="btn btn-warning">
                        <i class="icon-ban-circle icon-white"></i> Удалить
                    </button>
                {% } %}</td>
            </tr>
        {% } %}
        </script>
        
        <!-- The template to display files available for download -->
        <script id="template-download" type="text/html">
        {% for (var i=0, files=o.files, l=files.length, file=files[0]; i<l; file=files[++i]) { %}
            <tr class="template-download fade">
                {% if (file.error) { %}
                    <td></td>
                    <td class="name">{%=file.name%}</td>
                    <td class="size">{%=o.formatFileSize(file.size)%}</td>
                    <td class="error" colspan="2"><span class="label label-important">Error</span> {%=fileUploadErrors[file.error] || file.error%}</td>
                {% } else { %}
                    <td class="preview">{% if (file.thumbnail_url) { %}
                        <a href="{%=file.url%}" title="{%=file.name%}" rel="gallery" download="{%=file.name%}"><img src="{%=file.thumbnail_url%}"></a>
                    {% } %}</td>
                    <td class="name">
                        <a href="{%=file.url%}" title="{%=file.name%}" rel="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
                    </td>
                    <td class="size">{%=o.formatFileSize(file.size)%}</td>
                    <td colspan="2"></td>
                {% } %}
                <td class="delete">
                    <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                        <i class="icon-trash icon-white"></i> Delete
                    </button>
                    <input type="checkbox" name="delete" value="1">
                </td>
            </tr>
        {% } %}
        </script>
        
        <!--<script src="static/js/jquery-1.7.1.min.js"></script>-->
        <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
        <script src="static/js/vendor/jquery.ui.widget.js"></script>
        <!-- The Templates plugin is included to render the upload/download listings -->
        <script src="static/js/tmpl.min.js"></script>
        <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
        <script src="static/js/load-image.min.js"></script>
        <!-- The Canvas to Blob plugin is included for image resizing functionality -->
        <script src="static/js/canvas-to-blob.min.js"></script>
        <!-- Bootstrap JS and Bootstrap Image Gallery are not required, but included for the demo -->
        <script src="static/js/bootstrap.min.js"></script>
        <script src="static/js/bootstrap-image-gallery.min.js"></script>
        <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
        <script src="static/js/jquery.iframe-transport.js"></script>
        <!-- The basic File Upload plugin -->
        <script src="static/js/jquery.fileupload.js"></script>
        <!-- The File Upload image processing plugin -->
        <script src="static/js/jquery.fileupload-ip.js"></script>
        <!-- The File Upload user interface plugin -->
        <script src="static/js/jquery.fileupload-ui.js"></script>
        <!-- The main application script -->
        <script src="static/js/main.js"></script>
        <script src="static/js/common.js"></script>
        <script src="static/js/jquery-ui-1.8.18.custom.min.js"></script>
 		<script>
            $('#fileupload').fileupload({
                    formData: {example: 'test'}
                });

            
            $('#fileupload').bind('fileuploadsubmit', function (e, data) {
                    // The example input, doesn't have to be part of the upload form:
                    var title = $('#pic_title').val();
                    data.formData = {example: title};
                    if (!data.formData.example) {
                      $('#pic_title').focus();
                      return false;
                    }
                });
                
                (function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter13819918 = new Ya.Metrika({id:13819918, enableAll: true});
        } catch(e) {}
    });
    
    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
<noscript><div><img src="//mc.yandex.ru/watch/13819918" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
		
    </body>
</html>

<%def name="makerow(row)">
    <tr>
    %for img in row:
		<td align="center" style="vertical-align: bottom;">
			<img src="static/img/pack/${img.name}.jpg" title="${img.title}" alt="${img.title}">
			<center><a href="/full_image/${img.name}">${img.title}</a></center>
		</td>
    %endfor
    </tr>
</%def>