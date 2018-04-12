Received: from mx2.suse.de ([195.135.220.15]:54712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752846AbeDLVio (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Apr 2018 17:38:44 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43621AE49
        for <fstests@vger.kernel.org>; Thu, 12 Apr 2018 21:38:43 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH] check: annotate good and expunged tests in results
Date: Thu, 12 Apr 2018 17:38:38 -0400
Message-Id: <20180412213838.28929-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: mcgrof@suse.com, nborisov@suse.com, fdmanana@suse.com, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

Currently, we only create results files when a test has failed or was
supposed to run but some dependency wasn't met causing it not to run.
Short of saving the summary at the end of the run, there's no way to tell
which tests passed or which tests weren't run due to being excluded.

This patch moves successful test results to $seqres.out.good to annotate
good results.  It also adds tests excluded by group to the $tmp.xlist file
and adds annotations for every test excluded.  When a test is expunged
during execution, an expunged message will be issued and a
$seqres.expunged file will be created, both containing the reason for
the test being expunged.  Reasons can be "command line", "file $filename",
or "group <group> [group...]".

This makes the output more noisy in the expunged case and makes startup
take slightly longer, but ends up with results that can be more easily
parsed by automated tools.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 check | 57 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/check b/check
index 546683c5..9a1f4e7e 100755
--- a/check
+++ b/check
@@ -173,28 +173,18 @@ get_all_tests()
 	done
 }
 
-# takes the list of tests to run in $tmp.list, and removes the tests passed to
-# the function from that list.
+# takes the list of tests to run in $tmp.list and adds them to the excluded
+# test list, annotated with the group that excluded each one
 trim_test_list()
 {
+	group=$1
+	shift
 	test_list="$*"
 
-	rm -f $tmp.grep
-	numsed=0
-	for t in $test_list
-	do
-	    if [ $numsed -gt 100 ]; then
-		grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
-		mv $tmp.tmp $tmp.list
-		numsed=0
-		rm -f $tmp.grep
-	    fi
-	    echo "^$t\$" >>$tmp.grep
-	    numsed=`expr $numsed + 1`
+	for test in $test_list; do
+		test=${test##tests/}
+		echo "$test group $group" >> $tmp.xlist
 	done
-	grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
-	mv $tmp.tmp $tmp.list
-	rm -f $tmp.grep
 }
 
 
@@ -246,7 +236,7 @@ _prepare_test_list()
 			exit 1
 		fi
 
-		trim_test_list $list
+		trim_test_list $xgroup $list
 	done
 
 	# sort the list of tests into numeric order
@@ -285,13 +275,15 @@ while [ $# -gt 0 ]; do
 		for d in $SRC_GROUPS $FSTYP; do
 			[ -f $SRC_DIR/$d/$xfile ] || continue
 			for f in `sed "s/#.*$//" $SRC_DIR/$d/$xfile`; do
-				echo $d/$f >> $tmp.xlist
+				echo "$d/$f command line" >> $tmp.xlist
 			done
 		done
 		;;
 	-E)	xfile=$2; shift ;
 		if [ -f $xfile ]; then
-			sed "s/#.*$//" "$xfile" >> $tmp.xlist
+			sed -e "s/#.*$//" \
+			    -e "s;$; file $xfile;" "$xfile" \
+			    >> $tmp.xlist
 	        fi
 		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
@@ -491,11 +483,17 @@ _check_filesystems()
 _expunge_test()
 {
 	local TEST_ID="$1"
+	local OUTPUT="$2"
 	if [ -s $tmp.xlist ]; then
-		if grep -q $TEST_ID $tmp.xlist; then
-			echo "       [expunged]"
+		grep $TEST_ID $tmp.xlist > $tmp._expunge_test
+		if [ $? -eq 0 ]; then
+			sed -e "s;$TEST_ID ;;" $tmp._expunge_test | \
+				tr '\n' ' ' |  sed -e 's; group;;g'
+			echo
+			rm -f $tmp._expunge_test
 			return 1
 		fi
+		rm -f $tmp._expunge_test
 	fi
 	return 0
 }
@@ -670,8 +668,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	    echo -n "$seqnum"
 
 	    if $showme; then
-		_expunge_test $seqnum
+		_expunge_test $seqnum > $tmp.xreason
 		if [ $? -eq 1 ]; then
+			echo -n "        [expunged] "
+			cat $tmp.xreason
 			continue
 		fi
 		echo
@@ -689,11 +689,15 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	    else
 		# really going to try and run this one
 		#
-		rm -f $seqres.out.bad
+		rm -f $seqres.out.bad $seqres.out.good $seqres.expunged
+		rm -f $seqres.notrun
 
 		# check if we really should run it
-		_expunge_test $seqnum
+		_expunge_test $seqnum > $tmp.xreason
 		if [ $? -eq 1 ]; then
+			mv $tmp.xreason $seqres.expunged
+			echo -n "        [expunged] "
+			cat $seqres.expunged
 			continue
 		fi
 
@@ -704,7 +708,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		else
 			echo -n "	"	# prettier output with timestamps.
 		fi
-		rm -f core $seqres.notrun
+		rm -f core
 
 		start=`_wallclock`
 		$timestamp && echo -n "	["`date "+%T"`"]"
@@ -770,6 +774,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			    else
 				echo "$seqnum `expr $stop - $start`" >>$tmp.time
 				echo -n " `expr $stop - $start`s"
+				mv $tmp.out $seqres.out.good
 			    fi
 			    echo ""
 			else
-- 
2.15.1

