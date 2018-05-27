Received: from mail-pg0-f67.google.com ([74.125.83.67]:36380 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936343AbeE0Mt3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 May 2018 08:49:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id u7-v6so4153651pgp.3
        for <fstests@vger.kernel.org>; Sun, 27 May 2018 05:49:29 -0700 (PDT)
Date: Sun, 27 May 2018 20:49:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH V2] check: fail tests if check/dmesg are not clean
Message-ID: <20180527124923.GB6581@desktop>
References: <20180522234756.21055-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522234756.21055-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 23, 2018 at 09:47:56AM +1000, Dave Chinner wrote:
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
> ---
>  check     | 258 ++++++++++++++++++++++++++++--------------------------
>  common/rc |   6 ++
>  2 files changed, 142 insertions(+), 122 deletions(-)
> 
> diff --git a/check b/check
> index 96198ac4714e..ab0b5696dbb3 100755
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
> +err_msg=""

Should be "_err_msg", i.e. with leading underscore?

> +
>  # start the initialisation work now
>  iam=check
>  
> @@ -639,78 +641,95 @@ for section in $HOST_OPTIONS_SECTIONS; do
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
> +		if $do_report -a ! $first_test -a $tc_status != "expunge" ; then

This check (and the one at the end of this loop) doesn't work as
expected. Because $do_report is a true/false command, and "-a" and the
following expressions are all treated as command line arguments to
true/false, which got ignored by true/false.  That means above check
only depends on the value of $do_report, and results in something like
below in xUnit report file

        <testcase classname="xfstests.xfs_4k_reflink" name="xfs/293" time="-">
                <failure message="Unknown ret_state=" type="TestFail"/>
        </testcase>

if $do_report && ! $first_test && [ "$tc_status" != "expunge"; then
	_make_testcase_report "$tc_status"
fi

This check should work as expected.

Thanks,
Eryu
