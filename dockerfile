# Use Windows Server Core as the base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install IIS using DISM
RUN dism.exe /online /enable-feature /all /featurename:iis-webserver /NoRestart

# Set up work directory
WORKDIR C:/java

# Copy all installation files from local 'setup' folder to container
ADD ./setup C:/java/setup

# Install JRE and JDK
RUN powershell -Command "Start-Process -FilePath 'C:\\java\\setup\\jre.cmd' -NoNewWindow -Wait; \
     Start-Process -FilePath 'C:\\java\\setup\\jdk.cmd' -NoNewWindow -Wait"

# Execute the PowerShell script to set environment variables
RUN powershell -ExecutionPolicy Bypass -File C:/java/setup/Environmentvariable.ps1

# Install Python using the silent installation method
RUN C:/java/setup/py.cmd

# Copy Tomcat files directly with Docker COPY commad
COPY ./setup/tomcat C:/tomcat

# Copy the sample.war file to Tomcat's webapps directory
COPY ./setup/sample.war C:/tomcat/webapps/

# Alternative method using cmd array syntax for Docker RUN
RUN ["cmd", "/c", "C:/java/setup/tomcatservice.bat"]

# Use the full path to sc.exe
RUN C:/Windows/System32/sc.exe config tomcat9 obj=LocalSystem start=auto

# Expose Tomcat port
EXPOSE 8080

# Start Command Prompt and keep container running
CMD ["cmd", "/k"]