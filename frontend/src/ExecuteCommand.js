import React, { useState } from 'react';
import axios from 'axios';

function ExecuteCommand() {
  const [oscilloscopeId, setOscilloscopeId] = useState('');
  const [command, setCommand] = useState('');
  const [result, setResult] = useState(null);
  const apiUrl = process.env.REACT_APP_API_URL;

  const handleSubmit = (e) => {
    e.preventDefault();
    axios.post(`${apiUrl}/execute`, {
      oscilloscope_id: oscilloscopeId,
      command,
    })
      .then(response => setResult(response.data))
      .catch(error => console.error('Error executing command:', error));
  };

  return (
    <div>
      <h2>Exécuter une Commande SCPI</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>ID de l'Oscilloscope :</label>
          <input type="text" value={oscilloscopeId} onChange={(e) => setOscilloscopeId(e.target.value)} required />
        </div>
        <div>
          <label>Commande SCPI :</label>
          <input type="text" value={command} onChange={(e) => setCommand(e.target.value)} required />
        </div>
        <button type="submit">Exécuter</button>
      </form>
      {result && (
        <div>
          <h3>Résultat :</h3>
          <pre>{JSON.stringify(result, null, 2)}</pre>
        </div>
      )}
    </div>
  );
}

export default ExecuteCommand;
