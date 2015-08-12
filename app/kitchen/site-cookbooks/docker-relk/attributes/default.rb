default["logstash"]["settings"]["rabbitmq_host"] = "192.168.33.10"

default["logstash"]["settings"]["rabbitmq_vhost"] = "rsm"

default["logstash"]["settings"]["rules"] = [
    "100_input_mail.conf",
    # "100_input_logstash.conf",
    "100_input_auth.conf",
    "100_input_syslog.conf",
    "100_input_unattended_upgrades.conf",
    # "100_input_rabbitmq.conf",
    "100_input_lumberjack.conf",
    "100_input_upstart.conf",
    "200_filter_syslog.conf",
    "300_output_syslog.conf",
    # Input from log queue
    "100_input_rabbitmq.conf",
    "400_output_server.conf"
]