import React from 'react';
import OscilloscopeList from './OscilloscopeList';
import AddOscilloscope from './AddOscilloscope';
import ExecuteCommand from './ExecuteCommand';
import AddCommand from './AddCommand';

function App() {
  return (
    <div className="App">
      <h1>Interface SCPI pour Oscilloscopes</h1>
      <OscilloscopeList />
      <AddOscilloscope />
      <ExecuteCommand />
      <AddCommand />
    </div>
  );
}

export default App;
