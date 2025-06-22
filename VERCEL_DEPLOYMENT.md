# Vercel Deployment Guide

## Step-by-Step Vercel Deployment

### 1. Install Vercel CLI
```bash
npm i -g vercel
```

### 2. Prepare Project Structure
Ensure your project has the correct structure:
```
cyberguardian/
├── client/src/          # React frontend
├── server/              # Express backend
├── shared/              # Shared types
├── package.json
├── vercel.json          # Vercel configuration
└── tsconfig.json
```

### 3. Deploy to Vercel
```bash
# Login to Vercel
vercel login

# Deploy (from project root)
vercel

# Follow prompts:
# - Set up and deploy? Yes
# - Which scope? Your account
# - Link to existing project? No
# - Project name: cyberguardian
# - Directory: ./
```

### 4. Vercel Configuration (vercel.json)
```json
{
  "version": 2,
  "builds": [
    {
      "src": "client/src/**/*",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    },
    {
      "src": "server/index.ts",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/server/index.ts"
    },
    {
      "src": "/(.*)",
      "dest": "/client/src/index.html"
    }
  ],
  "env": {
    "NODE_ENV": "production"
  }
}
```

### 5. Required Scripts in package.json
```json
{
  "scripts": {
    "build": "vite build",
    "dev": "vite",
    "preview": "vite preview"
  }
}
```

### 6. Environment Variables
Set in Vercel dashboard:
- Go to Project Settings
- Navigate to Environment Variables
- Add:
  - `NODE_ENV=production`
  - Any other required variables

### 7. Custom Domain
1. Go to Vercel dashboard
2. Select your project
3. Go to Settings > Domains
4. Add your custom domain
5. Update DNS records as instructed

### 8. Automatic Deployments
- Connected to Git repository
- Auto-deploys on push to main branch
- Preview deployments for pull requests

## Alternative: GitHub Integration

### 1. GitHub Setup
1. Push code to GitHub repository
2. Go to Vercel dashboard
3. Click "Import Project"
4. Select your GitHub repository

### 2. Build Settings
- Framework Preset: Vite
- Build Command: `npm run build`
- Output Directory: `dist`
- Install Command: `npm install`

### 3. Deploy
Vercel will automatically build and deploy your application.

## Troubleshooting

### Build Issues
- Check build logs in Vercel dashboard
- Verify dependencies are correctly listed
- Ensure TypeScript compilation succeeds

### API Routes
- API routes must be in `/api` directory for Vercel
- Each API route should export default function
- Use `@vercel/node` runtime for Node.js APIs

### Static Files
- Place in `public` directory
- Reference with absolute paths starting with `/`

### Environment Variables
- Set in Vercel dashboard
- Restart deployment after adding variables
- Use `process.env.VARIABLE_NAME` in code