# metahostbackup
Xenserver Script for Backing Up Host &amp; Pool Metadata Information

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

**Title:** metahostbackup - a XenServer host & pool metadata Backup Script

**Package Contents:** README.md (this file), metahostbackup.sh, metahostbackup

## Version History:
 - v1.0 2017/27/08 Setup new script.


## Overview
 - This script will backup your xen host (full version + patches) & pool metadata which defines everything (VMs, Storage, etc.) on your active xenserver. 
 - The script will backup both a xxxx-host.bak & xxxx-meta.bak onto a NFS share and maintain a depth level of 3 latest version backups (*.bak.)
 - You can schedule this script to run daily - thus maintaining some type disaster recovery in case you need to recover from a major crashed server or bad patch.

## Quick Start Checklist

1. Place the metahostbackup.sh file somewhere on your Xenserver, such as, /root/scripts
2. Modify the top level variables within metahostbackup.sh to match you environment.
3. Edit the RETENTION= variable for the number of rolling backups you want to maintain.
4. Change the permissions of the metahostbackup.sh file, i.e., chmod +x /root/scripts/metahostbackup.sh
5. Modify the schedule within the cron job definition file metahostbackup. Also you can set the user in which you want to execute this job within the metahostbackup file.
6. Place the metahostbackup file in the /etc/cron.d directory and restart your cron service, i.e., /etc/init.d/crond restart
7. A log is maintained under - /var/log/metahostbackup.log.
