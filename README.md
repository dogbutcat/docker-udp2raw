# docker-udp2raw

## Change Log

> 2020-06

- update script

> 2019-03

- update udp2raw

## Introducing

this image is based on alpine image & you need basic docker knowledge. You can get it from Google or [Git-book](https://yeasy.gitbooks.io/docker_practice/) for Chinese Learning. Then DON'T ASK ME! :D

## Word first

this is for udpspeeder usage. Build-in version is [Here](https://github.com/wangyu-/UDPspeeder/releases/20180806.0)

## How To Use It

> please replace command option with default entry point `udp2raw_amd64` like what you need to add to end `docker run` as below

```sh
docker run -p 1234:1234/udp -p 5678:5678/udp dogbutcat/1.0-udp2raw \
          -s -l 0.0.0.0:1234 -r 127.0.0.1:5678 -k "passwds" --raw-mode faketcp -g
```

you can also replace the entry point with (reference [here](https://docs.docker.com/engine/reference/run/#entrypoint-default-command-to-execute-at-runtime))

- `udp2raw_x86`
- `udp2raw_arm`
- `udp2raw_amd64_hw_aes`
- `udp2raw_arm_asm_aes`
- `udp2raw_mips24kc_be`
- `udp2raw_mips24kc_be_asm_aes`
- `udp2raw_x86_asm_aes`
- `udp2raw_mips24kc_le`
- `udp2raw_mips24kc_le_asm_aes`

```sh
docker run -p 1234:1234 -p 5678:5678/udp dogbutcat/1.0-udp2raw udp2raw_x86 \
          -s -l 0.0.0.0:1234 -r 127.0.0.1:5678 -k "passwds" --raw-mode faketcp -g
```

### Caveats

please remember drop tcp package on listen port as it only accept udp to transfer to faketcp, you can get specific iptable rule with `-g` option throught command

```sh
docker run -p 1234:1234 -p 5678:5678/udp dogbutcat/1.0-udp2raw udp2raw_x86 \
          -s -l 0.0.0.0:1234 -r 127.0.0.1:5678 -k "passwds" --raw-mode faketcp -g
```

because udp2raw running on level 2, if not work correct, ~~maybe~~ MUST need add `--net=host`/`--cap-add=NET_ADMIN` or `network_mode:"host"`/`cap_add: NET_ADMIN` in compose