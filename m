Received: from mail-lf0-f49.google.com ([209.85.215.49]:36707 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdBUMoP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Feb 2017 07:44:15 -0500
Received: by mail-lf0-f49.google.com with SMTP id b80so26877537lfe.3
        for <fstests@vger.kernel.org>; Tue, 21 Feb 2017 04:44:14 -0800 (PST)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 2/2] report: Add xunit format report generator
Date: Tue, 21 Feb 2017 16:44:05 +0400
Message-Id: <1487681045-22884-4-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1487681045-22884-1-git-send-email-dmonakhov@openvz.org>
References: <1487681045-22884-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

xunit[1]/junit[2] are well known report formats for tests frameworks which
supported by most of test CI frameworks(such as Jenkins [3], Bamboo [4], Avocado [5])
Basically this is just xml document which can be easily parsed later by external tools.

changes since v1:
 - Use generic '-R fmt' option for report generation, asked by eguan@
 - localize variables, asked by eguan@
 - do not add empty files to report asked by eguan@
 - Add properties
 - Fix system-err/system-out node nesting

EXAMPLE:
#./check -R xunit -s ext4 generic/001 generic/010
#cat results/ext4/result.xml
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="xfstests" errors="0" skipped="1" tests="2" time="7"  hostname="alice" timestamp="2017-02-21T15:15:06"  >
	<properties>
		<property name="SECTION" value="ext4"/>
		<property name="FSTYP" value="ext4"/>
		<property name="MOUNT_OPTIONS" value="-o acl,user_xattr "/>
		<property name="HOST_OPTIONS" value="/devel/xfstests-dev.git/configs/alice.config"/>
		<property name="XFS_MKFS_OPTIONS" value="-bsize=4096"/>
		<property name="TIME_FACTOR" value="1"/>
		<property name="LOAD_FACTOR" value="1"/>
		<property name="TEST_DIR" value="/mnt/test"/>
		<property name="TEST_DEV" value="/dev/ram0"/>
		<property name="SCRATCH_DEV" value="/dev/ram1"/>
		<property name="SCRATCH_MNT" value="/mnt/scratch"/>
		<property name="OVERLAY_UPPER_DIR" value="upper"/>
		<property name="OVERLAY_LOWER_DIR" value="lower"/>
		<property name="OVERLAY_WORK_DIR" value="work"/>
	</properties>
	<testcase classname="xfstests.ext4" name="generic/001" time="5">
	</testcase>
	<testcase classname="xfstests.ext4" name="generic/010" time="1">
		<skipped message="src/dbtest not built" />
	</testcase>
</testsuite>

Footnotes:
[1] https://xunit.github.io/docs/format-xml-v2.html
[2] http://help.catchsoftware.com/display/ET/JUnit+Format
[3] https://jenkins.io
[4] https://www.atlassian.com/software/bamboo
[5] https://github.com/avocado-framework/avocado

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 check         |  38 +++++++++++---
 common/rc     |   5 +-
 common/report | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+), 9 deletions(-)
 create mode 100644 common/report

diff --git a/check b/check
index 8ee2f6f..bd2d763 100755
--- a/check
+++ b/check
@@ -39,7 +39,7 @@ export here=`pwd`
 xfile=""
 brief_test_summary=false
 err_msg=""
-
+do_report=false
 DUMP_OUTPUT=false
 
 # start the initialisation work now
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
+    -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
@@ -295,7 +296,10 @@ while [ $# -gt 0 ]; do
 	-T)	timestamp=true ;;
 	-d)	DUMP_OUTPUT=true ;;
 	-b)	brief_test_summary=true;;
-
+	-R)	report_fmt=$2 ; shift ;
+		REPORT_LIST="$REPORT_LIST ${report_fmt//,/ }"
+		do_report=true
+		;;
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
 
@@ -380,7 +384,12 @@ _wrapup()
 	check="$RESULT_BASE/check"
 
 	if $showme; then
-	:
+		if $needwrap; then
+			if $do_report; then
+				_make_section_report
+			fi
+			needwrap=false
+		fi
 	elif $needwrap; then
 		if [ -f $check.time -a -f $tmp.time ]; then
 			cat $check.time $tmp.time  \
@@ -431,6 +440,9 @@ _wrapup()
 			echo "Passed all $n_try tests" >>$tmp.summary
 		fi
 		echo "" >>$tmp.summary
