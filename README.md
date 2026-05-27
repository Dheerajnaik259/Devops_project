# 🚀 CI/CD Pipeline — GitHub Actions + GCP VM (GHCR)

A production-grade CI/CD pipeline that automatically tests, builds, containerizes, and deploys a Node.js web app to a Google Cloud Platform (GCP) VM instance via GitHub Container Registry (GHCR) on every push to `main`.

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
│  ③ Push to GitHub    │
│     Container        │
│     Registry (GHCR)  │
│  ④ SSH into GCP VM   │
│     & Pull/Restart   │
│  ⑤ Telegram Notify   │
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│  GCP Compute Engine  │
│  VM Instance         │
└─────────────────────┘
         │
         ▼
┌─────────────────────┐
│  Telegram Bot        │
│  Deploy Notification │
└─────────────────────┘
```

**Stack:** Node.js · Docker · GitHub Actions · GitHub Container Registry (GHCR) · GCP Compute Engine (VM) · Telegram Bot API

---

## ✨ Pipeline Stages

| Stage | Trigger | Description |
|-------|---------|-------------|
| ✅ **Test** | Every push & PR | Runs Jest unit tests |
| 🐳 **Build** | Push to `main` only | Builds Docker image |
| 📦 **Push** | Push to `main` only | Pushes image to GitHub Container Registry (ghcr.io) |
| 🚀 **Deploy** | Push to `main` only | SSHs into GCP VM, pulls the latest image, and restarts the container |
| 📬 **Notify** | After deploy | Sends Telegram message with deploy status and VM URL |

> PRs only trigger tests — no accidental deploys from feature branches.

---

## 🔐 GitHub Secrets Required

| Secret | Description |
|--------|-------------|
| `GCP_VM_HOST` | The public IP address or DNS domain of your GCP VM |
| `GCP_VM_USER` | The username used to SSH into the VM (e.g. `ubuntu`) |
| `GCP_VM_SSH_KEY` | Private SSH key (PEM/OpenSSH format) used to authenticate |
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
- GCP Compute Engine VM instance
- GitHub repository
- Telegram bot token

### GCP VM Setup

1. **Create VM Instance**:
   Create a standard VM Instance (e.g., `e2-micro` or `e2-medium`) on Google Compute Engine with Ubuntu or a similar Linux distribution.

2. **Install Docker**:
   SSH into your VM and install Docker:
   ```bash
   sudo apt-get update
   sudo apt-get install -y docker.io
   sudo systemctl start docker
   sudo systemctl enable docker
   # Add your ssh user to the docker group so sudo is not needed
   sudo usermod -aG docker $USER
   ```
   *Note: Log out and log back in to apply group changes.*

3. **Configure Firewall**:
   Ensure that HTTP traffic (port 80) is allowed to your VM instance in GCP firewall settings.

4. **Add SSH Keys**:
   Add your public SSH key to the GCP VM metadata or `~/.ssh/authorized_keys`, and store the private SSH key in GitHub Secrets as `GCP_VM_SSH_KEY`.

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
