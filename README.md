# tk5-hercules

Port of skunklabz' [tk4-hercules](https://github.com/skunklabz/tk4-hercules) docker file to [MVS 3.8j on Turnkey Version 5.2](https://www.prince-webdesign.nl/tk5), now running on Alpine Linux

## Usage

- Run `docker run -ti -p 3270:3270 -p8038:8038 skunklabz/tk5-hercules`
- Use a browser to check on the system's status by visiting `http://127.0.0.1:8038`
- Boot startup will take approx. 60 seconds.
- Once the bootup is complete and you see the Turnkey boot screen, use e.g. `c3270 127.0.0.1:3270` for connecting to the local MVS instance.


## Persistence
(copied from [tk4-hercules](https://github.com/skunklabz/tk4-hercules)'s documentation):

To run with persistence so that you don't lose your data after stopping the docker container please use the following command to start it up.

```
docker run -d \
--mount source=tk4-conf,target=/tk4-/conf \
--mount source=tk4-local_conf,target=/tk4-/local_conf \
--mount source=tk4-local_scripts,target=/tk4-/local_scripts \
--mount source=tk4-prt,target=/tk4-/prt \
--mount source=tk4-dasd,target=/tk4-/dasd \
--mount source=tk4-pch,target=/tk4-/pch \
--mount source=tk4-jcl,target=/tk4-/jcl \
--mount source=tk4-log,target=/tk4-/log \
-p 3270:3270 \
-p 8038:8038 tk4
```

### Description of persisted directories
- /tk4-/conf
  - This is where the master configuration file tk4-.cnf is stored
- /tk4-/local_conf
  - Scripts for initialization and unattended operations
- /tk4-/local_scripts
  - There are 10 files located here that are meant for user applied modifications and are run after Hercules initialization, when operating in manual mode or after MVS 3.8j initialization when operating in unattended mode
- /tk4-/prt
  - Used for simulated line printer devices
- /tk4-/pch
  - Card punch devices output stored here
- /tk4-/dasd
  - This contains all of the simulated CKD DASD volumes. Count key data or CKD is a direct-access storage device (DASD)
- /tk4-/jcl
  - contains the SYSGEN Job Control Files
- /tk4-/log
  - contains log files created during sysgen
