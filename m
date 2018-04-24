Received: from mail-pf0-f180.google.com ([209.85.192.180]:46190 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbeDXJgv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Apr 2018 05:36:51 -0400
Received: by mail-pf0-f180.google.com with SMTP id h69so11779552pfe.13
        for <fstests@vger.kernel.org>; Tue, 24 Apr 2018 02:36:51 -0700 (PDT)
Date: Tue, 24 Apr 2018 17:36:46 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: annotate good and expunged tests in results
Message-ID: <20180424093646.GA11384@desktop>
References: <20180412213838.28929-1-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412213838.28929-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: jeffm@suse.com
Cc: fstests@vger.kernel.org, mcgrof@suse.com, nborisov@suse.com, fdmanana@suse.com
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 12, 2018 at 05:38:38PM -0400, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>

[Sorry for the late review..]

> 
> Currently, we only create results files when a test has failed or was
> supposed to run but some dependency wasn't met causing it not to run.
> Short of saving the summary at the end of the run, there's no way to tell
> which tests passed or which tests weren't run due to being excluded.
> 
> This patch moves successful test results to $seqres.out.good to annotate
> good results.  It also adds tests excluded by group to the $tmp.xlist file
> and adds annotations for every test excluded.  When a test is expunged

I can see that annotating tests excluded by group is helpful, but I
don't think we need $seqres.out.good, passed tests are already shown by
check, and $seqres.out.good is same as the golden image, it looks
redundant.

> during execution, an expunged message will be issued and a
> $seqres.expunged file will be created, both containing the reason for
> the test being expunged.  Reasons can be "command line", "file $filename",
> or "group <group> [group...]".
> 
> This makes the output more noisy in the expunged case and makes startup
> take slightly longer, but ends up with results that can be more easily
> parsed by automated tools.
> 
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  check | 57 +++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/check b/check
> index 546683c5..9a1f4e7e 100755
> --- a/check
> +++ b/check
> @@ -173,28 +173,18 @@ get_all_tests()
>  	done
>  }
>  
> -# takes the list of tests to run in $tmp.list, and removes the tests passed to
> -# the function from that list.
> +# takes the list of tests to run in $tmp.list and adds them to the excluded
> +# test list, annotated with the group that excluded each one

The comments don't seem quite right, the new behavior doesn't take tests
from $tmp.list, it just edits the $tmp.xlist file for later use.

>  trim_test_list()
>  {
> +	group=$1

Please declare local variable as 'local' when possible.

> +	shift
>  	test_list="$*"
>  
> -	rm -f $tmp.grep
> -	numsed=0
> -	for t in $test_list
> -	do
> -	    if [ $numsed -gt 100 ]; then
> -		grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
> -		mv $tmp.tmp $tmp.list
> -		numsed=0
> -		rm -f $tmp.grep
> -	    fi
> -	    echo "^$t\$" >>$tmp.grep
> -	    numsed=`expr $numsed + 1`
> +	for test in $test_list; do
> +		test=${test##tests/}
> +		echo "$test group $group" >> $tmp.xlist
>  	done
> -	grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
> -	mv $tmp.tmp $tmp.list
> -	rm -f $tmp.grep
>  }
>  
>  
> @@ -246,7 +236,7 @@ _prepare_test_list()
>  			exit 1
>  		fi
>  
> -		trim_test_list $list
> +		trim_test_list $xgroup $list
>  	done
>  
>  	# sort the list of tests into numeric order
> @@ -285,13 +275,15 @@ while [ $# -gt 0 ]; do
>  		for d in $SRC_GROUPS $FSTYP; do
>  			[ -f $SRC_DIR/$d/$xfile ] || continue
>  			for f in `sed "s/#.*$//" $SRC_DIR/$d/$xfile`; do
> -				echo $d/$f >> $tmp.xlist
> +				echo "$d/$f command line" >> $tmp.xlist
>  			done
>  		done
>  		;;
>  	-E)	xfile=$2; shift ;
>  		if [ -f $xfile ]; then
> -			sed "s/#.*$//" "$xfile" >> $tmp.xlist
> +			sed -e "s/#.*$//" \
> +			    -e "s;$; file $xfile;" "$xfile" \
> +			    >> $tmp.xlist

When using config section, e.g. ./check -s <sec_name>, and FSTYP is
different in new section, check will do _prepare_test_list again, so
tests selected by "-x <xgroup>" will be listed twice in $tmp.xlist file,
as a result, I see duplicated group names in the annotate message, e.g.

generic/458        [expunged] group metadata metadata

I think we should move above "-X/-E" handlings to _prepare_test_list,
only assign variable "xfile" here (use a new variable for -E option,
perhaps). So that we could simply remove $tmp.xlist before calling
_prepare_test_list again, and it could exclude all specified tests only
once. Maybe as patch 1/2 in a patchset.

>  	        fi
>  		;;
>  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> @@ -491,11 +483,17 @@ _check_filesystems()
>  _expunge_test()
>  {
>  	local TEST_ID="$1"
> +	local OUTPUT="$2"

OUTPUT is not used.

>  	if [ -s $tmp.xlist ]; then
> -		if grep -q $TEST_ID $tmp.xlist; then
> -			echo "       [expunged]"
> +		grep $TEST_ID $tmp.xlist > $tmp._expunge_test
> +		if [ $? -eq 0 ]; then
> +			sed -e "s;$TEST_ID ;;" $tmp._expunge_test | \
> +				tr '\n' ' ' |  sed -e 's; group;;g'
> +			echo
> +			rm -f $tmp._expunge_test
>  			return 1
>  		fi
> +		rm -f $tmp._expunge_test
>  	fi
>  	return 0
>  }
> @@ -670,8 +668,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	    echo -n "$seqnum"
>  
>  	    if $showme; then
> -		_expunge_test $seqnum
> +		_expunge_test $seqnum > $tmp.xreason
>  		if [ $? -eq 1 ]; then
> +			echo -n "        [expunged] "
> +			cat $tmp.xreason
>  			continue
>  		fi
>  		echo
> @@ -689,11 +689,15 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  	    else
>  		# really going to try and run this one
>  		#
> -		rm -f $seqres.out.bad
> +		rm -f $seqres.out.bad $seqres.out.good $seqres.expunged
> +		rm -f $seqres.notrun
>  
>  		# check if we really should run it
> -		_expunge_test $seqnum
> +		_expunge_test $seqnum > $tmp.xreason
>  		if [ $? -eq 1 ]; then
> +			mv $tmp.xreason $seqres.expunged
> +			echo -n "        [expunged] "
> +			cat $seqres.expunged
>  			continue
>  		fi
>  
> @@ -704,7 +708,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  		else
>  			echo -n "	"	# prettier output with timestamps.
>  		fi
> -		rm -f core $seqres.notrun
> +		rm -f core
>  
>  		start=`_wallclock`
>  		$timestamp && echo -n "	["`date "+%T"`"]"
> @@ -770,6 +774,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			    else
>  				echo "$seqnum `expr $stop - $start`" >>$tmp.time
>  				echo -n " `expr $stop - $start`s"
> +				mv $tmp.out $seqres.out.good

As said above, I don't think it's that useful.

Thanks,
Eryu

>  			    fi
>  			    echo ""
>  			else
> -- 
> 2.15.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
