# SQL-install-script

The following three example files contain runnable code of different features within the modules.

---
ExampleSQL2017 - Installs SQL2017 onto your machine. Params:

-SQLFilePath: the filepath to the SQL2017 setup file.
-InstallPath: The filepath to install the instance in.
-InstallSharedDir: The filepatch to install shared resources in.
-ConfigIniPath: The location of the configurationFile.ini
-InstanceName: Name for the new instance
-InstanceID: ID for the new instance
-Features: Which features you want enabled for the instance
(Optional) -SQLauthentication: A switch to set up SQL authentication for the instance, if used
(Optional) -SQLpwd: The password for the SQL authentication, only if enabled above
(Optional) -FindInstall: A switch that will run a post install check to see if an active process exists for the new server.

---
ExampleSSMS - Installs SSMS onto your machine. Params:

-SsmsPath: Filepath to the setup file.
 
--- 
ExampleCheck - Checks your previous install.

-instanceName: The name of the instance to check for.
