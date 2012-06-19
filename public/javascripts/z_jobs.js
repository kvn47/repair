var statuses = {};
$(document).ready(function(){
  
  jQuery.fn.dataTableExt.oSort['ru_date-asc']  = function(a,b) {
    var ukDatea = a.split('.');
    var ukDateb = b.split('.');

    var x = (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
    var y = (ukDateb[2] + ukDateb[1] + ukDateb[0]) * 1;

    return ((x < y) ? -1 : ((x > y) ?  1 : 0));
  };

  jQuery.fn.dataTableExt.oSort['ru_date-desc'] = function(a,b) {
    var ukDatea = a.split('.');
    var ukDateb = b.split('.');

    var x = (ukDatea[2] + ukDatea[1] + ukDatea[0]) * 1;
    var y = (ukDateb[2] + ukDateb[1] + ukDateb[0]) * 1;

    return ((x < y) ? 1 : ((x > y) ?  -1 : 0));
  };
  
  $('#jobs_table').dataTable( {
    "oLanguage": {
      "sUrl": "dataTables.russian.txt"
    },
    "iDisplayLength": 25,
    "sPaginationType": "full_numbers",
    "bJQueryUI": false,
    "bProcessing": true,
    "aaSorting": [[ 8, "desc" ]],
    "aoColumns": [
      null,
      { "asSorting": ["asc", "desc"] },
      { "asSorting": ["asc", "desc"] },
      { "asSorting": ["asc", "desc"] },
      { "asSorting": ["asc", "desc"] },
      { "asSorting": ["asc", "desc"] },
      { "asSorting": ["asc", "desc"] },
      { "asSorting": ["asc", "desc"] },
      { "asSorting": ["asc", "desc"], "sType": "ru_date" },
      { "asSorting": ["asc", "desc"] },
      null,
      null
    ],
    "fnFooterCallback": function( nRow, aaData, iStart, iEnd, aiDisplay) {
      var is_admin = true
      var user_name = "#{current_user.username}"
      var totalSum = 0;
      
        for(var i=0; i<aiDisplay.length; i++){
          if(is_admin || (user_name == aaData[aiDisplay[i]][7])) {
            totalSum += aaData[aiDisplay[i]][6]*1;
          }
        }

        var nCells = nRow.getElementsByTagName('th');
        nCells[6].innerHTML = parseFloat(totalSum) + ' (' + parseInt(aiDisplay.length) + ')';
    }
    
  }).columnFilter( {
    aoColumns: [
      null,
      { type: "select", values: ['✓', '✕'] },
      { type: 'text' },
      { type: 'text' },
      { type: 'text' },
      { type: 'text' },
      { type: 'number' },
      { type: "text" },
      { type: 'text' },
      { type: 'select', values: ['✓', '✕'] },
      null,
      null
    ]
  });
  
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

function save_statuses(){
  $.post("/save_jobs_statuses",
         statuses
        );
  }
