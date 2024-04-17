import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      src: "/src",
      "@": `${path.resolve(__dirname, "./src")}`,
      "@pages": `${path.resolve(__dirname, "./src/pages")}`,
      "@assets": `${path.resolve(__dirname, "./src/assets")}`,
      "@images": `${path.resolve(__dirname, "./src/assets/images")}`,
      "@icons": `${path.resolve(__dirname, "./src/assets/icons")}`,
      "@components": `${path.resolve(__dirname, "./src/components")}`,
    }
  }
})
