$(function() {
	
	function Image(imgHash){
		this.imgHash = this.clear_hash(imgHash);
	}
	
	Image.prototype.is_choose = true;
	
	Image.prototype.clear_hash = function(imgHashUrl){
		return imgHashUrl.slice(12);
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
	//IMPORTANT: doesn't work properly on second interaction
	//solve THIS solve image attrs edition
	ImageSet.prototype.getEditable = function(){
		if (this.set.length == 1){
			var imgHash = this.set[0].imgHash;
			var txt = $('a[href$='+imgHash+']').text().trim();
			var lang = $('a[href$='+imgHash+'] input').val();
			console.log({'txt': txt, 'lang': lang, 'imgHash': imgHash});
			return {'txt': txt, 'lang': lang, 'imgHash': imgHash};
		}
	};
	ImageSet.prototype.delAll = function(){
		var currentSet = this.set;
		if (currentSet.length > 0){
			$.each(currentSet, function(i){
				$.ajax({
					url: '/img/'+currentSet[i].imgHash,
					type: 'DELETE',
					success: function(){},
					error: function(){}
				})
			});
		}
	};
	
	
	var imagesChoosen = new ImageSet();
	
	$('#del_all').click(function(){
		imagesChoosen.delAll();
	});
	
	
	$('#edit').click(function(){
		var editable = imagesChoosen.getEditable();
		$.ajax({
			url: '/img/'+editable.imgHash,
			type: 'POST',
			data: {'title': editable.txt, 'lang': editable.lang},
			success: function(){},
			error: function(){}
		});
	});
	
	
	var speedAnimation = '';
	$('#content_table a').click(function(event){
		event.preventDefault();
		el = new Image($(this).attr('href'));
		if (imagesChoosen.process(el)){
			$(this).parent().css("border", "3px dotted orange");	
		} else {
			$(this).parent().css("border", "None");
		}
		
		if (imagesChoosen.length() == 0){
			$('#not_select').show(speedAnimation);
			$('#editor-form').hide(speedAnimation);
			$('#del_all').hide(speedAnimation);
		} else if (imagesChoosen.length() == 1){
			$('#editor-form').show(speedAnimation);
			var editableFields = imagesChoosen.getEditable();
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
