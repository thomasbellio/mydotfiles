assume_role() {
        #!/bin/bash
        ROLE=$1
        ACCOUNT_ID=$2
        TOKEN_CODE=$3
        MFA_DEVICE=$4
        echo "arn:aws:iam::${ACCOUNT_ID}:role/${ROLE}" &&
        echo "Assuming role for account id: ${ACCOUNT_ID} " &&
        aws sts assume-role --duration-seconds 3600 --role-arn "arn:aws:iam::${ACCOUNT_ID}:role/${ROLE}" --serial-number "${MFA_DEVICE}"  --token-code "${TOKEN_CODE}" --role-session-name "connect-automation-assume-${ACCOUNT_ID}" > tmp_credentials.json &&
        export AWS_ACCESS_KEY_ID=$(cat tmp_credentials.json | jq -r .Credentials.AccessKeyId) &&
        export AWS_SECRET_ACCESS_KEY=$(cat tmp_credentials.json | jq -r .Credentials.SecretAccessKey) &&
        export AWS_SESSION_TOKEN=$(cat tmp_credentials.json | jq -r .Credentials.SessionToken) &&
        echo "Assumed role ${ROLE} for account ${ACCOUNT_ID}..." &&
        echo "Cleaning up....." &&
	rm tmp_credentials.json &&
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


