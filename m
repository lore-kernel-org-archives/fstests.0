Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:25101 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751854AbeEFWqh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 May 2018 18:46:37 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fFSQM-0000Uq-AW
        for fstests@vger.kernel.org; Mon, 07 May 2018 08:46:34 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fFSQM-0000Ng-9A
        for fstests@vger.kernel.org; Mon, 07 May 2018 08:46:34 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] check: fail tests if check/dmesg are not clean
Date: Mon,  7 May 2018 08:46:34 +1000
Message-Id: <20180506224634.1425-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Currently a test passes even if it leaves a corrupt filesystem
behind, or a splat in the system logs that should not be there.
Rework the check code to consider these as test failures so they can
be accounted and tracked correctly. This also allows us to include
the post-test filesystem checking in the test runtime - that is
currently not accounted to the test, either, so the real runtime of
each test is not accurately reflected in the time stats being
reported.

This requires a complete reworking of the main test check loop. It's
a bunch of spaghetti at the moment because it has post test
reporting code preventing use from using continue when a test is
done. Move that post test reporting to the start of the next loop
iteration and clean up the code to use continues where appropriate.

Also, for cases where we haven't run the test or it's already been
marked as failed, don't bother running the filesystem/dmesg checks
for failure as we're already going to report the test as failed.

This touches almost all of the loop, so get rid of the remaining
4 space indents inside the loop while moving all this code around.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 check | 250 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 132 insertions(+), 118 deletions(-)

diff --git a/check b/check
index 96198ac4714e..fcbfcc424778 100755
--- a/check
+++ b/check
@@ -639,78 +639,96 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	seqres="$check"
 	_check_test_fs
 
