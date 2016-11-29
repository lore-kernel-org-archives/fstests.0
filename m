Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:33509 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752817AbcK2CsM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Nov 2016 21:48:12 -0500
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1cBYSn-0000H1-5j
        for fstests@vger.kernel.org; Tue, 29 Nov 2016 13:48:09 +1100
Received: from dave by discord.disaster.area with local (Exim 4.88)
        (envelope-from <david@fromorbit.com>)
        id 1cBYSn-00045S-4a
        for fstests@vger.kernel.org; Tue, 29 Nov 2016 13:48:09 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] check: add brief result summaries
Date: Tue, 29 Nov 2016 13:48:09 +1100
Message-Id: <20161129024809.15671-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

When running multiple sections and hundreds of tests in each config
section, it's hard to see what failed from the summary output
because of the hundreds of tests listed in the "tests run" and
"tests not run" output. Add a "-b" option for brief result summaries
that only output the tests that failed and the summary count of
tests failed.

Signed-Off-By: Dave Chinner <dchinner@redhat.com>
---
 check | 114 ++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/check b/check
index 69341d8c4f72..738621858b90 100755
--- a/check
+++ b/check
@@ -36,6 +36,7 @@ have_test_arg=false
 randomize=false
 export here=`pwd`
 xfile=""
+brief_test_summary=false
 
 DUMP_OUTPUT=false
 
@@ -71,6 +72,7 @@ check options
     -T			output timestamps
     -r			randomize test order
     -d			dump test output to stdout
+    -b			brief test summary
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
@@ -244,6 +246,7 @@ while [ $# -gt 0 ]; do
 
 	-T)	timestamp=true ;;
 	-d)	DUMP_OUTPUT=true ;;
+	-b)	brief_test_summary=true;;
 
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
@@ -319,71 +322,70 @@ _wipe_counters()
 
 _wrapup()
 {
-    seq="check"
-    check="$RESULT_BASE/check"
+	seq="check"
+	check="$RESULT_BASE/check"
 
-    if $showme
-    then
+	if $showme; then
 	:
-    elif $needwrap
-    then
-	if [ -f $check.time -a -f $tmp.time ]
-	then
-	    cat $check.time $tmp.time \
-	    | $AWK_PROG '
-	{ t[$1] = $2 }
-END	{ if (NR > 0) {
-	    for (i in t) print i " " t[i]
-	  }
-	}' \
-	    | sort -n >$tmp.out
-	    mv $tmp.out $check.time
-	fi
+	elif $needwrap; then
+		if [ -f $check.time -a -f $tmp.time ]; then
+			cat $check.time $tmp.time  \
+				| $AWK_PROG '
+				{ t[$1] = $2 }
+				END {
+					if (NR > 0) {
+						for (i in t) print i " " t[i]
+					}
+				}' \
+				| sort -n >$tmp.out
+			mv $tmp.out $check.time
+		fi
 
-	echo "" >>$check.log
-	date >>$check.log
+		echo "" >>$check.log
+		date >>$check.log
 
-	echo "SECTION       -- $section" >>$tmp.summary
-	echo "=========================" >>$tmp.summary
-        if [ ! -z "$n_try" -a $n_try != 0 ]
-	then
-	    echo "Ran:$try"
-	    echo "Ran:$try" >>$check.log
-	    echo "Ran:$try" >>$tmp.summary
-	fi
+		echo "SECTION       -- $section" >>$tmp.summary
+		echo "=========================" >>$tmp.summary
+		if [ ! -z "$n_try" -a $n_try != 0 ]; then
+			if [ $brief_test_summary == "false" ]; then
+				echo "Ran:$try"
+				echo "Ran:$try" >>$tmp.summary
+			fi
+			echo "Ran:$try" >>$check.log
+		fi
 
-	$interrupt && echo "Interrupted!" >>$check.log
+		$interrupt && echo "Interrupted!" >>$check.log
 
-	if [ ! -z "$notrun" ]
-	then
-	    echo "Not run:$notrun"
-	    echo "Not run:$notrun" >>$check.log
-	    echo "Not run:$notrun" >>$tmp.summary
+		if [ ! -z "$notrun" ]; then
+			if [ $brief_test_summary == "false" ]; then
+				echo "Not run:$notrun"
+				echo "Not run:$notrun" >>$tmp.summary
+			fi
+			echo "Not run:$notrun" >>$check.log
+		fi
+
+		if [ ! -z "$n_bad" -a $n_bad != 0 ]; then
+		    echo "Failures:$bad"
+		    echo "Failed $n_bad of $n_try tests"
+		    echo "Failures:$bad" >>$check.log
+		    echo "Failed $n_bad of $n_try tests" >>$check.log
+		    echo "Failures:$bad" >>$tmp.summary
+		    echo "Failed $n_bad of $n_try tests" >>$tmp.summary
+		else
+		    echo "Passed all $n_try tests"
+		    echo "Passed all $n_try tests" >>$check.log
+		    echo "Passed all $n_try tests" >>$tmp.summary
+		fi
+		echo "" >>$tmp.summary
+		needwrap=false
 	fi
 
-        if [ ! -z "$n_bad" -a $n_bad != 0 ]
-	then
-	    echo "Failures:$bad"
-	    echo "Failed $n_bad of $n_try tests"
-	    echo "Failures:$bad" >>$check.log
-	    echo "Failed $n_bad of $n_try tests" >>$check.log
-	    echo "Failures:$bad" >>$tmp.summary
-	    echo "Failed $n_bad of $n_try tests" >>$tmp.summary
-	else
-	    echo "Passed all $n_try tests"
-	    echo "Passed all $n_try tests" >>$check.log
-	    echo "Passed all $n_try tests" >>$tmp.summary
+	sum_bad=`expr $sum_bad + $n_bad`
+	_wipe_counters
+	rm -f /tmp/*.rawout /tmp/*.out /tmp/*.err /tmp/*.time
+	if ! $OPTIONS_HAVE_SECTIONS; then
+		rm -f $tmp.*
 	fi
-	echo "" >>$tmp.summary
-	needwrap=false
-    fi
-
-    sum_bad=`expr $sum_bad + $n_bad`
-    _wipe_counters
-    rm -f /tmp/*.rawout /tmp/*.out /tmp/*.err /tmp/*.time
-    if ! $OPTIONS_HAVE_SECTIONS; then
-        rm -f $tmp.*
-    fi
 }
 
 _summary()
-- 
2.10.2

