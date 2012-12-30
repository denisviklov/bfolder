## -*- coding: utf-8 -*-
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name='yandex-verification' content='430203cf93d14992' />
        <meta name="google-site-verification" content="i2wvyETaw5Ksj8Bk0qQ6KmGT_7Xegu1Q-bKHZz8rM7o" />
        <title>Pixchan.${_(u'org')} - ${_(u'хостинг мемов')}</title>
        <link rel="stylesheet" href="/static/css/bootstrap.css">
        <script src="/static/js/jquery-1.7.2.min.js"></script>
        <script src="/static/js/bootstrap.js"></script>
        <script src="/static/js/common.js"></script>
        <script src="/static/js/jquery-ui-1.8.18.custom.min.js"></script>
        <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
        <script src="/static/js/vendor/jquery.ui.widget.js"></script>
        <!-- The Templates plugin is included to render the upload/download listings -->
        <script src="/static/js/tmpl.min.js"></script>
        <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
        <script src="/static/js/load-image.min.js"></script>
        <!-- The Canvas to Blob plugin is included for image resizing functionality -->
        <script src="/static/js/canvas-to-blob.min.js"></script>
        <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
        <script src="/static/js/jquery.iframe-transport.js"></script>
        <!-- The basic File Upload plugin -->
        <script src="/static/js/jquery.fileupload.js"></script>
        <!-- The File Upload image processing plugin -->
        <script src="/static/js/jquery.fileupload-ip.js"></script>
        <!-- The File Upload user interface plugin -->
        <script src="/static/js/jquery.fileupload-ui.js"></script>
        <!-- The main application script -->
        <script src="/static/js/main.js"></script>
        <script src="/static/js/common.js"></script>
        <script src="/static/js/jquery-ui-1.8.18.custom.min.js"></script>
        <script type="text/javascript" src="/static/js/jquery.validate.js"></script>
        <!-- The stylesheets -->
        <link rel="stylesheet" href="/static/css/smoothness/jquery-ui-1.8.18.custom.css">
        <link rel="stylesheet" href="/static/css/jquery.fileupload-ui.css">
    </head>
    
    <body style="background-color: #F8F8F8;">
    %if is_admin:
    	<%namespace name="admin" file="admin.mako"/>
    		${admin.create()}
    %endif
        <div class="container">
        	<div class="row">
        		
        		<!-- JQUERY UPLOAD START HERE -->
        		<div class="span12" style="margin-top: 60px;">
				   <form id="fileupload" action="/upload" method="POST" enctype="multipart/form-data">
				        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
				        <div class="row fileupload-buttonbar">
				            <div class="span7">
				                <!-- The fileinput-button span is used to style the file input field as button -->
				                <span class="btn btn-success fileinput-button">
				                    <i class="icon-plus icon-white"></i>
				                    <span>${_(u"Добавить файл")}</span>
				                    <input type="file" name="files[]" multiple>
				                </span>
				                <button type="submit" class="btn btn-primary start">
				                    <i class="icon-upload icon-white"></i>
				                    <span>${_(u"Загрузить")}</span>
				                </button>
				                <a href="#myModal" role="button" class="btn btn-warning" data-toggle="modal">${_(u'Загрузить из треда')}</a>
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
            			<a href="/"><b>pixChan</b></a> — ${_(u'это облачный сервис хранения мемов.<br>\
            			<p></p>\
						Теперь у нас появился официальнный add-on для Firefox который позволяет <b>сохранять понравившиеся картинки в один клик!</b><br>\
						Просто кликните правой кнопкой мыши по понравившейся картинке и выберите <b>send to pixchan.</b><br>\
						Плагин можно установить из официального каталога Mozilla <a href="https://addons.mozilla.org/en-US/firefox/addon/pixchan_addon/">pixchan firefox add-on</a><br>\
						<p></p>\
						Надеюсь тебе понравится, <b>Анон</b>.<br>') | n}
            			</div>
            	</div>
            	<div class="span6"><img src="/static/img/2ch_tian_logo_small_small.jpg"></div>
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
            		<div id="content_table">
            		   %if is_collection:
                           <div style="margin-top: 10px;">
                               <a href="${back}" style="font-size: 18px;">${_(u"<< назад")}</a><br/>
                               <h2> 
                                   <span>Пак "${collection_ref.title}" картинок ${collection_ref.length}</span>
                               </h2>
                           </div>
                        %endif
                	<center>
	                	<table style="margin-top: 10px;">
							${makerow(pager.items[:5])}
							${makerow(pager.items[5:10])}
							${makerow(pager.items[10:15])}
							${makerow(pager.items[15:])}
	                	</table>
                	</center>
                	</div>
                </div>
         </div><br>
         
             		${pager.pager(format="$link_previous ~2~ $link_next",
    										symbol_previous="<<",
    										symbol_next=">>",
    										link_attr=link_attr,
    										curpage_attr=curpage_attr,
    										dotdot_attr=dotdot_attr)}
        <p></p>
        
		        <div class="footer">
					<span style="text-align: center;"><b>anonym &copy;</b></span>
		        </div>
	</div>  
	       <!-- JavaScripts for file upload-->
        <script>
        var fileUploadErrors = {
            maxFileSize: '${_(u"Файл очень большой")}',
            minFileSize: '${_(u"Файл очень маленький")}',
            acceptFileTypes: '${_(u"Загрузка только картинок")}',
            maxNumberOfFiles: '${_(u"Слишком большое количество файлов")}',
            uploadedBytes: '${_(u"Слишком большой размер загрузки")}',
            emptyResult: '${_(u"Непонятная ошибка")}'
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
                	<td class="title"><label>${_(u"Название")}*: <input style="height: 25px;" name="title[]" required></label></td>
                </td>
                <td style="display: none;">
                	<td class="title"><label>${_(u"Теги")}: <input style="height: 25px;" name="tags[]"></label></td>
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
                        <i class="icon-ban-circle icon-white"></i> ${_(u"Удалить")}
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

 		<script type="text/javascript">
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
		</script>
		<noscript>
			<div>
				<img src="//mc.yandex.ru/watch/13819918" style="position:absolute; left:-9999px;" alt="" />
				</div>
		</noscript>
		
		<script type="text/javascript">
		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-36084820-1']);
		  _gaq.push(['_setDomainName', 'pixchan.org']);
		  _gaq.push(['_setAllowLinker', true]);
		  _gaq.push(['_trackPageview']);
		
		  (function() {
		    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();
	</script>
     
    <!-- Modal -->
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel">${_(u'Загрузить из треда')}</h3>
        </div>
        <form id="from-thread-download">
            <div class="modal-body">
                <div class="control-group">
                    <label class="control-label" for="inputURL">URL (beta-версия возможна только загрузка с 2-ch.so)</label>
                    <div class="controls">
                        <input type="text" id="inputURL" name="thread_url" placeholder="URL" class="required url">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="collection_name">${_(u'Название пака (например: петушки)')}</label>
                    <div class="controls">
                        <input type="text" id="collection_name" class="required" minlength="2" name="collection_name" placeholder="${_(u'Название пака')}">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn" data-dismiss="modal" aria-hidden="true">${_(u'Закрыть')}</button>
                <input type="submit" id="send_form" class="btn btn-primary" value="${_(u'Начать загрузку')}">
            </div>
        </form>
    </div>
    <!-- End of modal-->

    </body>
</html>

<%def name="makerow(row)">
    <tr>
    %for img in row:
        %if img.type == 'collection':
            <td align="center" style="vertical-align: bottom;">
                <a href="/collections/${img.id.__str__()}">
                <img src="/static/img/pack/${img.name}.jpg" title="${img.title}" alt="${img.title}">
                <input type="hidden" name="locale" value="${img.lang}">
                <center>Пак "${img.title}" картинок ${img.length}</center></a>
            </td>        
        %else:   
    		<td align="center" style="vertical-align: bottom;">
    			<a href="/full_image/${img.name}">
    			<img src="/static/img/pack/${img.name}.jpg" title="${img.title}" alt="${img.title}">
    			<input type="hidden" name="locale" value="${img.lang}">
    			<center>${img.title}</center></a>
    		</td>
        %endif
    %endfor
    </tr>
</%def>