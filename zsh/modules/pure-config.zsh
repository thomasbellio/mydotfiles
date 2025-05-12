prompt_pure_state_setup() {
  setopt localoptions noshwordsplit
  # Set empty username (this is the key change)
  local username=""

  typeset -gA prompt_pure_state
  prompt_pure_state[version]="1.23.0"
  prompt_pure_state+=(
    username "$username"
    prompt   "${PURE_PROMPT_SYMBOL:-❯}"
  )
}
