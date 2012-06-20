var statuses = {};
$(document).ready(function(){
  
  $('.status_img').click(function(){
    if($(this).attr('src').match('red_x.png')){
      $(this).attr('alt', '✓');
      $(this).next('.status_val').html('✓');
      $(this).slideUp(100).attr('src', '/images/green_check.png').slideDown(100);
      var job_id = $(this).parent().parent().children('.job_id_col').text();
      statuses["jb_"+job_id] = 1;
    }
    else{
      $(this).attr('alt', '✕');
      $(this).next('.status_val').html('✕');
      $(this).slideUp(100).attr('src', '/images/red_x.png').slideDown(100);
      var job_id = $(this).parent().parent().children('.job_id_col').text();
      statuses["jb_"+job_id] = 0;
    }
  });
  
  $('#filter_date_from').datepicker({
    changeMonth: true,
    changeYear: true,
    showAnim: 'slideDown',
    onSelect: function(selectedDate, inst) {
      $('#filter_date_to').datepicker('option', 'minDate', selectedDate);
      if($('#filter_date_to').val() == '') {
        $('#filter_date_to').datepicker('setDate', selectedDate);
      }
    }
  });
  
  $('#filter_date_to').datepicker({
    changeMonth: true,
    changeYear: true,
    showAnim: 'slideDown',
    onSelect: function(selectedDate) {
      $('#filter_date_from').datepicker('option', 'maxDate', selectedDate);
      if($('#filter_date_from').val() == '') {
        $('#filter_date_from').datepicker('setDate', selectedDate);
      }
    }
  });
  
  $('#filter_date_from,#filter_date_to').datepicker($.datepicker.regional['ru']);
  
  save_statuses = function(){
    $.post("/save_jobs_statuses", statuses);
  }
  
});

