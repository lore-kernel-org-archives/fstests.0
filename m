Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A2C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 09:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00526103D
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 09:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhILJSc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Sep 2021 05:18:32 -0400
Received: from out20-38.mail.aliyun.com ([115.124.20.38]:38788 "EHLO
        out20-38.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhILJSa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Sep 2021 05:18:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436469|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0543061-0.00411712-0.941577;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.LJ5WZbB_1631438234;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.LJ5WZbB_1631438234)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 12 Sep 2021 17:17:14 +0800
Date:   Sun, 12 Sep 2021 17:17:14 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 3/3] common/rc: Check call order of _require_dm_target
 and _require_scratch*
Message-ID: <YT3FmvvytzCvWllt@desktop>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
 <20210908083715.1831067-4-shinichiro.kawasaki@wdc.com>
 <20210910004857.GI1756565@dread.disaster.area>
 <20210910063405.j36w2oec2sqi6lob@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910063405.j36w2oec2sqi6lob@shindev>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 10, 2021 at 06:34:05AM +0000, Shinichiro Kawasaki wrote:
> On Sep 10, 2021 / 10:48, Dave Chinner wrote:
> > On Wed, Sep 08, 2021 at 05:37:15PM +0900, Shin'ichiro Kawasaki wrote:
> > > When SCRATCH_DEV is not set and the test case does not call
> > > _require_scratch* before _require_dm_target, _require_block_device
> > > called from _require_dm_target fails to evaluate SCRATCH_DEV and
> > > results in the test case failure. This failure reason is not described
> > > in the error message and it takes some time to catch.
> > 
> > You should quote the actual failure message here so we have some
> > idea of whether the message that was emitted was appropriate or not
> > without having to go know how the test failed...
> 
> Sorry about the lack of the infomration. As you found below, the meesage was
> "Usage: _require_block_device <dev>".
> 
> > 
> > > To catch the failure reason easier, check SCRATCH_DEV in
> > > _require_dm_target. If SCRATCH_DEV is not set, fail the test case
> > > and print message which requests to fix call order of _require_scratch*
> > > and _require_dm_target. This improvement follows what _scratch_shutdown
> > > does for _require_scratch_shutdown.
> > 
> > Also, you don't need to describe the change in the commit message -
> > the patch does that. The first paragraph is all that is needed here
> > as it describes why you want to make the change.
> 
> I see. I will write "why" in the commit message, not "what". (In the past, I
> was advised to write "what" the patch does, but I think this guide is valid
> only when the change is complicated).
> 
> > 
> > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > ---
> > >  common/rc | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index dda5da06..cbec8aaa 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -1971,6 +1971,9 @@ _require_dm_target()
> > >  
> > >  	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
> > >  	# behaviour
> > > +	if [ -z "$SCRATCH_DEV" ]; then
> > > +		_fail "_require_dm_target: call _require_scratch* first in test"
> > > +	fi
> > >  	_require_block_device $SCRATCH_DEV
> > >  	_require_sane_bdev_flush $SCRATCH_DEV
> > >  	_require_command "$DMSETUP_PROG" dmsetup
> > 
> > That's a notrun case, not a fail.
> > 
> > Also, we report the error that has occurred, not how to resolve the
> > problem. That's because we might change behaviour in future and now
> > the error message tells people to do something that is
> > wrong/non-existent. As such, I think the premise this change is based
> > on is not really valid - people running fstests are assumed to have
> > a level of knowledge sufficient to trace a failing test and
> > determine what went wrong from the error reported. i.e. the error
> > message should state what the problem was, not describe a potential
> > solution.
> 
> Thank you for the comment. These are the points I missed. At least I was
> able to catch the cause, so the improvement I suggested is not a big
> improvement.
> 
> > 
> > Also, this is not the place to check if SCRATCH_DEV is set. The
> > check for a NULL device should be in _require_block_device(). Oh,
> > wait, it already is:
> > 
> > _require_block_device()
> > {
> > 	if [ -z "$1" ]; then
> > 		echo "Usage: _require_block_device <dev>" 1>&2
> > 		exit 1
> > 	fi
> > ....
> > }
> > 
> > And that's the error message the test emitted that you didn't
> > understand, right?
> 
> Right :)
> 
> > 
> > If so, the change here should really be to _require_block_device().
> > i.e.
> > 
> > 	if [ -z "$1" ]; then
> > 		_notrun "test requires a block device to be specified"
> > 	fi
> > 
> > A quick scan shows a bunch of similar _requires checks that do
> > similar things with poor error messages and 'exit 1' (e.g.
> > _require_local_device()). _requires rules should call _notrun if the
> > test should not run because of incorrect setup, not 'exit 1'.
> 
> Thank you for your thoughts. I walked through _require_* bash functions in
> common/, and listed 20 functions below, which call 'exit 1', _fail, or
> 'return 1' for its argument check failure:
> 
> --- list start ---
> 
> common/rc
> 
>   _require_scratch_size
>   _require_scratch_size_nocheck
>   _require_command *
>   _require_block_device *
>   _require_local_device *
>   _require_zoned_device *
>   _require_non_zoned_device *
>   _require_scratch_ext4_feature
>   _require_xfs_io_command
>   _require_fio
>   _require_batched_discard *
>   _require_chattr
>   _require_fs_sysfs
>   _require_scratch_feature
> 
> common/btrfs
> 
>   _require_btrfs_mkfs_feature
>   _require_btrfs_fs_feature
> 
> common/xfs
> 
>   _require_xfs_db_command
>   _require_xfs_spaceman_command
> 
> common/encrypt
> 
>   _require_encryption_policy_support (checks arguments passed from _require_scratch_encryption)
> 
> common/rnameat2
> 
>   _require_renameat2
> 
> --- list end ---
> 
> Many of the functions above check arguments not for incorrect setup, but for
> call in test cases with invalid arguments. 6 functions of them with * in the
> list check arguments for the incorrect setups, such as DEBUGFS_PROG,
> SCRATCH_DEV or SCRATCH_MNT. So I suggest to modify these functions to improve
> error messages and call "_notrun". What do you think about this?

IMO the _fail calls in above _require* rules are indicating function
usage errors, which are bugs in the test code. While _notrun indicates a
required condition is not met for this test.

Thanks,
Eryu

P.S. I've applied the first two patches, thanks for the fix!

> 
> -- 
> Best Regards,
> Shin'ichiro Kawasaki
