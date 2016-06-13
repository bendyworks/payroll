(function(){
  function handlePageLoad() {
    $("#salaries_chart").click(function(){
      window.location.href = window.location.protocol + "//" + window.location.host + "/salaries";
    });
    $("#experience_chart").click(function(){
      window.location.href = "/experience";
    });
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
