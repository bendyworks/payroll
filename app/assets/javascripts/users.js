$(document).ready(function(){
  $('.admin_checkbox').click(function() {
    var checked; 
    var user_id = $(this).parents()[1].id.split('_')[1]
    if ($(this).is(':checked')) {
      checked = true;
    } else {
      checked = false;
    }
    $.ajax({
        type: "POST",
        url: "/users/" + user_id + "/set_admin_status?checked=" + checked,
        data: { id: $(this).data('user_id'), checked: checked }
     });     
  });
});