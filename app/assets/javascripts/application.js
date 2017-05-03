// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require gmaps/google
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require underscore
//= require_tree .
$(document).ready(function(){

    $('#appointment_department_id').on('change', function(){
       var value = $('#appointment_department_id option:selected').val();
       $.ajax('updatedoctors/'+value,{
          success: function(response){
          }
       });
    });

    $('#appointment_doctor_id').on('change', function(){
       var value = $('#appointment_doctor_id option:selected').val();
       $.ajax('updatetime/'+value,{
          success: function(response){
          }
       });
    });

    $('#appointment_doctor_id').on('change', function(){
       var value = $('#appointment_doctor_id option:selected').val();
       $.ajax('updatedate/'+value,{
          success: function(response){
          }
       });
    });

  var current_fs,next_fs,previous_fs;  //fieldsets
  var left,opacity,scale;  // fieldsets properties which we will animate

  $(".next").click(function(){
      current_fs = $(this).parent();
      next_fs = $(this).parent().next();
      // activate next step on progressbar
      $("progressbar li").eq($("#msform fieldset").index(next_fs)).addClass("active");
        //show next fieldset
        next_fs.show();
        //hide current fieldset
        current_fs.animate({opacity: 0},{
          step: function(now,mx){
              scale = 1 - (1 - now)* 0.2;
              left = (now*50)+'%';
              opacity = 1 - now;
              current_fs.css({'transform':'scale('+scale+')'});
              next_fs.css({'left':left,'opacity':opacity});
            },
            duration:800,
            complete:function(){
                current_fs.hide();
            },
            //this comes from custom easing plugin
            easing:'easeInOutBack'
        });
   });

   $(".previous").click(function(){
      current_fs = $(this).parent();
      previous_fs = $(this).parent().prev();
      // activate next step on progressbar
      $("progressbar li").eq($("#msform fieldset").index(current_fs)).removeClass("active");
        //show next fieldset
        previous_fs.show();
        //hide current fieldset
        current_fs.animate({opacity: 0},{
          step: function(now,mx){
              scale = 0.8 + (1-now) * 0.2;
              left = ((1-now)*50)+"%";
              opacity = 1 - now;
              current_fs.css({'left':left});
              previous_fs.css({'transform':'scale('+scale+')','opacity':opacity});
            },
            duration:800,
            complete:function(){
                current_fs.hide();
            },
            //this comes from custom easing plugin
            easing:'easeInOutBack'
        });
      });

});
