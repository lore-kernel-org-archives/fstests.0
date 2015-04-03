Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbbDCHRc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 3 Apr 2015 03:17:32 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id ED1E5B0424
	for <fstests@vger.kernel.org>; Fri,  3 Apr 2015 07:17:31 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3 2/4] generic: test hardlink to unlinked file
Date: Fri,  3 Apr 2015 15:17:20 +0800
Message-Id: <1428045440-10612-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1428045351-10446-1-git-send-email-eguan@redhat.com>
References: <1428045351-10446-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Kernel commit

aae8a97 fs: Don't allow to create hardlink for deleted file

disabled hardlink to unlinked file.

Test the race between link and unlink, which could end up adding link
count to an unlinked file and leading to fs corruption on xfs.

Test case was originally written by Eric Sandeen.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
v3:
- rebase and re-numbered to generic/084
- sleep 1 before removing all files being tailed

v2:
- create different link file in each iteration in link_unlink_storm(), which
  is confirmed to be able to reproduce the original corruption
- remove all newly created & tail'ed files at last, out of the loop, to avoid
  tail & rm race
- iterate $nr_cpu times to do the link_unlink_storm, not a fixed number
- add to quick group

 tests/generic/084     | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/084.out |   2 +
 tests/generic/group   |   1 +
 3 files changed, 107 insertions(+)
 create mode 100755 tests/generic/084
 create mode 100644 tests/generic/084.out

diff --git a/tests/generic/084 b/tests/generic/084
new file mode 100755
index 0000000..3fec6c2
--- /dev/null
+++ b/tests/generic/084
@@ -0,0 +1,104 @@
+#! /bin/bash
+# FS QA Test No. 084
+#
+# Test hardlink to unlinked file.
+#
+# Regression test for commit:
+# aae8a97 fs: Don't allow to create hardlink for deleted file
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
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
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+link_unlink_storm()
+{
+	local src=$1
+	local target=$2
+	local i=0
+
+	while true; do
+		ln -f $src $target.$i >/dev/null 2>&1
+		rm -f $target.$i >/dev/null 2>&1
+		let i=i+1
+	done
+}
+
+rm -f $seqres.full
+nr_cpu=`$here/src/feature -o`
+echo "Silence is golden"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# create, open & unlinked files so unlinked inode list is not empty
+for i in `seq 1 $nr_cpu`; do
+	testfile=$SCRATCH_MNT/$seq.unlinked.$i
+	touch $testfile
+	tail -f $testfile &
+	tail_pids="$tail_pids $!"
+done
+# give tail some time to open the file before the file is removed
+sleep 1
+rm -f $SCRATCH_MNT/$seq.unlinked.*
+
+# start link/unlink storm
+src=$SCRATCH_MNT/$seq.target
+touch $src
+for i in `seq 1 $nr_cpu`; do
+	target=$SCRATCH_MNT/$seq.target.link.$i
+	link_unlink_storm $src $target &
+	link_pids="$link_pids $!"
+done
+
+# remove & re-create target to race with link/unlink
+while true; do
+	rm -f $src
+	touch $src
+done &
+sleep 5
+kill $! >/dev/null 2>&1
+
+kill $tail_pids $link_pids >/dev/null 2>&1
+wait $tail_pids $link_pids
+
+# all done, no oops/hang expected, _check_filesystems checks SCRATCH_DEV after test
+status=0
+exit
diff --git a/tests/generic/084.out b/tests/generic/084.out
new file mode 100644
index 0000000..022f013
--- /dev/null
+++ b/tests/generic/084.out
@@ -0,0 +1,2 @@
+QA output created by 084
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 4fe2189..5cbc1fe 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -86,6 +86,7 @@
 081 auto quick
 082 auto quick
 083 rw auto enospc stress
+084 auto metadata quick
 088 perms auto quick
 089 metadata auto
 091 rw auto quick
-- 
1.8.3.1

