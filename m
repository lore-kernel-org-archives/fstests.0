Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188D6C00140
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Aug 2022 23:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiHBXM1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBXM0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Aug 2022 19:12:26 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D6203C8D6
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 16:12:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 44C3562CE63;
        Wed,  3 Aug 2022 09:12:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oJ13k-008SIY-UA; Wed, 03 Aug 2022 09:12:20 +1000
Date:   Wed, 3 Aug 2022 09:12:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs: test xfs_quota's 'dump' and 'report' -L/-R range
 parameters
Message-ID: <20220802231220.GD3861211@dread.disaster.area>
References: <20220802130554.117320-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802130554.117320-1-aalbersh@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62e9af57
        a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=4ruO79r7XMP0a-Fu7AMA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 02, 2022 at 03:05:55PM +0200, Andrey Albershteyn wrote:
> These parameters define ID range of users/groups/projects to show.
> This test adds more checks for wider coverage (e.g. empty range,
> full range, open range).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
> 
> This is regression test in relation to the patch [1].
> 
> Changes from v1:
>  - Moved to separate test (initially added to 152)
> 
> [1]: https://lore.kernel.org/all/20220328222503.146496-1-aalbersh@redhat.com/
....
> +filter_dump()
> +{
> +	_filter_scratch| _filter_trailing_spaces | \
> +		sed -E '/^[0-9]+/s/^[0-9]+/#ID/g'
> +}

Some sed hints. This looks like you are converting a line like:

"123 xyz 456 abc     "

to

"#ID xyz 456 abc"

In this situation, you don't need a line filter regex for sed to do
the right thing - it's redundant because the search regex will pull
exactly the same line into the pattern space as the line filter
would that the regex then acts upon. Hence the sed expression can be
simplified to:

sed -E 's/^[0-9]+/#ID/g'


Then because the regex is matching the start of the line, there
cannot more than one match per line. Hence the "g" suffix that tells
sed to continue searching the pattern space after the first match
has been found is not necessary. Now we have:

sed -E 's/^[0-9]+/#ID/'

And then if we look at _filter_trailing_spaces() we see it's just
another simple sed expression. But sed has this annoying CLI issue
where if you use extended regexes (-E ...) then you can only specify
one regex to apply to the pattern space. This makes matching the
start and end of the line a bit messy and error prone. e.g:

sed -E 's/^[0-9]+(\s+.*[[:alnum:]])\s*$/#ID\1/'

Will match the ID at the start, store the bit in the middle that we
want to retain in a register by assuming it ends with a number or
letter then whitespace, then matches the whitespace at the end of
the line. It then outputs #ID followed by the contents of register
1, thereby stripping the whitespace at the end of the line.

It's a complex regex, hard to read, and quite fragile.

But if we drop the extended regexes, we can now chain multiple
simple regexes together to be applied sequentially to the pattern
space line via multiple CLI "-e" expressions. So the sed command
becomes:

_filter_scratch | sed -e 's/^[0-9]\+/#ID/' -e 's/\s*$//'

Which is much easier to understand, and does all the work in a
single sed invocation.

> +
> +filter_report()
> +{
> +	_filter_quota | _filter_trailing_spaces | grep -v "^root \|^\#0 " \
> +		| sed -e '/^#[0-9]*/s/^#[0-9]*/#ID/g'
> +}

And the same here - this removes lines starting with root or #0 from
the output with grep, then replaces the initial ID with #ID via sed.
This can all be done with a single sed invocation, and this time we
use line matching regexes to delete the pattern space before
applying the substution regexes which then don't match anything
because the pattern space is empty for the lines we want to delete
from the output:

	_filter_quota | sed -e '/^root/d' \
				-e '/^#0/d' \
				-e 's/^[0-9]\+/#ID/' \
				-e 's/\s*$//'


> +set_quota_limit()
> +{
> +	local bs=$1
> +	local bh=$2
> +	local is=$3
> +	local ih=$4
> +	local user=$5
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +			-c "limit -$type bsoft=$bs bhard=$bh $user" \
> +			-c "limit -$type isoft=$is ihard=$ih $user" \
> +			$SCRATCH_MNT
> +}
> +
> +test_dump()
> +{
> +	local opt="$*"
> +
> +	rm -f $tmp.backup 2>>/dev/null
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +			-c "dump -$type $opt -f $tmp.backup" \
> +			$SCRATCH_MNT | _filter_scratch
> +	cat $tmp.backup | filter_dump
> +}
> +
> +test_report()
> +{
> +	local opt="$*"
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +			-c "report -$type $opt -bi" \
> +			$SCRATCH_MNT | filter_report
> +}
> +
> +test_xfs_quota()
> +{
> +	set_quota_limit 512k 2048k 10 20 $id
> +	set_quota_limit 1024k 4096k 10 20 $id2
> +
> +	echo "dump options test (type=$type)"
> +	echo "no options (full range)"; test_dump
> +	echo "-L option"; test_dump -L $id
> +	echo "-U option"; test_dump -U $id
> +	echo "-L/-U options (one element range)"; test_dump -L $id -U $id
> +	echo "-L/-U options (multiple elements range)"; test_dump -L $id -U $id2
> +	echo "-L/-U options (empty range)"; test_dump -L $id2 -U $id
> +	echo "-L/-U options (full range)"; test_dump -L 0 -U 0

While compact, this is difficult to read. Can you separate the echo
command from the actual test that is run? i.e.

	echo "dump options test (type=$type)"
	echo "no options (full range)";
	test_dump

	echo "-L option"
	test_dump -L $id

	echo "-U option"
	test_dump -U $id

Another option, which is also compact, is to call the test function
like so:

	test_dump "no options"
	test_dump "-L option" -L $id
	test_dump "-U option" -U $id
	.....

And capture the test description like so:

test_dump()
{
	local description=$1 ; shift
	local opt="$*"

	echo "Options: $description"

	....
}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
