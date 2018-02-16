# Build

docker build --no-cache --rm --build-arg ssl=off -t readylabs/symfony .

OR

docker build --no-cache --rm --build-arg ssl=on -t readylabs/symfony .


# Testing

## Quick

docker run --rm -it -v ~/docker_data/symfony/www:/var/www readylabs/symfony composer create-project symfony/website-skeleton myapp

docker run --rm -p 127.0.0.1:8080:80 -v ~/docker_data/symfony/www:/var/www --env SYMFONY=myapp readylabs/symfony apache2-foreground

