#!/bin/bash

# CyberGuardian Platform - GitHub Upload Script
# This script helps you upload the platform to GitHub

echo "🚀 CyberGuardian Platform - GitHub Upload Helper"
echo "================================================"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Get user input
echo ""
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter repository name (default: cyberguardian-platform): " REPO_NAME
REPO_NAME=${REPO_NAME:-cyberguardian-platform}

echo ""
echo "📁 Setting up local repository..."

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << EOF
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Production builds
dist/
build/

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
*.log
logs/

# Runtime data
pids/
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Cache
.cache/
.eslintcache
EOF
    echo "✅ .gitignore created"
fi

# Add files to git
echo ""
echo "📄 Adding files to repository..."
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "⚠️  No changes to commit"
else
    # Commit changes
    git commit -m "Initial commit: CyberGuardian cybersecurity platform

Features:
- Interactive dashboard with security metrics
- Password strength checker and vulnerability scanner
- Threat management system with CRUD operations
- Analytics dashboard with charts and reporting
- Cybersecurity glossary with searchable terms
- Modern responsive UI with dark/light mode
- Full TypeScript implementation
- Production-ready deployment configurations"
    echo "✅ Files committed to local repository"
fi

# Add remote repository
echo ""
echo "🔗 Setting up GitHub remote..."
REMOTE_URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

# Remove existing origin if it exists
git remote remove origin 2>/dev/null || true

# Add new origin
git remote add origin $REMOTE_URL
echo "✅ Remote repository added: $REMOTE_URL"

# Set main as default branch
git branch -M main

echo ""
echo "📤 Ready to push to GitHub!"
echo ""
echo "Next steps:"
echo "1. Create a new repository on GitHub:"
echo "   - Go to: https://github.com/new"
echo "   - Repository name: $REPO_NAME"
echo "   - Description: Comprehensive cybersecurity platform"
echo "   - Choose Public or Private"
echo "   - DO NOT initialize with README"
echo ""
echo "2. Run this command to push your code:"
echo "   git push -u origin main"
echo ""
echo "3. When prompted, enter your GitHub credentials:"
echo "   - Username: $GITHUB_USERNAME"
echo "   - Password: Your GitHub Personal Access Token"
echo ""
echo "🔑 Need a Personal Access Token?"
echo "   Go to: https://github.com/settings/tokens"
echo "   Generate new token with 'repo' scope"
echo ""
echo "🎉 After pushing, your platform will be live on:"
echo "   https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"

# Optionally try to push automatically
echo ""
read -p "Would you like to push to GitHub now? (y/N): " PUSH_NOW
if [[ $PUSH_NOW =~ ^[Yy]$ ]]; then
    echo ""
    echo "🚀 Pushing to GitHub..."
    git push -u origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 Success! Your CyberGuardian platform is now on GitHub!"
        echo "🔗 Repository URL: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
        echo ""
        echo "Ready for deployment:"
        echo "✅ Vercel: Import project from GitHub"
        echo "✅ Kinsta: Connect Git repository"
    else
        echo ""
        echo "❌ Push failed. Please check your credentials and repository settings."
        echo "💡 Make sure you've created the repository on GitHub first."
    fi
else
    echo ""
    echo "📝 Manual push required:"
    echo "   git push -u origin main"
fi

echo ""
echo "✨ Upload process complete!"