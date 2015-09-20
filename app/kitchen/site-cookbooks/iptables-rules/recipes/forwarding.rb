execute "/proc/sys/net/ipv4/ip_forward" do
  command "echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward"
  not_if "grep 1 /proc/sys/net/ipv4/ip_forward"
end

iptables_rule "forward" do
  action :enable
end