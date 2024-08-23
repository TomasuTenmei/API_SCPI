import React, { useEffect } from 'react';
import Amplify from '@aws-amplify/core';
import { Auth } from '@aws-amplify/auth';
import awsconfig from './aws-exports';
import SignIn from './SignIn';
import OscilloscopeList from './OscilloscopeList';
import AddOscilloscope from './AddOscilloscope';
import ExecuteCommand from './ExecuteCommand';
import AddCommand from './AddCommand';

Amplify.configure(awsconfig);

function App() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    Auth.currentAuthenticatedUser()
      .then(user => setUser(user))
      .catch(() => setUser(null));
  }, []);

  if (!user) {
    return <SignIn />;
  }

  return (
    <div className="App">
      <img src="/logo.png" alt="SCPI Interface" style={{ width: '5%', height: 'auto' }} />
      <h1>Interface SCPI pour Oscilloscopes</h1>
      <OscilloscopeList />
      <img src="/oscilloscope.png" alt="SCPI Interface" style={{ width: '15%', height: 'auto' }} />
      <AddOscilloscope />
      <ExecuteCommand />
      <AddCommand />
    </div>
  );
}

export default App;
