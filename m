Received: from mail.cn.fujitsu.com ([183.91.158.132]:29506 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405224AbfIXKUu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Sep 2019 06:20:50 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 294254CE14EA
        for <fstests@vger.kernel.org>; Tue, 24 Sep 2019 18:20:50 +0800 (CST)
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: question of generic/442 in xfs filesystem
Message-ID: <715285e7-8c84-1b4f-7094-c45f4ac056a6@cn.fujitsu.com>
Date: Tue, 24 Sep 2019 18:20:46 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi ALL
When I run generic/442  in xfs on 4.18.0-107.el8.x86_64 with upstream 
xfsprogs( v5.2.1), it sometimes failed as below:

-------------------------------------------
./check generic/442
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64
4.18.0-107.el8.x86_64 #1 SMP Fri Jun 14 13:46:34 UTC 2019
MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda11
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda11 
/mnt/xfstests/scratch

generic/442 1s ... _check_xfs_filesystem: filesystem on /dev/sda11 has 
dirty log
(see /var/lib/xfstests/results//generic/442.full for details)
xfs_check: /dev/sda11 is not a valid XFS filesystem (unexpected SB magic 
number 0x7c7c7c7c)
./common/xfs: line 197:  8118 Floating point exception(core dumped) 
${XFS_DB_PROG}${DBOPTS} -F -i -p xfs_check -c "check$OPTS" $1
_check_xfs_filesystem: filesystem on /dev/sda11 is inconsistent (r)
(see /var/lib/xfstests/results//generic/442.full for details)
-------------------------------------------

dmesg
---------------------------------------------
  2680.645994] run fstests generic/442 at 2019-09-25 09:26:35
[ 2681.673043] XFS (sda10): Unmounting Filesystem
[ 2682.051413] traps: xfs_db[8118] trap divide error ip:427dbf 
sp:7ffd772b80e0 error:0 in xfs_db[400000+a0000]
---------------------------------------------

addr2line -e xfs_db -f 427dbf
libxfs_mount
/root/xfsprogs-dev/libxfs/init.c:663
--------------------------------------------------
mp->m_maxicount = XFS_FSB_TO_INO(mp,
                                 (mp->m_maxicount / mp->m_ialloc_blks) *
                                  mp->m_ialloc_blks);
--------------------------------------------------

generic/442.full
--------------------------------------------------
mkfs.xfs: cannot open /dev/sda11: Device or resource busy
device-mapper: remove ioctl on error-test  failed: Device or resource busy
Command failed.
_check_xfs_filesystem: filesystem on /dev/sda11 has dirty log
*** xfs_logprint -t output ***
xfs_logprint: logprint.c:230: main: Assertion `x.logBBsize <= 
0x7fffffff' failed.
*** end xfs_logprint output
_check_xfs_filesystem: filesystem on /dev/sda11 is inconsistent (r)
*** xfs_repair -n output ***
Phase 1 - find and verify superblock...
bad primary superblock - bad magic number !!!

attempting to find secondary superblock...
.found candidate secondary superblock...
verified secondary superblock...
would write modified primary superblock
Primary superblock would have been modified.
Cannot proceed further in no_modify mod
--------------------------------------------------

It looks like scratch superblock has been writed into 0x7c(src/fsyncerr 
memset buf as 0x7c). I don't know what leads to this case fail.

Thanks
Yang Xu
