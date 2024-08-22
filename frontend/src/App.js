import React from 'react';
import OscilloscopeList from './OscilloscopeList';
import AddOscilloscope from './AddOscilloscope';
import ExecuteCommand from './ExecuteCommand';
import AddCommand from './AddCommand';

function App() {
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
