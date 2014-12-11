Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:50396 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932623AbaLKAu2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Dec 2014 19:50:28 -0500
Date: Wed, 10 Dec 2014 19:50:30 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: generic/256 test failure?
Message-ID: <20141211005030.GA30240@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I've been trying to debug generic/256 failing under ext4, and I
realized that it's actually failing with xfs as well:

BEGIN TEST: XFS Wed Dec 10 19:36:38 EST 2014
Device: /dev/vdd
mk2fs options:
mount options:
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/i686 kvm-xfstests 3.18.0-rc3-00029-g754c126
MKFS_OPTIONS  -- -f -bsize=4096 /dev/vdc
MOUNT_OPTIONS -- /dev/vdc /vdc

generic/256		[19:36:40] [19:37:31] - output mismatch (see /results/results-xfs/generic/256.out.bad)
    --- tests/generic/256.out	2014-12-10 18:15:22.000000000 -0500
    +++ /results/results-xfs/generic/256.out.bad	2014-12-10 19:37:32.002538550 -0500
    @@ -1 +1,2229 @@
     QA output created by 256
    +wrote 1073741824/1073741824 bytes at offset 0
    +1 GiB, 262144 ops; 0:00:11.00 (92.306 MiB/sec and 23630.3397 ops/sec)
    +pwrite64: No space left on device
    +pwrite64: No space left on device
    +pwrite64: No space left on device
    +pwrite64: No space left on device
    ...
    (Run 'diff -u tests/generic/256.out /results/results-xfs/generic/256.out.bad'  to see the entire diff)
Ran: generic/256
Failures: generic/256
Failed 1 of 1 tests

root@kvm-xfstests:~# blkid /dev/vdc
/dev/vdc: UUID="6a820f3b-109f-465e-941e-6bc2bfae6e42" TYPE="xfs"

This is failing with xfstests commit 6676905, and xfsprogs v3.2.2.

Is anyone else seeing this failure?

						- Ted
