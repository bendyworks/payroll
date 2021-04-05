import React, { useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

import { generateUniqueColors } from '../utils/generateUniqueColors';

/* eslint react/prop-types: 0 */

function formatDate(date) {
  return new Date(date).toLocaleDateString();
}

const TooltipContent = ({ active, payload }) => {
  if (active && payload && payload.length) {
    const data = payload[0].payload;

    return (
      <div
        className="custom-tooltip"
        style={{ backgroundColor: 'rgba(210, 210, 210, 0.5)', padding: 10, textAlign: 'center', borderRadius: 8 }}
      >
        <p style={{ color: 'black' }}>{`${formatDate(data.date)}`}</p>
        {payload
          .sort((a, b) => (parseInt(a.value) > parseInt(b.value) ? -1 : 1))
          .map((account, i) => (
            <p key={i} style={{ color: account.color, margin: 0 }}>
              {`${account.name}: ${account.value}`}
            </p>
          ))}
      </div>
    );
  }

  return null;
};

const BalanceGraph = ({ data }) => {
  const accounts = Object.keys(data[0])
    .filter((key) => key != 'date')
    .map((id) => ({ id, name: data[0][id]['name'] }));

  const colors = generateUniqueColors(accounts.length, 100, 40);
  const [hoveredId, setHoveredId] = useState(null);

  const handleLegendHover = (e) => {
    setHoveredId(e.payload.id);
  };

  const handleLegendClick = (e) => {
    window.location.href = `/accounts/${e.payload.id}`;
  };

  return (
    <ResponsiveContainer width="99%" height={480}>
      <LineChart data={data} margin={{ bottom: 80 }}>
        <CartesianGrid fill="#ecf0f1" strokeOpacity={0.75} strokeDasharray="4 4" vertical={false} />
        <XAxis type="number" dataKey="date" domain={['auto', 'auto']} tickMargin={10} tickFormatter={formatDate} />
        <YAxis type="number" padding={{ top: 15 }} domain={['auto', 'auto']} />
        <Tooltip content={<TooltipContent />} animationDuration={300} animationEasing="linear" />
        <Legend
          onClick={handleLegendClick}
          onMouseEnter={handleLegendHover}
          onMouseLeave={() => setHoveredId(null)}
          align="right"
          width="100%"
          wrapperStyle={{ position: 'relative', top: -80, zIndex: 1, cursor: 'pointer' }}
        />
        {accounts.map((account, i) => {
          return (
            <Line
              type="monotoneX"
              id={account.id}
              key={account.id}
              name={account.name}
              dataKey={`${account.id}.balance.amount`}
              stroke={colors[i]}
              fill={hoveredId == account.id ? '#ffffff' : colors[i]}
              strokeWidth={hoveredId == account.id ? 2.5 : 1.5}
              dot={{ r: 1.75 }}
              activeDot={{ r: 3, stroke: 'black', strokeWidth: 1 }}
              opacity={hoveredId != null ? (hoveredId == account.id ? 1 : 0.25) : 0.75}
            />
          );
        })}
      </LineChart>
    </ResponsiveContainer>
  );
};

export default BalanceGraph;
