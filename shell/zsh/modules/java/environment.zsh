export JAVA_HOME="$HOME/.java"
mkdir -p "$JAVA_HOME"

if [[ ":$PATH:" != *":/opt/homebrew/opt/openjdk/bin:"* ]]; then
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi
