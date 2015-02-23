Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:40539 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753322AbbBWWtO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 Feb 2015 17:49:14 -0500
Date: Tue, 24 Feb 2015 09:49:12 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] create _require_metadata_journaling, and add to tests
 that need it
Message-ID: <20150223224911.GM12722@dastard>
References: <54EBA093.3050401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EBA093.3050401@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 23, 2015 at 03:50:11PM -0600, Eric Sandeen wrote:
> Many tests use dm_flakey to trigger log replay, but for filesystems that
> don't support metadata journaling, this causes failures when it shouldn't.
> (i.e. we can hardly test log replay if there is no log).
> 
> For some tests they actually sync everything we care about, and find
> inconsistencies elsewhere, but I erred on the side of simply not running
> the test in most cases.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> 
> 
> diff --git a/common/rc b/common/rc
> index 7449a1d..015d2f5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2340,6 +2340,35 @@ _require_norecovery()
>  	_scratch_unmount
>  }
>  
> +# Does this filesystem support metadata journaling?
> +# We exclude ones here that don't; otherwise we assume
> +# that it does, so the test will run, fail, and motivate
> +# someone to update this test for a new filesystem.
> +#
> +# It's possible that TEST_DEV and SCRATCH_DEV have different
> +# features (it'd be odd, but possible) so check $TEST_DEV
> +# by default, but we can optionaly pass any dev we want.

Use all 80 columns ;)

> +_require_metadata_journaling()
> +{
> +	if [ -z $1 ]; then
> +		DEV=$TEST_DEV
> +	else
> +		DEV=$1
> +	fi
> +
> +	case "$FSTYP" in
> +	ext2|vfat|msdos)
> +		_notrun "$FSTYP does not support metadata journaling"
> +		;;
> +	ext4)
> +		# ext4 could be mkfs'd without a journal...
> +		_require_dumpe2fs
> +		$DUMPE2FS_PROG -h $DEV | grep has_journal || \
> +			_notrun "$FSTYP on $DEV not configured with metadata journaling"
> +		;;
> +	esac

And the default case?

Otherwise looks fine.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
