Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F52BC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 22:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiFTWGT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFTWGS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 18:06:18 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DA9719C2C
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 15:06:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5F30210E76B4;
        Tue, 21 Jun 2022 08:06:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o3PXC-0094Rw-EL; Tue, 21 Jun 2022 08:06:14 +1000
Date:   Tue, 21 Jun 2022 08:06:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] fstests: make sure to unfreeze test and scratch
 mounts
Message-ID: <20220620220614.GB1098723@dread.disaster.area>
References: <20220619134657.1846292-1-amir73il@gmail.com>
 <20220619134657.1846292-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619134657.1846292-3-amir73il@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62b0ef58
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=pGLkceISAAAA:8 a=7-415B0cAAAA:8
        a=by7FB1O-YF4-4JiWHucA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jun 19, 2022 at 04:46:55PM +0300, Amir Goldstein wrote:
> Almost all of the tests that _require_freeze() fail to unfreeze
> scratch mount in case the test is interrupted while fs is frozen.
> 
> Move the handling of unfreeze to generic check code.
> For now, tests only freeze scratch fs, but to be more robust, unfreeze
> both test and scratch fs following a call to _require_freeze().
> 
> Tests could still hang if thier private _cleanup() routine tries
> to modify the frozen fs or wait for a blocked process. Fix the
> _cleanup() routine of xfs/011 to avoid that.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  check             | 14 ++++++++------
>  common/rc         |  5 +++--
>  tests/generic/390 |  2 --
>  tests/xfs/011     |  2 --
>  tests/xfs/517     |  1 -
>  5 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/check b/check
> index de11b37e..d6ee71aa 100755
> --- a/check
> +++ b/check
> @@ -527,17 +527,21 @@ _check_filesystems()
>  {
>  	local ret=0
>  
> +	# Make sure both test and scratch are unfrozen post _require_freeze()
> +	if [ -f ${RESULT_DIR}/require_freeze ]; then
> +		xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
> +		xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
> +	fi

A test leaving a filesystem frozen on exit is a test bug. There can
still be background test processes sitting blocked on a frozen
filesystem when the test exits with a frozen filesystem, and that
has the potential to cause problems in the next few operations
because of "busy filesystem" errors trying to unmount the fs...

IOWs, think this is the wrong way to address this problem. tests
that freeze filesystems need to ensure that everything is cleaned up
properly in the test _cleanup() function where the right thing can
be done and blocked processes can be waited on once the fs has been
thawed.

> diff --git a/tests/generic/390 b/tests/generic/390
> index 20c66e22..0f2b86fa 100755
> --- a/tests/generic/390
> +++ b/tests/generic/390
> @@ -14,8 +14,6 @@ _begin_fstest auto freeze stress
>  _cleanup()
>  {
>  	cd /
> -	# Make sure $SCRATCH_MNT is unfreezed
> -	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
>  	rm -f $tmp.*
>  }

This test is already doing the right thing.

> diff --git a/tests/xfs/011 b/tests/xfs/011
> index d6e9099e..351a574e 100755
> --- a/tests/xfs/011
> +++ b/tests/xfs/011
> @@ -17,9 +17,7 @@ _begin_fstest auto freeze log metadata quick
>  _cleanup()
>  {
>  	$KILLALL_PROG -9 fsstress 2>/dev/null
> -	wait
>  	cd /
> -	_scratch_unmount 2>/dev/null
>  	rm -f $tmp.*
>  }

This is wrong. We have to wait for background fsstress processes to
exit, otherwise unmount can fail randomly. What it is missing is the
thaw before killing the fsstress processes and waiting for them to
complete.

> diff --git a/tests/xfs/517 b/tests/xfs/517
> index f7f9a8a2..961668e3 100755
> --- a/tests/xfs/517
> +++ b/tests/xfs/517
> @@ -15,7 +15,6 @@ _register_cleanup "_cleanup" BUS
>  _cleanup()
>  {
>  	cd /
> -	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT > /dev/null 2>&1
>  	rm -rf $tmp.*
>  }

This is doing the right thing, too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
