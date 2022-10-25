# Headus UV Floating Server #

This is a docker container for a floating license server for Headus UVLayout,
**This is not an offical docker image** but it does pull from the offical commpressed archive.

See: <https://www.uvlayout.com/>
made by: <http://www.headus.com.au/>

Support: <https://www.uvlayout.com/support/hlserver/>

## Container ##

Container Page: <https://github.com/cerebralfix/HLServerDocker/pkgs/container/hlserver>

```bash
docker pull https://ghcr.io/cerebralfix/hlserver:latest
```

## Running ##

On first run the hlmanager will generate a cod ethat you need to send to your vendor to obtain your floating license.

See support doc for more information: <https://www.uvlayout.com/support/hlserver/>

The code will be saved here for future reference:

```text
/usr/local/hlserver/hlmanager-code.txt
```

## Adding Licenses ##

You can either add licenses manually via command line, or via the headus UV app. See docs: <http://www.headus.com/doc/HLServer>

**Or** you can add them to a volume mounted text file to be added on launch.
The file should be mounted to:

```text
/usr/local/hlserver/hlmanager-license.txt
```

With each line representing a new key.
