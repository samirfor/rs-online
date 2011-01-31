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

   /* append link to a package via ajax */
   // begin
   var link = $("#link_url");

   $("#dialog-form").dialog({
      autoOpen: false,
      height: 200,
      width: 450,
      modal: false,
      buttons: {
         Cancel: function() {
            $(this).dialog('close');
         },
         'Append': function() {
            if (link.val() != null && link.val() != "") {
               $("#app-link").submit();
            }
            $(this).dialog("close");
         }
      }
   });
   // abre o dialogo.
   $('#append-link').click(function() {
      $('#dialog-form').dialog('open');
   });
   // end

   /* show raw links in a textarea */
   // begin
   $("#dialog-raw-links").dialog({
      autoOpen: false,
      height: 300,
      width: 600,
      modal: false,
      buttons: {
         Ok: function() {
            $( this ).dialog( "close" );
         }
      }
   });
   // abre o dialogo
   $("#show-raw-links").click(function(){
      $("#dialog-raw-links").dialog('open');
      $("#raw_links").select();
   });
   // end
});