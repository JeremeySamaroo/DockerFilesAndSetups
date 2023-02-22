# DockerFilesAndSetups



## Setting up Git on mac
1) Run the following command Note: Only if git not installed else go to step 2
```
xcode-select --install
```

2)Initialize git project
```
git init .
```

3)Add git remote to repository in each of the project required folders.
```
git remote add origin <url>
```

4)Add git files
```
git add .
```
5)Commit to git
```
git commit -m "<Some-Message>"
```

## Create Docker Container for Api
1) Create a Docker network
```
docker network create jncbDevNetwork 
```

2) Build Docker API container
```
docker build -t ubuntu_java11_node_img -f ubuntuJava11.Dockerfile .      
```

3) Create Docker API container with link to folder
```
docker run --name=JNCB_JAVA11_DEV -v <Path-of-working-code-local>:/app --network=jncbDevNetwork -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 -p 3004:3004 -p 3005:3005 -p 3006:3006 -p 80:80 -it ubuntu_java11_node_img /bin/sh

J_Specific 
docker run --name=JNCB_JAVA11_DEV -v /Users/jeremeysamaroo/dev/JNCB/01_21Feb2022_Sprint11/01_Sprint11_Build01_21Feb2022:/app --network=jncbDevNetwork -p 3000:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 -p 3004:3004 -p 3005:3005 -p 3006:3006 -p 80:80 -it ubuntu_java11_node_img /bin/sh




```

## Create Docker Container for MongoDB

1) Create Monogodb Image
```
docker pull postgres
```


3) Create Postgres Container
```

J_Specific
docker run  --name=Postgres -p 5432:5432 -e POSTGRES_PASSWORD="root" --network=jncbDevNetwork postgres      

ubuntu specific
docker run  --name=Postgres -p 5432:5432 -e POSTGRES_PASSWORD="root" --network=jncbDevNetwork postgres      


env string for local
mongodb://dockerMongodbDatabase:27017/corecash

mongodb://dockermongodbdatabase:27017/corecash

mongodb://localhost:27017/corecash

view node container running 
sudo docker container run api_corecash_container


```
something
