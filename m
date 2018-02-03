Received: from mx1.redhat.com ([209.132.183.28]:50162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeBCS5l (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 3 Feb 2018 13:57:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F05A4E90D
        for <fstests@vger.kernel.org>; Sat,  3 Feb 2018 18:57:41 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/3] check: Add -F option to specify failing tests
Date: Sat,  3 Feb 2018 19:57:36 +0100
Message-Id: <20180203185737.21025-2-agruenba@redhat.com>
In-Reply-To: <20180203185737.21025-1-agruenba@redhat.com>
References: <20180203185737.21025-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add a new -F option that takes a list of tests which are expected to
fail.  Adjust the output of the check script to indicate when a failure
is expected.  Summarize the number of actual vs.  expected passed and
failed tests at the end.

In addition, tests in this list which are prefixed with a dash are
skipped, so no separate -E list is necessary for tests which are known
to lock up.

This allows to use fstests for regression testing much more easily.  For
example, we have a list of around 30 tests that we currently expect to
fail, and two tests which lock up.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 check | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 23 deletions(-)

diff --git a/check b/check
index 546683c5..f1bf75d6 100755
--- a/check
+++ b/check
@@ -25,9 +25,13 @@ needwrap=true
 needsum=true
 n_try=0
 try=""
-n_bad=0
+n_bad=0		# number of unexpected failures
+n_xbad=0	# number of expected failures
+n_xgood=0	# number of unexpected successes
 sum_bad=0
 bad=""
+xbad=""
+xgood=""
 n_notrun=0
 notrun=""
 interrupt=true
@@ -54,7 +58,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
 
-rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
+rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.xfail $tmp.report.*
 
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
@@ -89,6 +93,7 @@ testlist options
     -x group[,group...]	exclude tests from these groups
     -X exclude_file	exclude individual tests
     -E external_file	exclude individual tests
+    -F external_file    tests expected to fail
     [testlist]		include tests matching names in testlist
 
 testlist argument is a list of tests in the form of <test dir>/<test name>.
@@ -108,7 +113,9 @@ for every test dir where this file is found, the listed test names are
 excluded from the list of tests to run from that test dir.
 
 external_file argument is a path to a single file containing a list of tests
-to exclude in the form of <test dir>/<test name>.
+in the form of <test dir>/<test name>.  For option -E, the listed tests are
+excluded.  For option -F, the listed tests are excluded if the test is
+preceded with a minus sign (-), and expected to fail otherwise.
 
 examples:
  check xfs/001
@@ -294,6 +301,13 @@ while [ $# -gt 0 ]; do
 			sed "s/#.*$//" "$xfile" >> $tmp.xlist
 	        fi
 		;;
+	-F)	xfile=$2; shift ;
+		if [ -f $xfile ]; then
+			x=`sed -e 's/\(^\|[ \t]\+\)#.*//; /^[ \t]*$/d' "$xfile"`
+			echo "$x" | sed -e "/^-/d" >> $tmp.xfail
+			echo "$x" | sed -ne "s/^-//p" >> $tmp.xlist
+		fi
+		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	-l)	diff="diff" ;;
@@ -383,12 +397,16 @@ _wipe_counters()
 {
 	n_try="0"
 	n_bad="0"
+	n_xbad="0"
+	n_xgood="0"
 	n_notrun="0"
-	unset try notrun bad
+	unset try notrun bad xbad xgood
 }
 
 _wrapup()
 {
+	local msg=""
+
 	seq="check"
 	check="$RESULT_BASE/check"
 
@@ -436,26 +454,28 @@ _wrapup()
 			echo "Not run:$notrun" >>$check.log
 		fi
 
-		if [ ! -z "$n_bad" -a $n_bad != 0 ]; then
-			echo "Failures:$bad"
-			echo "Failed $n_bad of $n_try tests"
-			echo "Failures:$bad" >>$check.log
-			echo "Failed $n_bad of $n_try tests" >>$check.log
-			echo "Failures:$bad" >>$tmp.summary
-			echo "Failed $n_bad of $n_try tests" >>$tmp.summary
-		else
-			echo "Passed all $n_try tests"
-			echo "Passed all $n_try tests" >>$check.log
-			echo "Passed all $n_try tests" >>$tmp.summary
-		fi
-		echo "" >>$tmp.summary
+		[ $n_xbad -eq 0 ] ||
+		     msg="${msg}Expected failures:$xbad\n"
+		[ $n_bad -eq 0 ] ||
+		    msg="${msg}Unexpected failures:$bad\n"
+		[ $n_xgood -eq 0 ] ||
+		    msg="${msg}Unexpected successes:$xgood\n"
+		local n_xpassed=`expr $n_try - $n_xbad`
+		local n_passed=`expr $n_xpassed - $n_bad`
+		[ $n_passed -eq 0 -a $n_xpassed -eq 0 ] ||
+		    msg="${msg}Passed $n_passed tests ($n_xpassed expected)\n"
+		[ $n_bad -eq 0 -a $n_xbad -eq 0 ] ||
+		    msg="${msg}Failed `expr $n_bad + $n_xbad` tests ($n_xbad expected)\n"
+		printf "$msg"
+		printf "$msg" >>$check.log
+		printf "$msg\n" >>$tmp.summary
 		if $do_report; then
 			_make_section_report
 		fi
 		needwrap=false
 	fi
 
-	sum_bad=`expr $sum_bad + $n_bad`
+	sum_bad=`expr $sum_bad + $n_bad + $n_xgood`
 	_wipe_counters
 	rm -f /tmp/*.rawout /tmp/*.out /tmp/*.err /tmp/*.time
 	if ! $OPTIONS_HAVE_SECTIONS; then
@@ -697,6 +717,14 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			continue
 		fi
 
+		# check if we expect failure
+		expect_failure=false
+		if [ -s $tmp.xfail ]; then
+			if grep $seqnum $tmp.xfail > /dev/null 2>&1 ; then
+				expect_failure=true
+			fi
+		fi
+
 		# slashes now in names, sed barfs on them so use grep
 		lasttime=`grep -w ^$seqnum $check.time | awk '// {print $2}'`
 		if [ "X$lasttime" != X ]; then
@@ -749,7 +777,11 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		else
 		    if [ $sts -ne 0 ]
 		    then
-			err_msg="[failed, exit status $sts]"
+			if $expect_failure; then
+			    err_msg="[failed (expected), exit status $sts]"
+			else
+			    err_msg="[failed, exit status $sts]"
+			fi
 			echo -n " $err_msg"
 			err=true
 		    fi
@@ -773,7 +805,11 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			    fi
 			    echo ""
 			else
-			    echo " - output mismatch (see $seqres.out.bad)"
+			    if $expect_failure; then
+				echo " - output mismatch (failure expected; see $seqres.out.bad)"
+			    else
+				echo " - output mismatch (see $seqres.out.bad)"
+			    fi
 			    mv $tmp.out $seqres.out.bad
 			    $diff $seq.out $seqres.out.bad | {
 				if test "$DIFF_LENGTH" -le 0; then
@@ -785,7 +821,11 @@ for section in $HOST_OPTIONS_SECTIONS; do
 						" to see the entire diff)"
 				fi; } | \
 				sed -e 's/^\(.\)/    \1/'
-			    err_msg="output mismatch (see $diff $seq.out $seqres.out.bad)"
+			    if $expect_failure; then
+				err_msg="output mismatch (failure expected; see $diff $seq.out $seqres.out.bad)"
+			    else
+				err_msg="output mismatch (see $diff $seq.out $seqres.out.bad)"
+			    fi
 			    err=true
 			fi
 		    fi
@@ -802,9 +842,19 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	    #
 	    if $err
 	    then
-		bad="$bad $seqnum"
-		n_bad=`expr $n_bad + 1`
+		if $expect_failure; then
+		    xbad="$xbad $seqnum"
+		    n_xbad=`expr $n_xbad + 1`
+		else
+		    bad="$bad $seqnum"
+		    n_bad=`expr $n_bad + 1`
+		fi
 		tc_status="fail"
+	    else
+		if $expect_failure; then
+		    xgood="$xgood $seqnum"
+		    n_xgood=`expr $n_xgood + 1`
+		fi
 	    fi
 	    if $do_report; then
 		_make_testcase_report "$tc_status"
-- 
2.14.3

