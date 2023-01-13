Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11CCC3DA78
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Jan 2023 21:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAMVdH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjAMVdF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jan 2023 16:33:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7060551FC
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 13:33:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 733B86232D
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 21:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82F0C433EF;
        Fri, 13 Jan 2023 21:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673645583;
        bh=vXSWhscbo4l9vz9+aFaHNPoECFQm3P0LC+R8dNm6ueo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CotQV1LUJ6T3NiO4+9OJnuPa9PK9J2YvRNwjcDSD2TPtR3PsqE/Myn4ze5qI7XYYQ
         VqJmFcn4sBnTabxoSGEo8MOucv/DZKyWnYSSdPrOVfZytAuHadbUQEqokXKID75ohS
         dzUaXxth/RUBl2I+sWywsweYlQKMcAqu7MrW4jSXpsFtQRRb3IaQJGg7uVlpIuTNPj
         rZArB+t82EnbXJzIlv1vB72TH0zE7f/IhB04kJypu4dmPJWg/s71IkWIFc947Lb07h
         wPOwarxgk3OBq5fcianV5OURdWaiFi/XFH+kSBOMdJ2hfYgvwoYQzfTkH5HcsrKCx3
         BclwYGQxKvxKA==
Date:   Fri, 13 Jan 2023 13:33:03 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/440: skip test if the dax mount option is enabled
Message-ID: <Y8HOD3P3l5nnPJO+@magnolia>
References: <1671790916-13-1-git-send-email-yangx.jy@fujitsu.com>
 <OS3PR01MB9499E00F5D2C42FCF847D81F83C29@OS3PR01MB9499.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB9499E00F5D2C42FCF847D81F83C29@OS3PR01MB9499.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 13, 2023 at 04:53:41AM +0000, yangx.jy@fujitsu.com wrote:
> Hi Darrick,
> 
> Is there any comment on the patch?

What happens if you set DAXINHERIT on the root directory and omit the
mount options?  Does it still fail?

--D


> Best Regards,
> Xiao Yang
> 
> -----Original Message-----
> From: Yang, Xiao/杨 晓 <yangx.jy@fujitsu.com> 
> Sent: 2022年12月23日 18:22
> To: djwong@kernel.org; fstests@vger.kernel.org
> Cc: zlang@kernel.org; Yang, Xiao/杨 晓 <yangx.jy@fujitsu.com>
> Subject: [PATCH] xfs/440: skip test if the dax mount option is enabled
> 
> With the enabled dax mount option, this test doesn't work well because unwritten extents will not be allocated according to the CoW extent size hint.
> 
> Try to fix the following error by the patch:
> $./check xfs/440
>     ...
>      fsgqa 64 0 0
>      Reflink and CoW
>      root 0 0 0
>     -fsgqa 1152 0 0
>     +fsgqa 128 0 0
>      Sync
>      root 0 0 0
>     ...
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  tests/xfs/440 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/440 b/tests/xfs/440 index 496ee04e..eb9fbd73 100755
> --- a/tests/xfs/440
> +++ b/tests/xfs/440
> @@ -23,6 +23,7 @@ _require_quota
>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_user
> +_exclude_scratch_mount_option dax
>  
>  echo "Format and mount"
>  _scratch_mkfs > "$seqres.full" 2>&1
> --
> 2.25.1
> 
