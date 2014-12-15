Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:24457 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936AbaLOUtT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 15 Dec 2014 15:49:19 -0500
Date: Tue, 16 Dec 2014 07:49:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/038: require fallocate support and test for trim
 support
Message-ID: <20141215204914.GS24183@dastard>
References: <alpine.LNX.2.00.1412152322070.21847@reiser4.gekom>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1412152322070.21847@reiser4.gekom>
Sender: fstests-owner@vger.kernel.org
To: Dushan Tcholich <dusanc@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 15, 2014 at 11:26:35PM +0100, Dushan Tcholich wrote:
> Add tests for allocate support and test if TRIM really works on tested 
> partition.
> 
> Signed-off-by: Dushan Tcholich <dusanc@gmail.com>
> 
> --- xfstests.orig/tests/generic/038	2014-12-14 15:18:00.000000000 +0100
> +++ xfstests/tests/generic/038	2014-12-15 23:21:11.000000000 +0100
> @@ -70,6 +70,10 @@
>  _supported_os Linux
>  _require_scratch
>  _require_fstrim
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "truncate"

No need to test for the truncate command as it's supported in all
versions of xfs_io people use. falloc, OTOH, isn't supported on oler
distros that people still need to run QA on, and hence that check is
required....

> +_test_batched_discard $SCRATCH_MNT || _notrun "FITRIM not supported on $SCRATCH_DEV"

$SCRATCH_MNT is not mounted at this point. The test needs to go
after _scratch_mkfs/_scratch_mount...

Hmmm - I'm thinking this should really be a "_requires_batched_discard"
function. It already internally calls _require_fstrim, so we should
just drive everything inwards. i.e.:

_require_batched_discard()
{
	if [ $# -ne 1 ]; then
		echo "Usage: _require_batched_discard mnt_point" 1>&2
		exit 1
	fi
	_require_fstrim
	[ $FSTRIM_PROG $1 > /dev/null 2>&1 ] || \
		_notrun "FITRIM not supported on $1"
}

And so not even need the _requires_fstrim call in these tests...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
