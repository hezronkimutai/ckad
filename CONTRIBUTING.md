# Contributing to CKAD Questions Repository

Thank you for your interest in contributing to the CKAD Questions Repository! Your contributions help make this a valuable resource for the Kubernetes community.

## Table of Contents

- [How to Contribute](#how-to-contribute)
- [Question Guidelines](#question-guidelines)
- [Question Structure](#question-structure)
- [Quality Standards](#quality-standards)
- [Submission Process](#submission-process)
- [Review Process](#review-process)
- [Code of Conduct](#code-of-conduct)

## How to Contribute

### Types of Contributions

- **New Questions**: Add practice questions for any CKAD domain
- **Improved Solutions**: Enhance existing solutions with better explanations
- **Bug Fixes**: Fix errors in questions, solutions, or documentation
- **Documentation**: Improve README files, guides, and explanations
- **Templates**: Enhance question and solution templates
- **Scripts**: Add validation or automation scripts

### Getting Started

1. **Fork the repository** to your GitHub account
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/ckad.git
   cd ckad
   ```
3. **Create a feature branch**:
   ```bash
   git checkout -b feature/new-deployment-question
   ```
4. **Make your changes** following the guidelines below
5. **Test your changes** on a real Kubernetes cluster
6. **Submit a pull request** with a clear description

## Question Guidelines

### Content Requirements

- **Exam Relevance**: Questions must align with official CKAD curriculum
- **Practical Focus**: Scenarios should reflect real-world use cases
- **Clear Objectives**: Each question should have specific, measurable goals
- **Appropriate Difficulty**: Difficulty level should match the complexity
- **Time Estimates**: Realistic time limits based on actual testing

### Domain Distribution

Target roughly equal distribution across CKAD domains:
- Domain 1: Application Design and Build (20%)
- Domain 2: Application Deployment (20%)
- Domain 3: Application Observability and Maintenance (15%)
- Domain 4: Application Environment, Configuration and Security (25%)
- Domain 5: Services and Networking (20%)

### Difficulty Levels

- **Basic (B)**: Single concept, 5-10 minutes, minimal setup
- **Intermediate (I)**: Multiple concepts, 10-20 minutes, moderate complexity
- **Advanced (A)**: Complex scenarios, 20+ minutes, multiple components

## Question Structure

### Directory Naming

Follow this pattern: `question-[number]-[topic]-[difficulty]`

Examples:
- `question-001-pod-creation-B`
- `question-015-deployment-rollback-I`
- `question-032-networkpolicy-debug-A`

### Required Files

```
question-XXX-topic-difficulty/
├── README.md                    # Problem statement
├── solution/
│   ├── README.md               # Step-by-step solution
│   ├── commands.sh             # kubectl commands
│   └── manifests/              # YAML files
│       └── *.yaml
└── examples/
    └── sample-output.txt       # Expected outputs
```

### Using Templates

1. **Copy templates** from the `templates/` directory
2. **Customize content** by replacing all `[placeholder]` text
3. **Follow naming conventions** consistently
4. **Test thoroughly** before submitting

## Quality Standards

### Testing Requirements

- [ ] All commands tested on a live Kubernetes cluster
- [ ] YAML manifests are syntactically correct
- [ ] Solutions produce expected results
- [ ] Verification steps work correctly
- [ ] Cleanup commands remove all created resources

### Documentation Standards

- [ ] Clear, unambiguous problem statements
- [ ] Step-by-step solutions with explanations
- [ ] Expected outputs for each major step
- [ ] Common mistakes and troubleshooting tips
- [ ] Proper grammar and spelling

### Technical Standards

- [ ] Use current stable Kubernetes versions
- [ ] Follow Kubernetes naming conventions
- [ ] Include proper labels and annotations
- [ ] Use appropriate resource requests/limits
- [ ] Follow security best practices

## Submission Process

### Before Submitting

1. **Test your question** on multiple Kubernetes distributions if possible
2. **Validate YAML** syntax using `kubectl apply --dry-run=client`
3. **Check timing** - verify your time estimates are realistic
4. **Review templates** - ensure all placeholders are replaced
5. **Run validation scripts** (if available) to check quality

### Pull Request Guidelines

#### Title Format
```
Add question: [Domain] - [Topic] - [Difficulty]
```

Examples:
- `Add question: Domain 1 - Multi-container Pod - Intermediate`
- `Fix solution: Domain 4 - ConfigMap mounting - Basic`

#### Description Template
```markdown
## Question Details
- **Domain**: [Domain name and number]
- **Difficulty**: [Basic/Intermediate/Advanced]
- **Time Estimate**: [X minutes]
- **Topic**: [Brief description]

## Changes Made
- [ ] Added new question with complete solution
- [ ] Tested on Kubernetes cluster
- [ ] Validated YAML syntax
- [ ] Verified timing estimates
- [ ] Added sample outputs

## Testing Environment
- **Kubernetes Version**: [e.g., v1.28.0]
- **Cluster Type**: [e.g., kind, minikube, GKE]
- **kubectl Version**: [e.g., v1.28.0]

## Checklist
- [ ] Question follows template structure
- [ ] Solution is complete and tested
- [ ] All files included (README, YAML, commands)
- [ ] No sensitive information included
- [ ] Follows naming conventions
```

### Review Criteria

Your pull request will be reviewed for:

1. **Accuracy**: Technical correctness of questions and solutions
2. **Clarity**: Clear problem statements and solution explanations
3. **Completeness**: All required files and documentation included
4. **Testing**: Evidence that the solution works on real clusters
5. **Style**: Consistent formatting and naming conventions
6. **Value**: Relevance to CKAD exam and learning objectives

## Review Process

### Timeline

- **Initial Review**: Within 3-5 business days
- **Follow-up**: Reviewers will provide feedback for improvements
- **Approval**: Once all feedback is addressed satisfactorily
- **Merge**: Approved PRs are merged promptly

### Feedback Response

- **Be Responsive**: Address feedback promptly and thoroughly
- **Ask Questions**: If feedback is unclear, ask for clarification
- **Test Changes**: Re-test after making requested modifications
- **Update Documentation**: Update any affected documentation

### Review Team

Reviews are conducted by:
- Repository maintainers
- Community contributors with CKAD certification
- Kubernetes subject matter experts

## Code of Conduct

### Our Standards

- **Be Respectful**: Treat all contributors with respect and kindness
- **Be Collaborative**: Work together to improve the resource
- **Be Constructive**: Provide helpful, actionable feedback
- **Be Patient**: Remember that everyone is learning
- **Be Inclusive**: Welcome contributors of all skill levels

### Unacceptable Behavior

- Harassment or discrimination of any kind
- Offensive or inappropriate content
- Spamming or irrelevant contributions
- Deliberately misleading or incorrect information

## Questions and Support

### Getting Help

- **GitHub Issues**: For bugs, feature requests, or general questions
- **Discussions**: For community Q&A and collaboration
- **Pull Request Comments**: For specific feedback on contributions

### Contact Information

- **Repository Maintainers**: [@hezronkimutai](https://github.com/hezronkimutai)
- **Community Discord**: [Link if available]
- **Email**: [Contact email if available]

## Recognition

Contributors will be:
- Listed in the repository's contributors section
- Credited in question metadata where appropriate
- Recognized in release notes for significant contributions

Thank you for helping make CKAD preparation better for everyone! 🚀

---

**Remember**: Quality over quantity. A few well-crafted, thoroughly tested questions are more valuable than many hastily created ones.