import React, { useEffect, useState } from 'react';
import axios from 'axios';

function OscilloscopeList() {
  const [oscilloscopes, setOscilloscopes] = useState([]);
  const apiUrl = process.env.REACT_APP_API_URL;

  useEffect(() => {
    axios.get(`${apiUrl}/oscilloscopes`)
      .then(response => setOscilloscopes(response.data))
      .catch(error => console.error('Error fetching oscilloscopes:', error));
  }, [apiUrl]);

  return (
    <div>
      <h2>Oscilloscopes</h2>
      <ul>
        {oscilloscopes.map(osc => (
          <li key={osc.oscilloscope_id}>{osc.model} - {osc.ip_address}</li>
        ))}
      </ul>
    </div>
  );
}

export default OscilloscopeList;
