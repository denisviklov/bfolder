$(function(){

	$('.input-large').autocomplete({
		source: '/search_autocomplete',
		minLength: 2,
		select: function(event, ui){}
	});

	$("#from-thread-download").validate({
		submitHandler: function(form) {
			$('#send_form').prop('disabled', true);
			var form_data = $(form).serialize();
			$.ajax({
				url: '/collection/',
				type: 'POST',
				data: form_data,
				success: function(response){
					$('#myModal').modal('hide');
					$('#resetForm').trigger('click');
					$('#send_form').prop('disabled', false);
					response = jQuery.parseJSON(response);
					collection_url_tpl = 'http://pixchan.org/collections/' + response['collection_id'];
					$('#resultCollectionLink').text(collection_url_tpl);
					$('#resultModal').modal();
				},
			});
   	   	}
	});
});

function reload_table(){
	$.ajax({
		url: '/table_reload',
		type: 'POST',
		success: function(data){
			$('#content_table').html(data);
			return true;
		}
	});
}