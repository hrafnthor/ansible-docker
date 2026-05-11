# Default behavior when running 'just' without input
default:
  @just --choose

# Updates the Ansible requirements
update:
  @ansible-galaxy install -r requirements.yml -f -vv

# Runs molecule testing with inputs
test *INPUTS:
  @molecule test {{INPUTS}}

# Tests all scenarios
test-all:
  @just test --all

# Test only the latest install scenario
test-install-latest *EXTRA:
  @just test --scenario-name install-latest {{EXTRA}}

# Test only the specific version install scenario
test-install-version *EXTRA:
  @just test --scenario-name install-version {{EXTRA}}

# Test only the removal scenario
test-removal *EXTRA:
  @just test --scenario-name remove {{EXTRA}}

# Test only the installation of locally supplied signing keys
test-repository-local-signing *EXTRA:
  @just test --scenario-name repository-local-signing {{EXTRA}}
