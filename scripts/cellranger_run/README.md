# Cell Ranger setup and run
Instructions for setting up and running Cell Ranger in LCSBs HPC.
## Installation

Go to `$HOME` and Download tar.gz with:

```bash
cd $HOME
curl -o cellranger-9.0.1.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-9.0.1.tar.gz?Expires=1741813380&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA&Signature=Msg0afmv7luBeMBNHN9e6PisiCJ~lSVK-SvdEtit~7fsaFZVORqBt6nCxFwqasb9Y5Ycbz-WAaoB2ajyAygtWOmRByIEk69IMiAO4kHMbYGWBJCryf0u0z64bqMpzK5KLETUpg4dyMtNxQlxrTpJsXL9jBxDFaHjCaSam9OL3PHscRvrmKoTgc98KUvEe3FaJAJVhG2JTj6Y2NHXSr3mXKoqI3XtXoLQg0UK8bne-ifavUtiFQ-hvQKFtkNLmVJbBxepurD6EBy-oU6CaXpcAn2lOOSI0p3iB1FNx0ONsTVUH8Ibvbk8fOAHTDoATtiP-cWBWAbcQG4Qj43kLWm9~A__"
```

Uncompress tar.gz with:

```bash
tar -xf cellranger-9.0.1.tar.gz
rm cellranger-9.0.1.tar.gz
```

Add cellranger to path in .bashrc

```bash
# Add cellranger to path
export PATH=$PATH:$HOME/cellranger-9.0.1
```

Download reference transcriptome, in this case human

```bash
curl -O "https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2024-A.tar.gz"
tar -xf refdata-gex-GRCh38-2024-A.tar.gz
rm refdata-gex-GRCh38-2024-A.tar.gz
```

## Running
Edit `cellranger_run.sh` with the desired values for:
- `fastq_dir`: directory with the FASTQ files.
- `id`: ID of the analysis, which will be used for creating a folder within `out_dir` with all the results.
- `ref_trnscrptm`: directory with the reference transcriptome (in this case is `refdata-gex-GRCh38-2024-A.tar.gz`)
- `out_dir`: directory where generated files will be stored.

Then run:
```bash
bash cellranger_run.sh
```