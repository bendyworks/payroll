import React from 'react';
import PropTypes from 'prop-types';
import { ScatterChart, Scatter, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

const ExperienceGraph = ({ data }) => {
  data = JSON.parse(data);

  return (
    <ResponsiveContainer width="99%" height={500}>
      <ScatterChart
        margin={{
          top: 10,
          right: 30,
          left: 30,
          bottom: 10,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis
          type="number"
          dataKey="weighted_years_experience"
          padding={{ top: 100 }}
          unit="years"
          domain={['auto', 'auto']}
        />
        <YAxis type="number" dataKey="current_or_last_pay" name="salary" domain={['dataMin - 5000', 'auto']} />
        <Tooltip cursor={{ strokeDasharray: '3 3' }} />
        <Scatter data={data} fill="#8884d8" />
      </ScatterChart>
    </ResponsiveContainer>
  );
};

export default ExperienceGraph;
