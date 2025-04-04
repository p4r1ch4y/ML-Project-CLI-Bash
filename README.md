# ML Project Template Generator

This tool is a command-line interface (CLI) application that automatically creates a standardized file structure for machine-learning projects. It sets up necessary directories and files, making it easier to organize your ML workflow.

## File Structure Created

```
output_folder/
│
├── Data/
│   ├── train/
│   ├── test/
│   └── validation/
│
├── main.py
├── model.py
├── utils.py
├── train.py
├── test.py
└── test_notebook.ipynb
```

## Requirements
- Python 3.6 +

## Installation
1. Clone this repository or download the `mlp_cli.py` file.
2. Ensure you have Python installed on your system.

## Usage

Run the script from the command line with the following syntax:
```
python mlp_cli.py create <output_folder> <dataset_folder>
```
Where:
- `<output_folder>` is the path where you want to create the project structure
- `<dataset_folder>` is the path to your existing folder containing the dataset images (with train, test, and validation subfolders)

Example:
```
python mlp_cli.py create ./my_ml_project ./my_dataset
```

This command will create the project structure in `./my_ml_project` using the dataset from `./my_dataset`.


## Bash Script ( by gemini ) 

How to Use the Bash Script:

Save the code above as create_ml_project.sh.

Make it executable: chmod +x create_ml_project.sh.

Run it: ./create_ml_project.sh create ./my_new_ml_project ./path/to/my/dataset

Replace ./my_new_ml_project with your desired output directory name.

Replace ./path/to/my/dataset with the actual path to your dataset folder (which should contain train, test, validation subfolders if you want them copied).
