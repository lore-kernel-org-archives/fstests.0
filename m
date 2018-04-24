Received: from mx2.suse.de ([195.135.220.15]:48407 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbeDXSD1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Apr 2018 14:03:27 -0400
Subject: Re: [PATCH] check: annotate good and expunged tests in results
References: <20180412213838.28929-1-jeffm@suse.com>
 <20180424093646.GA11384@desktop>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <fde6f93d-5c12-dcc8-9194-c91f96773bc6@suse.com>
Date: Tue, 24 Apr 2018 14:03:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180424093646.GA11384@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, mcgrof@suse.com, nborisov@suse.com, fdmanana@suse.com
List-ID: <fstests@vger.kernel.org>

On 4/24/18 5:36 AM, Eryu Guan wrote:
> On Thu, Apr 12, 2018 at 05:38:38PM -0400, jeffm@suse.com wrote:
>> From: Jeff Mahoney <jeffm@suse.com>
> 
> [Sorry for the late review..]

Thanks for the review just the same.

>> Currently, we only create results files when a test has failed or was
>> supposed to run but some dependency wasn't met causing it not to run.
>> Short of saving the summary at the end of the run, there's no way to tell
>> which tests passed or which tests weren't run due to being excluded.
>>
>> This patch moves successful test results to $seqres.out.good to annotate
>> good results.  It also adds tests excluded by group to the $tmp.xlist file
>> and adds annotations for every test excluded.  When a test is expunged
> 
> I can see that annotating tests excluded by group is helpful, but I
> don't think we need $seqres.out.good, passed tests are already shown by
> check, and $seqres.out.good is same as the golden image, it looks
> redundant.

The contents are redundant, but the purpose of the file existing isn't.
My goal is to be able to point a script at the results directory for a
test run and autogenerate a table of results and/or compare them to
known results.  Right now, there's no way to tell whether a test was run
at all, only that it failed or was skipped due to some missing
dependency.  The expunge changes handle the explicitly skipped cases,
but without the .good files, there's nothing indicating a test actually
ran or when it last did.  The contents don't have to be the output.  If
you can think of something more useful there (or if we just create an
empty file), that's fine too.
>> -# takes the list of tests to run in $tmp.list, and removes the tests passed to
>> -# the function from that list.
>> +# takes the list of tests to run in $tmp.list and adds them to the excluded
>> +# test list, annotated with the group that excluded each one
> 
> The comments don't seem quite right, the new behavior doesn't take tests
> from $tmp.list, it just edits the $tmp.xlist file for later use.

Right.  I missed updating the comment after changing the behavior.

>>  trim_test_list()
>>  {
>> +	group=$1
> 
> Please declare local variable as 'local' when possible.

Ok.

> When using config section, e.g. ./check -s <sec_name>, and FSTYP is
> different in new section, check will do _prepare_test_list again, so
> tests selected by "-x <xgroup>" will be listed twice in $tmp.xlist file,
> as a result, I see duplicated group names in the annotate message, e.g.
> 
> generic/458        [expunged] group metadata metadata
> 
> I think we should move above "-X/-E" handlings to _prepare_test_list,
> only assign variable "xfile" here (use a new variable for -E option,
> perhaps). So that we could simply remove $tmp.xlist before calling
> _prepare_test_list again, and it could exclude all specified tests only
> once. Maybe as patch 1/2 in a patchset.

Ok, that's easy enough to do.

>>  	        fi
>>  		;;
>>  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
>> @@ -491,11 +483,17 @@ _check_filesystems()
>>  _expunge_test()
>>  {
>>  	local TEST_ID="$1"
>> +	local OUTPUT="$2"
> 
> OUTPUT is not used.

Ack.

>> @@ -770,6 +774,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>  			    else
>>  				echo "$seqnum `expr $stop - $start`" >>$tmp.time
>>  				echo -n " `expr $stop - $start`s"
>> +				mv $tmp.out $seqres.out.good
> 
> As said above, I don't think it's that useful.

It doesn't need to be the contents of the output, but I'd like it to be
*something* and moving a file that already exists is as easy as creating
a new one.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
