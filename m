Received: from mail-pg0-f65.google.com ([74.125.83.65]:33368 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeD0LYB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Apr 2018 07:24:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id i194-v6so1356765pgd.0
        for <fstests@vger.kernel.org>; Fri, 27 Apr 2018 04:24:01 -0700 (PDT)
Date: Fri, 27 Apr 2018 19:23:56 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: annotate good and expunged tests in results
Message-ID: <20180427112356.GP11384@desktop>
References: <20180412213838.28929-1-jeffm@suse.com>
 <20180424093646.GA11384@desktop>
 <fde6f93d-5c12-dcc8-9194-c91f96773bc6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde6f93d-5c12-dcc8-9194-c91f96773bc6@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: fstests@vger.kernel.org, mcgrof@suse.com, nborisov@suse.com, fdmanana@suse.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 24, 2018 at 02:03:24PM -0400, Jeff Mahoney wrote:
> On 4/24/18 5:36 AM, Eryu Guan wrote:
> > On Thu, Apr 12, 2018 at 05:38:38PM -0400, jeffm@suse.com wrote:
> >> From: Jeff Mahoney <jeffm@suse.com>
> > 
> > [Sorry for the late review..]
> 
> Thanks for the review just the same.
> 
> >> Currently, we only create results files when a test has failed or was
> >> supposed to run but some dependency wasn't met causing it not to run.
> >> Short of saving the summary at the end of the run, there's no way to tell
> >> which tests passed or which tests weren't run due to being excluded.
> >>
> >> This patch moves successful test results to $seqres.out.good to annotate
> >> good results.  It also adds tests excluded by group to the $tmp.xlist file
> >> and adds annotations for every test excluded.  When a test is expunged
> > 
> > I can see that annotating tests excluded by group is helpful, but I
> > don't think we need $seqres.out.good, passed tests are already shown by
> > check, and $seqres.out.good is same as the golden image, it looks
> > redundant.
> 
> The contents are redundant, but the purpose of the file existing isn't.
> My goal is to be able to point a script at the results directory for a
> test run and autogenerate a table of results and/or compare them to
> known results.  Right now, there's no way to tell whether a test was run

But the test run & pass info is already available from the check output
and the test result summary at the end of check. Is that sufficient for
you? Also, we already have mechanism to generate a test report in xunit
format, i.e. ./check -R xunit -g auto, which includes results for passed
& failed & notrun tests.

My concern is that saving .good files consume more and more space over
time, and they don't provide any additional information (even with empty
files that don't require much space).

Thanks,
Eryu

> at all, only that it failed or was skipped due to some missing
> dependency.  The expunge changes handle the explicitly skipped cases,
> but without the .good files, there's nothing indicating a test actually
> ran or when it last did.  The contents don't have to be the output.  If
> you can think of something more useful there (or if we just create an
> empty file), that's fine too.
> >> -# takes the list of tests to run in $tmp.list, and removes the tests passed to
> >> -# the function from that list.
> >> +# takes the list of tests to run in $tmp.list and adds them to the excluded
> >> +# test list, annotated with the group that excluded each one
> > 
> > The comments don't seem quite right, the new behavior doesn't take tests
> > from $tmp.list, it just edits the $tmp.xlist file for later use.
> 
> Right.  I missed updating the comment after changing the behavior.
> 
> >>  trim_test_list()
> >>  {
> >> +	group=$1
> > 
> > Please declare local variable as 'local' when possible.
> 
> Ok.
> 
> > When using config section, e.g. ./check -s <sec_name>, and FSTYP is
> > different in new section, check will do _prepare_test_list again, so
> > tests selected by "-x <xgroup>" will be listed twice in $tmp.xlist file,
> > as a result, I see duplicated group names in the annotate message, e.g.
> > 
> > generic/458        [expunged] group metadata metadata
> > 
> > I think we should move above "-X/-E" handlings to _prepare_test_list,
> > only assign variable "xfile" here (use a new variable for -E option,
> > perhaps). So that we could simply remove $tmp.xlist before calling
> > _prepare_test_list again, and it could exclude all specified tests only
> > once. Maybe as patch 1/2 in a patchset.
> 
> Ok, that's easy enough to do.
> 
> >>  	        fi
> >>  		;;
> >>  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
> >> @@ -491,11 +483,17 @@ _check_filesystems()
> >>  _expunge_test()
> >>  {
> >>  	local TEST_ID="$1"
> >> +	local OUTPUT="$2"
> > 
> > OUTPUT is not used.
> 
> Ack.
> 
> >> @@ -770,6 +774,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >>  			    else
> >>  				echo "$seqnum `expr $stop - $start`" >>$tmp.time
> >>  				echo -n " `expr $stop - $start`s"
> >> +				mv $tmp.out $seqres.out.good
> > 
> > As said above, I don't think it's that useful.
> 
> It doesn't need to be the contents of the output, but I'd like it to be
> *something* and moving a file that already exists is as easy as creating
> a new one.
> 
> -Jeff
> 
> -- 
> Jeff Mahoney
> SUSE Labs
