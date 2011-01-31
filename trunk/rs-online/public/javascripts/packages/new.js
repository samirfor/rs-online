/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(function(){
   $(".button").hover(function(){
      $(this).toggleClass('ui-state-highlight', 0);
      return false;
   });

   $("#priorities").buttonset();
   $("#package_use_ip").button();

   $('#bClear').button({
      icons: {
         primary: 'ui-icon-trash'
      }
   });
   $('#bSubmit').button({
      icons: {
         primary: 'ui-icon-plusthick'
      }
   });
   $(".form-buttons").buttonset();
   //$("input[type=text]:first").focus();
});
