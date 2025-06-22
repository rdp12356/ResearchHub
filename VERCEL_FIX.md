# Vercel Deployment Fix

## Issue
Vercel expects "package.json" or "build.sh" as the build source, not "client/src/App.tsx".

## Solution
Updated configuration files to work with Vercel's expectations:

### 1. Updated vercel.json
- Changed build source to "package.json"
- Simplified build configuration
- Set proper build and output commands

### 2. Updated package.json
Added required scripts:
```json
{
  "scripts": {
    "build": "vite build",
    "preview": "vite preview",
    "start": "tsx server/index.ts"
  }
}
```

### 3. Alternative Deployment Options

#### Option A: Frontend-Only Deployment (Recommended)
Deploy only the frontend to Vercel:
1. Create separate repository for frontend
2. Copy only `client/` folder contents to root
3. Use standard Vite deployment

#### Option B: Use Different Platform
- **Kinsta**: Better for full-stack apps
- **Railway**: Supports Node.js backends
- **Render**: Good for full-stack deployment

### 4. Quick Fix Commands
```bash
# Update the repository with fixed configurations
git add .
git commit -m "Fix Vercel deployment configuration"
git push origin main
```

### 5. Vercel Project Settings
In Vercel dashboard:
- Framework Preset: Vite
- Build Command: `npm run build`
- Output Directory: `dist`
- Install Command: `npm install`
- Root Directory: `./` (leave empty)

The updated configuration should resolve the Vercel deployment issue.