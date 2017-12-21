Received: from mga09.intel.com ([134.134.136.24]:20663 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755928AbdLUCit (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 20 Dec 2017 21:38:49 -0500
From: Li Zhijian <zhijianx.li@intel.com>
Subject: generic/388 is failed under ext4
Message-ID: <be7e6d14-dcc9-1822-e005-4e779fc97873@intel.com>
Date: Thu, 21 Dec 2017 10:38:47 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.orgfstests@vger.kernel.org
Cc: "Li, Philip" <philip.li@intel.com>
List-ID: <fstests@vger.kernel.org>

Hi all

I'm not sure whether the failure is expected or not when i ran generic/388 under ext4

i ran it from v4.11 to v4.15-rc3, they all failed.

below is my environment(0Day), if we miss something, please let me know

----------------------
2017-12-20 17:12:07 export TEST_DIR=/fs/vda
2017-12-20 17:12:07 export TEST_DEV=/dev/vda
2017-12-20 17:12:08 export FSTYP=ext4
2017-12-20 17:12:08 export SCRATCH_MNT=/fs/scratch
2017-12-20 17:12:08 mkdir /fs/scratch -p
2017-12-20 17:12:08 export SCRATCH_DEV=/dev/vdd

# ./check generic/381 generic/388
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 vm-kbuild-2G-6 4.11.0
MKFS_OPTIONS  -- /dev/vdd
MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdd /fs/scratch

generic/381	 13s
generic/388	 119s
_check_generic_filesystem: filesystem on /dev/vdd is inconsistent
(see /lkp/benchmarks/xfstests/results//generic/388.full for details)
Ran: generic/381 generic/388
Failures: generic/388
Failed 1 of 2 tests
----------------------
$ cat results/generic/388.full
Creating filesystem with 67108864 4k blocks and 16777216 inodes
Filesystem UUID: 9ac5e021-7762-4f28-b4a5-efea2f314021
Superblock backups stored on blocks:
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
	4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done

seed = 1513782251
seed = 1513499724
seed = 1513248362
seed = 1513677476
seed = 1513572741
seed = 1513970611
seed = 1513102235
seed = 1513882898
seed = 1513634177
seed = 1513110916
seed = 1513243327
seed = 1513376892
seed = 1513275972
seed = 1513692719
seed = 1513650632
seed = 1513583319
seed = 1513888121
seed = 1513150767
seed = 1514019061
seed = 1513562176
seed = 1513224003
seed = 1513648864
seed = 1513293550
seed = 1514073545
seed = 1513611663
seed = 1513368302
seed = 1513873193
seed = 1513369400
seed = 1513415832
seed = 1513423557
seed = 1513273399
seed = 1513801026
seed = 1513832168
seed = 1513490977
seed = 1513508319
seed = 1513354560
seed = 1514122482
seed = 1513789924
seed = 1513239713
seed = 1514051325
seed = 1513567381
seed = 1513171908
seed = 1513347867
seed = 1513921217
seed = 1514013263
seed = 1513875985
seed = 1513412628
seed = 1513211787
seed = 1513935505
seed = 1513877047
_check_generic_filesystem: filesystem on /dev/vdd is inconsistent
*** fsck.ext4 output ***
fsck from util-linux 2.28.1
e2fsck 1.43.7 (16-Oct-2017)
Pass 1: Checking inodes, blocks, and sizes
Inode 16515231, i_size is 0, should be 491520.  Fix? no

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/vdd: ********** WARNING: Filesystem still has errors **********

/dev/vdd: 844/16777216 files (12.4% non-contiguous), 1347734/67108864 blocks
*** end fsck.ext4 output
*** mount output ***
rootfs on / type rootfs (rw)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,size=760836k,nr_inodes=190209,mode=755)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
selinuxfs on /sys/fs/selinux type selinuxfs (rw,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/lib/systemd/systemd-cgroups-agent,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
cgroup on /sys/fs/cgroup/cpu type cgroup (rw,nosuid,nodev,noexec,relatime,cpu)
cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/net_cls type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=26,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=29217)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
sunrpc on /run/rpc_pipefs type rpc_pipefs (rw,relatime)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime)
mqueue on /dev/mqueue type mqueue (rw,relatime)
configfs on /sys/kernel/config type configfs (rw,relatime)
tmp on /tmp type tmpfs (rw,relatime)
inn:/result on /inn/result type nfs4 (rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,port=0,timeo=600,retrans=2,sec=sys,clientaddr=10.0.2.15,local_lock=none,addr=192.168.1.1)
tmpfs on /run/user/0 type tmpfs (rw,nosuid,nodev,relatime,size=204520k,mode=700)
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc (rw,relatime)
/dev/vda on /fs/vda type ext4 (rw,relatime,data=ordered)
*** end mount output

----------------------




