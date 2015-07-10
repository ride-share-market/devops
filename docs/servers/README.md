## Requirements

- The devops digitalocean.com scripts need the environment variable RSMCOM_DIGITAL_OCEAN_ACCESS_TOKEN set.
- Check:
- `echo $RSMCOM_DIGITAL_OCEAN_ACCESS_TOKEN`
- Set (token from encrypted keepass file):
- `export RSMCOM_DIGITAL_OCEAN_ACCESS_TOKEN=abc123`

### Chef Server Data Bags
- `cd app/kitchen`
- `knife data bag create network`
- `knife data bag from file network data_bags/network/prd_ams_ridesharemarket.json`
- `knife data bag create network`
- `knife data bag from file secrets data_bags/secrets/secrets.json`
- `knife data bag create users`
- `knife data bag from file secrets data_bags/users/rsm-data.json`

### Chef Server Cookbooks
- `knife cookbook upload --all`

### Servers

- [redline](cloud/digital_ocean_redline.md)
- [crimson](cloud/digital_ocean_crimson.md)