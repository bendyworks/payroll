google.load('visualization', '1.0', {
  packages: ['corechart'],
  callback: draw_salaries_chart
});

function parseRow(row) {
  return row.map(function (x, i) {
    // First row is date--example: 1357016400000
    if (i == 0) {
      return new Date(x)
      // Odd rows are salaries in floats--example: "50000.0"
    } else if ((i % 2) == 1 && x !== null) {
      return parseFloat(x);
    } else {
      return x;
    }
  });
};

function draw_salaries_chart() {
  var data_table = new google.visualization.DataTable();
  var data = $("#salaries_chart").data("dataTable");
  var employees = $("#salaries_chart").data("employees");
  var chart_params = $("#salaries_chart").data("chartParams");

  data_table.addColumn({
    "type": "date",
    "label": "Date"
  });

  employees.map(function(employee) {
    data_table.addColumn({
      "type": "number",
      "label": employee.display_name
    });
    data_table.addColumn({
      "type": "string",
      "role": "tooltip"
    });
  });

  data.map(function (row) {
    data_table.addRow(parseRow(row));
  });

  var chart = new google.visualization.LineChart(document.getElementById('salaries_chart'));
  chart.draw(data_table, chart_params);

  var selectHandler = function() {
    // Handle clicks on legend by checking whether row is null
    // (meaning we've clicked on a column header, e.g. Daisie $59k).
    // Selection is an empty array when double clicking, so don't do
    // anything in that case.
    var selection = chart.getSelection();
    if ((selection.length > 0) && (selection[0]['row'] == null)) {

      var colno = selection[0]['column']
      var employee_idx = colno - (1 + Math.floor(colno/2))
      window.location = employees[employee_idx].employee_path_for_js;
    };
  };

  google.visualization.events.addListener(chart, 'select', selectHandler);
};
