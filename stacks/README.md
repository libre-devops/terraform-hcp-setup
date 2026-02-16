```bash
STACK_ID="$(terraform stacks list -organization-name "${TF_STACKS_ORGANIZATION_NAME:?}" -project-name "${TF_STACKS_PROJECT_NAME:?}" | grep -F "${TF_STACKS_STACK_NAME:?}" | grep -oE 'st-[A-Za-z0-9]+' | head -n1)" && [ -n "$STACK_ID" ] && terraform stacks configuration upload -stack-id "$STACK_ID" && terraform stacks deployment-group create -stack-id "$STACK_ID" -deployment-group-name "${TF_STACKS_STACK_NAME}" && terraform stacks deployment-run create -stack-id "$STACK_ID" -deployment-group-name "${TF_STACKS_STACK_NAME}" -deployment-config "dev.tfdeploy.hcl"
```


```bash
STACK_ID="$(terraform stacks list -organization-name "${TF_STACKS_ORGANIZATION_NAME:?}" -project-name "${TF_STACKS_PROJECT_NAME:?}" | grep -F "${TF_STACKS_STACK_NAME:?}" | grep -oE 'st-[A-Za-z0-9]+' | head -n1)"
```

```bash
STACK_ID="$(terraform stacks list -organization-name "${TF_STACKS_ORGANIZATION_NAME:?}" -project-name "${TF_STACKS_PROJECT_NAME:?}" | grep -F "${TF_STACKS_STACK_NAME:?}" | grep -oE 'st-[A-Za-z0-9]+' | head -n1)" && [ -n "$STACK_ID" ] && terraform stacks configuration upload -stack-id "$STACK_ID"
```

```bash
terraform stacks configuration upload -stack-id "$STACK_ID"
```