Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67320C433ED
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Apr 2021 03:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C1161041
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Apr 2021 03:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhDADkq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 31 Mar 2021 23:40:46 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41525 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233201AbhDADke (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 Mar 2021 23:40:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UU.FG43_1617248432;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UU.FG43_1617248432)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 01 Apr 2021 11:40:33 +0800
Date:   Thu, 1 Apr 2021 11:40:32 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, guan@eryu.me
Subject: Re: [PATCH v2 3/4] generic/554: hide permision warning on exfat
Message-ID: <20210401034032.GP95214@e18g06458.et15sqa>
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-4-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330220005.56019-4-preichl@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 31, 2021 at 12:00:04AM +0200, Pavel Reichl wrote:
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 13 +++++++++++++
>  tests/generic/554 |  3 ++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 2d658711..379140ea 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2401,6 +2401,19 @@ _format_swapfile() {
>  	fi
>  }
>  
> +_format_swapon_file() {

It's not a "format" action anymore, the _format prefix seems misleading.
I think _swapon_file seems fine.

Thanks,
Eryu

> +	local fname="$1"
> +
> +	if [ "$FSTYP" = "exfat" ]; then
> +		# exfat does not support posix file permisions, so warning is
> +		# to be expected
> +		swapon "$fname" |& grep -v "insecure permissions"
> +	else
> +		swapon "$fname"
> +	fi
> +
> +}
> +
>  # Check that the filesystem supports swapfiles
>  _require_scratch_swapfile()
>  {
> diff --git a/tests/generic/554 b/tests/generic/554
> index fa4f97d2..c2f9eee8 100755
> --- a/tests/generic/554
> +++ b/tests/generic/554
> @@ -46,7 +46,8 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $SCRATCH_MNT/file >> $seqres.full 2>&
>  
>  echo swap files return ETXTBUSY
>  _format_swapfile $SCRATCH_MNT/swapfile 16m
> -swapon $SCRATCH_MNT/swapfile
> +_format_swapon_file $SCRATCH_MNT/swapfile
> +
>  $XFS_IO_PROG -f -c "copy_range -l 32k $SCRATCH_MNT/file" $SCRATCH_MNT/swapfile
>  swapoff $SCRATCH_MNT/swapfile
>  
> -- 
> 2.30.2
