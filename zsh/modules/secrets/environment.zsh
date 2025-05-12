# Set default secret strategy if not defined
export ZSH_SECRET_STRATEGY=${ZSH_SECRET_STRATEGY:-pass}

# Function to get secrets using the configured strategy
get_secret() {
  local secret_name=$1
  local env_var_name=$2

  case "$ZSH_SECRET_STRATEGY" in
    pass)
      # Use pass to retrieve the secret
      local secret_value="$(pass $secret_name)"
      if [[ $? -ne 0 ]]; then
        echo "Warning: Failed to retrieve secret '$secret_name' using pass" >&2
        return 1
      fi
      echo "$secret_value"
      ;;
    environment)
      # Use the environment variable directly
      local env_value="${(P)env_var_name}"
      if [[ -z "$env_value" ]]; then
        echo "Warning: Environment variable '$env_var_name' is not set" >&2
        return 1
      fi
      echo "$env_value"
      ;;
    *)
      echo "Warning: Unknown ZSH_SECRET_STRATEGY '$ZSH_SECRET_STRATEGY', falling back to 'pass'" >&2
      export ZSH_SECRET_STRATEGY="pass"
      get_secret "$secret_name" "$env_var_name"
      ;;
  esac
}

# Set OPENAI_API_KEY using the configured strategy
if [[ -z "$OPENAI_API_KEY" ]] || [[ "$ZSH_SECRET_STRATEGY" == "pass" ]]; then
  export OPENAI_API_KEY="$(get_secret "openai/neovim-api-key" "OPENAI_API_KEY")"
fi
