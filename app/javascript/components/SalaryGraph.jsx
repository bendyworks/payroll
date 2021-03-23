import React, { useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

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
      <LineChart data={data} margin={{ bottom: 80 }}>
        <CartesianGrid fill="#2c3e50" strokeOpacity={0.15} strokeDasharray="4 4" vertical={false} />
        <XAxis dataKey="date" tickMargin={10} tickFormatter={formatDate} />
        <YAxis padding={{ bottom: 15, top: 15 }} domain={['auto', 'auto']} tickFormatter={formatSalary} />
        <Tooltip content={<TooltipContent />} />
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
              id={emp.id}
              key={emp.id}
              name={emp.name}
              type="monotone"
              dataKey={`${emp.id}.salary`}
              stroke={colors[i % colors.length]}
              fill={colors[i % colors.length]}
              strokeWidth={hoveredId == emp.id ? 3 : 1.5}
              activeDot={{ r: 6 }}
            />
          );
        })}
      </LineChart>
    </ResponsiveContainer>
  );
};

export default SalaryGraph;
