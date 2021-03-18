import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { ScatterChart, Scatter, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const ExperienceGraph = ({ data }) => {
  data = JSON.parse(data);
  data.forEach((emp) => {
    emp.weighted_years_experience = Math.round(emp.weighted_years_experience * 100) / 100;
  });

  const [hoveredId, setHoveredId] = useState(null);
  const colors = ['#f25f5c', '#CCA300', '#00CCAD', '#2A8CB7', '#995C88'];

  const handleLegendClick = (e) => {
    window.location.href = `/employees/${e.payload.id}`;
  };

  const handleLegendHover = (e) => {
    setHoveredId(e.payload.id);
  };

  return (
    <ResponsiveContainer width="99%" height={480}>
      <ScatterChart margin={{ bottom: 80 }}>
        <CartesianGrid fill="#2c3e50" strokeOpacity={0.15} strokeDasharray="4 4" />
        <XAxis
          type="number"
          dataKey="weighted_years_experience"
          name="experience"
          tickMargin={10}
          unit=" years"
          domain={['auto', 'auto']}
        />
        <YAxis
          type="number"
          allowDecimals={false}
          dataKey="current_or_last_pay"
          name="salary"
          domain={['dataMin - 5000', 'auto']}
          padding={{ bottom: 20 }}
          tickFormatter={(tick) => `${Math.floor(tick / 1000)}k`}
          form
        />
        <Tooltip />
        <Legend
          onClick={handleLegendClick}
          onMouseEnter={handleLegendHover}
          onMouseLeave={() => setHoveredId(null)}
          iconType="diamond"
          align="right"
          width="100%"
          wrapperStyle={{ position: 'relative', top: -80, zIndex: 1, cursor: 'pointer' }}
        />
        {data.map((employee, i) => (
          <Scatter
            id={employee.id}
            key={employee.id}
            data={[employee]}
            name={employee.display_name}
            shape="diamond"
            stroke={'#ffffff'}
            strokeWidth={hoveredId == employee.id ? 2 : 0}
            fill={colors[i % colors.length]}
          />
        ))}
      </ScatterChart>
    </ResponsiveContainer>
  );
};

export default ExperienceGraph;
