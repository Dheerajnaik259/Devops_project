# 🚀 CI/CD Pipeline — GitHub Actions + GCP Cloud Run

A production-grade CI/CD pipeline that automatically tests, builds, containerizes, and deploys a Node.js web app to Google Cloud Run on every push to `main`.

---

## 📐 Architecture

```
Developer pushes to main
         │
         ▼
┌─────────────────────┐
│  GitHub Actions      │
│                      │
│  ① Run Tests         │
│  ② Build Docker Image│
│  ③ Push to Artifact  │
│     Registry (GCP)   │
│  ④ Deploy to         │
│     Cloud Run (GCP)  │
│  ⑤ Telegram Notify   │
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│  Cloud Run           │
│  (Live URL)          │
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│  Telegram Bot        │
│  Deploy Notification │
└─────────────────────┘
```

**Stack:** Node.js · Docker · GitHub Actions · GCP Artifact Registry · GCP Cloud Run · Telegram Bot API

---

## ✨ Pipeline Stages

| Stage | Trigger | Description |
|-------|---------|-------------|
| ✅ **Test** | Every push & PR | Runs Jest unit tests |
| 🐳 **Build** | Push to `main` only | Builds Docker image |
| 📦 **Push** | Push to `main` only | Pushes image to GCP Artifact Registry |
| 🚀 **Deploy** | Push to `main` only | Deploys to Cloud Run (zero-downtime) |
| 📬 **Notify** | After deploy | Sends Telegram message with deploy status |

> PRs only trigger tests — no accidental deploys from feature branches.

---

## 🔐 GitHub Secrets Required

| Secret | Description |
|--------|-------------|
| `GCP_PROJECT_ID` | Your GCP project ID |
| `GCP_SA_KEY` | GCP Service Account JSON key (base64) |
| `TELEGRAM_BOT_TOKEN` | Your Telegram bot token |
| `TELEGRAM_CHAT_ID` | Your Telegram chat ID |

---

## 📁 Project Structure

```
cicd-gcp-pipeline/
├── app/
│   ├── index.js          # Express web app
│   ├── index.test.js     # Jest tests
│   └── package.json
├── .github/
│   └── workflows/
│       └── deploy.yml    # Full CI/CD pipeline
├── Dockerfile            # Multi-stage Docker build
├── .dockerignore
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites
- GCP account with billing enabled
- GitHub repository
- Telegram bot token

### GCP Setup

```bash
# 1. Enable required APIs
gcloud services enable \
  artifactregistry.googleapis.com \
  run.googleapis.com \
  cloudbuild.googleapis.com

# 2. Create Artifact Registry repository
gcloud artifacts repositories create cicd-repo \
  --repository-format=docker \
  --location=us-central1

# 3. Create Service Account
gcloud iam service-accounts create github-actions-sa \
  --display-name="GitHub Actions SA"

# 4. Grant required roles
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:github-actions-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/artifactregistry.writer"

gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:github-actions-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
  --member="serviceAccount:github-actions-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"

# 5. Create and download key
gcloud iam service-accounts keys create key.json \
  --iam-account=github-actions-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com
```

Add the contents of `key.json` as the `GCP_SA_KEY` secret in GitHub (Settings → Secrets).

---

## 💡 Why I Built This

Automates the full software delivery lifecycle — from code push to live deployment — with zero manual steps. Demonstrates real-world DevOps skills: containerization, cloud-native deployment, secrets management, and multi-job pipeline orchestration.

---

## 🛠️ Future Improvements

- [ ] Staging environment with manual approval gate before production
- [ ] Automated rollback on failed health check
- [ ] Slack notification in addition to Telegram
- [ ] Docker image vulnerability scanning with Trivy
- [ ] Infrastructure as Code with Terraform

---

## 📄 License

MIT
