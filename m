Received: from mail-lf0-f44.google.com ([209.85.215.44]:33506 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdAaRn0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2017 12:43:26 -0500
Received: by mail-lf0-f44.google.com with SMTP id x1so128645485lff.0
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2017 09:43:25 -0800 (PST)
From: Dmitry Monakhov <dmongw@gmail.com>
Subject: [PATCH 2/2] report: Add xunit format report generator
Date: Tue, 31 Jan 2017 21:43:21 +0400
Message-Id: <1485884601-21651-3-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1485884601-21651-1-git-send-email-dmonakhov@openvz.org>
References: <1485884601-21651-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

xunit[1]/junit[2] are well known report formats for tests frameworks which
supported by most of test CI frameworks(such as Jenkins [3], Bamboo [4], Avocado [5])
Basically this is just xml document which can be easily parsed later by external tools.

EXAMPLE:
#./check --xunit -s ext4 generic/001 generic/010 generic/013
#cat results/ext4/result.xml
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="xfstests" errors="0" skipped="1" tests="3" time="12" timestamp="2017-01-31 18:24:06" >
	<testcase classname="ext4" name="generic/001" time="6">
	</testcase>
	<testcase classname="ext4" name="generic/010" time="0">
		<skipped message="src/dbtest not built" />
	</testcase>
	<testcase classname="ext4" name="generic/013" time="3">
	</testcase>
</testsuite>

Footnotes:
[1] https://xunit.github.io/docs/format-xml-v2.html
[2] http://help.catchsoftware.com/display/ET/JUnit+Format
[3] jenkins.io
[4] https://www.atlassian.com/software/bamboo
[5] https://github.com/avocado-framework/avocado

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 check         |  22 +++++++++---
 common/rc     |   3 ++
 common/report | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 5 deletions(-)
 create mode 100644 common/report

diff --git a/check b/check
index edc0899..1442b6c 100755
--- a/check
+++ b/check
@@ -54,7 +54,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
 
-rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist
+rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
 
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
@@ -75,6 +75,7 @@ check options
     -r			randomize test order
     -d			dump test output to stdout
     -b			brief test summary
+    --xunit		generate summary in xunit format
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
@@ -296,6 +297,7 @@ while [ $# -gt 0 ]; do
 	-d)	DUMP_OUTPUT=true ;;
 	-b)	brief_test_summary=true;;
 
+	--xunit) REPORT_XUNIT=yes; DO_REPORT=yes ;;
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
 
@@ -380,7 +382,10 @@ _wrapup()
 	check="$RESULT_BASE/check"
 
 	if $showme; then
-	:
+		if $needwrap; then
+			_make_section_report
+			needwrap=false
+		fi
 	elif $needwrap; then
 		if [ -f $check.time -a -f $tmp.time ]; then
 			cat $check.time $tmp.time  \
@@ -431,9 +436,9 @@ _wrapup()
 			echo "Passed all $n_try tests" >>$tmp.summary
 		fi
 		echo "" >>$tmp.summary
+		_make_section_report
 		needwrap=false
 	fi
