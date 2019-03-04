// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery2
//= require jquery-ui

//=require jquery.mjs.nestedSortable.js


var my_func = function(){

    $('.sortable_tree').each(function() {
        $(this).nestedSortable({
            forceHelperSizeType: true,
            errorClass: 'cantdoit',
            disableNesting: 'cantdoit',
            handle: '> .item',
            helper: 'clone',
            listType: 'ol',
            items: 'li',
            opacity: 0.6,
            placeholder: 'placeholder',
            revert: 250,
            maxLevels: $(this).data('max-levels'),
            //maxLevels: #{options[:max_levels] || 5},
            //tabSize: 20,
            // protectRoot: $(this).data('protect-root'),

            // prevent drag flickers
            tolerance: 'pointer',
            toleranceElement: '> div',
            isTree: true,
            startCollapsed: false,
            //startCollapsed: $(this).data("start-collapsed"),

            relocate: function(){
                //$(this).nestedSortable("disable");
                var data = $(this).nestedSortable("serialize");
                var url = $(this).data("sortable-url");

                // update on server
                $.ajax({
                    url: url,
                    type: "post",
                    data: data
                }).always(function(){
                    //$(this).nestedSortable("enable");

                    $(this).find('.item').each(function(index){
                        if (index % 2){
                            $(this).removeClass('odd').addClass('even');
                        }else{
                            $(this).removeClass('even').addClass('odd');
                        }
                    });

                }).done(function(data){

                }).fail(function(jqXHR, textStatus){

                });


                //$(this).nestedSortable("enable");
            }
        }); // nested tree
    });


}
document.addEventListener("turbolinks:load", function() {
  my_func();
})
