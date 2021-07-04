Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD4C07E95
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1016142F
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhGDKuA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Jul 2021 06:50:00 -0400
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:38564 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDKuA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Jul 2021 06:50:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07542144|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0220531-0.00629578-0.971651;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KbwPrYT_1625395642;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KbwPrYT_1625395642)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 04 Jul 2021 18:47:23 +0800
Date:   Sun, 4 Jul 2021 18:47:22 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YOGRukqZFQTb36MS@desktop>
References: <20210621164851.1808923-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621164851.1808923-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 21, 2021 at 12:48:51PM -0400, Theodore Ts'o wrote:
> ext4/048 will fail when running on older kernels that don't support
> the filename wipe feature.  The journal checkpoint ioctl is a related

I think that depends on if we treat it as a feature or a bugfix. We
should let the test fail on old kernels if that's a bugfix, and skip the
test if it's a feature. Apparently, we take it as a feature here.

> feature, and landed just a little bit after filename wipe feature, so
> use support for the journal checkpoint ioctl as a proxy for support
> for the filename wipe feature.

This seems fragile, they're related features but not always bounded
together, I think it's possible for distros developers decide to
backport only one of the features (though quite unlikely).

Is it worth to introduce features sysfs entry for journal checkpoint and
filename wipe in ext4? In fstests' point of view, it's great to have
such entries that could be checked. If it's not worth it, I think the
"feature proxy" way is acceptable, given that the two features are
closely related and aimed to the same security issue.

Thanks,
Eryu

> 
> Without this change, this test will fail when tesing 5.10, 5.4, and
> other LTS kernels.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  tests/ext4/048 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/ext4/048 b/tests/ext4/048
> index 51189618..35e6aa7f 100755
> --- a/tests/ext4/048
> +++ b/tests/ext4/048
> @@ -93,6 +93,14 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
>  # create scratch dir for testing
>  # create some files with no name a substr of another name so we can grep later
>  _scratch_mount >> $seqres.full 2>&1
> +
> +# Use the presence of the journal checkpoint ioctl as a proxy of filename
> +# wipe being supported
> +if test -x $here/src/checkpoint_journal && \
> +	! $here/src/checkpoint_journal $SCRATCH_MNT --dry-run ; then
> +    _notrun "filename wipe not supported"
> +fi
> +
>  blocksize="$(_get_block_size $SCRATCH_MNT)"
>  mkdir $testdir
>  file_num=1
> -- 
> 2.31.0
