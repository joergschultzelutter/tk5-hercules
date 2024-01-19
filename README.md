# tk5-hercules

[![License: The Unlicense](https://img.shields.io/badge/License-Unlicense-blue.svg)](https://unlicense.org)

Port of skunklabz' [tk4-hercules](https://github.com/skunklabz/tk4-hercules) docker file to [MVS 3.8j with Turnkey Version 5.2](https://www.prince-webdesign.nl/tk5), now running on Alpine Linux

## Usage

- Run `docker run -ti -p 3270:3270 -p8038:8038 skunklabz/tk5-hercules`
- Use a browser to check on the system's status by visiting `http://127.0.0.1:8038`
- Total boot startup will take approximately 60 seconds.
- Once the bootup is complete and you see the Turnkey boot screen on the status page, use e.g. `c3270 127.0.0.1:3270` for connecting to the local MVS instance.


## Persistence
To run with persistence so that you don't lose your data after stopping the docker container please use the following command to start it up.

```
docker run -d \
--mount source=tk5-conf,target=/tk5/conf \
--mount source=tk5-local_conf,target=/tk5/local_conf \
--mount source=tk5-local_scripts,target=/tk5/local_scripts \
--mount source=tk5-prt,target=/tk5/prt \
--mount source=tk5-dasd,target=/tk5/dasd \
--mount source=tk5-pch,target=/tk5/pch \
--mount source=tk5-jcl,target=/tk5/jcl \
--mount source=tk5-log,target=/tk5/log \
--mount source=tk5-tape,target=/tk5/tape \
-p 3270:3270 \
-p 8038:8038 tk5
```

### Description of persisted directories

| Directory            | Description                                                                                                                                                                                                               |
|----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/tk5/conf`          | This is where the master configuration file `tk5.cnf` is stored                                                                                                                                                           |
| `/tk5/local_conf`    | Scripts for initialization and unattended operations                                                                                                                                                                      |
| `/tk5/local_scripts` | There are 10 files located here that are meant for user applied modifications and are run after Hercules initialization, when operating in manual mode or after MVS 3.8j initialization when operating in unattended mode |
| `/tk5/prt`           | Used for simulated line printer devices                                                                                                                                                                                   |          
| `/tk5/pch`           | Card punch devices output stored here                                                                                                                                                                                     |
| `/tk5/dasd`          | This contains all of the simulated CKD DASD volumes. Count key data or CKD is a direct-access storage device (DASD)                                                                                                       |                                                                                                      |
| `/tk5/jcl`           | contains the SYSGEN Job Control Files                                                                                                                                                                                     |          
| `/tk5/log`           | contains log files created during sysgen                                                                                                                                                                                  |          
| `/tk5/tape`          | Used for simulated tape devices                                                                                                                                                                                           |          