-
 	sum_bad=`expr $sum_bad + $n_bad`
 	_wipe_counters
 	rm -f /tmp/*.rawout /tmp/*.out /tmp/*.err /tmp/*.time
@@ -519,6 +524,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		echo "SECTION       -- $section"
 	fi
 
+	sect_start=`_wallclock`
 	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
 		echo "RECREATING    -- $FSTYP on $TEST_DEV"
 		_test_unmount 2> /dev/null
@@ -624,9 +630,11 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	    if $OPTIONS_HAVE_SECTIONS; then
 		export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;${RESULT_BASE}/$section;"`
 		seqres="$RESULT_BASE/$section/$seqnum"
+		sectdir_res="$RESULT_BASE/$section"
 	    else
 		export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;$RESULT_BASE;"`
 		seqres="$RESULT_BASE/$seqnum"
+		sectdir_res="$RESULT_BASE"
 	    fi
 
 	    mkdir -p $RESULT_DIR
@@ -638,9 +646,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		start=0
 		stop=0
 		n_notrun=`expr $n_notrun + 1`
+		_make_testcase_report "list"
 		continue
 	    fi
-
+	    tc_status="pass"
 	    if [ ! -f $seq ]; then
 		echo " - no such test?"
 	    else
@@ -704,6 +713,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		    cat $seqres.notrun
 		    notrun="$notrun $seqnum"
 		    n_notrun=`expr $n_notrun + 1`
+		    tc_status="notrun"
 		else
 		    if [ $sts -ne 0 ]
 		    then
@@ -763,10 +773,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		bad="$bad $seqnum"
 		n_bad=`expr $n_bad + 1`
 		quick=false
+		tc_status="fail"
 	    fi
-
+	    _make_testcase_report "$tc_status"
 	    seq="after_$seqnum"
 	done
+	sect_stop=`_wallclock`
 	_wrapup
 	echo
 
diff --git a/common/rc b/common/rc
index f97b4d2..9f1a068 100644
--- a/common/rc
+++ b/common/rc
@@ -3246,6 +3246,9 @@ _get_fs_sysfs_attr()
 }
 
 
+if [ ! -z "$DO_REPORT" ]; then
+   . ./common/report
+fi
 
 init_rc
 
diff --git a/common/report b/common/report
new file mode 100644
index 0000000..05496c5
--- /dev/null
+++ b/common/report
@@ -0,0 +1,108 @@
+#
+# Reports generator funcitons lives here
+#
+
+
+#
+# Xunit format report functions
+_xunit_make_section_report()
+{
+	# section ==> testsuite
+	#<?xml version="1.0" encoding="UTF-8"?>
+	#<testsuite errors="0" failures="1" name="avocado" skipped="1" tests="3" time="0.0942118167877" timestamp="2017-01-30 21:43:42.117398">
+	sect_name=$section
+	sect_time=`expr $sect_stop - $sect_start`
+
+	if [ $sect_name == '-no-sections-' ]; then
+	    sect_name='global'
+	fi
+	report=$tmp.report.xunit.$sect_name.xml
+
+	n_total=`expr $n_try + $n_notrun`
+	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $sectdir_res/result.xml
+	stats="errors=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\" timestamp=\"$date_time\""
+	echo "<testsuite name=\"xfstests\" $stats >" >> $sectdir_res/result.xml
+	cat $tmp.report.xunit.$sect_name.xml >> $sectdir_res/result.xml
+	echo "</testsuite>" >> $sectdir_res/result.xml
+	echo "Xunit report: $sectdir_res/result.xml"
+}
+
+_xunit_make_testcase_report()
+{
+	test_status="$1"
+	test_time=`expr $stop - $start`
+	sect_name=$section
+
+	#TODO: other places may also win if no-section mode will be named like 'default/global'
+	if [ $sect_name == '-no-sections-' ]; then
+		sect_name='global'
+	fi
+	report=$tmp.report.xunit.$sect_name.xml
+	strip="$SRC_DIR/"
+	test_name=${seq#$strip}
+	echo -e "\t<testcase classname=\"$sect_name\" name=\"$test_name\" time=\"$test_time\">" >> $report
+	case $test_status in
+		"pass")
+		;;
+		"notrun")
+			if [ -f $seqres.notrun ]; then
+			    msg=`cat $seqres.notrun`
+			    echo -e "\t\t<skipped message=\"$msg\" />" >> $report
+			else
+				echo -e "\t\t<skipped/>" >> $report
+			fi
+			;;
+		"list")
+			echo -e "\t\t<skipped/>" >> $report
+			;;
+		"fail")
+			if [ -z "$err_msg" ]; then
+			    err_msg="Test $sequm failed, reason unknown"
+			fi
+			echo -e "\t\t<failure message=\"$err_msg\" type=\"TestFail\">" >> $report
+			if [ -f $seqres.full ]; then
+			    echo -e "\t\t\t<system-out>" >> $report
+			    printf  '<![CDATA[\n' >>$report
+			    cat $seqres.full | tr -dc '[:print:][:space:]' >>$report
+			    printf ']]>\n'  >>$report
+			    echo -e "\t\t\t</system-out>" >> $report
+			fi
+			if [ -f $seqres.dmesg ]; then
+			    echo -e "\t\t\t<system-err>" >> $report
+			    printf  '<![CDATA[\n' >>$report
+			    cat $seqres.dmesg | tr -dc '[:print:][:space:]' >>$report
+			    printf ']]>\n'  >>$report
+			    echo -e "\t\t\t</system-err>" >> $report
+			elif [ -f $seqres.out.bad ]; then
+			    echo -e "\t\t\t<system-err>" >> $report
+			    printf  '<![CDATA[\n' >>$report
+			    $diff $seq.out $seqres.out.bad >>$report
+			    printf ']]>\n'  >>$report
+			    echo -e "\t\t\t</system-err>" >> $report
+			fi
+			echo -e "\t\t</failure>" >> $report
+			;;
+		*)
+			echo -e "\t\t<failure message=\"Unknown ret_state=$ret_state\" type=\"TestFail\"/>" >> $report
+			;;
+	esac
+	echo -e "\t</testcase>" >> $report
+}
+
+
+#
+#  Common report generator entry points
+_make_section_report()
+{
+	if [ ! -z "$REPORT_XUNIT" ]; then
+	    _xunit_make_section_report
+	fi
+}
+
+_make_testcase_report()
+{
+	test_status="$1"
+	if [ ! -z "$REPORT_XUNIT" ]; then
+	    _xunit_make_testcase_report "$test_status"
+	fi
+}
-- 
2.9.3

