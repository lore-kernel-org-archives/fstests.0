Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21291 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbaJLV0K (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 12 Oct 2014 17:26:10 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9CLQ9At027480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Sun, 12 Oct 2014 17:26:09 -0400
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s9CLQ8Mg007819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <fstests@vger.kernel.org>; Sun, 12 Oct 2014 17:26:09 -0400
Message-ID: <543AF1F1.8010103@redhat.com>
Date: Sun, 12 Oct 2014 16:26:09 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] xfs: test larger dump/restore to/from file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test creates a large-ish directory structure using
fsstress, and does a dump/restore to make sure we dump
all the files.

Without the fix for the regression caused by:
c7cb51d xfs: fix error handling at xfs_inumbers

we will see failures like:

    -xfsrestore: 486 directories and 1590 entries processed
    +xfsrestore: 30 directories and 227 entries processed

as it fails to process all inodes.

I think that existing tests have a much smaller set of files,
and so don't trip the bug.

I don't do a file-by-file comparison here, because for some
reason the diff output gets garbled; this test only checks
that we've dumped & restored the correct number of files.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/dump b/common/dump
index 7fe50f6..c42eb2c 100644
--- a/common/dump
+++ b/common/dump
@@ -298,15 +298,16 @@ _stable_fs()
 # files,dirs,links,symlinks
 #
 # Pinched from test 013.
+# Takes one argument, the number of ops to perform
 #
-_create_dumpdir_stress()
+_create_dumpdir_stress_num()
 {
     echo "Creating directory system to dump using fsstress."
 
+    _count=$1
     _wipe_fs
 
     _param="-f link=10 -f creat=10 -f mkdir=10 -f truncate=5 -f symlink=10"
-    _count=240
     rm -rf $dump_dir
     if ! mkdir $dump_dir; then
         echo "    failed to mkdir $dump_dir"
@@ -331,6 +332,10 @@ _create_dumpdir_stress()
     _stable_fs
 }
 
+_create_dumpdir_stress() {
+	_create_dumpdir_stress_num 240
+}
+
 _mk_fillconfig1()
 {
     cat <<End-of-File >$tmp.config
diff --git a/tests/xfs/307 b/tests/xfs/307
new file mode 100755
index 0000000..cc267ad
--- /dev/null
+++ b/tests/xfs/307
@@ -0,0 +1,50 @@
+#! /bin/bash
+# FS QA Test No. 307
+#
+# Test out a level 0 dump/restore of a subdir to a file
+#
+# Use fsstress to create a larger directory structure with a mix of files
+# Test for regression caused by
+# c7cb51d xfs: fix error handling at xfs_inumbers
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2014 Eric Sandeen.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#-----------------------------------------------------------------------
+#
+
+seqfull=$0
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=0	# success is the default!
+trap "rm -rf $tmp.*; exit \$status" 0 1 2 3 15
+
+. ./common/rc
+. ./common/dump
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+
+_create_dumpdir_stress_num 4096
+_do_dump_restore
+
+# success, all done
+exit
diff --git a/tests/xfs/307.out b/tests/xfs/307.out
new file mode 100644
index 0000000..61b8c12
--- /dev/null
+++ b/tests/xfs/307.out
@@ -0,0 +1,47 @@
+QA output created by 307
+Creating directory system to dump using fsstress.
+
+-----------------------------------------------
+fsstress : -f link=10 -f creat=10 -f mkdir=10 -f truncate=5 -f symlink=10
+-----------------------------------------------
+xfsdump|xfsrestore ...
+xfsdump  -s DUMP_SUBDIR - SCRATCH_MNT | xfsrestore  - RESTORE_DIR
+xfsrestore: using file dump (drive_simple) strategy
+xfsrestore: searching media for dump
+xfsrestore: examining media file 0
+xfsrestore: dump description: 
+xfsrestore: hostname: HOSTNAME
+xfsrestore: mount point: SCRATCH_MNT
+xfsrestore: volume: SCRATCH_DEV
+xfsrestore: session time: TIME
+xfsrestore: level: 0
+xfsrestore: session label: ""
+xfsrestore: media label: ""
+xfsrestore: file system ID: ID
+xfsrestore: session id: ID
+xfsrestore: media ID: ID
+xfsrestore: searching media for directory dump
+xfsrestore: reading directories
+xfsrestore: 486 directories and 1590 entries processed
+xfsrestore: directory post-processing
+xfsrestore: restoring non-directory files
+xfsrestore: restore complete: SECS seconds elapsed
+xfsrestore: Restore Status: SUCCESS
+xfsdump: using file dump (drive_simple) strategy
+xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
+xfsdump: dump date: DATE
+xfsdump: session id: ID
+xfsdump: session label: ""
+xfsdump: ino map <PHASES>
+xfsdump: ino map construction complete
+xfsdump: estimated dump size: NUM bytes
+xfsdump: /var/xfsdump/inventory created
+xfsdump: creating dump session media file 0 (media 0, file 0)
+xfsdump: dumping ino map
+xfsdump: dumping directories
+xfsdump: dumping non-directory files
+xfsdump: ending media file
+xfsdump: media file size NUM bytes
+xfsdump: dump size (non-dir files) : NUM bytes
+xfsdump: dump complete: SECS seconds elapsed
+xfsdump: Dump Status: SUCCESS
diff --git a/tests/xfs/group b/tests/xfs/group
index 09bce15..c1eace0 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -198,3 +198,4 @@
 304 auto quick quota
 305 auto quota
 306 auto stress log metadata repair
+307 auto stress dump


