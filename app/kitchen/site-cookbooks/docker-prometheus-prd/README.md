# docker-prometheus-prd-cookbook

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
    <td><tt>['docker-prometheus-prd']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### docker-prometheus-prd::default

Include `docker-prometheus-prd` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[docker-prometheus-prd::default]"
  ]
}
```

## License and Authors

Author:: Ride Share Market (<systemsadmin@ridesharemarket.com>)
