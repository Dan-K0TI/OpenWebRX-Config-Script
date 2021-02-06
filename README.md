# OpenWebRX configuration file script

install.sh is a simple script to help when editing OpenWebRX configuration files

OpenWebRX can be found at https://www.openwebrx.de/


## Installation

To install place the install.sh script in your home directory along with 
copies of the running files from /etc/openwebrx.
Make the install.sh script executable with chmod

```bash
chmod +x install.sh
```

## Usage

After editing any of the files run the script to copy over to production
The script  requires running with sudo

```bash
sudo ./update.sh
```

Some sample outputs from some possible file states

Both json files are badly formatted:
```bash
$ sudo ./update.sh
bands.json -------- file bad , test failed
bookmarks.json ---- file bad , test failed
```

bands.json is good and newer and bookmarks.json is badly formatted
```bash
sudo ./update.sh
bands.json -------- passes json test
bands.json -------- newer and copied
bookmarks.json ---- file bad , test failed
```

Both json files are good, only one has been updated.
```bash
sudo ./update.sh
bands.json -------- passes json test
bands.json -------- not newer, no copy performed
bookmarks.json ---- passes json test
bookmarks.json ---- newer and copied
config_webrx.py --- not newer, no copy performed
OpenWebRX reloaded
```


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Good DX
Dan


## License
[MIT](https://choosealicense.com/licenses/mit/)