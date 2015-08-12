docker_container "rsm-rabbitmq" do
  detach true
  image "rabbitmq:3.5.4-management"
  container_name "rsm-rabbitmq"
  restart "always"
  init_type false
  hostname "rsm-rabbit"
  port [
           "5672:5672",
           "15672:15672"
       ]
end
# sudo docker run --rm -it --hostname my-rabbit --name some-rabbit \
#    -p 5672:5672 -p 15672:15672 \
#    rabbitmq:management
