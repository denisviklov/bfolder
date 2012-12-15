$(function() {
	
	function Image(imgHash){
		this.imgHash = this.clear_hash(imgHash);
	}
	
	Image.prototype.clear_hash = function(imgHashUrl){
		return imgHashUrl.slice(12);
	}
	
	Image.prototype.info = function(){
			var imgHash = this.imgHash;
			var txt = $('a[href$='+imgHash+']').text().trim();
			var lang = $('a[href$='+imgHash+'] input').val();
			return {'txt': txt, 'lang': lang, 'imgHash': imgHash};
		}
	
	
	function ImageSet(){
		this.set = [];
	}
	
	ImageSet.prototype.length = function(){return this.set.length}
	ImageSet.prototype.process = function(imgObj){
		var is_exist = false;
		var currentSet = this.set;
		$.each(currentSet, function(i){
			if (currentSet[i].imgHash == imgObj.imgHash){
				is_exist = true;
				currentSet.pop(i);
				};
		});
	
		if (!is_exist){
			this.set[this.set.length] = imgObj;
			return true;
		} else {
			return false;}
	};

	ImageSet.prototype.get = function(i){
		return this.set[i];
	};

	ImageSet.prototype.delAll = function(){
		var currentSet = this.set;
		if (currentSet.length > 0){
			$.each(currentSet, function(i){
				$.ajax({
					url: '/img/'+currentSet[i].imgHash,
					type: 'DELETE',
					success: function(){
						this.set = [];
						reload_table();
						//NEED REALIZE SEPARATE PANEL CLASS
						$('#editor-form').hide();
						$('#del_all').hide();
						$('#not_select').show();
						},
					error: function(){}
				})
			});
		}
	};
	
	
	var imagesChoosen = new ImageSet();
	
	$('#del_all').click(function(){
		imagesChoosen.delAll();
	});
	
	$('#delete').click(function(){
		imagesChoosen.delAll();
	});
	
	
	$('#edit').click(function(){
		var imgHash = imagesChoosen.get(0).info().imgHash;
		var title = $('#name-editor-fld').val();
		var lang = $('#locale_select :selected').attr('value');
		$.ajax({
			url: '/img/'+imgHash,
			type: 'POST',
			data: {'title': title, 'lang': lang},
			success: function(){reload_table();},
			error: function(){}
		});
	});
	
	
	var speedAnimation = '';
	$('#content_table a').live('click', function(event){
		event.preventDefault();
		el = new Image($(this).attr('href'));
		if (imagesChoosen.process(el)){
			$(this).parent().css("border", "3px dotted orange");	
		} else {
			$(this).parent().css("border", "None");
		}
		//ALL ACTIONS HERE MUST PLACE IN SEPARATE CLASS METHODS
		if (imagesChoosen.length() == 0){
			$('#not_select').show(speedAnimation);
			$('#editor-form').hide(speedAnimation);
			$('#del_all').hide(speedAnimation);
		} else if (imagesChoosen.length() == 1){
			$('#editor-form').show(speedAnimation);
			var editableFields = imagesChoosen.get(0).info();
			$('#locale_select option[value="'+editableFields.lang+'"]').attr('selected', true);
			$('#name-editor-fld').val(editableFields.txt);
			$('#not_select').hide();
			$('#del_all').hide(speedAnimation);
		} else if (imagesChoosen.length() > 1){
			$('#del_all').show(speedAnimation);
			$('#editor-form').hide(speedAnimation);
			$('#not_select').hide(speedAnimation);
		}
		return false;
	});
})
