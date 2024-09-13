import React from 'react'
import ReactDOM from 'react-dom/client'
import { VisibilityProvider } from './providers/VisibilityProvider'
import { MantineProvider } from '@mantine/core'
import { ModalsProvider } from '@mantine/modals'
import Dashboard from './components/Dashboard'
import Catalogue from './components/Catalogue'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <MantineProvider  theme={{ colorScheme:'dark' }}>
      <ModalsProvider>
        <VisibilityProvider componentName="Dashboard">
          <Dashboard/>
        </VisibilityProvider>
        <VisibilityProvider componentName="Catalogue">
          <Catalogue/>
        </VisibilityProvider>
      </ModalsProvider>
    </MantineProvider>
  </React.StrictMode>
)