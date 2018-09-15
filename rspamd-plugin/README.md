Integrates Vipul's Razor with Rspamd.

Taken from [cgt rspamd-plugins repo](https://github.com/cgt/rspamd-plugins)

Distributed under the MIT license.

## Usage
in /etc/rspamd/rspamd.conf.local put this sections:
```
razor {
    host = 127.0.0.1;
    port = 9192;
}

modules {
    path = "$PLUGINSDIR/lua/"
    path = "$CONFDIR/razor.lua"
}
```

...todo...
