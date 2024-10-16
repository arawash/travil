import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import TenantDashboard from './components/TenantDashboard';
import UserProfile from './components/UserProfile';

function App() {
  return (
    <Router>
      <Switch>
        <Route path="/dashboard" component={TenantDashboard} />
        <Route path="/profile" component={UserProfile} />
      </Switch>
    </Router>
  );
}

export default App;
