// src/SignIn.js
import React, { useState } from 'react';
import { Auth } from '@aws-amplify/auth';

function SignIn() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  const handleSignIn = async (e) => {
    e.preventDefault();
    try {
      const user = await Auth.signIn(username, password);
      console.log('Sign in success:', user);
    } catch (error) {
      console.log('Error signing in:', error);
    }
  };

  return (
    <div>
      <h2>Connexion</h2>
      <form onSubmit={handleSignIn}>
        <div>
          <label>Nom d'utilisateur :</label>
          <input type="text" value={username} onChange={(e) => setUsername(e.target.value)} required />
        </div>
        <div>
          <label>Mot de passe :</label>
          <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
        </div>
        <button type="submit">Se connecter</button>
      </form>
    </div>
  );
}

export default SignIn;
