default["docker-prometheus"]["scrape_configs"] = [
    {
        :job_name => "node",
        :target_groups => [
            "192.168.33.100:9100",
            "192.168.33.101:9100"
        ]
    },
    {
        :job_name => "docker",
        :target_groups => [
            "192.168.33.100:9104",
            "192.168.33.101:9104"
        ]
    },
    {
        :job_name => "statsd",
        :target_groups => [
            "192.168.33.100:9102"
        ]
    }
]
