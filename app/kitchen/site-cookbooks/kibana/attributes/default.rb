default["kibana"]["src_filename"] = "kibana-4.0.2-linux-x64"

default["kibana"]["src_filename_type"] = "tar.gz"

default["kibana"]["src_url"] = "https://download.elastic.co/kibana/kibana/#{default["kibana"]["src_filename"]}.#{default["kibana"]["src_filename_type"]}"

default["kibana"]["extract_path"] = "/opt/kibana"

default["kibana"]["log_path"] = "/var/log/kibana"

default["kibana"]["log_file"] = "kibana.log"

default["kibana"]["elasticsearch_url"] = "http://localhost:9200"

default["kibana"]["user"] = "logstash"
