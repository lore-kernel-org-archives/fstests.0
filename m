Received: from mx2.suse.de ([195.135.220.15]:42536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbfAWB7j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 22 Jan 2019 20:59:39 -0500
Subject: Re: [PATCH 7/7] check: move test exclusion handling to
 _prepare_test_list
References: <20190121163316.20616-1-jeffm@suse.com>
 <20190121163316.20616-7-jeffm@suse.com> <20190121230919.GI4205@dastard>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <a9bbc4d3-aa35-7396-1c7d-77b943bc1638@suse.com>
Date: Tue, 22 Jan 2019 20:59:36 -0500
MIME-Version: 1.0
In-Reply-To: <20190121230919.GI4205@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 1/21/19 6:09 PM, Dave Chinner wrote:
> On Mon, Jan 21, 2019 at 11:33:16AM -0500, jeffm@suse.com wrote:
>> From: Jeff Mahoney <jeffm@suse.com>
>>
>> In order to simplify combining excluded tests specified on the command
>> line vs specified via config files,
> 
> You mean defining excludes in configs/<hostname>.config files,
> right? i.e. in config sections?

Yes.

> But the section code only calls _prepare_test_list if the test dev
> is recreated by each section, right? So you can't really change the
> expunge list from the config files without forcing a test dev
> reformat, right?

Right.  In my testing I didn't hit this situation, but it's there.  I
can fix that.

>> it makes sense to push the handling
>> into _prepare_test_list.  This means we start with a fresh $tmp.xlist
>> and rebuild it each time _prepare_test_list is called.
> 
> The patch does more than that, right?
> 
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>>  check | 41 ++++++++++++++++++++++++-----------------
>>  1 file changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/check b/check
>> index 77a06b00..17073c4e 100755
>> --- a/check
>> +++ b/check
>> @@ -230,7 +230,28 @@ _prepare_test_list()
>>  		done
>>  	fi
>>  
>> -	# Specified groups to exclude
>> +	:> $tmp.xlist
>> +
>> +	# Per-fstype/generic/shared file of tests to exclude (-X)
>> +	for xfile in $XGROUP_FILES; do
> 
> That adds support for multiple group exclude files (i.e. multiple -X
> options), right?

Yes.  I'll document that in the commit message.

>> +		for d in $SRC_GROUPS $FSTYP; do
>> +			[ -f $SRC_DIR/$d/$xfile ] || continue
>> +			for f in `sed "s/#.*$//" $SRC_DIR/$d/$xfile`; do
>> +				echo "$d/$f command line" >> $tmp.xlist
>> +			done
>> +		done
>> +	done
>> +
>> +	# External file of tests to exclude (-E)
>> +	for xfile in $EXCLUDE_FILES; do
>> +		if [ -f $xfile ]; then
>> +			sed -e "s/#.*$//" \
>> +			    -e "s;$; file $xfile;" "$xfile" \
> 
> And I have no idea what problem this second expression is solving -
> it wasn't in the original code that got copied here.

This series is part of a larger set I've been using for a while.  I
reordered them and pulled out the least controversial.  This was
originally after a patch that adds reporting for why a test was expunged
to the check output.  We can ignore this part for now.

Thanks for the review,

-Jeff

-- 
Jeff Mahoney
SUSE Labs
