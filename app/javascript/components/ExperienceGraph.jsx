import React, { useState } from 'react';
import {
  ScatterChart,
  Scatter,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  ZAxis,
} from 'recharts';

import { generateUniqueColors } from '../utils/generateUniqueColors';

/* eslint react/prop-types: 0 */

function formatSalary(salary) {
  return `${Math.floor(salary / 1000)}k`;
}

function formatExperience(exp) {
  return Math.round(exp * 100) / 100;
}

const TooltipContent = ({ active, payload }) => {
  if (active && payload && payload.length) {
    const data = payload[0].payload;

    return (
      <div
        className="custom-tooltip"
        style={{ backgroundColor: 'rgba(210, 210, 210, 0.5)', padding: 10, textAlign: 'center', borderRadius: 8 }}
      >
        <p style={{ color: data.color }}>{`${data.name}`}</p>
        <p style={{ color: 'black', margin: 0 }}>{`${formatExperience(payload[0].value)} years`}</p>
        <p style={{ color: 'black', margin: 0 }}>{formatSalary(payload[1].value)}</p>
      </div>
    );
  }

  return null;
};

const ExperienceGraph = ({ data }) => {
  const colors = generateUniqueColors(data.length, 100, 40);
  const [hoveredId, setHoveredId] = useState(null);

  data.forEach((emp, i) => {
    emp.color = colors[i % colors.length];
  });

  const handleLegendClick = (e) => {
    window.location.href = `/employees/${e.payload.id}`;
  };

  const handleLegendHover = (e) => {
    setHoveredId(e.payload.id);
  };

  return (
    <ResponsiveContainer width="99%" height={480}>
      <ScatterChart margin={{ bottom: 80 }}>
        <CartesianGrid fill="#ecf0f1" strokeOpacity={0.75} strokeDasharray="4 4" />
        <XAxis
          type="number"
          dataKey="experience"
          domain={['auto', 'auto']}
          tickFormatter={formatExperience}
          tickMargin={10}
          unit=" years"
        />
        <YAxis
          type="number"
          dataKey="salary"
          domain={['dataMin', 'auto']}
          tickFormatter={formatSalary}
          padding={{ bottom: 15, top: 15 }}
        />
        <ZAxis range={[150, 150]} />
        <Tooltip content={<TooltipContent />} />
        <Legend
          onClick={handleLegendClick}
          onMouseEnter={handleLegendHover}
          onMouseLeave={() => setHoveredId(null)}
          iconType="circle"
          iconSize={8}
          align="right"
          width="100%"
          wrapperStyle={{ position: 'relative', top: -80, zIndex: 1, cursor: 'pointer' }}
        />
        {data.map((employee, i) => (
          <Scatter
            id={employee.id}
            key={employee.id}
            data={[employee]}
            name={employee.name}
            shape="circle"
            stroke={'#ffffff'}
            strokeWidth={hoveredId == employee.id ? 2 : 0}
            fill={colors[i]}
            onMouseOver={handleLegendHover}
            onMouseOut={() => setHoveredId(null)}
          />
        ))}
      </ScatterChart>
    </ResponsiveContainer>
  );
};

export default ExperienceGraph;
