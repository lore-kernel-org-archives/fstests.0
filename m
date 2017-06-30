Received: from mga09.intel.com ([134.134.136.24]:4947 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbdF3DlI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Jun 2017 23:41:08 -0400
Date: Fri, 30 Jun 2017 11:41:04 +0800
From: Dai Xiang <xiangx.dai@intel.com>
Subject: [QUESTION] xfstests: generic/102,103,204 with f2fs run failed since
 no space left
Message-ID: <20170630034104.GA11974@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: philip.li@intel.com, zhijianx.li@intel.com, xiangx.dai@intel.com
List-ID: <fstests@vger.kernel.org>

I found below issues:

root@test ~/xfstests# ./check generic/102
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 test 4.12.0-rc7-00192-gc0bc126
MKFS_OPTIONS  -- /dev/sda8
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda8 /fs/scratch

generic/102	 - output mismatch (see ~/xfstests/results//generic/102.out.bad)
    --- tests/generic/102.out	2017-06-29 16:19:14.000000000 +0800
    +++ ~/xfstests/results//generic/102.out.bad	2017-06-29 17:39:21.577327287 +0800
    @@ -1,21 +1,11 @@
     QA output created by 102
    -wrote 419430400/419430400 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 419430400/419430400 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -wrote 419430400/419430400 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    ...
    (Run 'diff -u tests/generic/102.out ~/xfstests/results//generic/102.out.bad'  to see the entire diff)
Ran: generic/102
Failures: generic/102
Failed 1 of 1 tests

i try to decrease mkfs size and succeed:

generic/102:
dev_size=$((20 * 1024 * 1024))     # 512MB filesystem  <=== change to 20M
_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
_scratch_mount
root@test ~/xfstests# ./check generic/102
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 test 4.12.0-rc7-00192-gc0bc126
MKFS_OPTIONS  -- /dev/sda8
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda8 /fs/scratch

generic/102	 2s
Ran: generic/102
Passed all 1 tests

The max mkfs size is 30M, it mkfs /dev/sda8:

root@test ~/xfstests# df /dev/sda8
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        2.7G     0  2.7G   0% /dev     <===

generic/103:

_consume_freesp()
{
	file=$1

	# consume nearly all available space (leave ~512kB)
	avail=`_get_available_space $SCRATCH_MNT`
	filesizekb=$((avail / 1024 - 512))   <===
	$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file  <=== here print no space left
}

I print into log:

root@test ~/xfstests# cat log
520072372
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sda4      524286976 1275212 520072884   1% /fs/scratch  <===

Seems available space can not use all, and decrease this val can pass:

root@test ~/xfstests# ./check generic/103
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 test 4.12.0-rc7-00192-gc0bc126
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/103 2s ... 3s
Ran: generic/103
Passed all 1 tests

root@test ~/xfstests# cat log
500000000
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sda4      524286976 1275212 520072884   1% /fs/scratch


Like 103, 203 can pass with less space:

root@test ~/xfstests# ./check generic/204
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 test 4.12.0-rc7-00192-gc0bc126
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/204	 - output mismatch (see ~/xfstests/results//generic/204.out.bad)
    --- tests/generic/204.out	2017-06-29 16:19:14.000000000 +0800
    +++ ~/xfstests/results//generic/204.out.bad	2017-06-30 10:39:33.943499885 +0800
    @@ -1,2 +1,18524 @@
     QA output created by 204
    +./tests/generic/204: line 88: /fs/scratch/13240: No space left on device
    +./tests/generic/204: line 89: /fs/scratch/13240: No space left on device
    +./tests/generic/204: line 88: /fs/scratch/13241: No space left on device
    +./tests/generic/204: line 89: /fs/scratch/13241: No space left on device
    +./tests/generic/204: line 88: /fs/scratch/13242: No space left on device
    +./tests/generic/204: line 89: /fs/scratch/13242: No space left on device
    ...
    (Run 'diff -u tests/generic/204.out ~/xfstests/results//generic/204.out.bad'  to see the entire diff)
Ran: generic/204
Failures: generic/204
Failed 1 of 1 tests

root@test ~/xfstests# ./check generic/204
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 test 4.12.0-rc7-00192-gc0bc126
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/204 1s ... 1s
Ran: generic/204
Passed all 1 tests

root@test ~/xfstests# cat log
12800
Filesystem     1K-blocks  Used Available Use% Mounted on
/dev/sda4         116736 14344     53240  22% /fs/scratch


Do above issues are just related to my dev can not use ful available space or maybe decrease test space size to make more host can run it?

Best Wishes 
Dai Xiang
