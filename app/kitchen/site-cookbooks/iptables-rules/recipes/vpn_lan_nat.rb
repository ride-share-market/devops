# Allows a server to forward/masquerade for private subnet

iptables_rule "vpn_lan_forward" do
  action :enable
end

iptables_rule "vpn_lan_masquerade" do
  action :enable
end
