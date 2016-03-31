(function(){
  function handlePageLoad() {
    $("#salary_preview_chart").click(function(){
      window.location.href = window.location.protocol + "//" + window.location.host + "/salaries";
    })
  }

  $(document).ready(function(){
    console.log('document ready');
    handlePageLoad();
  });
  $(document).on('page:load', function(){
    console.log('page load');
    handlePageLoad();
  });
}());
