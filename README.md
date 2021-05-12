# sample-apache-logs
 It prints sample apache logs to a file.<br>
 I wrote this script to check elasticsearch's benchmark values.
 ```
 usage: ./run.sh [-h] [-f file_name] [-a log_amount=1] [-s sleep_time=0]
 where:
    -h  show this help text
    -f  file name
    -a  log amount (default:1)
    -s  sleep time (default:0)
	
 info: file will be written into /var/log/[file_name]
 ```
