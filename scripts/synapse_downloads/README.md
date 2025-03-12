# Download data programatically from synapse.org
Setup of the Synapse.org client and usage, with a python script for downloading the data.
## Install synapse client
```bash
conda activate python-3.8
pip3 install synapseclient
conda deactivate
```
## Usage
### Command line
```bash
synapse get <synID>
```
### Python
Use python script `download_synapse.py`:
```bash
conda activate python-3-8
python3 download_synapse.py --synID <synID> --outDir </path/to/output/dir>
conda deactivate
```
