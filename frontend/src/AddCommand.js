import React, { useState } from 'react';
import axios from 'axios';

function AddCommand() {
  const [name, setName] = useState('');
  const [syntax, setSyntax] = useState('');
  const [description, setDescription] = useState('');
  const apiUrl = process.env.REACT_APP_API_URL;

  const handleSubmit = (e) => {
    e.preventDefault();
    axios.post(`${apiUrl}/commands`, {
      name,
      syntax,
      description,
    })
      .then(response => {
        alert('Commande ajoutée avec succès !');
        setName('');
        setSyntax('');
        setDescription('');
      })
      .catch(error => console.error('Error adding command:', error));
  };

  return (
    <div>
      <h2>Ajouter une Commande SCPI</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Nom :</label>
          <input type="text" value={name} onChange={(e) => setName(e.target.value)} required />
        </div>
        <div>
          <label>Syntaxe :</label>
          <input type="text" value={syntax} onChange={(e) => setSyntax(e.target.value)} required />
        </div>
        <div>
          <label>Description :</label>
          <textarea value={description} onChange={(e) => setDescription(e.target.value)} required></textarea>
        </div>
        <button type="submit">Ajouter</button>
      </form>
    </div>
  );
}

export default AddCommand;
