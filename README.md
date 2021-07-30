# Project AAAA_2019_Project-Template

## Project overview

https://biocellgen-private.svi.edu.au/weeo_2021_meta-eqtl/public/index.html


## Reproducibility and version control

We aim to make all of our projects and analyses completely open and reproducible. The [workflowr][] package makes this aim easier to achieve by providing a set of tools and conventions for reproducible analysis workflows in R and the simultaneous building of a website that presents the analyses, with source code, in a readable way. 

The system integrates seamlessly with the git version control system.

As many project files as possible should be under version control. All user-created text files (e.g. `.md`, `.Rmd`, etc) and code (`.R`, `.py`, etc. files) should be under version control. Files that are large in size should not be under version control (too many large files in the repository makes git become unwieldy), and, in general, there is no need for files produced by code or analysis files to be versioned as running the workflow will produce them.

Docker containers encapsulating software environments enable reproducibility by allowing the same software and environments to be easily used by different people across different platforms. As such, we use them extensively.

Workflow management software makes a very big difference when trying to run complicated computational workflows and making them portable across local, cluster, and other HPC computing environments.

## Acknowledgements

This project is a [workflmiowr][] project. Making use of the workflowr package for reproducible analyses dictates certain structures for the project file.

[workflowr]: https://github.com/jdblischak/workflowr
