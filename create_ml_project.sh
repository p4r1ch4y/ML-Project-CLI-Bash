#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
EXPECTED_ARGS=3
COMMAND_NAME="create"

# --- Helper Function for Usage ---
usage() {
  echo "Usage: $0 <command> <output_folder> <dataset_folder>"
  echo "  command: Currently only '$COMMAND_NAME' is supported."
  echo "  output_folder: Path to the directory where the project structure will be created."
  echo "  dataset_folder: Path to the existing folder containing dataset subfolders (train, test, validation)."
  exit 1
}

# --- Argument Validation ---
if [ "$#" -ne "$EXPECTED_ARGS" ]; then
  echo "Error: Incorrect number of arguments." >&2
  usage
fi

COMMAND="$1"
OUTPUT_FOLDER="$2"
DATASET_FOLDER="$3"

# Convert command to lowercase for case-insensitive comparison (optional but good practice)
COMMAND_LOWER=$(echo "$COMMAND" | tr '[:upper:]' '[:lower:]')

# --- Main Logic ---
if [ "$COMMAND_LOWER" == "$COMMAND_NAME" ]; then
  echo "Creating project structure in '$OUTPUT_FOLDER'..."

  # Create output folder and Data subfolder
  # mkdir -p creates parent directories as needed and doesn't error if it exists
  DATA_FOLDER="$OUTPUT_FOLDER/Data"
  mkdir -p "$DATA_FOLDER"
  echo "Created directory: '$DATA_FOLDER'"

  # Copy dataset subfolders if they exist
  for SUBFOLDER in train test validation; do
    SRC_PATH="$DATASET_FOLDER/$SUBFOLDER"
    DST_PATH="$DATA_FOLDER/$SUBFOLDER" # Destination path inside Data folder

    if [ -d "$SRC_PATH" ]; then
      echo "Copying '$SRC_PATH' to '$DATA_FOLDER/'..."
      # Copy the directory contents into the destination
      # Use cp -r for recursive copy. Adding a trailing slash to DST_PATH ensures
      # SRC_PATH itself is copied *into* DATA_FOLDER if DST_PATH doesn't exist,
      # or contents merged if it does. Using DATA_FOLDER/ ensures copying into it.
      cp -r "$SRC_PATH" "$DATA_FOLDER/"
    else
      # Print warning to standard error
      echo "Warning: Dataset subfolder '$SRC_PATH' not found. Skipping." >&2
      # Optional: Create empty placeholder if source not found?
      # mkdir -p "$DST_PATH"
    fi
  done

  # Create empty placeholder files
  echo "Creating placeholder files..."
  touch "$OUTPUT_FOLDER/main.py"
  touch "$OUTPUT_FOLDER/model.py"
  touch "$OUTPUT_FOLDER/utils.py"
  touch "$OUTPUT_FOLDER/train.py"
  touch "$OUTPUT_FOLDER/test.py"

  # Create basic notebook file
  # Using single quotes around the echo argument to preserve inner double quotes
  echo '{"cells": [], "metadata": {}, "nbformat": 4, "nbformat_minor": 4}' > "$OUTPUT_FOLDER/test_notebook.ipynb"

  echo "File structure created successfully in '$OUTPUT_FOLDER'"

else
  echo "Error: Unknown command '$COMMAND'." >&2
  usage
fi

exit 0