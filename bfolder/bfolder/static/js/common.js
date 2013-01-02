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
				contents: 'json',
				type: 'POST',
				data: form_data,
				success: function(response){
					form.resetForm();
					$('#myModal').modal('hide');
					reload_table();
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