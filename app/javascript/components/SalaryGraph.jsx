import React, { useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

import { generateUniqueColors } from '../utils/generateUniqueColors';

/* eslint react/prop-types: 0 */

function formatSalary(salary) {
  return `${Math.floor(salary / 1000)}k`;
}

function formatDate(date) {
  return new Date(date).toLocaleDateString();
}

const TooltipContent = ({ active, payload }) => {
  if (active && payload && payload.length) {
    const data = payload[0].payload;

    return (
      <div
        className="custom-tooltip"
        style={{ backgroundColor: 'rgba(0, 0, 0, 0.6)', padding: 10, textAlign: 'center', borderRadius: 8 }}
      >
        <p style={{ color: '#ffffff' }}>{`${formatDate(data.date)}`}</p>
        {payload.map((emp, i) => (
          <p key={i} style={{ color: emp.color, margin: 0 }}>{`${emp.name}: ${formatSalary(emp.value)}`}</p>
        ))}
      </div>
    );
  }

  return null;
};

const SalaryGraph = ({ data }) => {
  const employees = Object.keys(data[0])
    .filter((key) => key != 'date')
    .map((id) => ({ id, name: data[0][id]['name'] }));

  const colors = generateUniqueColors(employees.length, 100, 40);
  const [hoveredId, setHoveredId] = useState(null);

  const handleLegendHover = (e) => {
    setHoveredId(e.payload.id);
  };

  const handleLegendClick = (e) => {
    window.location.href = `/employees/${e.payload.id}`;
  };

  return (
    <ResponsiveContainer width="99%" height={480}>
      <LineChart data={data} margin={{ bottom: 80 }}>
        <CartesianGrid fill="#6b6b6b" strokeOpacity={0.35} strokeDasharray="4 4" vertical={false} />
        <XAxis dataKey="date" domain={['auto', 'auto']} tickFormatter={formatDate} tickMargin={10} />
        <YAxis domain={['auto', 'auto']} tickFormatter={formatSalary} padding={{ bottom: 10, top: 10 }} />
        <Tooltip content={<TooltipContent />} animationDuration={300} animationEasing="linear" />
        <Legend
          onClick={handleLegendClick}
          onMouseEnter={handleLegendHover}
          onMouseLeave={() => setHoveredId(null)}
          align="right"
          width="100%"
          wrapperStyle={{ position: 'relative', top: -80, zIndex: 1, cursor: 'pointer' }}
        />
        {employees.map((emp, i) => {
          return (
            <Line
              type="monotone"
              id={emp.id}
              key={emp.id}
              name={emp.name}
              dataKey={`${emp.id}.salary`}
              stroke={colors[i]}
              fill={hoveredId == emp.id ? '#ffffff' : colors[i]}
              strokeWidth={hoveredId == emp.id ? 2.5 : 1.5}
              dot={{ r: 1.75 }}
              activeDot={{ r: 2 }}
            />
          );
        })}
      </LineChart>
    </ResponsiveContainer>
  );
};

export default SalaryGraph;
