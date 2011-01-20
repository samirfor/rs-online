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

   //$("input[type=text]:first").focus();
});
