Setup qStudio
===============

You must follow these steps from within your EC2 instance.

## Download qStudio

Navigate to the [TimeStored](https://www.timestored.com/qstudio/download) website and download the relavent version (usually x64).

<p style="text-align: center">
    <img src="../workshop/graphics/qStudio_Download1.png" alt="Download button on qStudio website" width="90%"/>
</p>

Download the [Microsoft C++ 2010 service pack](https://www.microsoft.com/en-gb/download/details.aspx?id=26999) (there is a specific DLL from this that you need that is usually installed on Windows machines).

<p style="text-align: center">
    <img src="../workshop/graphics/MSpack_download.png" alt="Download MSPack" width="90%"/>
</p>

Select the relevant version (usually x64).**

<p style="text-align: center">
    <img src="../workshop/graphics/MSpack_download2.png" alt="Download MSPack select version" width="90%"/>
</p>

Run the file that was just downloaded.

Search for ‘Edit Environment variables’ and add `SSL_VERIFY_SERVER=NO` as one of them.

<p style="text-align: center">
    <img src="../workshop/graphics/edit_env_var1.png" alt="Edit Environment Variables 1" width="90%"/>
</p>
<p style="text-align: center">
    <img src="../workshop/graphics/edit_env_var2.png" alt="Edit Environment Variables 2" width="90%"/>
</p>
<p style="text-align: center">
    <img src="../workshop/graphics/edit_env_var3.png" alt="Edit Environment Variables 3" width="90%"/>
</p>
