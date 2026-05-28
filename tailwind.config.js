import type { Config } from 'tailwindcss'

export default <Partial<Config>>{
  theme: {
    extend: {
      colors: {
        sencra: {
          50:  '#eef2ff',
          100: '#dfe6ff',
          200: '#b9c4ff',
          300: '#8998ff',
          400: '#5a6cff',
          500: '#2d3fff',   // base text/logo
          600: '#1f2fe6',
          700: '#1826c7',
          800: '#121ea1',
          900: '#0c167a'
        },
        accent: {
          50:  '#fff3e8',
          100: '#ffe1c4',
          200: '#ffbf85',
          300: '#ff993d',
          400: '#ff7f00',   // brand orange
          500: '#e66f00',
          600: '#cc6200',
          700: '#a35000',
          800: '#7a3d00',
          900: '#522900'
        }
      },
      boxShadow: {
        'brand': '0 10px 30px -10px rgba(31,47,230,.25)'
      },
      ringColor: {
        brand: '#2d3fff'
      }
    }
  }
}
