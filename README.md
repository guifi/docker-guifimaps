# docker-guifimaps
Docker images for guifimaps service

## Requirements
We must have installed those packages:
- **docker engine**: version 1.13 or above


And that should be enough to run our image

## Working with this
If you want to work with this version of guifimaps WMS system you should run this command inside a development directory with writing permissions:

```
docker run -it -p 9000:80 -v "$PWD"/guifimaps:/home/guifi/ guifi/guifimaps
```

This command runs guifi/fiberfy container with a persistent volume mounted inside ./guifimaps/ folder. WMS service is bind in localhost port 9000.

```
Guifi.net guifimaps successfully installed in Docker image!
```

When this appears guifimaps is installed in the Docker container.

If you want to reinstall guifimaps you should erase INSTALLED file:
```
sudo rm ./guifimaps/INSTALLED
```
