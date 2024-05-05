commit(){
     git commit -m"$1"
}

base_64_encode(){
    $ENCODE=$(echo -n "$1" | base64)
    echo $ENCODE
    echo $ENCODE | pbcopy
}
#AWS helpers
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

my_ip() {
	dig +short myip.opendns.com @resolver1.opendns.commit 
}

get_secret_values() {
	kubectl get secrets -o yaml  $1 > $2
	cat $2
}

jwt_decode() {
    # Read the JWT from the first argument or from standard input
    local jwt="${1:-$(</dev/stdin)}"
    # Extract the payload part of the JWT, which is the second part after splitting by '.'
    local encoded_payload=$(echo "$jwt" | cut -d "." -f 2)

    # Decode the payload from Base64 URL to regular Base64
    local base64_payload=$(echo "$encoded_payload" | tr '_-' '+/' | tr -d '=')

    # Add required padding to Base64 string
    local mod=$((${#base64_payload} % 4))
    if [ $mod -eq 2 ]; then
        base64_payload="${base64_payload}=="
    elif [ $mod -eq 3 ]; then
        base64_payload="${base64_payload}="
    fi

    # Decode from Base64 and output
    echo "$base64_payload" | base64 -d 2>/dev/null

    # Check for decoding errors, likely due to invalid input
    if [ $? -ne 0 ]; then
        echo "Error: Failed to decode JWT payload. The token may be invalid." >&2
        return 1
    fi
}

