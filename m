Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401BFC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  6 May 2022 05:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiEFFOD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 May 2022 01:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346016AbiEFFOD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 May 2022 01:14:03 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59687637F
        for <fstests@vger.kernel.org>; Thu,  5 May 2022 22:10:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5BF4D10E6278
        for <fstests@vger.kernel.org>; Fri,  6 May 2022 15:10:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nmqEL-008ahT-VD
        for fstests@vger.kernel.org; Fri, 06 May 2022 15:10:17 +1000
Date:   Fri, 6 May 2022 15:10:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] fstests: faster group file creation
Message-ID: <20220506051017.GF1949718@dread.disaster.area>
References: <20220506031232.483883-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506031232.483883-1-david@fromorbit.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6274adbb
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8
        a=VjI-3l-qDItjYoU8h0MA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

We don't need to execute every test just to check it's groups are
valid. Just grab all the groups with grep, pull out the unique ones,
then check them.

This also avoids the problem of editor swap files being present in
the test directory and breaking the build because they are not
executable.

Building on a clean, already built tree so it only builds the
group lists:

$ time make
....
Building udf
 [GROUP] /home/dave/src/xfstests-dev/tests/udf/group.list
Building xfs
 [GROUP] /home/dave/src/xfstests-dev/tests/xfs/group.list

real    0m36.917s
user    0m15.032s
sys     0m26.219s
$

Patched:

$ time make
....
Building udf
 [GROUP] /home/dave/src/xfstests-dev/tests/udf/group.list
Building xfs
 [GROUP] /home/dave/src/xfstests-dev/tests/xfs/group.list
groups "frobnozzle" not mentioned in documentation.
gmake[3]: *** [../../include/buildgrouplist:8: group.list] Error 1
gmake[2]: *** [../include/buildrules:31: xfs] Error 2
gmake[1]: *** [include/buildrules:31: tests] Error 2
make: *** [Makefile:51: default] Error 2

real    0m1.751s
user    0m0.863s
sys     0m1.067s

$

Just a little bit faster, and as you can see that it still detects
groups that are not documented. There was also an open .001.swp file
in the XFS directory and that doesn't throw a failure anymore,
either.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
V2: don't optimise away the per-test group listing in the output
file that check relies on for '-g <group>' matching.

 common/preamble   | 28 -----------------------
 tools/mkgroupfile | 66 ++++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/common/preamble b/common/preamble
index 64d79385..f4a405ac 100644
--- a/common/preamble
+++ b/common/preamble
@@ -23,26 +23,6 @@ _register_cleanup()
 	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
 }
 
-# Make sure each group is in the documentation file.
-_check_groups() {
-	test -n "$GROUPNAME_DOC_FILE" || return 0
-
-	local testname="$(echo "$0" | sed -e 's/^.*tests\///g')"
-	declare -a missing=()
-
-	for group in "$@"; do
-		if ! grep -q "^${group}[[:space:]]" "$GROUPNAME_DOC_FILE"; then
-			missing+=("\"${group}\"")
-		fi
-	done
-	test "${#missing}" -eq 0 && return 0
-
-	local suffix=
-	test "${#missing}" -gt 1 && suffix="s"
-	echo "$testname: group$suffix ${missing[@]} not mentioned in documentation." 1>&2
-	return 1
-}
-
 # Prepare to run a fstest by initializing the required global variables to
 # their defaults, sourcing common functions, registering a cleanup function,
 # and removing the $seqres.full file.
@@ -59,14 +39,6 @@ _begin_fstest()
 
 	seq=`basename $0`
 
-	# If we're only running the test to generate a group.list file,
-	# spit out the group data and exit.
-	if [ -n "$GENERATE_GROUPS" ]; then
-		_check_groups "$@" || exit 1
-		echo "$seq $@"
-		exit 0
-	fi
-
 	seqres=$RESULT_DIR/$seq
 	echo "QA output created by $seq"
 
diff --git a/tools/mkgroupfile b/tools/mkgroupfile
index 3844e57d..24435898 100755
--- a/tools/mkgroupfile
+++ b/tools/mkgroupfile
@@ -11,40 +11,64 @@ fi
 
 test_dir="$PWD"
 groupfile="$1"
+new_groups="/tmp/groups.$$"
 GROUPNAME_DOC_FILE="$(readlink -m ../../doc/group-names.txt)"
-export GROUPNAME_DOC_FILE
 
 if [ ! -x ../../check ]; then
 	echo "$0: Run this from tests/XXX/."
 	exit 1
 fi
 
-cleanup() {
-	test -z "$groupfile" && return
-	test -z "$ngroupfile" && return
-
-	if [ $ret -eq 0 ]; then
-		mv -f "$ngroupfile" "$groupfile"
-	else
-		rm -f "$ngroupfile"
-	fi
+cleanup()
+{
+	rm -f $new_groups.check
+	rm -f $new_groups
 }
 
 ret=1	# trigger cleanup of temporary files unless we succeed
 trap 'cleanup; exit $ret' EXIT INT TERM QUIT
 
+# Make sure each group is in the documentation file.
+_check_groups() {
+	test -n "$GROUPNAME_DOC_FILE" || return 0
+
+	local groups="$1"
+	declare -a missing=()
+
+	for group in `grep -v '#' $groups`; do
+		if ! grep -q "^${group}[[:space:]]" "$GROUPNAME_DOC_FILE"; then
+			missing+=("\"${group}\"")
+		fi
+	done
+	test "${#missing}" -eq 0 && return 0
+
+	local suffix=
+	test "${#missing}" -gt 1 && suffix="s"
+	echo "group$suffix ${missing[@]} not mentioned in documentation." 1>&2
+	ret=1
+	exit 1
+}
+
 generate_groupfile() {
-	cat << ENDL
+	cat << ENDL > $new_groups
 # QA groups control file, automatically generated.
 # See _begin_fstest in each test for details.
 
 ENDL
+
 	cd ../../
-	export GENERATE_GROUPS=yes
-	grep -R -l "^_begin_fstest" "$test_dir/" 2>/dev/null | while read testfile; do
-		test -x "$testfile" && "$testfile" || return 1
-	done | sort -g
-	ret="${PIPESTATUS[1]}"
+
+	# Aggregate the groups each test belongs to for the group file
+	grep -I -R "^_begin_fstest" $test_dir/ | \
+		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
+
+	# Create the list of unique groups for existence checking
+	grep -I -R "^_begin_fstest" $test_dir/ | \
+		sed -e 's/^.*_begin_fstest //' -e 's/ /\n/g' | \
+		sort -u > $new_groups.check
+
+	_check_groups $new_groups.check
+
 	cd "$test_dir"
 }
 
@@ -52,10 +76,12 @@ if [ -z "$groupfile" ] || [ "$groupfile" = "-" ]; then
 	# Dump the group file to stdout and exit
 	unset groupfile
 	generate_groupfile
+	cat $new_groups
 else
 	# Otherwise, write the group file to disk somewhere.
-	ngroupfile="${groupfile}.new"
-	rm -f "$ngroupfile"
-	generate_groupfile >> "$ngroupfile"
-	# let cleanup rename or delete ngroupfile
+	generate_groupfile
+	mv -f "$new_groups" "$groupfile"
 fi
+
+# Success!
+ret=0
