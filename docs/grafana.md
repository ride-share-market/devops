# Grafana

1) Sign in
http://192.168.33.10:3000/
admin:admin

3) Configure a new Datasource
Datasources -> Add New

- Name: rsm-prometheus
- Default: checked
- Type: Prometheus

- URL: http://rsm-prometheus:9090
- Access: proxy


3) Graphs

- Dashboards -> New
- Add Panel -> Graph
- Edit...
