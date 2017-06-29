Received: from mga05.intel.com ([192.55.52.43]:46742 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbdF2GQY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Jun 2017 02:16:24 -0400
Date: Thu, 29 Jun 2017 14:16:17 +0800
From: Dai Xiang <xiangx.dai@intel.com>
Subject: [QUESTION] xfstests generic/263 run failed: Invalid argument
Message-ID: <20170629061617.GA15106@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xiangx.dai@intel.com
List-ID: <fstests@vger.kernel.org>

When run generic/263 with f2fs, below issue occurs:
root@test ~/xfstests# ./check generic/263
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 test 4.12.0-rc6
MKFS_OPTIONS  -- /dev/sda8
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda8 /fs/scratch

generic/263	 [failed, exit status 1] - output mismatch (see ~/xfstests/results//generic/263.out.bad)
    --- tests/generic/263.out	2017-05-31 18:15:23.000000000 +0800
    +++ ~/xfstests/results//generic/263.out.bad	2017-06-29 11:01:17.371729760 +0800
    @@ -1,3 +1,16 @@
     QA output created by 263
     fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
    -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
    +skipping insert range behind EOF
    +truncating to largest ever: 0x11e00
    +dowrite: write: Invalid argument
    +LOG DUMP (7 total operations):
    ...
    (Run 'diff -u tests/generic/263.out ~/xfstests/results//generic/263.out.bad'  to see the entire diff)
Ran: generic/263
Failures: generic/263
Failed 1 of 1 tests

root@test ~/xfstests# cat results/generic/263.full
~/xfstests/ltp/fsx -N 10000 -o 8192 -l 500000 -r 4096 -t 512 -w 512 -Z /fs/sda5/junk
skipping insert range behind EOF
truncating to largest ever: 0x11e00
dowrite: write: Invalid argument   <===
LOG DUMP (7 total operations):
1(  1 mod 256): SKIPPED (no operation)
2(  2 mod 256): SKIPPED (no operation)
3(  3 mod 256): FALLOC   0x2e0f2 thru 0x2f438	(0x1346 bytes) PAST_EOF
4(  4 mod 256): SKIPPED (no operation)
5(  5 mod 256): SKIPPED (no operation)
6(  6 mod 256): TRUNCATE UP	from 0x0 to 0x11e00
7(  7 mod 256): WRITE    0x73400 thru 0x745ff	(0x1200 bytes) HOLE
Log of operations saved to "/fs/sda5/junk.fsxops"; replay with --replay-ops
Correct content saved for comparison
(maybe hexdump "/fs/sda5/junk" vs "/fs/sda5/junk.fsxgood")

root@test ~/xfstests# ~/xfstests/ltp/fsx -N 10000 -o 8192 -l 500000 -r 4096 -t 512 -w 512 -Z /fs/sda5/junk
/fs/sda5/junk: Invalid argument

Is it a bug?

Thanks
Dai Xiang
