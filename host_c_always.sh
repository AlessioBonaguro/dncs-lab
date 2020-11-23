# Startup commands for host-C go here
sudo docker run -it --rm -d -p 80:80 --name webServer dustnic82/nginx-test
echo "Host-C -> webServer run..\n"
