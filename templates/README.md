# Templates Directory

This directory contains templates for creating consistent CKAD questions and solutions across the repository.

## Available Templates

### 1. Question Template
**File**: [`question-template.md`](./question-template.md)

Use this template when creating new CKAD practice questions. It provides a standardized format that includes:
- Question metadata (difficulty, domain, time limit)
- Scenario description
- Clear task requirements
- Success criteria
- Tips and related concepts

### 2. Solution Template
**File**: [`solution-template.md`](./solution-template.md)

Use this template to document step-by-step solutions. Features:
- Overview of the solution approach
- Detailed step-by-step instructions
- Expected outputs for each step
- Alternative approaches
- Common mistakes to avoid
- Key learning points

### 3. YAML Manifest Template
**File**: [`manifest-template.yaml`](./manifest-template.yaml)

Template for creating Kubernetes YAML manifests with:
- Common resource patterns
- Proper formatting guidelines
- Examples for different resource types
- Best practices for metadata

### 4. Commands Template
**File**: [`commands-template.sh`](./commands-template.sh)

Shell script template containing:
- Common kubectl command patterns
- Solution workflow structure
- Verification commands
- Cleanup procedures
- CKAD-specific command references

## How to Use These Templates

### Creating a New Question

1. **Choose the domain directory:**
   ```bash
   cd questions/domain-[X]-[domain-name]/
   ```

2. **Create question directory:**
   ```bash
   mkdir question-[number]-[topic]-[difficulty]
   cd question-[number]-[topic]-[difficulty]
   ```

3. **Copy and customize the question template:**
   ```bash
   cp ../../../templates/question-template.md README.md
   ```

4. **Create solution structure:**
   ```bash
   mkdir -p solution/manifests
   mkdir -p examples
   ```

5. **Copy and customize templates:**
   ```bash
   cp ../../../templates/solution-template.md solution/README.md
   cp ../../../templates/commands-template.sh solution/commands.sh
   cp ../../../templates/manifest-template.yaml solution/manifests/
   ```

### Directory Structure After Using Templates

```
question-001-pod-creation-B/
├── README.md                    # From question-template.md
├── solution/
│   ├── README.md               # From solution-template.md
│   ├── commands.sh             # From commands-template.sh
│   └── manifests/
│       └── pod.yaml            # From manifest-template.yaml
└── examples/
    └── sample-output.txt       # Expected command outputs
```

## Template Customization Guidelines

### Question Template
- Replace all `[placeholder]` text with actual values
- Ensure the scenario is realistic and practical
- Make tasks specific and measurable
- Include appropriate difficulty level and time estimates

### Solution Template
- Provide complete, working solutions
- Test all commands on a real cluster
- Include expected outputs for verification
- Document any assumptions or prerequisites

### YAML Template
- Remove unused sections and comments
- Ensure valid YAML syntax
- Follow Kubernetes naming conventions
- Include only necessary fields

### Commands Template
- Test all commands before documenting
- Include error handling where appropriate
- Provide clear comments for complex operations
- Organize commands logically

## Quality Checklist

Before submitting a new question using these templates:

- [ ] All placeholders replaced with actual values
- [ ] Question tested on a live Kubernetes cluster
- [ ] Solution produces expected results
- [ ] YAML manifests are syntactically correct
- [ ] Commands execute without errors
- [ ] Difficulty level is appropriate
- [ ] Time estimate is realistic
- [ ] All verification steps work correctly

## Naming Conventions

### Question Naming
Format: `question-[number]-[topic]-[difficulty]`
- **Number**: 3-digit zero-padded (001, 002, etc.)
- **Topic**: Short descriptive name (pod-creation, configmap-mount, etc.)
- **Difficulty**: B (Basic), I (Intermediate), A (Advanced)

Examples:
- `question-001-pod-creation-B`
- `question-015-deployment-rollback-I`
- `question-032-networkpolicy-debug-A`

### File Naming
- Question description: `README.md`
- Solution guide: `solution/README.md`
- Commands: `solution/commands.sh`
- Manifests: `solution/manifests/[resource-type].yaml`
- Examples: `examples/sample-output.txt`

## Contributing New Templates

If you want to add new templates:

1. Create the template file with clear placeholders
2. Add documentation to this README
3. Test the template with a sample question
4. Submit a pull request with your changes

## Template Maintenance

Templates are updated periodically to:
- Reflect current Kubernetes versions
- Incorporate community feedback
- Add new best practices
- Fix identified issues

Check the repository's main README for the latest template version information.