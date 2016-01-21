Received: from mx1.redhat.com ([209.132.183.28]:33576 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547AbcAUE3z (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jan 2016 23:29:55 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id A40FF461E2
	for <fstests@vger.kernel.org>; Thu, 21 Jan 2016 04:29:55 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [RFC PATCH] fstests: add known issue support
Date: Thu, 21 Jan 2016 12:29:30 +0800
Message-Id: <1453350570-25862-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add known issue support so it's easier to know if a failure is a known
issue or a new one (and potential regression), and mark the whole test
as failure (check returns non-zero) only when there're unknown failures.

A new $KNOWNISSUE_DIR dir is introduced (default to `pwd`/knownissue),
and common known issues across filesystems/arches/configs can be listed
in $KNOWNISSUE_DIR/generic and $KNOWNISSUE_DIR/$FSTYP, they are the
default known issue files.

When testing with section in config, an additional section-specific
known issue file is processed, $KNOWNISSUE_DIR/$section_name, all known
failures for this specific config can be listed here.

A new "-k" option to check is added, it's used to specify user-provided
known issue file rather than the default files. When "-k" is used, only
the known issues in this file are processed, $KNOWNISSUE_DIR/{generic,
$FSTYP, $section_name} are ignored.

The format of the known issue file is:
 # comments are starting with '#'
 # first column is test name
 # second column indicates if the test should be skipped, yes to skip
 # the third column is the note about this failure
 # test name	skip?	comments
 generic/001	no	triggers WARNING ...
 generic/002	yes	crash kernel, skip, patch xxx should fix it
 ...

After test, test summary is printed, e.g.

	Ran: ext4/005 generic/001 generic/018
	Failures: ext4/005 generic/018
	Failed 2 of 3 tests
	Known failures: ext4/005
	1 of 2 failed tests are known failures
	Unknown failures: generic/018
	1 of 2 failed tests are unknown failures

Examples:
 # run specific section with user provided known issue file
 ./check -g auto -s ext4_1k_data_journal -k /path/to/known_issue_file

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 check         | 179 ++++++++++++++++++++++++++++++++++++++++------------------
 common/config |   4 ++
 2 files changed, 127 insertions(+), 56 deletions(-)

diff --git a/check b/check
index 135a9fb..dc91580 100755
--- a/check
+++ b/check
@@ -29,6 +29,10 @@ n_bad=0
 sum_bad=0
 bad=""
 notrun=""
+n_knownbad=0
+knownbad=""
+n_unknownbad=0
+unknownbad=""
 interrupt=true
 diff="diff -u"
 showme=false
@@ -73,6 +77,7 @@ check options
     -d			dump test output to stdout
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
+    -k file		use this known issue file other than the default one
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -134,6 +139,34 @@ trim_test_list()
 	mv $tmp.tmp $tmp.list
 }
 
+# save tests in known issue file that should be skipped in $tmp.xlist
+get_skip_test_list()
+{
+	$AWK_PROG '{if ($2 == "yes") print $1}' $1 | grep -v "^#" >>$tmp.xlist
+}
+
+# save all tests in known issue file in $tmp.knownissue
+get_knownissue_list()
+{
+	$AWK_PROG '{print $1}' $1 | grep -v "^#" >>$tmp.knownissue
+}
+
+# check if the given test is a known issue
+is_knownissue()
+{
+	grep -qF $1 $tmp.knownissue 2>/dev/null
+}
+
+process_knownissue()
+{
+	for file in $*; do
+		if [ ! -s $file ]; then
+			continue
+		fi
+		get_knownissue_list $file
+		get_skip_test_list $file
+	done
+}
 
 _wallclock()
 {
@@ -228,6 +261,7 @@ while [ $# -gt 0 ]; do
 	        fi
 		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
+	-k)	KNOWNISSUE_FILE="$2"; shift ;;
 	-l)	diff="diff" ;;
 	-udiff)	diff="$diff -u" ;;
 
@@ -262,6 +296,17 @@ if ! . ./common/config; then
 	exit 1
 fi
 
