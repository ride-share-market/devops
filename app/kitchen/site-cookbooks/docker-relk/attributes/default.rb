default["logstash"]["settings"]["fqdn"] = node["fqdn"]

default["logstash"]["settings"]["rabbitmq_host"] = "rsm-rabbitmq"

default["logstash"]["settings"]["rabbitmq_vhost"] = "rsm"

default["logstash"]["settings"]["rabbitmq_user"] = "rsm-logstash"

default["logstash"]["settings"]["rules"] = [
    # "100_input_auth.conf",
    "100_input_syslog.conf",
    # "100_input_firehol.conf",
    # "100_input_mail.conf",
    # "100_input_logstash.conf",
    # "100_input_unattended_upgrades.conf",
    # "100_input_rabbitmq.conf",
    "100_input_lumberjack.conf",
    # "100_input_upstart.conf",
    # "200_filter_syslog.conf",
    # "200_filter_firehol.conf",
    # "300_output_syslog.conf",
    # Input from log queue
    "100_input_rabbitmq.conf",
    "400_output_server.conf"
]