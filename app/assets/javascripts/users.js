$(document).ready(function(){
  $('.admin_checkbox').click(function() {
    var user_id = $(this).parents()[1].id.split('_')[1];
    var checked = $(this).is(':checked');

    $.ajax({
        type: "POST",
        url: "/users/" + user_id + "/set_admin_status?checked=" + checked,
        data: { id: $(this).data('user_id'), checked: checked }
     });     
  });
});