+		if $do_report; then
+			_make_section_report
+		fi
 		needwrap=false
 	fi
 
@@ -519,6 +531,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		echo "SECTION       -- $section"
 	fi
 
+	sect_start=`_wallclock`
 	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
 		echo "RECREATING    -- $FSTYP on $TEST_DEV"
 		_test_unmount 2> /dev/null
@@ -623,11 +636,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	    group=`dirname $seq`
 	    if $OPTIONS_HAVE_SECTIONS; then
 		export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;${RESULT_BASE}/$section;"`
-		seqres="$RESULT_BASE/$section/$seqnum"
+		REPORT_DIR="$RESULT_BASE/$section"
 	    else
 		export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;$RESULT_BASE;"`
-		seqres="$RESULT_BASE/$seqnum"
+		REPORT_DIR="$RESULT_BASE"
 	    fi
+	    seqres="$REPORT_DIR/$seqnum"
 
 	    mkdir -p $RESULT_DIR
 
@@ -638,9 +652,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		start=0
 		stop=0
 		n_notrun=`expr $n_notrun + 1`
+		if $do_report; then
+			_make_testcase_report "list"
+		fi
 		continue
 	    fi
-
+	    tc_status="pass"
 	    if [ ! -f $seq ]; then
 		echo " - no such test?"
 	    else
@@ -704,6 +721,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		    cat $seqres.notrun
 		    notrun="$notrun $seqnum"
 		    n_notrun=`expr $n_notrun + 1`
+		    tc_status="notrun"
 		else
 		    if [ $sts -ne 0 ]
 		    then
@@ -762,10 +780,14 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		bad="$bad $seqnum"
 		n_bad=`expr $n_bad + 1`
 		quick=false
+		tc_status="fail"
+	    fi
+	    if $do_report; then
+		_make_testcase_report "$tc_status"
 	    fi
-
 	    seq="after_$seqnum"
 	done
+	sect_stop=`_wallclock`
 	_wrapup
 	echo
 
diff --git a/common/rc b/common/rc
index ec9b2a0..6ac8ea3 100644
--- a/common/rc
+++ b/common/rc
@@ -155,6 +155,10 @@ case "$FSTYP" in
 	 ;;
 esac
 
+if [ ! -z "$REPORT_LIST" ]; then
+   . ./common/report
+fi
+
 _mount()
 {
     $MOUNT_PROG `_mount_ops_filter $*`
@@ -3297,7 +3301,6 @@ _get_fs_sysfs_attr()
 }
 
 
-
 init_rc
 
 ################################################################################
