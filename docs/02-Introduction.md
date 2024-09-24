Introduction
===============

## Goals of the workshop

1. To understand what TorQ is and to know the benefits of using it with Managed kdb Insights.

2. To set up a TorQ stack within Managed kdb Insights, connect to the clusters, and access the data within - both historical and real-time.

3. Show existing TorQ users how to migrate their database into Managed kdb Insights.

## What are we going to build?

We will be building “TorQ for Amazon FinSpace with Managed kdb Insights”, a MVP of TorQ which is leveraging functionality within AWS. In this MVP, although all the TorQ code will be included within your code bucket, we will only be using files which are a necessity for this MVP creation. This will create a working TorQ setup on the cloud through Managed kdb Insights. We are going to do so by replicating the below steps.

- Creating and setting up a Kdb Environment on Amazon Finspace.

- Create a General Purpose (GP) cluster for the Discovery process of TorQ. This allows other processes to use the discovery service to register their own availability, find other processes (by process type), and subscribe to receive updates for new process availability.

- Create a Ticker Plant (TP) cluster. This will receive data from the feed and send it to it's subscribers (RDB in this setup). In this setup we use a Segmented Ticker Plant (STP) but for simplicity it will just be called TP for this documentation.

- Create an RDB cluster. This will allow us to query and store live data from the TP.

- Create a HDB cluster. This will allow us to query historical data.

- Create Gateway cluster which acts as the gateway within TorQ. This process allows users to query data within the RDB and HDB processes.

- Lastly, create another General Purpose (GP) cluster within Managed kdb Insights. This will replicate the feed handler of TorQ, which will normalize and prepare our data into a schema readable by kdb, for the ingestion and population of our tables.

All of this culminates in a TorQ production system being hosted on the cloud using six clusters. This allows users to ingest data, before querying both live and historical data through a gateway and discovery process.