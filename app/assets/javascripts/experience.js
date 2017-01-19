// | Years of Experience | Daisie $59K | tooltip text | Donald (support) $40K | tooltip text | Employee N | tooltip text |
// |---------------------+-------------+--------------+-----------------------+--------------+------------+--------------|
// |                3.77 | 59000.0     | String       | null                  | null         | null       | null         |
// |                3.06 | null        | null         | 40000.0               | String       | null       | null         |
// |               Float | null        | null         | null                  | null         | Float      | string       |



google.load('visualization', '1.0', {
  packages: ['corechart'],
  callback: draw_experience_chart
});

function draw_experience_chart() {
  var data_table = new google.visualization.DataTable();
  var data = $("#experience_chart").data("dataTable");
  var employees = $("#experience_chart").data("employees");
  var chart_params = $("#experience_chart").data("chartParams");

  data_table.addColumn({
    "type":"number",
    "label":"Years of Experience"
  });

  employees.map(function(employee) {
    data_table.addColumn({
      "type": "number",
      "label": employee.first_name + " " + employee.display_pay
    });
    data_table.addColumn({
      "type": "string",
      "label": "tooltip text",
      "role": "tooltip"
    });
  });

  data.map(function(row) {
    var row_to_add = row.map(function(x) {
      var parsed = parseFloat(x);
      if(isNaN(parsed)) {
        if(x !== null) {
          return {v: x};
        } else {
          return x;
        }
      } else {
        return {v: parsed};
      }
    });

    data_table.addRow(row_to_add);
  });

  var chart = new google.visualization.ScatterChart(document.getElementById('experience_chart'));
  chart.draw(data_table, chart_params);

  var selectHandler = function(e) {
    // Handle clicks on legend by checking whether row is null
    // (meaning we've clicked on a column header, e.g. Daisie $59k).
    // Selection is an empty array when double clicking, so don't do
    // anything in that case.
    //
    // NOTE: This depends on the shape of the data columns.
    var selection = chart.getSelection();
    if ((selection.length > 0) && (selection[0]['row'] == null)) {
      var employee_idx = (selection[0]['column'] - 1) / 2;
      window.location = employees[employee_idx].employee_path_for_js;
    };
  };

  google.visualization.events.addListener(chart, 'select', selectHandler);
};
