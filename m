Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42266 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbbB0Lbf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Feb 2015 06:31:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1RBVYuN016629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 27 Feb 2015 06:31:35 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 3/5] generic: test hardlink to unlinked file
Date: Fri, 27 Feb 2015 19:30:23 +0800
Message-Id: <1425036625-23361-4-git-send-email-eguan@redhat.com>
In-Reply-To: <1425036625-23361-1-git-send-email-eguan@redhat.com>
References: <1425036625-23361-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Eric Sandeen <esandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

Kernel commit

aae8a97 fs: Don't allow to create hardlink for deleted file

disabled hardlink to unlinked file.

Test the race between link and unlink, which could end up adding link
count to an unlinked file and leading to fs corruption on xfs.

Test case was originally written by Eric Sandeen.

Cc: Eric Sandeen <esandeen@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/072     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/072.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 102 insertions(+)
 create mode 100755 tests/generic/072
 create mode 100644 tests/generic/072.out

diff --git a/tests/generic/072 b/tests/generic/072
new file mode 100755
index 0000000..5628400
--- /dev/null
+++ b/tests/generic/072
@@ -0,0 +1,99 @@
+#! /bin/bash
+# FS QA Test No. 072
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
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+
+link_unlink_storm()
+{
+	local src=$1
+	local target=$2
+
+	while true; do
+		ln -f $src $target >/dev/null 2>&1
+		rm -f $target >/dev/null 2>&1
+	done
+}
+
+rm -f $seqres.full
+nr_cpu=`$here/src/feature -o`
+echo "Silence is golden"
+
+# create, open & unlinked files so unlinked inode list is not empty
+for i in `seq 1 64`; do
+	testfile=$TEST_DIR/$seq.unlinked.$i
+	touch $testfile
+	tail -f $testfile &
+	tail_pids="$tail_pids $!"
+	rm -f $testfile
+done
+
+# start link/unlink storm
+src=$TEST_DIR/$seq.target
+touch $testfile
+for i in `seq 1 $nr_cpu`; do
+	target=$TEST_DIR/$seq.target.link.$i
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
+# all done, no oops/hang expected, _check_filesystems checks TEST_DEV after test
+status=0
+exit
diff --git a/tests/generic/072.out b/tests/generic/072.out
new file mode 100644
index 0000000..590bbc6
--- /dev/null
+++ b/tests/generic/072.out
@@ -0,0 +1,2 @@
+QA output created by 072
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index f41cc3b..7265b18 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -74,6 +74,7 @@
 069 rw udf auto quick
 070 attr udf auto quick stress
 071 auto quick quota
+072 auto metadata
 074 rw udf auto
 075 rw udf auto quick
 076 metadata rw udf auto quick stress
-- 
1.8.3.1

