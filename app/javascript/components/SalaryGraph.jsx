import React from 'react';
import PropTypes from 'prop-types';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const SalaryGraph = ({ data }) => {
  let employees = Object.keys(data[0])
    .slice(1)
    .map((name) => ({ name, id: data[0][name].id }));

  const handleLegendClick = (e) => {
    const id = employees.find((emp) => emp.name === e.value).id;
    window.location.href = `/employees/${id}`;
  };

  return (
    <ResponsiveContainer width="99%" height={500}>
      <LineChart
        data={data}
        margin={{
          top: 5,
          right: 30,
          left: 20,
          bottom: 5,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="date" />
        <YAxis type="number" domain={['dataMin - 5000', 'auto']} />
        <Tooltip />
        <Legend
          onClick={handleLegendClick}
          width="50%"
          wrapperStyle={{ position: 'relative', margin: 'auto', bottom: 25 }}
        />
        {employees.map((emp) => {
          return (
            <Line
              key={emp.id}
              type="monotone"
              name={emp.name}
              dataKey={`${emp.name}.salary`}
              stroke="#8884d8"
              activeDot={{ r: 8 }}
            />
          );
        })}
      </LineChart>
    </ResponsiveContainer>
  );
};

export default SalaryGraph;
