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
				$(this).removeClass('col-md-4 col-sm-4 col-xs-6 col-md-6 col-sm-6').addClass('col-md-3 col-sm-3');
		});
		$('ul.product-listing  li').each( function() {
			$(this).removeClass('span6 span4').addClass('span3');
		});
	});

	$('a#grid-th-large').on('click', function(){
		removeActive();
		$('.i-th-large').addClass('active');
		$('ul.product-list li').each( function() {
				$(this).removeClass('col-md-3 col-sm-3 col-xs-6 col-md-6 col-sm-6').addClass('col-md-4 col-sm-4');
		});
		$('ul.product-listing  li').each( function() {
			$(this).removeClass('span3 span6').addClass('span4');
		});
	});

	$('a#grid-th').on('click', function(){
		removeActive();
		$('.i-th').addClass('active');
		$('ul.product-list  li').each( function() {
			$(this).removeClass('col-xs-12 col-md-3 col-sm-3 col-md-4 col-sm-4').addClass('col-xs-6 col-md-6 col-sm-6');
		});
		$('ul.product-listing  li').each( function() {
			$(this).removeClass('span3 span4').addClass('span6');
		});
	});

	$('a#grid-th-vertical').on('click', function(){
		removeActive();
		$('.i-th-vertical').addClass('active');
		$('ul.product-list  li').each( function() {
			$(this).removeClass('col-md-3 col-sm-3 col-md-4 col-sm-4 col-xs-6').addClass('col-xs-12');
		});
		$('ul.product-listing  li').each( function() {
			$(this).removeClass('span3 span4').addClass('span6');
		});
	});
});


