Received: from mx1.redhat.com ([209.132.183.28]:40456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752464AbcHUOrn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 21 Aug 2016 10:47:43 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/033: source mkfs output again if isize less than 512
Date: Sun, 21 Aug 2016 22:47:39 +0800
Message-Id: <1471790859-26077-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

When blocksize is 512b, xfs/033 will run mkfs.xfs again to make sure
inode size is 512b. As below:

  # devzero blows away 512byte blocks, so make 512byte inodes (at least)
  _scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
  . $tmp.mkfs
  [ $isize -lt 512 ] && \
          _scratch_mkfs_xfs -isize=512 | _filter_mkfs >/dev/null 2>&1

But after "566ebd5 mkfs: default to CRC enabled filesystems", xfsprogs
enable CRC as default. If MKFS_OPTIONS is "-b size=512 -m crc=0", the
first "_scratch_mkfs_xfs" will make crc=0, but the second will change
"crc" to "1", because it'll waive the "-b size=512 -m crc=0" options.

xfs/033 need to check xfs's sb_features, for use different .out files.
So we should import the mkfs output($tmp.mkfs file) again, if the
scecond mkfs changes something.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

I moved the mkfs_xfs output to /dev/null, because:
  1. I think it's not necessary.
  2. The case maybe do and output mkfs once or twice(not sure). So it'll be
  hard to keep consistent golden image.

Thanks,
Zorro

 tests/xfs/033               | 8 +++++---
 tests/xfs/033.out.crc.linux | 6 ------
 tests/xfs/033.out.irix      | 6 ------
 tests/xfs/033.out.linux     | 6 ------
 4 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/tests/xfs/033 b/tests/xfs/033
index 9342f0c..45caf08 100755
--- a/tests/xfs/033
+++ b/tests/xfs/033
@@ -78,10 +78,12 @@ _require_scratch
 _require_no_large_scratch_dev
 
 # devzero blows away 512byte blocks, so make 512byte inodes (at least)
-_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
+_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs >/dev/null
 . $tmp.mkfs
-[ $isize -lt 512 ] && \
-	_scratch_mkfs_xfs -isize=512 | _filter_mkfs >/dev/null 2>&1
+if [ $isize -lt 512 ]; then
+	_scratch_mkfs_xfs -isize=512 | _filter_mkfs 2>$tmp.mkfs >/dev/null
+	. $tmp.mkfs
+fi
 
 # link correct .out file
 FEATURES=$(_get_os_name)
diff --git a/tests/xfs/033.out.crc.linux b/tests/xfs/033.out.crc.linux
index a6e86b9..2ab4c43 100644
--- a/tests/xfs/033.out.crc.linux
+++ b/tests/xfs/033.out.crc.linux
@@ -1,10 +1,4 @@
 QA output created by 033
-meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
-data     = bsize=XXX blocks=XXX, imaxpct=PCT
-         = sunit=XXX swidth=XXX, unwritten=X
-naming   =VERN bsize=XXX
-log      =LDEV bsize=XXX blocks=XXX
-realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 Corrupting root inode - setting bits to 0
 Wrote X.XXKb (value 0x0)
 Phase 1 - find and verify superblock...
diff --git a/tests/xfs/033.out.irix b/tests/xfs/033.out.irix
index 1a2d9c3..5960117 100644
--- a/tests/xfs/033.out.irix
+++ b/tests/xfs/033.out.irix
@@ -1,10 +1,4 @@
 QA output created by 033
-meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
-data     = bsize=XXX blocks=XXX, imaxpct=PCT
-         = sunit=XXX swidth=XXX, unwritten=X
-naming   =VERN bsize=XXX
-log      =LDEV bsize=XXX blocks=XXX
-realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 Corrupting root inode - setting bits to 0
 Wrote X.XXKb (value 0x0)
 Phase 1 - find and verify superblock...
diff --git a/tests/xfs/033.out.linux b/tests/xfs/033.out.linux
index d79ce2a..68bc781 100644
--- a/tests/xfs/033.out.linux
+++ b/tests/xfs/033.out.linux
@@ -1,10 +1,4 @@
 QA output created by 033
-meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
-data     = bsize=XXX blocks=XXX, imaxpct=PCT
-         = sunit=XXX swidth=XXX, unwritten=X
-naming   =VERN bsize=XXX
-log      =LDEV bsize=XXX blocks=XXX
-realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
 Corrupting root inode - setting bits to 0
 Wrote X.XXKb (value 0x0)
 Phase 1 - find and verify superblock...
-- 
2.7.4

