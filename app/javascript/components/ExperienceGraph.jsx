import React from "react";
import PropTypes from "prop-types";
import {
  ScatterChart,
  Scatter,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from "recharts";

const ExperienceGraph = ({ data }) => {
  data = JSON.parse(data);

  return (
    <ResponsiveContainer width="99%" height={500}>
      <ScatterChart
        width={400}
        height={400}
        margin={{
          top: 20,
          right: 20,
          bottom: 20,
          left: 20,
        }}
      >
        <CartesianGrid />
        <XAxis
          type="number"
          dataKey="weighted_years_experience"
          name="experience"
          unit="years"
          domain={["auto", "auto"]}
        />
        <YAxis
          type="number"
          dataKey="current_or_last_pay"
          name="salary"
          domain={["dataMin - 5000", "auto"]}
        />
        <Tooltip cursor={{ strokeDasharray: "3 3" }} />
        <Scatter name="A school" data={data} fill="#8884d8" />
      </ScatterChart>
    </ResponsiveContainer>
  );
};

export default ExperienceGraph;
