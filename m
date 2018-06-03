Received: from mail-pl0-f68.google.com ([209.85.160.68]:41482 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeFCNM7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Jun 2018 09:12:59 -0400
Received: by mail-pl0-f68.google.com with SMTP id az12-v6so17991693plb.8
        for <fstests@vger.kernel.org>; Sun, 03 Jun 2018 06:12:59 -0700 (PDT)
Date: Sun, 3 Jun 2018 21:12:51 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH V3] check: fail tests if check/dmesg are not clean
Message-ID: <20180603131251.GI6581@desktop>
References: <20180528230737.25270-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528230737.25270-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 29, 2018 at 09:07:37AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Currently a test appears to pass even if it leaves a corrupt
> filesystem behind, or a splat in the system logs that should not be
> there. While the test is internally tracked as failed (and the
> summary reports it as failed) the per-test output exits with a
> success and so emits a completion time before the post-test checks
> are run by the test harness.  Rework the check code to report
> post-test check failures as specific test failures rather than as
> separate failure line items in the overall harness output.
> 
> Reworking where we emit the errors this also allows us to include
> the post-test filesystem checking in the test runtime. This is
> currently not accounted to the test and can be substantial. Hence
> the real elapsed time of each test is not accurately reflected in
> the time stats being reported and so regressions in filesystem
> checking performance go unnoticed.
> 
> Changing the output reporting requires a complete reworking of the
> main test check loop. It's a bunch of spaghetti at the moment
> because it has post test reporting code at the end of the loop which
> must run regardless of the test result.  By moving the post test
> reporting to the start of the next loop iteration, we can clean up
> the code substantially by using continue directives where
> appropriate.
> 
> Also, for cases where we haven't run the test or it's already been
> marked as failed, don't bother running the filesystem/dmesg checks
> for failure as we're already going to report the test as failed.
> 
> This touches almost all of the loop, so get rid of the remaining
> 4 space indents inside the loop while moving all this code around.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>

I hit some other errors when testing the xUnit report result, please see
below. (Sorry for not finding it in previous review..)

