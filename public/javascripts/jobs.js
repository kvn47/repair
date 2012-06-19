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
  
});

save_statuses = function(){
  $.post("/save_jobs_statuses", statuses);
}
