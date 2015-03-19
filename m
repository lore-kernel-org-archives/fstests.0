Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:35948 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbCSLqo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 19 Mar 2015 07:46:44 -0400
Received: by wetk59 with SMTP id k59so55014057wet.3
        for <fstests@vger.kernel.org>; Thu, 19 Mar 2015 04:46:43 -0700 (PDT)
Message-ID: <550AB720.3090009@plexistor.com>
Date: Thu, 19 Mar 2015 13:46:40 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: [PATCH v3] xfstest: generic/080 test that mmap-write updates c/mtime
References: <54F733BD.7060807@plexistor.com> <54F734C4.7080409@plexistor.com> <20150305001312.GA4251@dastard> <550A9C84.4090807@plexistor.com> <20150319104409.GO4810@dhcp-13-216.nay.redhat.com>
In-Reply-To: <20150319104409.GO4810@dhcp-13-216.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Boaz Harrosh <boaz@plexistor.com>, Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <matthew.r.wilcox@intel.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

when using mmap() for file i/o, writing to the file should update
it's c/mtime. Specifically if we first mmap-read from a page, then
memap-write to the same page.

This test was failing for the initial submission of DAX because
pfn based mapping do not have an page_mkwrite called for them.
The new Kernel patches that introduce pfn_mkwrite fixes this test.

Written by Dave Chinner but edited and tested by:
	Omer Zilberberg

Dave hands-up man, it looks like you edited this directly
in the email, but there was not even a single typo.

Tested-by: Omer Zilberberg <omzg@plexistor.com>
Tested-by: Boaz Harrosh <boaz@plexistor.com>
Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
Signed-off-by: Boaz Harrosh <boaz@plexistor.com>
Need-Reviewed-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/080     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/080.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100755 tests/generic/080
 create mode 100644 tests/generic/080.out

diff --git a/tests/generic/080 b/tests/generic/080
new file mode 100755
index 0000000..bb9d552
--- /dev/null
+++ b/tests/generic/080
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test No. 080
+#
+# Verify that mtime is updated when writing to mmap-ed pages
+#
+#-----------------------------------------------------------------------
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
+status=0
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	rm -f $testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+_require_test
+
+echo "Silence is golden."
+rm -f $seqres.full
+
+# pattern the file.
+testfile=$TEST_DIR/mmap_mtime_testfile
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c fsync $testfile >> $seqres.full
+
+# sample timestamps.
+mtime1=`stat -c %Y $testfile`
+ctime1=`stat -c %Z $testfile`
+echo "before mwrite: $mtime1 $ctime1" >> $seqres.full
+
+# map read followed by map write to trigger timestamp change
+sleep 2
+$XFS_IO_PROG -c "mmap 0 4k" -c "mread 0 4k" -c "mwrite 0 4k" $testfile >> $seqres.full
+
+# sample and verify that timestamps have changed.
+mtime2=`stat -c %Y $testfile`
+ctime2=`stat -c %Z $testfile`
+echo "after mwrite : $mtime2 $ctime2" >> $seqres.full
+
+if [ "$mtime1" == "$mtime2" ]; then
+	echo "mtime not updated"
+	let status=$status+1
+fi
+if [ "$ctime1" == "$ctime2" ]; then
+	echo "ctime not updated"
+	let status=$status+1
+fi
+
+exit
diff --git a/tests/generic/080.out b/tests/generic/080.out
new file mode 100644
index 0000000..cccac52
--- /dev/null
+++ b/tests/generic/080.out
@@ -0,0 +1,2 @@
+QA output created by 080
+Silence is golden.
diff --git a/tests/generic/group b/tests/generic/group
index d56d3ce..8154401 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -79,6 +79,7 @@
 077 acl attr auto enospc
 078 auto quick metadata
 079 acl attr ioctl metadata auto quick
+080 auto quick
 083 rw auto enospc stress
 088 perms auto quick
 089 metadata auto
-- 
1.9.3


