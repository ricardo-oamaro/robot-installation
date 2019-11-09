############################################################################################
# Robot Installation
#
# Version 1.1
# - Added CX_Oracle
# - Added Oracle Instant Client
#
# ##########################################################################################
#
# Version 1.0
# Script to setup local Machine to runs Robot automaiton. Function:
# -Installation Python, NodeJS, RobotFramework (Selenium, Autoit, SAP, SSH Library, appium)
# -Environment variable setup. 
#
# Instruction:
# - Download robot.bat e robot-install.ps1 from git repository https://github.ibm.com/vfsousa/automacoesTIM
# - Right-click in robot.bat > Run as administrator
# ----------------------------
# Created by Ricardo Amaro
# Contact riamaro@br.ibm.com
# -----------------------------
###########################################################################################

# Anaconda installation
# choco install anaconda3
# choco upgrade anaconda3

Write-Host "Installing Python 3.7.3 x64..." -ForegroundColor Cyan
Write-Host "Downloading..."
$script = New-Object Net.WebClient
$script | Get-Member
$script.DownloadString("https://chocolatey.org/install.ps1")
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
choco upgrade chocolatey
Write-Host "Installing Python..."
choco install -y python3
refreshenv
python -V
python -m pip install --upgrade pip
Write-Host "Installing NodeJS..."
choco install -y nodejs
npm install -g appium
npm install -g appium-doctor
Write-Host "Installing Mini Conda..."
choco install -y miniconda3
[Environment]::SetEnvironmentVariable('PATH', ([Environment]::GetEnvironmentVariable('PATH', 'Machine') + ';C:\tools\miniconda3\Scripts'), 'Machine')
Write-Host "Setting up Oracle Instant Client..."
C:\tools\miniconda3\Scripts\conda.exe install -c anaconda oracle-instantclient
Write-Host "Installing RobotFramework..."
pip install robotframework
pip install robotframework-selenium2library --user
pip install robotframework-autoitlibrary
pip install robotframework-SapGuiLibrary
pip install robotframework-SSHLibrary
pip install cx_oracle
pip install six --user
pip install robotframework-appiumlibrary --user
pip install selenium --user
pip install robotframework-faker
pip install robotframework-csvlib
pip install robotframework-csvlibrary

Write-Host "Setting up Environment Variables"
$pythonVar = Get-ChildItem "C:\Python*\"
$androidVar = Get-ChildItem "C:\Android\android-sdk\"
$javaVar = Get-ChildItem "C:\Program Files\Java\jdk*\bin\"
#criar nova variavel
[System.Environment]::SetEnvironmentVariable('PYTHONPATH', $pythonVar, [System.EnvironmentVariableTarget]::Machine) 
[System.Environment]::SetEnvironmentVariable('ANDROID_HOME', $androidVar, [System.EnvironmentVariableTarget]::Machine) 
# [System.Environment]::SetEnvironmentVariable('CLASSPATH', ';%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\htmlconverter.jar;%JAVA_HOME%\jre\lib;%JAVA_HOME%\jre\lib\rt.jar;', [System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable('JAVA_HOME', $javaVar, [System.EnvironmentVariableTarget]::Machine) 

#adicionar linha no path
[Environment]::SetEnvironmentVariable('PATH', ([Environment]::GetEnvironmentVariable('PATH', 'Machine') + ';%JAVA_HOME%\bin;%PYTHONPATH%;%PYTHONPATH%\Scripts;%ANDROID_HOME%;C:\instantclient'), 'Machine')

Write-Host "Completed Installation!!!"

# LOAD FORMS ASSEMBLY
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null


# PROMPT USER FOR REBOOT
$output = [System.Windows.Forms.MessageBox]::Show("The Installation has been completed. Windows must be restarted. Do you want to do it now?", "Attention", "4")


# IF YES, REBOOT
if ($output -eq "Yes")
    {
        shutdown -r -t 00
    }
elseif ($output -eq "No")
    {
        exit
    }


