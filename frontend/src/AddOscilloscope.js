import React, { useState } from 'react';
import axios from 'axios';

function AddOscilloscope() {
  const [model, setModel] = useState('');
  const [ipAddress, setIpAddress] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();

    // Assurez-vous que l'URL de l'API est correcte
    const apiUrl = process.env.REACT_APP_API_URL;

    axios.post(`${apiUrl}/oscilloscopes`, {
      model,
      ip_address: ipAddress,
    })
      .then(response => {
        alert('Oscilloscope ajouté avec succès !');
        setModel('');  // Réinitialiser le formulaire après soumission
        setIpAddress(''); // Réinitialiser le formulaire après soumission
      })
      .catch(error => {
        console.error('Error adding oscilloscope:', error.response ? error.response.data : error.message);
        alert('Une erreur est survenue lors de l\'ajout de l\'oscilloscope');
      });      
  };

  return (
    <div>
      <h2>Ajouter un Oscilloscope</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Modèle :</label>
          <input type="text" value={model} onChange={(e) => setModel(e.target.value)} required />
        </div>
        <div>
          <label>Adresse IP :</label>
          <input type="text" value={ipAddress} onChange={(e) => setIpAddress(e.target.value)} required />
        </div>
        <button type="submit">Ajouter</button>
      </form>
    </div>
  );
}

export default AddOscilloscope;