diff --git a/common/report b/common/report
new file mode 100644
index 0000000..1a1eadd
--- /dev/null
+++ b/common/report
@@ -0,0 +1,161 @@
+#
+# Reports generator funcitons lives here
+#
+
+# List of xfstests's enviroment variables to include reports
+## TODO automate list population inside common/conf
+REPORT_ENV_LIST="$REPORT_ENV_LIST SECTION"
+REPORT_ENV_LIST="$REPORT_ENV_LIST FSTYP"
+REPORT_ENV_LIST="$REPORT_ENV_LIST PLATFORM"
+REPORT_ENV_LIST="$REPORT_ENV_LIST MKFS_OPTIONS"
+REPORT_ENV_LIST="$REPORT_ENV_LIST MOUNT_OPTIONS"
+
+REPORT_ENV_LIST="$REPORT_ENV_LIST HOST_OPTIONS"
+REPORT_ENV_LIST="$REPORT_ENV_LIST CHECK_OPTIONS"
+REPORT_ENV_LIST="$REPORT_ENV_LIST XFS_MKFS_OPTIONS"
+REPORT_ENV_LIST="$REPORT_ENV_LIST TIME_FACTOR"
+REPORT_ENV_LIST="$REPORT_ENV_LIST LOAD_FACTOR"
+
+REPORT_ENV_LIST="$REPORT_ENV_LIST TEST_DIR"
+REPORT_ENV_LIST="$REPORT_ENV_LIST TEST_DEV"
+REPORT_ENV_LIST="$REPORT_ENV_LIST SCRATCH_DEV"
+REPORT_ENV_LIST="$REPORT_ENV_LIST SCRATCH_MNT"
+
+REPORT_ENV_LIST="$REPORT_ENV_LIST OVERLAY_UPPER_DIR"
+REPORT_ENV_LIST="$REPORT_ENV_LIST OVERLAY_LOWER_DIR"
+REPORT_ENV_LIST="$REPORT_ENV_LIST OVERLAY_WORK_DIR"
+
+#
+# Xunit format report functions
+_xunit_add_property()
+{
+    local name="$1"
+    local value="${!name}"
+
+    if [ ! -z "$value" ]; then
+	echo -e "\t\t<property name=\"$name\" value=\"$value\"/>" >> $REPORT_DIR/result.xml
+    fi
+}
+_xunit_make_section_report()
+{
+	# xfstest:section ==> xunit:testsuite
+	local sect_name=$section
+	local sect_time=`expr $sect_stop - $sect_start`
+	local n_total=`expr $n_try + $n_notrun`
+
+	if [ $sect_name == '-no-sections-' ]; then
+	    sect_name='global'
+	fi
+	local report=$tmp.report.xunit.$sect_name.xml
+	#Header
+	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $REPORT_DIR/result.xml
+	local dtime=`echo $date_time| tr  " " 'T'`
+	local stats="errors=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\""
+	local hw_info="hostname=\"$HOST\" timestamp=\"$dtime\" "
+	echo "<testsuite name=\"xfstests\" $stats  $hw_info >" >> $REPORT_DIR/result.xml
+	#Properties
+
+	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
+	for p in $REPORT_ENV_LIST;do
+	    _xunit_add_property "$p"
+	done
+	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
+	cat $tmp.report.xunit.$sect_name.xml >> $REPORT_DIR/result.xml
+	echo "</testsuite>" >> $REPORT_DIR/result.xml
+	echo "Xunit report: $REPORT_DIR/result.xml"
+}
+
+_xunit_make_testcase_report()
+{
+	local test_status="$1"
+	local test_time=`expr $stop - $start`
+	local strip="$SRC_DIR/"
+	local test_name=${seq#$strip}
+	local sect_name=$section
+
+	#TODO: other places may also win if no-section mode will be named like 'default/global'
+	if [ $sect_name == '-no-sections-' ]; then
+		sect_name='global'
+
+	fi
+	local report=$tmp.report.xunit.$sect_name.xml
+
+	echo -e "\t<testcase classname=\"xfstests.$sect_name\" name=\"$test_name\" time=\"$test_time\">" >> $report
+	case $test_status in
+		"pass")
+			;;
+		"notrun")
+			if [ -f $seqres.notrun ]; then
+			    local msg=`cat $seqres.notrun`
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
+			echo -e "\t\t<failure message=\"$err_msg\" type=\"TestFail\" />" >> $report
+			if [ -s $seqres.full ]; then
+			    echo -e "\t\t<system-out>" >> $report
+			    printf  '<![CDATA[\n' >>$report
+			    cat $seqres.full | tr -dc '[:print:][:space:]' >>$report
+			    printf ']]>\n'  >>$report
+			    echo -e "\t\t</system-out>" >> $report
+			fi
+			if [ -f $seqres.dmesg ]; then
+			    echo -e "\t\t<system-err>" >> $report
+			    printf  '<![CDATA[\n' >>$report
+			    cat $seqres.dmesg | tr -dc '[:print:][:space:]' >>$report
+			    printf ']]>\n'  >>$report
+			    echo -e "\t\t</system-err>" >> $report
+			elif [ -s $seqres.out.bad ]; then
+			    echo -e "\t\t<system-err>" >> $report
+			    printf  '<![CDATA[\n' >>$report
+			    $diff $seq.out $seqres.out.bad >>$report
+			    printf ']]>\n'  >>$report
+			    echo -e "\t\t</system-err>" >> $report
+			fi
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
+	for report in $REPORT_LIST; do
+		case "$report" in
+			"xunit")
+				_xunit_make_section_report "$test_status"
+				;;
+			*)
+				_fatal "report format '$report' is not supported"
+				;;
+		esac
+	done
+}
+
+_make_testcase_report()
+{
+	test_status="$1"
+	for report in $REPORT_LIST; do
+		case "$report" in
+			"xunit")
+				_xunit_make_testcase_report "$test_status"
+				;;
+			*)
+				_fatal "report format '$report' is not supported"
+				;;
+		esac
+	done
+}
-- 
2.9.3

