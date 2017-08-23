Received: from mail-wr0-f193.google.com ([209.85.128.193]:37971 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbdHWPst (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2017 11:48:49 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [RFC][PATCH 0/8] Crash consistency xfstest using dm-log-writes
Date: Wed, 23 Aug 2017 18:49:09 +0300
Message-Id: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi all,

I've collected these patches that have been sitting in Josef Bacik's
tree for a few years and kicked them a bit into shape.
The dm-log-writes target has been merged to kernel v4.1, see:
https://github.com/torvalds/linux/blob/master/Documentation/device-mapper/log-writes.txt

I have been getting frequent test failures, both fsck and file checksum
errors while testing xfs, ext4 and btrfs.  The patterns of failures
are quite different between the different file systems.
I tested on two systems, one with SSD and one with spinning disk.
I personally believe those error imply either a wrong assumptions
on I/O model that the test tools are making or a test
implementation bug.

Decided to post the patches anyway, because it may take me a while
to debug the failures, so giving other develpers a chance to produce
more test results on their systems and maybe help in debugging the
test failures.

Some data points from my tests:
- ext4 test results seem more consistent than xfs test results -
  with some random seed values I could not get ext4 to fail
  and with some random seed values, like the ones provided in the patch,
  ext4 test failed with exactly the same fsck error, on the same log
  mark on both SSD and spinning disk systems.
- With the random seed values in this patch set, ext4 test always
  failed with the same fsck error (end of extent exceeds allowed value).
- btrfs test also failed with the provided random seed values, but with
  slightly different fsck errors each run.
- Unlike ext4 and btrfs, xfs tests seemed to fail arbitrarily for any value
  of random seed I tried.
- xfs tests fail sometimes on file checksum error, each run on a different
  file and I've never seen xfs failing on fsck error.
- Tests were much more likely to fail with xfs on spinning disk (9 out of 10)
  compared to xfs on SSD (1 out of 10).
- Removing -o discard mount option, adding fsx AIO (-A) and disabling mapped
  read/write (-W -R) did not improve xfs test failures as far as I can tell

Any tips and pointers to other things I could test before diving
into tracing would be much appreciated.

If anyone can run the test to get additional data points that would
be much appreciated as well.

Thanks,
Amir.

P.S.: Josef,

Because I split the patches and made some changes, I did not keep
your S-O-B. After you review my changes, if you like, I can restore
your S-O-B.

Amir Goldstein (8):
  common/rc: convert some egrep to grep
  common/rc: fix _require_xfs_io_command params check
  fsx: fixes to random seed
  fsx: fix path of .fsx* files
  fsx: add support for integrity check with dm-log-writes target
  log-writes: add replay-log program to replay dm-log-writes target
  fstests: add support for working with dm-log-writes target
  fstests: add crash consistency fsx test using dm-log-writes

 .gitignore                   |   1 +
 README                       |   2 +
 common/dmlogwrites           |  86 ++++++++++
 common/rc                    |  15 +-
 doc/auxiliary-programs.txt   |   8 +
 doc/requirement-checking.txt |  20 +++
 ltp/fsx.c                    | 152 ++++++++++++++---
 src/Makefile                 |   2 +-
 src/log-writes/Makefile      |  23 +++
 src/log-writes/SOURCE        |   6 +
 src/log-writes/log-writes.c  | 379 +++++++++++++++++++++++++++++++++++++++++++
 src/log-writes/log-writes.h  |  70 ++++++++
 src/log-writes/replay-log.c  | 348 +++++++++++++++++++++++++++++++++++++++
 tests/generic/500            | 128 +++++++++++++++
 tests/generic/500.out        |   2 +
 tests/generic/group          |   1 +
 16 files changed, 1212 insertions(+), 31 deletions(-)
 create mode 100644 common/dmlogwrites
 create mode 100644 src/log-writes/Makefile
 create mode 100644 src/log-writes/SOURCE
 create mode 100644 src/log-writes/log-writes.c
 create mode 100644 src/log-writes/log-writes.h
 create mode 100644 src/log-writes/replay-log.c
 create mode 100755 tests/generic/500
 create mode 100644 tests/generic/500.out

-- 
2.7.4

