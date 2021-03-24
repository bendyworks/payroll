import React, { useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

/* eslint react/prop-types: 0 */

function formatDate(date) {
  return new Date(date).toLocaleDateString();
}

const BalanceGraph = ({ data }) => {
  const accounts = Object.keys(data[0])
    .filter((key) => key != 'date')
    .map((id) => ({ id, name: data[0][id]['name'] }));

  const [hoveredId, setHoveredId] = useState(null);
  const colors = ['#f25f5c', '#CCA300', '#00CCAD', '#2A8CB7', '#995C88'];

  const handleLegendHover = (e) => {
    setHoveredId(e.payload.id);
  };

  return (
    <ResponsiveContainer width="99%" height={480}>
      <LineChart data={data} margin={{ bottom: 80 }}>
        <CartesianGrid fill="#2c3e50" strokeOpacity={0.15} strokeDasharray="4 4" vertical={false} />
        <XAxis dataKey="date" tickMargin={10} tickFormatter={formatDate} />
        <YAxis padding={{ bottom: 15, top: 15 }} domain={['auto', 'auto']} />
        <Tooltip />
        <Legend
          onMouseEnter={handleLegendHover}
          onMouseLeave={() => setHoveredId(null)}
          align="right"
          width="100%"
          wrapperStyle={{ position: 'relative', top: -80, zIndex: 1, cursor: 'pointer' }}
        />
        {accounts.map((account, i) => {
          return (
            <Line
              id={account.id}
              key={account.id}
              name={account.name}
              type="monotoneX" // Play around with this for different types of line interpolation
              dataKey={`${account.id}.balance.amount`}
              stroke={colors[i % colors.length]}
              fill={colors[i % colors.length]}
              strokeWidth={hoveredId == account.id ? 3 : 1.5}
              activeDot={{ r: 6 }}
            />
          );
        })}
      </LineChart>
    </ResponsiveContainer>
  );
};

export default BalanceGraph;