> ---
>  check     | 260 +++++++++++++++++++++++++++++-------------------------
>  common/rc |   6 ++
>  2 files changed, 144 insertions(+), 122 deletions(-)
> 
> diff --git a/check b/check
> index f6fb352bcbb9..0cdf95e9f5e7 100755
> --- a/check
> +++ b/check
> @@ -38,10 +38,12 @@ randomize=false
>  export here=`pwd`
>  xfile=""
>  brief_test_summary=false
> -_err_msg=""
>  do_report=false
>  DUMP_OUTPUT=false
>  
> +# This is a global variable used to pass test failure text to reporting gunk
> +_err_msg=""
> +
>  # start the initialisation work now
>  iam=check
>  
> @@ -643,78 +645,97 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	seqres="$check"
>  	_check_test_fs
>  
> -	for seq in $list
> -	do
> -	    err=false
> -	    _err_msg=""
> -	    if [ ! -f $seq ]; then
> -	        # Try to get full name in case the user supplied only seq id
> -	        # and the test has a name. A bit of hassle to find really
> -	        # the test and not its sample output or helping files.
> -	        bname=$(basename $seq)
> -	        full_seq=$(find $(dirname $seq) -name $bname* -executable |
> -	            awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
> -	                END { print shortest }')
> -	        if [ -f $full_seq ] \
> -	            && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
> -	            seq=$full_seq
> -	        fi
> -	    fi
> +	err=false
> +	first_test=true
> +	for seq in $list ; do
> +		# Run report for previous test!
> +		if $err ; then
> +			bad="$bad $seqnum"
> +			n_bad=`expr $n_bad + 1`
> +			tc_status="fail"
> +		fi
> +		if $do_report && ! $first_test ; then
> +			if [ $tc_status != "expunge" ] ; then
> +				_make_testcase_report "$tc_status"
> +			fi

This report is based on $seq variable, so when the test is _notrun (thus
"continue" in the for loop), it's reporting the wrong test seq name, it
should report the previous test seq not current. I saw reports like:

        <testcase classname="xfstests.xfs_4k_reflink" name="generic/403" time="1">
                <skipped message="no kernel support for y2038 sysfs switch" />
        </testcase>
        <testcase classname="xfstests.xfs_4k_reflink" name="generic/403" time="2">

Note that both results reported test name as "generic/403", but the
first one should really be "generic/402".

I appended a fix patch in the end, if it looks fine I can fold the fix
into this patch.

...
<snip>
...
> +	if $do_report -a ! $first_test -a $tc_status != "expunge" ; then
>  		_make_testcase_report "$tc_status"
> -	    fi
> -	    seq="after_$seqnum"
> -	done
> +	fi
> +

This if check should be fixed too as above one.

Thanks,
Eryu


diff --git a/check b/check
index 24f1e2bb583e..e1c266c11866 100755
--- a/check
+++ b/check
@@ -649,12 +649,13 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		fi
 		if $do_report && ! $first_test ; then
 			if [ $tc_status != "expunge" ] ; then
-				_make_testcase_report "$tc_status"
+				_make_testcase_report "$prev_seq" "$tc_status"
 			fi
 		fi
 		first_test=false
 
 		err=false
+		prev_seq="$seq"
 		if [ ! -f $seq ]; then
 			# Try to get full name in case the user supplied only
 			# seq id and the test has a name. A bit of hassle to
@@ -825,8 +826,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		n_bad=`expr $n_bad + 1`
 		tc_status="fail"
 	fi
-	if $do_report -a ! $first_test -a $tc_status != "expunge" ; then
-		_make_testcase_report "$tc_status"
+	if $do_report && ! $first_test ; then
+		if [ $tc_status != "expunge" ] ; then
+			_make_testcase_report "$prev_seq" "$tc_status"
+		fi
 	fi
 
 	sect_stop=`_wallclock`
diff --git a/common/report b/common/report
index a62d343e5216..fb00b402cffc 100644
--- a/common/report
+++ b/common/report
@@ -77,10 +77,11 @@ _xunit_make_section_report()
 
 _xunit_make_testcase_report()
 {
-	local test_status="$1"
+	local test_seq="$1"
+	local test_status="$2"
 	local test_time=`expr $stop - $start`
 	local strip="$SRC_DIR/"
-	local test_name=${seq#$strip}
+	local test_name=${test_seq#$strip}
 	local sect_name=$section
 
 	# TODO: other places may also win if no-section mode will be named like 'default/global'
@@ -126,13 +127,13 @@ _xunit_make_testcase_report()
 		elif [ -s $seqres.out.bad ]; then
 			echo -e "\t\t<system-err>" >> $report
 			printf	'<![CDATA[\n' >>$report
-			$diff $seq.out $seqres.out.bad | encode_xml >>$report
+			$diff $test_seq.out $seqres.out.bad | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-err>" >> $report
 		fi
 		;;
 	*)
-		echo -e "\t\t<failure message=\"Unknown ret_state=$ret_state\" type=\"TestFail\"/>" >> $report
+		echo -e "\t\t<failure message=\"Unknown test_status=$test_status\" type=\"TestFail\"/>" >> $report
 		;;
 	esac
 	echo -e "\t</testcase>" >> $report
@@ -157,11 +158,12 @@ _make_section_report()
 
 _make_testcase_report()
 {
-	test_status="$1"
+	local test_seq="$1"
+	local test_status="$2"
 	for report in $REPORT_LIST; do
 		case "$report" in
 		"xunit")
-			_xunit_make_testcase_report "$test_status"
+			_xunit_make_testcase_report "$test_seq" "$test_status"
 			;;
 		*)
 			_dump_err "report format '$report' is not supported"
