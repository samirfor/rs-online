/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
$(function(){
   /* paginação */
   $('#example').dataTable({
      "bJQueryUI": true,
      "sPaginationType": "full_numbers",
      "aaSorting": [ [0, 'asc'] ]
   });

   /* detalhes do pacote */
   $("#toggler").button({
      icons: {
         primary: ' ui-icon-plus'
      }
   });
   
   $("#toggler").click(function() {
      $("#details").toggle("blind",null,500);
   });
});