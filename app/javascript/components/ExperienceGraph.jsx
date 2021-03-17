import React from 'react';
import PropTypes from 'prop-types';
import { ScatterChart, Scatter, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const ExperienceGraph = ({ data }) => {
  data = JSON.parse(data);

  const handleLegendClick = (e) => {
    const id = e.payload.data[0].id;
    window.location.href = `/employees/${id}`;
  };

  return (
    <ResponsiveContainer width="99%" height={500}>
      <ScatterChart
        margin={{
          top: 5,
          right: 30,
          left: 20,
          bottom: 5,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis type="number" dataKey="weighted_years_experience" unit="years" domain={['auto', 'auto']} />
        <YAxis type="number" dataKey="current_or_last_pay" name="salary" domain={['dataMin - 5000', 'auto']} />
        <Tooltip />
        <Legend
          onClick={handleLegendClick}
          width="50%"
          iconType="diamond"
          iconSize={12}
          wrapperStyle={{ position: 'relative', margin: 'auto', bottom: 25, zIndex: 1 }}
        />
        {data.map((employee) => (
          <Scatter key={employee.id} data={[employee]} name={employee.display_name} fill="#8884d8" />
        ))}
      </ScatterChart>
    </ResponsiveContainer>
  );
};

export default ExperienceGraph;
