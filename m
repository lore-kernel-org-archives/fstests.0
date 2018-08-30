Received: from mail-pg1-f193.google.com ([209.85.215.193]:42343 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeH3HTI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Aug 2018 03:19:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so3232195pgp.9
        for <fstests@vger.kernel.org>; Wed, 29 Aug 2018 20:19:09 -0700 (PDT)
Date: Thu, 30 Aug 2018 11:19:03 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] misc large filesystem fixes
Message-ID: <20180830031902.GC3651@desktop>
References: <b647246c-c206-229a-f801-60f20dfa9f28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b647246c-c206-229a-f801-60f20dfa9f28@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 29, 2018 at 04:43:38PM -0500, Eric Sandeen wrote:
> There are a few tests which fail on large filesytems because
> we run into mkfs limits.
> 
> xfs/010 and xfs/013 hardcode 2 AGs, but if the device is larger
> than 2T this will fail.  Check the device size and restrict it
> to just under 2T so that a 2-AG mkfs is possible.
> 
> xfs/178 tries to decrease the agcount and re-mkfs, but if the
> default AG size was chosen to be 1T, decreasing the AG count
> results in too-large AGs and mkfs fails.  The intention here
> AFAICT is to simply re-mkfs with non-overlapping AG headers,
> so increasing the AG count should achieve the same purpose,
> and cause mkfs to choose a smaller-than-default AG size which
> should pass.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/xfs/010 b/tests/xfs/010
> index ee1595c8..2b30c867 100755
> --- a/tests/xfs/010
> +++ b/tests/xfs/010
> @@ -96,7 +96,14 @@ _require_xfs_finobt
>  
>  rm -f $seqres.full
>  
> -_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _filter_mkfs 2>$seqres.full
> +# If 2 AGs would result in too-large AG size, restrict the size
> +DSIZEOPT=""
> +DEV_SZ=$(blockdev --getsize64 $SCRATCH_DEV)
> +if [ "$DEV_SZ" -ge "$((2*(2**40)))" ]; then
> +  DSIZEOPT="-d size=2047g"
> +fi
> +
> +_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2 $DSIZEOPT" | _filter_mkfs 2>$seqres.full

I think this kind of problem will happen to all tests that specify a
custom "agcount" in mkfs but without an "agsize" nor "size". For
example, xfs/062 would fail if $SCRATCH_DEV is larger than 8T. I guess
we need a more general way to fix the problem.

I'm thinking to introduce a new helper to require a given agcount will
fit the device size, and if the device is bigger than ($agcount * 1T)
then _notrun the test, something like (may need a better helper name):

_require_xfs_support_agcount()
{
	local dev=$1
	local agcount=$2
	local max_sz=$((agcount*(2**40)))
	local dev_sz=$(blockdev --getsize64 $dev)

	if [ $dev_sz -gt $max_sz ]; then
		_notrun "agcount $agcount is too small to hold $dev_sz device"
	fi
}

Then add this _require rule to all tests that only specify a custom
agsize, e.g. for xfs/010 we could do

_require_xfs_support_agcount $SCRATCH_DEV 2

I roughly went through all xfs tests and found that the following ones
may need this new _require rule

xfs/010
xfs/013
xfs/062
xfs/178
xfs/179
xfs/310

Perhaps there're better ways to solve the problem, any suggestions are
welcomed! 

Thanks,
Eryu
