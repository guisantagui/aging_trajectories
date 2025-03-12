# Download data programatically from synapse.org

## Install synapse client

```bash
conda activate python-3.8
pip3 install synapseclient
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
python3 download_synapse --synID <synID> --outDir </path/to/output/dir>
```
