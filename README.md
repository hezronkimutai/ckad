# CKAD Questions Repository

A comprehensive collection of practice questions and study materials for the **Certified Kubernetes Application Developer (CKAD)** exam.

## 🎯 About

This repository provides hands-on practice questions organized by CKAD exam domains, designed to help you prepare for the certification exam through practical exercises that mirror real-world scenarios.

## 📚 Exam Domains Coverage

The questions are organized according to the official CKAD curriculum:

| Domain | Weight | Directory | Description |
|--------|--------|-----------|-------------|
| **Application Design and Build** | 20% | [`domain-1-application-design-build/`](./questions/domain-1-application-design-build/) | Container images, Jobs, CronJobs, multi-container Pods |
| **Application Deployment** | 20% | [`domain-2-application-deployment/`](./questions/domain-2-application-deployment/) | Deployments, rolling updates, Helm |
| **Application Observability and Maintenance** | 15% | [`domain-3-observability-maintenance/`](./questions/domain-3-observability-maintenance/) | Probes, monitoring, debugging, logs |
| **Application Environment, Configuration and Security** | 25% | [`domain-4-environment-config-security/`](./questions/domain-4-environment-config-security/) | ConfigMaps, Secrets, RBAC, SecurityContexts |
| **Services and Networking** | 20% | [`domain-5-services-networking/`](./questions/domain-5-services-networking/) | Services, Ingress, NetworkPolicies |

## 🚀 Quick Start

### Prerequisites

- Kubernetes cluster (local or cloud)
- `kubectl` CLI tool
- Basic understanding of Kubernetes concepts

### Local Setup Options

```bash
# Option 1: kind (Kubernetes in Docker)
kind create cluster --name ckad-practice

# Option 2: minikube
minikube start --driver=docker

# Option 3: k3d
k3d cluster create ckad-practice
```

### Using This Repository

1. **Clone the repository:**
   ```bash
   git clone https://github.com/hezronkimutai/ckad.git
   cd ckad
   ```

2. **Choose your learning path:**
   - **By Domain**: Navigate to specific exam domains
   - **By Difficulty**: Start with Basic (B), progress to Intermediate (I), then Advanced (A)
   - **Random Practice**: Use the provided scripts for random question selection

3. **Practice workflow:**
   ```bash
   # Navigate to a question
   cd questions/domain-1-application-design-build/question-001-pod-creation-B
   
   # Read the problem
   cat README.md
   
   # Attempt the solution
   # Check your work against the provided solution
   cd solution && cat README.md
   ```

## 📖 Question Format

Each question follows a consistent structure:

```
question-XXX-topic-difficulty/
├── README.md              # Problem statement and requirements
├── solution/
│   ├── README.md          # Step-by-step solution
│   ├── manifests/         # YAML configuration files
│   └── commands.sh        # kubectl commands
└── examples/
    └── sample-output.txt  # Expected command outputs
```

### Difficulty Levels

- **Basic (B)**: Single concept, 5-10 minutes
- **Intermediate (I)**: Multiple concepts, 10-20 minutes
- **Advanced (A)**: Complex scenarios, 20+ minutes

## 🎓 Study Tips

### Exam Preparation Strategy

1. **Master the Basics**: Start with Basic questions in each domain
2. **Time Management**: Practice with time constraints (2 minutes per question average)
3. **kubectl Proficiency**: Focus on command-line efficiency
4. **YAML Fluency**: Practice writing configurations from scratch
5. **Debugging Skills**: Learn to troubleshoot common issues quickly

### Essential kubectl Commands

```bash
# Quick reference commands you'll use frequently
kubectl run pod-name --image=nginx --dry-run=client -o yaml > pod.yaml
kubectl create deployment deploy-name --image=nginx --replicas=3
kubectl expose deployment deploy-name --port=80 --target-port=8080
kubectl get pods -o wide --show-labels
kubectl describe pod pod-name
kubectl logs pod-name -c container-name
```

## 🔧 Validation Scripts

Use the provided scripts to validate your environment and solutions:

```bash
# Check cluster readiness
./scripts/check-cluster.sh

# Validate YAML syntax
./scripts/validate-yaml.sh questions/domain-1-application-design-build/

# Run solution tests
./scripts/test-solution.sh question-001-pod-creation-B
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details on:

- Adding new questions
- Improving existing content
- Reporting issues
- Code review process

### Quick Contribution Steps

1. Fork the repository
2. Create a feature branch: `git checkout -b new-question-topic`
3. Follow the question template in [`templates/`](./templates/)
4. Test your question on a live cluster
5. Submit a pull request

## 📊 Progress Tracking

Track your preparation progress:

- [ ] Domain 1: Application Design and Build (__ / __ questions)
- [ ] Domain 2: Application Deployment (__ / __ questions)
- [ ] Domain 3: Application Observability and Maintenance (__ / __ questions)
- [ ] Domain 4: Application Environment, Configuration and Security (__ / __ questions)
- [ ] Domain 5: Services and Networking (__ / __ questions)

## 🔗 Additional Resources

- [Official CKAD Curriculum](https://github.com/cncf/curriculum/blob/master/CKAD_Curriculum_v1.28.pdf)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [CKAD Exam Tips](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad)

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Support

If this repository helps you pass your CKAD exam, please consider:

- ⭐ Starring the repository
- 🐛 Reporting issues or suggestions
- 🤝 Contributing new questions
- 📢 Sharing with other CKAD candidates

---

**Good luck with your CKAD certification journey! 🚀**

> Remember: The CKAD exam is hands-on and time-constrained. Practice with real clusters and focus on speed and accuracy.