# RBAC Role Based Access Controll System

## Configure database in Docker
### 1. Build PostgreSQL and Redis Docker Image
Run the following command:
```
cd docker
docker compose up -d

```
## Gradle Build
This build includes a copy of the Gradle wrapper. You don't have to have Gradle installed on your system to build the project. Simply execute the wrapper along with the appropriate task, for example
```
./gradlew clean
```
## Run the project
```
./gradlew bootRun

```
## Run this on linux if ./gradlew not found error
```
chmod +x gradlew
dos2unix gradlew
./gradlew bootRun
```
### If you see this, it means the Application is running successfully
```
Application Started successfully!
  ██████╗  ██████╗  █████╗  ██████╗ 
  ██╔══██╗ ██╔══██╗██╔══██╗██╔════╝ 
  ██████╔╝ ██████╔╝███████║██║      
  ██╔══██╗ ██╔══██╗██╔══██║██║      
  ██║  ██║ ██████╔╝██║  ██║╚██████╗ 
  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝           
```