Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BFFC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Sep 2021 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB0060F6B
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Sep 2021 00:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhIJAwW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Sep 2021 20:52:22 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34378 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232508AbhIJAuU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Sep 2021 20:50:20 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C3CED104EFB6;
        Fri, 10 Sep 2021 10:48:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mOUiv-00Ag6A-LY; Fri, 10 Sep 2021 10:48:57 +1000
Date:   Fri, 10 Sep 2021 10:48:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 3/3] common/rc: Check call order of _require_dm_target
 and _require_scratch*
Message-ID: <20210910004857.GI1756565@dread.disaster.area>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
 <20210908083715.1831067-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908083715.1831067-4-shinichiro.kawasaki@wdc.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=JF9118EUAAAA:8 a=7-415B0cAAAA:8
        a=DVUKmJ1ITyFACv_vUXkA:9 a=CjuIK1q_8ugA:10 a=xVlTc564ipvMDusKsbsT:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 08, 2021 at 05:37:15PM +0900, Shin'ichiro Kawasaki wrote:
> When SCRATCH_DEV is not set and the test case does not call
> _require_scratch* before _require_dm_target, _require_block_device
> called from _require_dm_target fails to evaluate SCRATCH_DEV and
> results in the test case failure. This failure reason is not described
> in the error message and it takes some time to catch.

You should quote the actual failure message here so we have some
idea of whether the message that was emitted was appropriate or not
without having to go know how the test failed...

> To catch the failure reason easier, check SCRATCH_DEV in
> _require_dm_target. If SCRATCH_DEV is not set, fail the test case
> and print message which requests to fix call order of _require_scratch*
> and _require_dm_target. This improvement follows what _scratch_shutdown
> does for _require_scratch_shutdown.

Also, you don't need to describe the change in the commit message -
the patch does that. The first paragraph is all that is needed here
as it describes why you want to make the change.

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index dda5da06..cbec8aaa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1971,6 +1971,9 @@ _require_dm_target()
>  
>  	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
>  	# behaviour
> +	if [ -z "$SCRATCH_DEV" ]; then
> +		_fail "_require_dm_target: call _require_scratch* first in test"
> +	fi
>  	_require_block_device $SCRATCH_DEV
>  	_require_sane_bdev_flush $SCRATCH_DEV
>  	_require_command "$DMSETUP_PROG" dmsetup

That's a notrun case, not a fail.

Also, we report the error that has occurred, not how to resolve the
problem. That's because we might change behaviour in future and now
the error message tells people to do something that is
wrong/non-existent. As such, I think the premise this change is based
on is not really valid - people running fstests are assumed to have
a level of knowledge sufficient to trace a failing test and
determine what went wrong from the error reported. i.e. the error
message should state what the problem was, not describe a potential
solution.

Also, this is not the place to check if SCRATCH_DEV is set. The
check for a NULL device should be in _require_block_device(). Oh,
wait, it already is:

_require_block_device()
{
	if [ -z "$1" ]; then
		echo "Usage: _require_block_device <dev>" 1>&2
		exit 1
	fi
....
}

And that's the error message the test emitted that you didn't
understand, right?

If so, the change here should really be to _require_block_device().
i.e.

	if [ -z "$1" ]; then
		_notrun "test requires a block device to be specified"
	fi

A quick scan shows a bunch of similar _requires checks that do
similar things with poor error messages and 'exit 1' (e.g.
_require_local_device()). _requires rules should call _notrun if the
test should not run because of incorrect setup, not 'exit 1'.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
