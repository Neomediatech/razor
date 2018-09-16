Integrates Vipul's Razor with Rspamd.  
Taken from [cgt rspamd-plugins repo](https://github.com/cgt/rspamd-plugins).  
Distributed under the MIT license.

## Prerequisites
* make sure to have configured [razor](../README.md)

## Usage
in `/etc/rspamd/rspamd.conf.local` put this sections:
```
razor {
    host = 127.0.0.1;
    port = 9192;
}

modules {
    path = "$CONFDIR/razor.lua"
}
```
Maybe you want Razor add some score to your spam score :-)  Pyzor
Edit `/etc/rspamd/local.d/metrics.conf` and add this section:
```
symbol "RAZOR" {
    weight = 2.0;
    description = "Detected as spam by Vipul's Razor";
}
```
In [cgt manual](https://github.com/cgt/rspamd-plugins/issues/1#issuecomment-379147658) Christoffer suggests to give `2.0` score.  
I suggest you to try with the section above commented out, to evaluate if and how Razor works on your environment.  
Razor will works with Rspamd, if it detects mails as spam, razor.lua will insert the `RAZOR` symbol but with `0.0` score.

You can see what happens using a command like  
`egrep "RAZOR\([[:digit:]]+\.[[:digit:]]+\)" /var/log/rspamd/rspamd.log` to see the scores history.  
Or you can use a command like  
`tail -f /var/log/rspamd/rspamd.log | egrep "RAZOR\([[:digit:]]+\.[[:digit:]]+\)"` to see what happens in realtime.

After you monitored the behaviour for some hour, and you are satisfied of the results, you can uncomment the section above, and choose if you want increase the score. Is up to you.

Put [razor.lua](./razor.lua) in `/etc/rspamd` folder
