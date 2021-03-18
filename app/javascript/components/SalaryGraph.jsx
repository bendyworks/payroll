import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const SalaryGraph = ({ data }) => {
  const employees = Object.keys(data[0])
    .filter((key) => key != 'date')
    .map((id) => ({ id, name: data[0][id]['name'] }));

  const [hoveredId, setHoveredId] = useState(null);
  const colors = ['#f25f5c', '#CCA300', '#00CCAD', '#2A8CB7', '#995C88'];

  const handleLegendClick = (e) => {
    window.location.href = `/employees/${e.payload.id}`;
  };

  const handleLegendHover = (e) => {
    setHoveredId(e.payload.id);
  };

  return (
    <ResponsiveContainer width="99%" height={400}>
      <LineChart data={data}>
        <CartesianGrid fill="#2c3e50" strokeOpacity={0.15} strokeDasharray="4 4" vertical={false} />
        <XAxis dataKey="date" tickMargin={10} tickFormatter={(tick) => new Date(tick).toLocaleDateString()} />
        <YAxis
          padding={{ bottom: 20 }}
          domain={['auto', 'auto']}
          tickFormatter={(tick) => `${Math.floor(tick / 1000)}k`}
        />
        <Tooltip />
        <Legend
          onClick={handleLegendClick}
          onMouseEnter={handleLegendHover}
          onMouseLeave={() => setHoveredId(null)}
          align="right"
          width="100%"
          wrapperStyle={{ position: 'relative', top: 0, zIndex: 1, cursor: 'pointer' }}
        />
        {employees.map((emp, i) => {
          return (
            <Line
              id={emp.id}
              key={emp.id}
              name={emp.name}
              type="monotone"
              dataKey={`${emp.id}.salary`}
              stroke={colors[i % colors.length]}
              strokeWidth={hoveredId == emp.id ? 3 : 1.5}
              fill="#ffffffff"
              activeDot={{ r: 8 }}
            />
          );
        })}
      </LineChart>
    </ResponsiveContainer>
  );
};

export default SalaryGraph;
