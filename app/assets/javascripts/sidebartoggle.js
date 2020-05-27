var filtersShowing = false;

$(function() {
	//$("#sidebar").hide();
	//$("#main_content").css("margin-right",0);
	$("#current_user").hide();

	var heading = $('#filters_sidebar_section h3');
  	$('#filters_sidebar_section h3').html(heading.html() + ' (ocultar/mostrar)');
  	$('#filters_sidebar_section h3').css('cursor', 'pointer');

  	// Let's default to filters being hidden.
  	$('#filters_sidebar_section .panel_contents').hide();
  	$('#main_content').css('margin-right','auto');
  	$('#search_status_sidebar_section').hide();

  	// Implement the hide / show toggle behavior.
  	$('#filters_sidebar_section h3').on('click', toggleFilters);
});

function toggleFilters() {
	$('#filters_sidebar_section .panel_contents').toggle('slide');
	$('#search_status_sidebar_section').toggle('slide');
	//$('#sidebar').toggle('slide');

	if( filtersShowing )
		$('#main_content').animate({ marginRight: '0px' }, 500);
	else
		$('#main_content').animate({ marginRight: '300px' }, 500);

	filtersShowing = !filtersShowing;
}
