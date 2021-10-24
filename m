Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA75C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 14:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CF060F45
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 14:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJXOL7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Oct 2021 10:11:59 -0400
Received: from out20-169.mail.aliyun.com ([115.124.20.169]:60620 "EHLO
        out20-169.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhJXOL7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Oct 2021 10:11:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1918012|-1;BR=01201311R981S22rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0640395-0.00307541-0.932885;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Lh078Te_1635084576;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lh078Te_1635084576)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 24 Oct 2021 22:09:36 +0800
Date:   Sun, 24 Oct 2021 22:09:36 +0800
From:   Eryu Guan <guan@eryu.me>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: Include swap in memory size calculation
Message-ID: <YXVpIJe6Wz0leDqq@desktop>
References: <20211015183534.2193978-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015183534.2193978-1-willy@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 15, 2021 at 07:35:34PM +0100, Matthew Wilcox (Oracle) wrote:
> _free_memory_bytes() is used to determine whether it's reasonable to
> create a tmpfs of a particular size.  Since tmpfs can swap (and some of
> these tests are good for evaluating swapping), it makes sense to include
> the free swap as well as the free memory in the calculation.
> 
> Use perl instead of awk because at least mawk will saturate at 2^31-1.
> gawk doesn't, but that kind of dependency is a bad thing to require.
> At least this eliminates a use of grep.
> 
> With this fixed, generic/273 generic/274 generic/275 generic/312
> generic/320 generic/466 all now pass on tmpfs instead of being skipped.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f693d39..f84d3873 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -966,7 +966,7 @@ _scratch_pool_mkfs()
>  # Return the amount of free memory available on the system
>  _free_memory_bytes()
>  {
> -    free -b | grep ^Mem | awk '{print $4}'
> +    free -b | perl -lane '$F[0] =~ /^[A-Z]/ and $total += $F[3]; END { print $total }'
>  }
>  
>  _available_memory_bytes()

This _available_memory_bytes() may also use _free_memory_bytes(), and
right now only generic/551 takes use of it, but generic/551 doesn't seem
to want to include swap.

Perhaps introduce a new helper to query free memory including swap space?

Thanks,
Eryu
