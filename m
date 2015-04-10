Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbbDJNCg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 10 Apr 2015 09:02:36 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 4/7] fstests: environments - add performance tests (as example of usage)
Date: Fri, 10 Apr 2015 15:02:26 +0200
Message-Id: <1428670949-17524-5-git-send-email-jtulak@redhat.com>
In-Reply-To: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
References: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

This patch adds new test category for performance tests, which utilises
the new environment architecture.

There are two simple tests. Currently, both are configured to be quick,
running about 20 seconds, so you can easily try them.

- 001 is for benchmarking readdir speed using xfs_io -c "readdir".
  In this test, an environment is used to generate NUM of empty files in
  a directory. Runtime is
- 002 is a simulation of SQLite, using fio for the testing. It uses no environment
  to show how the modified skeleton from ./new script works by default.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 tests/performance/001-readdir | 123 +++++++++++++++++++++++++++++++++++++++++
 tests/performance/002-sqlite  | 124 ++++++++++++++++++++++++++++++++++++++++++
 tests/performance/Makefile    |  21 +++++++
 tests/performance/group       |   7 +++
 4 files changed, 275 insertions(+)
 create mode 100755 tests/performance/001-readdir
 create mode 100755 tests/performance/002-sqlite
 create mode 100644 tests/performance/Makefile
 create mode 100644 tests/performance/group

diff --git a/tests/performance/001-readdir b/tests/performance/001-readdir
new file mode 100755
index 0000000..f415213
--- /dev/null
+++ b/tests/performance/001-readdir
@@ -0,0 +1,123 @@
+#! /bin/bash
+# FS QA Test No. 001
+#
+# Performance test.
+# Readdir speed for various amounts of files in a directory.
+# The test is run on TEST_DIR as well as in overlayfs above TEST_DIR.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 RedHat.  All Rights Reserved.
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
+# List of environments this test can use for preparing files for the testing.
+# They are independent of each other (multiple entries = multiple runs).
+# If "none" is given, the test can be run without any environment,
+# ommiting it signifies that the test won't run without any of them.
+#
+# Example: supported_environments="none empty_files full_partition"
+#
+# If you want to combine multiple environments at once, you have to
+# call them yourself: _environment_require PATH ENVIRONMENT_NAME
+
+supported_environments="none overlayfs"
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
+    cd /
+    rm -f $tmp.*
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
+_supported_os IRIX Linux
+_require_test
+_disable_output_check
+
+run_test(){
+	# PUT TEST BELOW
+
+	if ! type xfs_io >/dev/null 2>&1; then 
+		_fail "This test requires xfs_io in PATH."
+	fi
+
+	export ENV_MERGED="$TEST_DIR/merged"
+	mkdir -p "$ENV_MERGED"
+	_environment_require $TEST_DIR
+
+	echo ""
+	echo "## environment $ENV_NAME"
+
+	numbers="1000 5000 10000"
+	for n in $numbers;do
+		echo ""
+		export ENV_FILES_NUMBER=$n
+		_environment_require "$ENV_MERGED" "empty-files"
+		er=$?
+		if [ $er -ne 0 ];then
+			continue
+		fi
+
+
+		verbose=true
+
+		# check for xfs_io tool
+		which xfs_io >/dev/null 2>&1
+		if [ $? -ne 0 ];then
+			_fatal "xfs_io tool has to be installed in PATH!"
+		fi
+		echo "# MEASURED_DATA"
+		xfs_io -c "readdir" "$TEST_DIR" |paste -sd ", " -
+		_environment_clean "$ENV_MERGED" "empty-files"
+	done
+	_environment_clean $TEST_DIR
+	rmdir "$ENV_MERGED"
+
+	# PUT TEST ABOVE
+}
+
+
+# Filter the supported_environments by user input (-eo/-ex arguments)
+# and run the test for all environments in the intersect of
+# the supported and user-allowed environments.
+for environment in $(_filter_environments "$supported_environments")
+do
+	export ENV_NAME="$environment"
+	run_test
+done
+
+# optional stuff if your test has verbose output to help resolve problems
+#echo
+#echo "If failure, check $seqres.full (this) and $seqres.full.ok (reference)"
+
+# success, all done
+status=0
+exit
diff --git a/tests/performance/002-sqlite b/tests/performance/002-sqlite
new file mode 100755
index 0000000..a278124
--- /dev/null
+++ b/tests/performance/002-sqlite
@@ -0,0 +1,124 @@
+#! /bin/bash
+# FS QA Test No. 002
+#
+# Performance test for simulating SQLite.
+#
+# Requires FIO.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 YOUR NAME HERE.  All Rights Reserved.
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
+# List of environments this test can use for preparing files for the testing.
+# They are independent of each other (multiple entries = multiple runs).
+# If "none" is given, the test can be run without any environment,
+# ommiting it signifies that the test won't run without any of them.
+#
+# Example: supported_environments="none empty_files full_partition"
+#
+# If you want to combine multiple environments at once, you have to
+# call them yourself: _environment_require PATH ENVIRONMENT_NAME
+
+supported_environments="none"
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
+	rm database-sqlite.prerun.txt
+    cd /
+    rm -f $tmp.*
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
+_supported_os IRIX Linux
+_require_test
+_disable_output_check
+
+FIO_BIN=fio
+RUNTIME=20
+
+cat <<EOF > $tmp.sqlite.fio
+[global]
+rw=randrw
+rwmixread=80
+size=1G
+directory=$TEST_DIR
+fadvise_hint=0
+direct=1
+blocksize=8k
+numjobs=\$ncpus*2
+time_based
+runtime=$RUNTIME
+ioengine=libaio
+norandommap=1
+exec_prerun=echo 3 > /proc/sys/vm/drop_caches
+group_reporting
+
+[database-sqlite]
+nrfiles=1
+numjobs=1
+ioengine=sync
+lockfile=exclusive
+
+EOF
+
+run_test(){
+	_environment_require $TEST_DIR
+	# PUT TEST BELOW
+
+	if ! type $FIO_BIN >/dev/null 2>&1; then 
+		_fail "Can't run without $FIO_BIN installed."
+	fi
+
+	$FIO_BIN --append-terse $tmp.sqlite.fio
+
+	# PUT TEST ABOVE
+	 _environment_clean $TEST_DIR
+}
+
+
+# Filter the supported_environments by user input (-eo/-ex arguments)
+# and run the test for all environments in the intersect of
+# the supported and user-allowed environments.
+for environment in $(_filter_environments "$supported_environments")
+do
+	export ENV_NAME="$environment"
+    run_test
+done
+
+# optional stuff if your test has verbose output to help resolve problems
+#echo
+#echo "If failure, check $seqres.full (this) and $seqres.full.ok (reference)"
+
+# success, all done
+status=0
+exit
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
diff --git a/tests/performance/group b/tests/performance/group
new file mode 100644
index 0000000..25d4059
--- /dev/null
+++ b/tests/performance/group
@@ -0,0 +1,7 @@
+# QA groups control file
+# Defines test groups and nominal group owners
+# - do not start group names with a digit
+# - comment line before each group is "new" description
+#
+001-readdir readdir
+002-sqlite fio db-simulation
-- 
2.1.0

