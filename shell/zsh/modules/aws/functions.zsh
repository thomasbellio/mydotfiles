assume_role() {
    local ROLE=$1
    local ACCOUNT_ID=$2
    local TOKEN_CODE=$3
    local MFA_DEVICE=$4

    # A token code is only meaningful alongside an MFA device.
    if [ -n "$TOKEN_CODE" ] && [ -z "$MFA_DEVICE" ]; then
        echo "Error: TOKEN_CODE was provided without an MFA_DEVICE. Pass an MFA device or omit the token." >&2
        return 1
    fi

    local ROLE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/${ROLE}"

    local mfa_args=()
    if [ -n "$MFA_DEVICE" ]; then
        mfa_args+=(--serial-number "$MFA_DEVICE" --token-code "$TOKEN_CODE")
    fi

    echo "$ROLE_ARN"
    echo "Assuming role for account id: ${ACCOUNT_ID}"

    local creds
    creds=$(aws sts assume-role \
        --duration-seconds 3600 \
        --role-arn "$ROLE_ARN" \
        --role-session-name "connect-automation-assume-${ACCOUNT_ID}" \
        "${mfa_args[@]}") || { echo "assume-role failed" >&2; return 1; }

    export AWS_ACCESS_KEY_ID=$(jq -r .Credentials.AccessKeyId <<<"$creds")
    export AWS_SECRET_ACCESS_KEY=$(jq -r .Credentials.SecretAccessKey <<<"$creds")
    export AWS_SESSION_TOKEN=$(jq -r .Credentials.SessionToken <<<"$creds")

    echo "Done. You are now running commands as role ${ROLE} for account ${ACCOUNT_ID}"
}

auth_with_mfa() {
    #!/bin/bash
    MFA_DEVICE=$1
    TOKEN_CODE=$2
    echo "Authenticating with MFA..." &&
	aws sts get-session-token --duration-seconds 43200  --serial-number  "$MFA_DEVICE" --token-code "$TOKEN_CODE" > tmp_credentials.json &&
	export AWS_ACCESS_KEY_ID=$(cat tmp_credentials.json | jq -r .Credentials.AccessKeyId) &&
	export AWS_SECRET_ACCESS_KEY=$(cat tmp_credentials.json | jq -r .Credentials.SecretAccessKey) &&
	export AWS_SESSION_TOKEN=$(cat tmp_credentials.json | jq -r .Credentials.SessionToken) &&
    echo "cleaning up..." &&
    rm tmp_credentials.json &&
    echo "removed tmp credentials file..." &&
    echo "Authenticated with MFA"
}

clean_aws_creds() {
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
}


