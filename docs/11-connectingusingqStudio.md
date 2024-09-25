Connecting Using qStudio
===============

Open qStudio, right-click on `Servers` in the top left corner and select `Add Server`.

<p style="text-align: center">
    <img src="../workshop/graphics/Servers_qStudio1.png" alt="Add Server Connection" width="90%"/>
</p>

You will then see a pop-up showing the server properties. This is where you will add the information from the connection string (details below in the next step).

<p style="text-align: center">
    <img src="../workshop/graphics/Server_Properties1.png" alt="Server Properties" width="90%"/>
</p>

Follow the step in our [Generate Connection String section](https://dataintellecttech.github.io/TorQ-Amazon-FinSpace-Starter-Pack/08-clusterconnectionstring/#generate-connection-string) to get a fresh connection string. The generated connection string provides you with everything you need to fill the boxes above. See the below connection string for an example:

<p style="text-align: center">
    <img src="../workshop/graphics/Connectionstring3.png" alt="Connection String" width="90%"/>
</p>

The required fields in the Server Properties screen are contained within the connection string and are colon separated. Here,

`Host:` vpce-063d07d253dde398d-19p5nh4w.vpce-svc-0b408455b16d79292.us-west-2.vpce.amazonaws.com

`Port:` 443

`Name:` This is just the name of your process, can be anything i.e. rdb

`Username:` david-finspace

`Password:` Host=vpce-063d07d253dde398d-19p5nh4w.vpce-svc-0b408455b16d79292.us-west-2.vpce.amazonaws.com&Port=443&User=david-finspace&Action=finspace%3AConnectKxCluster&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDUaCXVzLXdlc3QtMiJGMEQCIFOmCCIAE5hyh0obtgV8TeS9jCglbxFPEossH5f4vRhrAiAIaxSHF%2FQhjqACSlmwlLTNJBvx658bQwyiH9LVz20ehSr4AgguEAIaDDc2NjAxMjI4NjAwMyIMl3TMLJjQytFtFLaiKtUCbJrjypNOC5U8GwttcBfln2SV%2FJclct%2FmeDtnUCUcVB3bzcCUOpGQFXUR%2FtonWVO0ZO1SUu%2Bna%2Bs0l0UfMu7K7qDOQhszg1%2Fxdblx0TRi70GVunATeJlpppyQeZNUk9RHSOvGPCN8VKGBJmisbeo3bJb7MvVLak1lgVdLn%2FxUIS0uTfA62PbzU6LPE1nj85bupgLrvAMlSwvZMy3pVXJaN%2BBvk0mulmCvIYfqlqL%2FcjvWbOMQdyXsdAYCO4TRpA7I38Jmfr9h1oee2JVvVMCu41yRQhbAqtqgvNwrhgSyOQASAJSVGiIPHiXyGz5KefntOfq1zADleUrUg0Nvh6EPFj%2FavNsHZyBSapvUVVsx%2FA9aI2aHeg5P%2FtCifq%2Bnxg5vyKSX4GcB7P40pKs3Ymeb3yAUllN2tJ5VXlx7SI3p8jfTB8k72BeOzu%2BLbWs5gtb%2BlZG1cSQwzKSHrwY6wAEpzwyEjjuh50PM6OZgRBNgBEOiqLaTHqjBv7VHcjsF5FnpJqZ2AhBtQXXkFiItA%2FSZ7B0aGbL0sYJ8v7WZZIMtAvg4e0ve9VBYXf4hnl5i82T5EJfAy727E9e25Wwb%2FILZAeOjdTY0IhcgvWlLCeBJNEHEMO8h8yupkLfFQHlNvF14wrH1U8bSd934M8k%2F22%2FDTrZFlVQXe%2FeLYt%2FxOBEHfHWiMH51v2IDv39%2B%2B7%2FGq3XmrcNymPQQ0HcoJEK%2BTjg%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240301T130412Z&X-Amz-SignedHeaders=host&X-Amz-Expires=900&X-Amz-Credential=ASIA3EWPD4QZXLHMX4GY%2F20240301%2Fus-west-2%2Ffinspace-apricot%2Faws4_request&X-Amz-Signature=c134f0dc1f0cba738c0bf8547c9ca8702593ea9e9b89ee2d17892fd379524d30

<p style="text-align: center">
    <img src="../workshop/graphics/CompleteServers1.png" alt="All Servers" width="90%"/>
</p>
