# 🚀 CI/CD Pipeline — GitHub Actions + Render + Telegram

A production-grade CI/CD pipeline that automatically tests, builds, containerizes, and deploys a Node.js web app to Render on every push to `main` — with Telegram notifications on every deploy.

---

## 📐 Architecture

```
Developer pushes to main
         │
         ▼
┌─────────────────────────┐
│     GitHub Actions       │
│                          │
│  ① Run Tests (Jest)      │
│  ② Deploy to Render      │
│  ③ Telegram Notification │
└─────────────────────────┘
         │
         ▼
┌─────────────────────────┐
│  Render (Docker)         │
│  Live Public URL         │
└─────────────────────────┘
         │
         ▼
┌─────────────────────────┐
│  Telegram Bot            │
│  Deploy Notification     │
└─────────────────────────┘
```

**Stack:** Node.js · Express · Docker · GitHub Actions · Render · Telegram Bot API

---

## ✨ Pipeline Stages

| Stage | Trigger | Description |
|-------|---------|-------------|
| ✅ **Test** | Every push & PR | Runs Jest unit tests |
| 🚀 **Deploy** | Push to `main` only | Triggers Render deploy via webhook |
| 📬 **Notify** | After every deploy | Sends Telegram message with status |

> Pull requests only trigger tests — no accidental deploys from feature branches.

---

## 🔐 GitHub Secrets Required

| Secret | Description |
|--------|-------------|
| `RENDER_DEPLOY_HOOK` | Render deploy hook URL (Settings → Deploy Hook) |
| `TELEGRAM_BOT_TOKEN` | Your Telegram bot token from BotFather |
| `TELEGRAM_CHAT_ID` | Your Telegram chat ID |

---

## 📁 Project Structure

```
cicd-gcp-pipeline/
├── app/
│   ├── index.js          # Express web app (/ and /health endpoints)
│   ├── index.test.js     # Jest unit tests
│   └── package.json
├── .github/
│   └── workflows/
│       └── deploy.yml    # Full CI/CD pipeline
├── Dockerfile            # Multi-stage Docker build
├── .dockerignore
└── README.md
```

---

## 🌐 Live Demo

**URL:** https://devops-project-og10.onrender.com

Sample response:
```json
{
  "status": "ok",
  "message": "CI/CD Pipeline on GCP 🚀",
  "version": "1.0.0",
  "timestamp": "2026-05-27T07:09:55.049Z"
}
```

Health check:
```json
{ "status": "healthy" }
```

---

## 🚀 Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/Dheerajnaik259/Devops_project.git
cd Devops_project
```

### 2. Run locally
```bash
cd app
npm install
npm start
# Visit http://localhost:8080
```

### 3. Run tests
```bash
cd app
npm test
```

### 4. Deploy your own
1. Fork this repo
2. Create a Web Service on [Render](https://render.com) connected to your fork
3. Add the 3 GitHub secrets listed above
4. Push to `main` — pipeline runs automatically

---

## 🧪 Test the Pipeline

Make any change and push:
```bash
git add .
git commit -m "feat: trigger pipeline"
git push origin main
```

Watch it run: **GitHub repo → Actions tab**

---

## 💡 Why I Built This

Manual deployments are slow and error-prone. This pipeline automates the full delivery lifecycle — from code push to live deployment — in under 30 seconds, with zero manual steps. Demonstrates real-world DevOps skills: containerization, CI/CD automation, secrets management, and multi-job pipeline orchestration.

---

## 🛠️ Future Improvements

- [ ] Add staging environment with manual approval gate
- [ ] Docker image vulnerability scanning with Trivy
- [ ] Slack notifications in addition to Telegram
- [ ] Automated rollback on failed health check
- [ ] Infrastructure as Code with Terraform

---

## 📄 License

MIT
