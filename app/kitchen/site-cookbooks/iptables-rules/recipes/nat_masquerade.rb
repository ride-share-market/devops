# Allows a server to forward/masquerade for private subnet

iptables_rule "nat_forward" do
  action :enable
end

iptables_rule "nat_masquerade" do
  action :enable
end

execute "/proc/sys/net/ipv4/ip_forward" do
  command "echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward"
  not_if "grep 1 /proc/sys/net/ipv4/ip_forward"
end