-	for seq in $list
-	do
-	    err=false
-	    _err_msg=""
-	    if [ ! -f $seq ]; then
-	        # Try to get full name in case the user supplied only seq id
-	        # and the test has a name. A bit of hassle to find really
-	        # the test and not its sample output or helping files.
-	        bname=$(basename $seq)
-	        full_seq=$(find $(dirname $seq) -name $bname* -executable |
-	            awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
-	                END { print shortest }')
-	        if [ -f $full_seq ] \
-	            && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
-	            seq=$full_seq
-	        fi
-	    fi
+	err=false
+	first_test=true
+	for seq in $list ; do
+		# Run report for previous test!
+		if $err ; then
+			bad="$bad $seqnum"
+			n_bad=`expr $n_bad + 1`
+			tc_status="fail"
+		fi
+		if $do_report -a ! $first_test -a $tc_status != "expunge" ; then
+			_make_testcase_report "$tc_status"
+		fi
+		first_test=false
+
+		err=false
+		_err_msg=""
+		if [ ! -f $seq ]; then
+			# Try to get full name in case the user supplied only
+			# seq id and the test has a name. A bit of hassle to
+			# find really the test and not its sample output or
+			# helping files.
+			bname=$(basename $seq)
+			full_seq=$(find $(dirname $seq) -name $bname* -executable |
+				awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
+				     END { print shortest }')
+			if [ -f $full_seq ] && \
+			   [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
+				seq=$full_seq
+			fi
+		fi
 
-	    # the filename for the test and the name output are different.
-	    # we don't include the tests/ directory in the name output.
-	    export seqnum=`echo $seq | sed -e "s;$SRC_DIR/;;"`
-
-	    # Similarly, the result directory needs to replace the tests/
-	    # part of the test location.
-	    group=`dirname $seq`
-	    if $OPTIONS_HAVE_SECTIONS; then
-		export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;${RESULT_BASE}/$section;"`
-		REPORT_DIR="$RESULT_BASE/$section"
-	    else
-		export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;$RESULT_BASE;"`
-		REPORT_DIR="$RESULT_BASE"
-	    fi
-	    seqres="$REPORT_DIR/$seqnum"
+		# the filename for the test and the name output are different.
+		# we don't include the tests/ directory in the name output.
+		export seqnum=`echo $seq | sed -e "s;$SRC_DIR/;;"`
 
-	    mkdir -p $RESULT_DIR
+		# Similarly, the result directory needs to replace the tests/
+		# part of the test location.
+		group=`dirname $seq`
+		if $OPTIONS_HAVE_SECTIONS; then
+			export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;${RESULT_BASE}/$section;"`
+			REPORT_DIR="$RESULT_BASE/$section"
+		else
+			export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;$RESULT_BASE;"`
+			REPORT_DIR="$RESULT_BASE"
+		fi
+		seqres="$REPORT_DIR/$seqnum"
 
-	    echo -n "$seqnum"
+		mkdir -p $RESULT_DIR
+		echo -n "$seqnum"
 
-	    if $showme; then
-		_expunge_test $seqnum
-		if [ $? -eq 1 ]; then
+		if $showme; then
+			_expunge_test $seqnum
+			if [ $? -eq 1 ]; then
+			    tc_status="expunge"
+			    continue
+			fi
+			echo
+			start=0
+			stop=0
+			tc_status="list"
+			n_notrun=`expr $n_notrun + 1`
 			continue
 		fi
-		echo
-		start=0
-		stop=0
-		n_notrun=`expr $n_notrun + 1`
-		if $do_report; then
-			_make_testcase_report "list"
+
+		tc_status="pass"
+		if [ ! -f $seq ]; then
+			echo " - no such test?"
+			continue
 		fi
-		continue
-	    fi
-	    tc_status="pass"
-	    if [ ! -f $seq ]; then
-		echo " - no such test?"
-	    else
+
 		# really going to try and run this one
-		#
 		rm -f $seqres.out.bad
 
 		# check if we really should run it
 		_expunge_test $seqnum
 		if [ $? -eq 1 ]; then
+			tc_status="expunge"
 			continue
 		fi
 
+		# record that we really tried to run this test.
+		try="$try $seqnum"
+		n_try=`expr $n_try + 1`
+
 		# slashes now in names, sed barfs on them so use grep
 		lasttime=`grep -w ^$seqnum $check.time | awk '// {print $2}'`
 		if [ "X$lasttime" != X ]; then
 			echo -n " ${lasttime}s ..."
 		else
-			echo -n "	"	# prettier output with timestamps.
+			echo -n "	" # prettier output with timestamps.
 		fi
 		rm -f core $seqres.notrun
 
@@ -732,90 +750,86 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			./$seq >$tmp.out 2>&1
 			sts=$?
 		fi
-		$timestamp && _timestamp
-		stop=`_wallclock`
 
-		if [ -f core ]
-		then
-		    _err_msg="[dumped core]"
-		    echo -n " $_err_msg"
-		    mv core $RESULT_BASE/$seqnum.core
-		    err=true
+		if [ -f core ]; then
+			_err_msg="[dumped core]"
+			echo -n " $_err_msg"
+			mv core $RESULT_BASE/$seqnum.core
+			err=true
 		fi
 
-		if [ -f $seqres.notrun ]
-		then
-		    $timestamp || echo -n " [not run] "
-		    $timestamp && echo " [not run]" && echo -n "	$seqnum -- "
-		    cat $seqres.notrun
-		    notrun="$notrun $seqnum"
-		    n_notrun=`expr $n_notrun + 1`
-		    tc_status="notrun"
-		else
-		    if [ $sts -ne 0 ]
-		    then
+		if [ -f $seqres.notrun ]; then
+			$timestamp && _timestamp
+			stop=`_wallclock`
+			$timestamp || echo -n " [not run] "
+			$timestamp && echo " [not run]" && \
+				      echo -n "	$seqnum -- "
+			cat $seqres.notrun
+			notrun="$notrun $seqnum"
+			n_notrun=`expr $n_notrun + 1`
+			tc_status="notrun"
+			continue;
+		fi
+
+		if [ $sts -ne 0 ]; then
 			_err_msg="[failed, exit status $sts]"
 			echo -n " $_err_msg"
 			err=true
-		    fi
-		    if [ ! -f $seq.out ]
-		    then
+		else
+			# the test apparently passed, so check for corruption
+			# and log messages that shouldn't be there.
+			_check_filesystems
+			_check_dmesg || err=true
+			_check_kmemleak || err=true
+		fi
+
+		# test ends after all checks are done.
+		$timestamp && _timestamp
+		stop=`_wallclock`
+
+		if [ ! -f $seq.out ]; then
 			_dump_err "no qualified output"
 			err=true
-		    else
-
-			# coreutils 8.16+ changed quote formats in error messages from
-			# `foo' to 'foo'. Filter old versions to match the new version.
-			sed -i "s/\`/\'/g" $tmp.out
-			if diff $seq.out $tmp.out >/dev/null 2>&1
-			then
-			    if $err
-			    then
-				:
-			    else
+			continue;
+		fi
+		# coreutils 8.16+ changed quote formats in error messages
+		# from `foo' to 'foo'. Filter old versions to match the new
+		# version.
+		sed -i "s/\`/\'/g" $tmp.out
+		if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
+			if ! $err ; then
 				echo "$seqnum `expr $stop - $start`" >>$tmp.time
 				echo -n " `expr $stop - $start`s"
-			    fi
-			    echo ""
-			else
-			    echo " - output mismatch (see $seqres.out.bad)"
-			    mv $tmp.out $seqres.out.bad
-			    $diff $seq.out $seqres.out.bad | {
-				if test "$DIFF_LENGTH" -le 0; then
-					cat
-				else
-					head -n "$DIFF_LENGTH"
-					echo "..."
-					echo "(Run '$diff $seq.out $seqres.out.bad'" \
-						" to see the entire diff)"
-				fi; } | \
-				sed -e 's/^\(.\)/    \1/'
-			    _err_msg="output mismatch (see $diff $seq.out $seqres.out.bad)"
-			    err=true
 			fi
-		    fi
-		    try="$try $seqnum"
-		    n_try=`expr $n_try + 1`
-		    _check_filesystems
-		    _check_dmesg || err=true
-		    _check_kmemleak || err=true
-		fi
+			echo ""
+		else
+			echo " - output mismatch (see $seqres.out.bad)"
+			mv $tmp.out $seqres.out.bad
+			$diff $seq.out $seqres.out.bad | {
+			if test "$DIFF_LENGTH" -le 0; then
+				cat
+			else
+				head -n "$DIFF_LENGTH"
+				echo "..."
+				echo "(Run '$diff $seq.out $seqres.out.bad'" \
+					" to see the entire diff)"
+			fi; } | sed -e 's/^\(.\)/    \1/'
 
-	    fi
+			_err_msg="output mismatch (see $diff $seq.out $seqres.out.bad)"
+			err=true
+		fi
+	done
 
-	    # come here for each test, except when $showme is true
-	    #
-	    if $err
-	    then
+	# make sure we record the status of the last test we ran.
+	if $err ; then
 		bad="$bad $seqnum"
 		n_bad=`expr $n_bad + 1`
 		tc_status="fail"
-	    fi
-	    if $do_report; then
+	fi
+	if $do_report -a ! $first_test -a $tc_status != "expunge" ; then
 		_make_testcase_report "$tc_status"
-	    fi
-	    seq="after_$seqnum"
-	done
+	fi
+
 	sect_stop=`_wallclock`
 	interrupt=false
 	_wrapup
-- 
2.17.0

