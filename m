Received: from aserp1040.oracle.com ([141.146.126.69]:39720 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdJ1Ukd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Oct 2017 16:40:33 -0400
Date: Sat, 28 Oct 2017 13:40:29 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: generic/459 requires thin_check?
Message-ID: <20171028204029.GA4908@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi,

I noticed a test failure when running generic/459 -- it seems that this
test wants thin_check to be installed, doesn't explicitly check for it
(possibly because it is indirectly run by lvcreate), and therefore the
thin pool fails to activate.  I think this test needs to look for
thin_check and _notrun if it's not found.  Comments?

--D

results/generic/459.out is as follows:

meta-data=/dev/pmem4             isize=512    agcount=4, agsize=16000 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1, reflink=1
data     =                       bsize=4096   blocks=64000, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=3609, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
File descriptor 3 (/tmp/log) leaked on lvm invocation. Parent PID 11865: /bin/bash
  Wiping xfs signature on /dev/pmem4.
  Physical volume "/dev/pmem4" successfully created
File descriptor 3 (/tmp/log) leaked on lvm invocation. Parent PID 11865: /bin/bash
  Volume group "vg_459" successfully created
File descriptor 3 (/tmp/log) leaked on lvm invocation. Parent PID 11865: /bin/bash
  Logical volume "pool_459" created.
File descriptor 3 (/tmp/log) leaked on lvm invocation. Parent PID 11865: /bin/bash
  /usr/sbin/thin_check: execvp failed: No such file or directory
  WARNING: Integrity check of metadata for pool vg_459/pool_459 failed.
  WARNING: Sum of all thin volume sizes (200.00 MiB) exceeds the size of thin pool vg_459/pool_459 (100.00 MiB)!
  For thin pool auto extension activation/thin_pool_autoextend_threshold should be below 100.
  /usr/sbin/thin_check: execvp failed: No such file or directory
  Check of pool vg_459/pool_459 failed (status:2). Manual repair required!
  Failed to activate thin pool vg_459/pool_459.
