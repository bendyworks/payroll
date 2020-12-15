// NOTE: JS `Date`s are milliseconds from the epoch.  Ruby Dates are seconds from the epoch.

// | Date                      | Daisie $59K | Donald (support) $40K | Mickey $55K | Minnie $49K |
// |---------------------------+-------------+-----------------------+-------------+-------------|
// | new Date(1352613600000.0) |        null | null                  | null        | null        |
// | new Date(1360303200000.0) |     57000.0 | null                  | null        | null        |
// | ...                       |             |                       |             |             |
// | new Date(1465362000000.0) |     59000.0 | 40000.0               | 55000.0     | 49000.0     |
// | new Date(1466053200000.0) |     59000.0 | 40000.0               | 55000.0     | 49000.0     |

google.load('visualization', '1.0', {
  packages: ['corechart'],
  callback: draw_salaries_chart
});

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

  data.map(function(row) {
    const salary_date = new Date(row[0]);
    var rest = row.slice(1);
    var rest_to_add = rest.map(function(x) {
      if(x !== null) {
        return {v: parseFloat(x)};
      } else {
        return x;
      }
    });
    var mix_to_add = rest_to_add.reduce(function (row, v, i) {
      if(v !== null) {
        return row.concat(
          v,
          `${salary_date.toLocaleDateString("en-US", { month: 'long', year: 'numeric' })}
            ${employees[i].display_name}: $${(v.v / 1000).toString()}k`
          );
      } else {
        return row.concat(v, "");
      }
    }, []);
    var row_to_add = [{v: salary_date}].concat(mix_to_add);

    data_table.addRow(row_to_add);
  });

  var chart = new google.visualization.LineChart(document.getElementById('salaries_chart'));
  chart.draw(data_table, chart_params);

  var selectHandler = function(e) {
    // Handle clicks on legend by checking whether row is null
    // (meaning we've clicked on a column header, e.g. Daisie $59k).
    // Selection is an empty array when double clicking, so don't do
    // anything in that case.
    var selection = chart.getSelection();
    if ((selection.length > 0) && (selection[0]['row'] == null)) {
      var employee_idx = selection[0]['column'] - 1;
      window.location = employees[employee_idx].employee_path_for_js;
    };
  };

  google.visualization.events.addListener(chart, 'select', selectHandler);
};
