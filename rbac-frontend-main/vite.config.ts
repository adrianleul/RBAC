import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  // Use the existing `Public` directory (capital P) as Vite's public dir
  publicDir: 'Public',
  plugins: [react()],
  optimizeDeps: {
    exclude: ['lucide-react'],
  },
});
