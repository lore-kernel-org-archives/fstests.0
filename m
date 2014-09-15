Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:6277 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757129AbaIOVwW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Sep 2014 17:52:22 -0400
Date: Tue, 16 Sep 2014 07:52:18 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Add UBIFS support
Message-ID: <20140915215218.GH4322@dastard>
References: <1410772280-9771-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410772280-9771-1-git-send-email-richard@nod.at>
Sender: fstests-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 15, 2014 at 11:11:20AM +0200, Richard Weinberger wrote:
> UBIFS needs some extra care, the device node is of type character and
> it has no fsck tool.

Not being familiar with UBIFS, the explaination is rather brief and
doesn't explain anything to me. Can you document how where supposed
to treat a filesystem that doesn't exist on a block device for all
the tests that assume that the local fileystem is on a block device?
e.g. how do all the generic tests that use loopback devices work?
What about dm-flakey?

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  README        |  1 +
>  check         |  2 ++
>  common/config |  4 ++--
>  common/rc     | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/README b/README
> index 8a362bd..96adc44 100644
> --- a/README
> +++ b/README
> @@ -100,6 +100,7 @@ Running tests:
>        Running all the udf tests: ./check -udf -g udf
>      - for running nfs tests: ./check -nfs [test(s)]
>      - for running cifs/smb3 tests: ./check -cifs [test(s)]
> +    - for running ubifs tests: ./check -ubifs [test(s)]
>      - To randomize test order: ./check -r [test(s)]
>  
>      
> diff --git a/check b/check
> index 42a1ac2..57ec612 100755
> --- a/check
> +++ b/check
> @@ -70,6 +70,7 @@ check options
>      -nfs                test NFS
>      -cifs               test CIFS
>      -tmpfs              test TMPFS
> +    -ubifs              test UBIFS
>      -l			line mode diff
>      -udiff		show unified diff (default)
>      -n			show me, do not run tests

I'd like to avoid adding command line switches for random filesystem
types if at all possible. I'd much prefer that it be derived from
the current TEST_DEV if at all possible. Can you probe for UBIFS
similar to using blkid for local filesystems?

> diff --git a/common/config b/common/config
> index fc21b37..af082ea 100644
> --- a/common/config
> +++ b/common/config
> @@ -430,7 +430,7 @@ get_next_config() {
>  		exit 1
>  	fi
>  
> -	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
> +	echo $TEST_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
>  	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
>  		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
>  		exit 1

Needs a comment explaining what format we are searching for there?

> @@ -453,7 +453,7 @@ get_next_config() {
>  		export SCRATCH_DEV_NOT_SET=true
>  	fi
>  
> -	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
> +	echo $SCRATCH_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
>  	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
>  		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
>  		exit 1
> diff --git a/common/rc b/common/rc
> index b8f711a..064b987 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1034,6 +1034,12 @@ _require_scratch_nocheck()
>  		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
>  		fi
>  		;;
> +	ubifs)
> +		if [ -z "$SCRATCH_DEV" -o ! -c "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
> +		then
> +		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
> +		fi
> +		;;

s/unique/valid/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
