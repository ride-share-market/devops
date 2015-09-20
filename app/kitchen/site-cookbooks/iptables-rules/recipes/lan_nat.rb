# Allows a server to forward/masquerade for private subnet

iptables_rule "lan_forward" do
  action :enable
end

iptables_rule "lan_masquerade" do
  action :enable
end


