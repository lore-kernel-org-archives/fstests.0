Received: from sandeen.net ([63.231.237.45]:58310 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdAMO4Q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 13 Jan 2017 09:56:16 -0500
Subject: [PATCH V2] tools: compare-failures script
References: <c756a755-8b9e-2c42-3855-4ffe507f9bd2@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <b8709bd8-fc9a-3804-7b28-71bc4bfe5985@sandeen.net>
Date: Fri, 13 Jan 2017 08:56:15 -0600
MIME-Version: 1.0
In-Reply-To: <c756a755-8b9e-2c42-3855-4ffe507f9bd2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is a simple script to compare failures across runs.

Given files containing stdout from several runs, each of which contains
a Failures: line, it will print a table of all failures for each run.
Test subdir names are abbreviated for compactness, i.e. generic->g.
For 7 results files named test 1 through test 7:

# compare-fail.sh test*

Failures:
g/075 g/082 g/209 g/233 g/270 g/388 x/004 x/073 x/076
-----------------------------------------------------
      g/082       g/233             x/004 x/073       test1 
      g/082       g/233             x/004 x/073 x/076 test2 
      g/082                         x/004 x/073 x/076 test3 
      g/082                   g/388 x/004 x/073       test4 
      g/082             g/270       x/004 x/073       test5 
      g/082                         x/004 x/073       test6 
g/075 g/082 g/209 g/233             x/004 x/073       test7 

This lets us easily spot unique failures and outliers.

This could be enhanced to output CSV etc, but for now I think it's
helpful to visualize changes in failures across multiple runs.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: not sure why I had the commit log in so few columns ;)
That's the only change.

diff --git a/README b/README
index 400e902..3213d02 100644
--- a/README
+++ b/README
@@ -272,6 +272,9 @@ Pass/failure:
     The elapsed time for the most recent pass for each test is kept
     in "check.time".
 
+    The compare-failures script in tools/ may be used to compare failures
+    across multiple runs, given files containing stdout from those runs.
+
 __________________
 SUBMITTING PATCHES
 __________________
diff --git a/tools/compare-failures b/tools/compare-failures
new file mode 100755
index 0000000..13b07b9
--- /dev/null
+++ b/tools/compare-failures
@@ -0,0 +1,67 @@
+#!/bin/bash
+
+# Compare test failures across runs
+# 
+# Takes multiple "results" files as arguments, comprised of the
+# stdout from a ./check run, each containing a Failures: line.
+#
+# Outputs a table of failures for comparison across runs
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
+filter_names() {
+	sed -e s/btrfs/b/ \
+	    -e s/cifs/c/g \
+	    -e s/f2fs/f/g \
+	    -e s/generic/g/g \
+	    -e s/overlay/o/g \
+	    -e s/shared/s/g \
+	    -e s/udf/u/g \
+	    -e s/xfs/x/g
+}
+
+# ALLFAILURES:   A B C D E F G
+# THESEFAILURES: A   C D     G
+
+# We want to print the header (ALLFAILURES) and then
+# if a run didn't fail a particular test, print spaces instead
+
+# All tests that failed in any run, all on one line, unique
+ALLFAILURES=`grep -h ^Failures: $* \
+		| tr " " "\n" \
+		| sort | uniq \
+		| filter_names \
+		| tr "\n" " " \
+		| sed -e "s/^Failures: //g"`
+
+# Header
+echo "Failures:"
+echo $ALLFAILURES
+echo $ALLFAILURES | sed -e "s/./-/g"
+
+# Per-file failures
+for FILE in $*; do
+	THESEFAILURES=`grep ^Failures: $FILE | filter_names`
+	for FAILURE in $ALLFAILURES; do
+		CELL=`echo $THESEFAILURES \
+		      | grep -wo "$FAILURE" || echo $FAILURE | sed -e "s/./ /g"`
+		echo -n "$CELL "
+	done
+	echo $FILE
+done
