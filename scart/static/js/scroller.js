$(document).ready(function() {      
	  
	  
	  $(function() {
		$( ".slider-vertical" ).slider({
			orientation: "vertical",
			range: "max",
			min: 0,
			max: 2000,
			value: 20,
			slide: function( event, ui ) {
				$( ".amount" ).val( ui.value );
				
			}
		});
		$( ".amount" ).val( $( ".slider-vertical" ).slider( "value" ) );
	});
	  
	   $(function() {
		$( ".slider-vertical1" ).slider({
			orientation: "vertical",
			range: "max",
			min: 0,
			max: 50,
			value: 20,
			slide: function( event, ui ) {
				$( ".amount1" ).val( ui.value );
			}
		});
		$( ".amount1" ).val( $( ".slider-vertical1" ).slider( "value" ) );
	});
	   
	   
	
	$(function() {
//change the main div to overflow-hidden as we can use the slider now
$('#scroll-pane').css('overflow','hidden');

//compare the height of the scroll content to the scroll pane to see if we need a scrollbar
var difference = $('#scroll-content').height()-$('#scroll-pane').height();//eg it's 200px longer 

if(difference>0)//if the scrollbar is needed, set it up...
{
   var proportion = difference / $('#scroll-content').height();//eg 200px/500px
   var handleHeight = Math.round((1-proportion)*$('#scroll-pane').height());//set the proportional height - round it to make sure everything adds up correctly later on
   handleHeight -= handleHeight%2; 

   $("#scroll-pane").after('<\div id="slider-wrap"><\div id="slider-vertical"><\/div><\/div>');//append the necessary divs so they're only there if needed
   $("#slider-wrap").height($("#scroll-pane").height());//set the height of the slider bar to that of the scroll pane


   //set up the slider 
   $('#slider-vertical').slider({
      orientation: 'vertical',
      min: 0,
      max: 100,
      value: 100,
      slide: function(event, ui) {//used so the content scrolls when the slider is dragged
         var topValue = -((100-ui.value)*difference/100);
         $('#scroll-content').css({top:topValue});//move the top up (negative value) by the percentage the slider has been moved times the difference in height
      },
      change: function(event, ui) {//used so the content scrolls when the slider is changed by a click outside the handle or by the mousewheel
         var topValue = -((100-ui.value)*difference/100);
         $('#scroll-content').css({top:topValue});//move the top up (negative value) by the percentage the slider has been moved times the difference in height
      }
   });

   //set the handle height and bottom margin so the middle of the handle is in line with the slider
   $(".ui-slider-handle").css({height:handleHeight,'margin-bottom':-0.5*handleHeight});
	
   var origSliderHeight = $("#slider-vertical").height();//read the original slider height
   var sliderHeight = origSliderHeight - handleHeight ;//the height through which the handle can move needs to be the original height minus the handle height
   var sliderMargin =  (origSliderHeight - sliderHeight)*0.5;//so the slider needs to have both top and bottom margins equal to half the difference
   $(".ui-slider").css({height:sliderHeight,'margin-top':sliderMargin});//set the slider height and margins
   
}//end if

//code to handle clicks outside the slider handle
$(".ui-slider").click(function(event){//stop any clicks on the slider propagating through to the code below
   	event.stopPropagation();
   });
   
$("#slider-wrap").click(function(event){//clicks on the wrap outside the slider range
	  var offsetTop = $(this).offset().top;//read the offset of the scroll pane
	  var clickValue = (event.pageY-offsetTop)*100/$(this).height();//find the click point, subtract the offset, and calculate percentage of the slider clicked
	  $("#slider-vertical").slider("value", 100-clickValue);//set the new value of the slider
}); 
	 
//additional code for mousewheel


});
	
});

// JavaScript Document