Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965250AbaKNNb3 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Nov 2014 08:31:29 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 3/7] Created new performance test category
Date: Fri, 14 Nov 2014 14:27:43 +0100
Message-Id: <1415971667-16873-3-git-send-email-jtulak@redhat.com>
In-Reply-To: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
References: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>, lczerner@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

This tests category is currently used only for demonstration of the environment setup, but later there are going to be performance tests.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 check                         |  2 +-
 tests/performance/001         | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/performance/001.out     |  1 +
 tests/performance/002         | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/performance/002.out     |  1 +
 tests/performance/003         | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/performance/003.out     |  1 +
 tests/performance/004         | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/performance/004.out     |  1 +
 tests/performance/Makefile    | 21 +++++++++++++++
 tests/performance/environment | 11 ++++++++
 tests/performance/group       |  9 +++++++
 12 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100755 tests/performance/001
 create mode 100644 tests/performance/001.out
 create mode 100755 tests/performance/002
 create mode 100644 tests/performance/002.out
 create mode 100755 tests/performance/003
 create mode 100644 tests/performance/003.out
 create mode 100755 tests/performance/004
 create mode 100644 tests/performance/004.out
 create mode 100644 tests/performance/Makefile
 create mode 100644 tests/performance/environment
 create mode 100644 tests/performance/group

diff --git a/check b/check
index 42a1ac2..a246d92 100755
--- a/check
+++ b/check
@@ -59,7 +59,7 @@ then
 fi
 
 SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
-SRC_GROUPS="generic shared"
+SRC_GROUPS="generic shared performance"
 export SRC_DIR="tests"
 
 usage()
diff --git a/tests/performance/001 b/tests/performance/001
new file mode 100755
index 0000000..d8f2dad
--- /dev/null
+++ b/tests/performance/001
@@ -0,0 +1,63 @@
+#! /bin/bash
+# FS QA Test No. 001
+#
+# Random file copier to produce chains of identical files so the head
+# and the tail can be diff'd at the end of each iteration.
+#
+# Exercises creat, write and unlink for a variety of directory sizes, and
+# checks for data corruption.
+#
+# run [config]
+#
+# config has one line per file with filename and byte size, else use
+# the default one below.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+tmp=/tmp/$$
+here=`pwd`
+status=1
+done_cleanup=false
+trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+_require_test
+_require_environment $TEST_DIR
+
+verbose=true
+
+
+
+_cleanup(){
+	_environment_clean $TEST_DIR
+}
+
+status=0
+exit
diff --git a/tests/performance/001.out b/tests/performance/001.out
new file mode 100644
index 0000000..097d046
--- /dev/null
+++ b/tests/performance/001.out
@@ -0,0 +1 @@
+QA output created by 001
diff --git a/tests/performance/002 b/tests/performance/002
new file mode 100755
index 0000000..d8f2dad
--- /dev/null
+++ b/tests/performance/002
@@ -0,0 +1,63 @@
+#! /bin/bash
+# FS QA Test No. 001
+#
+# Random file copier to produce chains of identical files so the head
+# and the tail can be diff'd at the end of each iteration.
+#
+# Exercises creat, write and unlink for a variety of directory sizes, and
+# checks for data corruption.
+#
+# run [config]
+#
+# config has one line per file with filename and byte size, else use
+# the default one below.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+tmp=/tmp/$$
+here=`pwd`
+status=1
+done_cleanup=false
+trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+_require_test
+_require_environment $TEST_DIR
+
+verbose=true
+
+
+
+_cleanup(){
+	_environment_clean $TEST_DIR
+}
+
+status=0
+exit
diff --git a/tests/performance/002.out b/tests/performance/002.out
new file mode 100644
index 0000000..c57ca23
--- /dev/null
+++ b/tests/performance/002.out
@@ -0,0 +1 @@
+QA output created by 002
diff --git a/tests/performance/003 b/tests/performance/003
new file mode 100755
index 0000000..d8f2dad
--- /dev/null
+++ b/tests/performance/003
@@ -0,0 +1,63 @@
+#! /bin/bash
+# FS QA Test No. 001
+#
+# Random file copier to produce chains of identical files so the head
+# and the tail can be diff'd at the end of each iteration.
+#
+# Exercises creat, write and unlink for a variety of directory sizes, and
+# checks for data corruption.
+#
+# run [config]
+#
+# config has one line per file with filename and byte size, else use
+# the default one below.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+tmp=/tmp/$$
+here=`pwd`
+status=1
+done_cleanup=false
+trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+_require_test
+_require_environment $TEST_DIR
+
+verbose=true
+
+
+
+_cleanup(){
+	_environment_clean $TEST_DIR
+}
+
+status=0
+exit
diff --git a/tests/performance/003.out b/tests/performance/003.out
new file mode 100644
index 0000000..e8cf537
--- /dev/null
+++ b/tests/performance/003.out
@@ -0,0 +1 @@
+QA output created by 003
diff --git a/tests/performance/004 b/tests/performance/004
new file mode 100755
index 0000000..d8f2dad
--- /dev/null
+++ b/tests/performance/004
@@ -0,0 +1,63 @@
+#! /bin/bash
+# FS QA Test No. 001
+#
+# Random file copier to produce chains of identical files so the head
+# and the tail can be diff'd at the end of each iteration.
+#
+# Exercises creat, write and unlink for a variety of directory sizes, and
+# checks for data corruption.
+#
+# run [config]
+#
+# config has one line per file with filename and byte size, else use
+# the default one below.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+tmp=/tmp/$$
+here=`pwd`
+status=1
+done_cleanup=false
+trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+_supported_fs generic
+_supported_os IRIX Linux
+_require_test
+_require_environment $TEST_DIR
+
+verbose=true
+
+
+
+_cleanup(){
+	_environment_clean $TEST_DIR
+}
+
+status=0
+exit
diff --git a/tests/performance/004.out b/tests/performance/004.out
new file mode 100644
index 0000000..8e2d391
--- /dev/null
+++ b/tests/performance/004.out
@@ -0,0 +1 @@
+QA output created by 004
diff --git a/tests/performance/Makefile b/tests/performance/Makefile
new file mode 100644
index 0000000..5a50b07
--- /dev/null
+++ b/tests/performance/Makefile
@@ -0,0 +1,21 @@
+#
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+PERFORMANCE_DIR = performance
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(PERFORMANCE_DIR)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+	$(INSTALL) -m 644 environment $(TARGET_DIR)
+	$(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
diff --git a/tests/performance/environment b/tests/performance/environment
new file mode 100644
index 0000000..9fb2e06
--- /dev/null
+++ b/tests/performance/environment
@@ -0,0 +1,11 @@
+# QA setups control file
+# Defines test environments 
+# - Do not start environment names with a digit.
+# - If an environment is prefixed with underscore, the environment is prepared
+#   clean again, even if previously run test had the same environment. 
+#   So big-files and _big-files are the same, only the first one is
+#   prepared only once, while the second one is prepared every time.
+001 none fill90-dvd dummy1
+002 dummy1 dummy2
+003 dummy1 _dummy2
+004 _dummy1 _dummy2
diff --git a/tests/performance/group b/tests/performance/group
new file mode 100644
index 0000000..f5854b9
--- /dev/null
+++ b/tests/performance/group
@@ -0,0 +1,9 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001 auto performance
+002 auto performance
+003 auto performance
+004 auto performance
-- 
1.9.3

