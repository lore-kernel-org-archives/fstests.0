Received: from nbjjceehfcj.turbo-smtp.net ([199.244.75.29]:36169 "HELO
	nbjjceehfcj.turbo-smtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750810AbbI2XKT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 29 Sep 2015 19:10:19 -0400
Message-ID: <560B18C8.8000204@sysam.it>
Date: Wed, 30 Sep 2015 01:03:36 +0200
From: Angelo Dureghello <angelo@sysam.it>
MIME-Version: 1.0
Subject: help on xfs test results
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi all,

thanks for all the great support until now.

I finally completed all the tests in my arm 32 bit target platform, and 
have still 4 hopefully false positives. Below my comments:



generic tests

*** 256
/media/p6/fill.161/3.bin: No space left on device

  - output mismatch (see 
/home/angelo/xfstests/results//./generic/256.out.bad)
     --- tests/./generic/256.out	2015-09-17 10:54:06.815078834 +0000
     +++ /home/angelo/xfstests/results//./generic/256.out.bad	2000-01-01 
00:42:13.822058816 +0000
     @@ -1 +1,2229 @@
      QA output created by 256
     +wrote 1073741824/1073741824 bytes at offset 0
     +1 GiB, 262144 ops; 0:02:35.00 (6.602 MiB/sec and 1690.0353 ops/sec)
     +pwrite64: No space left on device
     +pwrite64: No space left on device
     +pwrite64: No space left on device
     +pwrite64: No space left on device
     ...


xfs tests
**** 020
creates a 60t, fails if > 16t (Growing the data section failed), could 
be normal in 32bit arch ?

**** 080
Looks like not XFS issue. mmap() failed, no more memory after 2,5G

# ./start_xfs_test.sh
QA output created by 080
[ 5263.189727] XFS (mmcblk0p5): Mounting V4 Filesystem
[ 5263.459360] XFS (mmcblk0p5): Ending clean mount

mmappiong 512000000
mmappiong 512000000
mmappiong 512000000

doio (31296) 01:27:38
---------------------
mmap() failed - 0xffffffff 12

doio (31296) 01:27:38
---------------------
mmap-write() request failed:  Cannot allocate memory (12)
Request number 59
           fd 11 is file /media/p5/rwtest.file - open flags are 0200002 
O_RDWR,O_DIRECT,
           write done at file offset 4178432 - pattern is M (0115)
           number of requests is 1, strides per request is 1
           i/o byte count = 56832
           memory alignment is aligned
           DIRECT I/O: offset % 512 = 0 length % 56832 = 0
           mem alignment 0x200 xfer size: small: 512 large: 2147483136

syscall:  mmap-write(NULL, 512000000, PROT_WRITE, MAP_SHARED, 11, 0)
	file is mmaped to: 0x0
	file-mem=0x3fc200, length=56832, buffer=0x48600


doio (31296) 01:27:38
---------------------
doio(): operation 121 returned != 0
rwtest.sh : iogen reported errors (r=141)


**** 136
very long test, output similar but different values


Hope those finding can be useful, and maybe some of you have an
idea on the reasons. I am still investigating.


Many thanks,
Regards,
Angelo Dureghello


-------------------------------------------------------------------------

Below info on the target system.

# cat /proc/version
Linux version 4.1.6-rt5+ (angelo@hostpc) (gcc version 4.9.3 20150413 
(prerelease) (Linaro GCC 4.9-2015.05) ) #118 SMP PREEMPT RT Tue Sep 29 
13:31:25 CEST 2015

Linux host 4.1.6-rt5+ #118 SMP PREEMPT RT Tue Sep 29 13:31:25 CEST 2015 
armv7l GNU/Linux

Using microsd for kernel, rootfs, test partitions, and setting:

export TEST_DEV='/dev/mmcblk0p5'
export TEST_DIR='/media/p5'
export SCRATCH_DEV='/dev/mmcblk0p6'
export SCRATCH_MNT='/media/p6'
export FSTYP='xfs'






