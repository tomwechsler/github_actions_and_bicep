# Setting up the test environment

**Install Chocolatey for Individual Use**  

[Package Manager for Windows - Documentation](https://chocolatey.org/install)

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**Install PowerShell with choco**  
```
choco install powershell-core
```

**Install Visual Studio Code with choco**  
```
choco install vscode
```

**Install Git with choco**  
```
choco install git.install
```

**Install Azure CLI with choco**  
```
choco install azure-cli
```

**Install Bicep CLI with choco**  
```
choco install bicep
```