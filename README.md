# TorQ-Amazon-FinSpace-Starter-Pack
An example market data capture system designed for running in AWS Managed kdb Insights.

This codebase contains:

* Useful scripts for interacting with Managed kdb Insights - ./scripts directory
* Initial code for a "TorQ for Amazon FinSpace with Managed kdb Insights" application

## Getting Started
Follow instructions on the [TorQ on Managed kdb Insights Documentation Pages](https://dataintellecttech.github.io/TorQ-Amazon-FinSpace-Starter-Pack/).

## Updating the Documentation with Mkdocs

To make changes to the documentation website you must simply use this command while in the branch you have made the changes on:

`mkdocs gh-deploy`

You will be prompted to enter a username and password, after this the site should have been updated. You can test the site locally if you want using mkdocs. First use the command:

`mkdocs build`

Then:

`mkdocs serve -a YourIp:Port`

Head to the address it gives you to check if your changes have worked. More information about using mkdocs can be found [here](http://www.mkdocs.org/)
  
## Release Notes
- **2.0.0, May 2024**
  * Added support for STP process
  * Added support for WDB process
  * Added support for AWS Dataviews and Scaling Groups
  * Added support for DataAccess API
  * Bug Fixes
- **1.1.0, Apr 2024**
  * env.q now uses native .aws variables to dynamically set global variables
  * terraform updates to support scaling group and shared volume compatibility
  * create_clusters.py supports creation of dedicated clusters and clusters on scaling groups
- **1.0.3, Mar 2024**:
  * sleep command no longer calls the os, instead mimics
- **1.0.2, Feb 2024**:
  * Updated documentation to be more detailed and readable
  * Updated exec role permissions to be in sync with AWS security changes
  * Fixed feed connection logic to rdb
- **1.0.1, Dec 2023**:
  * Renaming project refrences to TorQ-Amazon-FinSpace-Starter-Pack
- **1.0.0, Dec 2023**:
  * Initial public release of TorQ-Finspace-Starter-Pack
