- `knife node show mandolin`

- Add cookbooks one by one
- `knife node run_list add mandolin docker-wrapper`
- `knife node run_list add mandolin docker-lumberjack::default`
- `knife node run_list add mandolin docker-lumberjack::ssl`