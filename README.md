# X-Frame-Bypass

Forked and adapted from [niutech/x-frame-bypass](https://github.com/niutech/x-frame-bypass)

> You want to embed url in `<iframe>` element but the target has already protected itself by setting `X-Frame-Options` header... 
> 
> Don't worry: `./x-frame-bypass.sh [TARGET_URL]`

*Should only be used as a basic PoC. Customized it to fit your needs*

## Prerequisites

* [gitar](https://github.com/ariary/gitar): the reverse proxy
* [surge](https://surge.sh): host js file + expose it
* [ngrok](https://ngrok.com/): expose the reverse proxy
* [tmux](https://github.com/tmux/tmux)

***Privacy Notes:*** Be aware that the traffic is going to pass trough surge and ngrok. For more privacy expose your own server.


