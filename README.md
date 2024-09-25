# chef-conda

Under development

## Local testing

### Run with chef-solo

Download the dependencies using `berks`:

```bash
berks vendor berks-vendor-cookbooks
```

`chef-solo` will find the berks cookbooks donwloaded since the path is in `solo.rb`. To run `chef-solo` execute:

```bash
sudo chef-solo -c solo.rb -j solo.d/default.json
```

For testing:

```bash
sudo chef-solo -Etest -c solo.rb -j solo.d/default.json
```
