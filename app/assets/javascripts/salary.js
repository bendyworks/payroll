google.load('visualization', '1.0', {
  packages: ['corechart'],
  callback: draw_salary_chart
});

function draw_salary_chart() {
  var employee_name = $("#salary_chart").data("employeeName");
  var data = $("#salary_chart").data("dataTable");
  var data_table = new google.visualization.DataTable({
    cols: [
      {"label": "Date", "type": "date"},
      {"label": employee_name, "type": "number"}
    ],
    rows: data.map(function(d) {
      d.c[0] = {v: new Date(d.c[0])};
      d.c[1] = {v: parseFloat(d.c[1])};
      return d;
    })
  });
  var chart_params = $("#salary_chart").data("chartParams");

  var chart = new google.visualization.LineChart(document.getElementById('salary_chart'));
  chart.draw(data_table, chart_params);
};
