/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(function(){
   $("#def_search").button();

   $("input[type=text]:first").focus();

   $(".poshytip").poshytip({
      className: 'tip-darkgray',
      bgImageFrameSize: 9,
      offsetX: -25,
      showTimeout: 1,
      hideTimeout: 1,
      followCursor: true
   });

   $("#flash-msg").click(function() {
      $("#flash-msg").hide('blind',null,600);
		return false;
   });
});