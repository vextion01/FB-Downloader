# FB-Downloader

My aunt needed to download a ton of videos from Facebook — that’s why I built this. 😄

this script can download both public and private videos from private group or user.
---

## My Environment   

- ffmpeg version 4.4.2-0ubuntu0.22.04.1
- sed (GNU sed) 4.8
- grep (GNU grep) 3.7
- Ubuntu 22.04.5 LTS
- Ugreen Ergonomic Wireless Mouse Model : 90545
- Wood Chair
jk :)
---

## How to use.

1. Go to the video you want to download (this script can download both public and private videos).
2. Press `Ctrl + U` and copy the entire page source.
3. Paste the copied content into a text file.
4. Run the script.
🤓🤓🤓🤓🤓🤓🤓🤓

## How to start  

### Change permission file.  
Adds the execute permission to loader.sh. 
```sh
chmod +x loader.sh
```

### Run this file.
You can run it directly from the terminal like this 🥳🥳:
```sh
./loader.sh -f file.txt ...
```
### Options

| Option   | Long Option            | Description                                    |
| -------- | ---------------------- | ---------------------------------------------- |
| `-c`     | `--check`              | Check the resolution of the video.             |
| `-d`     | `--datasaver`          | Download the video at the lowest quality.      |
| `-f` FILE| `--file` FILE          | Specifies the input file to use.               |
| `-h`     | `--help`               | Display help information.                      |
| `-m`     | `--maximum`            | Download the video in the highest quality.     |
| `-r` RES | `--resolution` RES     | Sets the resolution (e.g., `1080p`, `720p`).   |
| `-v` VOL | `--volume` VOL         | Adjust the video volume (e.g., `3.0`). The default is 2.0. |


---
## Important Notes

⚠️ **Disclaimer❗️❗️❗️** 
This project is intended for educational and personal use only. It is not affiliated with or endorsed by Facebook or Meta Platforms, Inc.

Downloading videos from Facebook may violate their Terms of Service and should only be done with the permission of the content owner. Users are solely responsible for how they use this tool.

We do not support or encourage the unauthorized downloading, redistribution, or misuse of copyrighted content. By using this project, you agree to use it ethically and lawfully.

---
