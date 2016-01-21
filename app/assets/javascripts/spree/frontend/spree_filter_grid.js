var removeActive = function () {
	$('.i-th').removeClass('active');
	$('.i-th-vertical').removeClass('active');
	$('.i-th-large').removeClass('active');
	$('.i-th-extra-large').removeClass('active');
};


$('document').ready( function () {

	// Added to activate mobile or desktop icon
	var windowWidth = $(window).width();
	if (windowWidth > 767){
		$('.i-th').addClass('active');
	} else {
		$('.i-th-vertical').addClass('active');
	}

    
	$('a#grid-th-extra-large').on('click', function(){
		removeActive();
		$('.i-th-extra-large').addClass('active');
		$('ul.product-list li').each( function() {
			$(this).css('width','23.0769%').removeProp('clear');
		});
		$('ul.product-listing  li').each( function() {
			$(this).css('width','23.0769%').removeProp('clear');
		});
	});

	$('a#grid-th-large').on('click', function(){
		removeActive();
		$('.i-th-large').addClass('active').removeProp('clear');
		$('ul.product-list li').each( function() {
			$(this).css('width','31.6239%').removeProp('clear');
		});

		$('ul.product-listing  li').each( function() {
			$(this).css('width','31.6239%').removeProp('clear');
		});
	});

	$('a#grid-th').on('click', function(){
		removeActive();
		$('.i-th').addClass('active');
		$('ul.product-list  li').each( function() {
			$(this).css('width','48.7179%').removeProp('clear');
		});
		$('ul.product-listing  li').each( function() {
			$(this).css('width','48.7179%').removeProp('clear');
		});
	});

	$('a#grid-th-vertical').on('click', function(){
		removeActive();
		$('.i-th-vertical').addClass('active');
		$('ul.product-list  li').each( function() {
			$(this).css('width','100%').removeProp('clear');
		});
		$('ul.product-listing  li').each( function() {
			$(this).css('width','100%').removeProp('clear');
		});
	});
});