+# process known issue file to
+# 1. get all known issues
+# 2. get tests need to be skipped from known issue list
+if [ -n "$KNOWNISSUE_FILE" ]; then
+	# have user specified known issue file
+	process_knownissue $KNOWNISSUE_FILE
+else
+	# no user specified known issue file, use the default files
+	process_knownissue $KNOWNISSUE_DIR/generic $KNOWNISSUE_BASE/$FSTYP
+fi
+
 # Process tests from command line now.
 if $have_test_arg; then
 	while [ $# -gt 0 ]; do
@@ -304,77 +349,88 @@ fi
 
 _wipe_counters()
 {
-	n_try="0"
-	n_bad="0"
-	unset try notrun bad
+	n_try=0
+	n_bad=0
+	n_knownbad=0
+	n_unknownbad=0
+	unset try notrun bad knownbad unknownbad
+}
+
+_log()
+{
+	echo -e "$@"
+	echo -e "$@" | fmt >>$check.log
+	echo -e "$@" >>$tmp.summary
 }
 
 _wrapup()
 {
-    seq="check"
-    check="$RESULT_BASE/check"
-
-    if $showme
-    then
-	:
-    elif $needwrap
-    then
-	if [ -f $check.time -a -f $tmp.time ]
-	then
-	    cat $check.time $tmp.time \
-	    | $AWK_PROG '
+	seq="check"
+	check="$RESULT_BASE/check"
+
+	if $showme; then
+		:
+	elif $needwrap; then
+		if [ -f $check.time -a -f $tmp.time ]; then
+			cat $check.time $tmp.time | $AWK_PROG '
 	{ t[$1] = $2 }
 END	{ if (NR > 0) {
 	    for (i in t) print i " " t[i]
 	  }
 	}' \
-	    | sort -n >$tmp.out
-	    mv $tmp.out $check.time
-	fi
+			| sort -n >$tmp.out
+			mv $tmp.out $check.time
+		fi
 
-	echo "" >>$check.log
-	date >>$check.log
-	echo $list | fmt | sed -e 's/^/    /' -e "s;$SRC_DIR/;;g" >>$check.log
-	$interrupt && echo "Interrupted!" >>$check.log
+		echo "" >>$check.log
+		date >>$check.log
+		echo $list | fmt | sed -e 's/^/    /' -e "s;$SRC_DIR/;;g" >>$check.log
+		$interrupt && echo "Interrupted!" >>$check.log
 
-	echo "SECTION       -- $section" >>$tmp.summary
-	echo "=========================" >>$tmp.summary
-        if [ ! -z "$n_try" -a $n_try != 0 ]
-	then
-	    echo "Ran:$try"
-	    echo "Ran:$try" >>$tmp.summary
-	fi
+		echo "SECTION       -- $section" >>$tmp.summary
+		echo "=========================" >>$tmp.summary
+		if [ ! -z "$n_try" -a $n_try != 0 ]; then
+			echo "Ran:$try"
+			echo "Ran:$try" >>$tmp.summary
+		fi
 
-	if [ ! -z "$notrun" ]
-	then
-	    echo "Not run:$notrun"
-	    echo "Not run:$notrun" >>$check.log
-	    echo "Not run:$notrun" >>$tmp.summary
+		if [ ! -z "$notrun" ]; then
+			_log "Not run:$notrun"
+		fi
+
+		if [ ! -z "$n_bad" -a $n_bad != 0 ]; then
+			for t in $bad; do
+				if is_knownissue $t; then
+					knownbad="$knownbad $t"
+					n_knownbad=`expr $n_knownbad + 1`
+				else
+					unknownbad="$unknownbad $t"
+					n_unknownbad=`expr $n_unknownbad + 1`
+				fi
+			done
+			_log "Failures:$bad"
+			_log "Failed $n_bad of $n_try tests"
+			if [ ! -z "$n_knownbad" -a $n_knownbad != 0 ]; then
+				_log "Known failures:$knownbad"
+				_log "$n_knownbad of $n_bad failed tests are known failures"
+			fi
+			if [ ! -z "$n_unknownbad" -a $n_unknownbad != 0 ]; then
+				_log "Unknown failures:$unknownbad"
+				_log "$n_unknownbad of $n_bad failed tests are unknown failures"
+			fi
+		else
+			_log "Passed all $n_try tests"
+		fi
+		echo "" >>$tmp.summary
+		needwrap=false
 	fi
 
-        if [ ! -z "$n_bad" -a $n_bad != 0 ]
-	then
-	    echo "Failures:$bad"
-	    echo "Failed $n_bad of $n_try tests"
-	    echo "Failures:$bad" | fmt >>$check.log
-	    echo "Failed $n_bad of $n_try tests" >>$check.log
-	    echo "Failures:$bad" >>$tmp.summary
-	    echo "Failed $n_bad of $n_try tests" >>$tmp.summary
-	else
-	    echo "Passed all $n_try tests"
-	    echo "Passed all $n_try tests" >>$check.log
-	    echo "Passed all $n_try tests" >>$tmp.summary
+	sum_bad=`expr $sum_bad + $n_unknownbad`
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
@@ -434,9 +490,20 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		status=1
 		exit
 	fi
+	mkdir -p $KNOWNISSUE_DIR
+	if [ ! -d $KNOWNISSUE_DIR ]; then
+		echo "failed to create known issue directory $KNOWNISSUE_DIR"
+		status=1
+		exit
+	fi
 
 	if $OPTIONS_HAVE_SECTIONS; then
 		echo "SECTION       -- $section"
+		# process section-specific known issue file
+		# if no known issue file is specified in command line
+		if [ -z "$KNOWNISSUE_FILE" ]; then
+			process_knownissue $KNOWNISSUE_DIR/$section
+		fi
 	fi
 
 	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
diff --git a/common/config b/common/config
index 079e831..ff2b37a 100644
--- a/common/config
+++ b/common/config
@@ -485,6 +485,10 @@ get_next_config() {
 	if [ -z "$RESULT_BASE" ]; then
 		export RESULT_BASE="$here/results/"
 	fi
+	# set default KNOWNISSUE_DIR
+	if [ -z "$KNOWNISSUE_DIR" ]; then
+		export KNOWNISSUE_DIR="$here/knownissue"
+	fi
 
 	#  Mandatory Config values.
 	MC=""
-- 
2.5.0

