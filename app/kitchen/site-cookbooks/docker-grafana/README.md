# docker-grafana-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['docker-grafana']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### docker-grafana::default

Include `docker-grafana` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[docker-grafana::default]"
  ]
}
```

## License and Authors

Author:: Ride Share Market (<systemsadmin@ridesharemarket.com>)
