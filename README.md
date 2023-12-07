docker build -t my-php-slim-app .

docker run -p 8080:80 my-php-slim-app

docker tag my-php-slim-app:latest yourusername/my-php-slim-app:latest


docker push yourusername/my-php-slim-app:latest