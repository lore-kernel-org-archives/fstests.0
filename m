Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7789C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 09:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784766108F
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Sep 2021 09:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhILJbZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Sep 2021 05:31:25 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:34582 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhILJbY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Sep 2021 05:31:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09928253|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0234617-0.00378857-0.97275;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.LJ5bF8._1631439008;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.LJ5bF8._1631439008)
          by smtp.aliyun-inc.com(10.147.44.118);
          Sun, 12 Sep 2021 17:30:09 +0800
Date:   Sun, 12 Sep 2021 17:30:08 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 2/3] btrfs/146: Add _require_scratch_dev_pool before
 _require_dm_target
Message-ID: <YT3IoLrI0Kucg//R@desktop>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
 <20210908083715.1831067-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908083715.1831067-3-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 08, 2021 at 05:37:14PM +0900, Shin'ichiro Kawasaki wrote:
> The test case btrfs/146 calls _require_dm_target which depends on
> SCRATCH_DEV. The test case assumes that valid devices are set in
> SCRATCH_DEV_POOL, and one of the devices is propagated to SCRATCH_DEV.
> However, when SCRATCH_DEV_POOL is not set, valid value is not propagated
> to SCRATCH_DEV and _require_dm_target causes unexpected test case
> failure. To avoid the failure, add _require_scratch_dev_pool call before
> _require_dm_target call to detect invalid SCRATCH_DEV_POOL beforehand.
> 
> Of note is that the test case replaces SCRATCH_DEV_POOL value internally
> and calls _require_scratch_dev_pool for the replaced SCRATCH_DEV_POOL.
> With this fix, the test case will call _require_scratch_dev_pool twice
> for the original SCRATCH_DEV_POOL and the replaced SCRATCH_DEV_POOL.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/btrfs/146 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/146 b/tests/btrfs/146
> index 64c3513f..eee1a286 100755
> --- a/tests/btrfs/146
> +++ b/tests/btrfs/146
> @@ -26,6 +26,7 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_fs btrfs
> +_require_scratch_dev_pool

There's no need for the test to call _require_scratch_dev_pool twice, it
doesn't do any setup work, just to make sure there's scratch pool
defined. Move both _require_scratch and _require_scratch_dev_pool up
here should be fine. I've fixed it on commit.

Thanks,
Eryu

>  _require_dm_target error
>  _require_test_program fsync-err
>  _require_test_program dmerror
> -- 
> 2.31.1
