
$(function(){
	$('.input-large').autocomplete({
		source: '/search_autocomplete',
		minLength: 2,
		select: function(event, ui){}
	});
});
