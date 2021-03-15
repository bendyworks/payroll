import React from "react";
import PropTypes from "prop-types";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";

const SalaryGraph = ({ data }) => {
  let employees = Object.keys(data[0]);
  employees.shift();

  return (
    <ResponsiveContainer width="99%" height={500}>
      <LineChart
        data={data}
        margin={{
          top: 5,
          right: 30,
          left: 20,
          bottom: 5,
        }}
      >
        <XAxis dataKey="date" />
        <YAxis type="number" domain={["dataMin - 5000", "auto"]} />
        <CartesianGrid />
        <Tooltip />
        <Legend />
        {employees.map((name, i) => {
          return (
            <Line
              key={i}
              type="monotone"
              dataKey={name}
              stroke="#8884d8"
              activeDot={{ r: 8 }}
            />
          );
        })}
      </LineChart>
    </ResponsiveContainer>
  );
};

export default SalaryGraph;
