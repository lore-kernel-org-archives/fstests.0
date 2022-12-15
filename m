Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D40C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Dec 2022 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLOQKq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLOQKf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Dec 2022 11:10:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB032B9D
        for <fstests@vger.kernel.org>; Thu, 15 Dec 2022 08:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFFA161E38
        for <fstests@vger.kernel.org>; Thu, 15 Dec 2022 16:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A81FC433F0;
        Thu, 15 Dec 2022 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671120632;
        bh=PSjaWl5ljvyl7zZFswi2zh5RUqQTtoBaCm0/aZdZvI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIYjpEJbJu7P+6b1P6VZGgV2nIpCBfOuqvQLvVPUVVYn4+Nj13MD4eCmK93SrF6/s
         p5e5f7Vv4POCrNFXNO7pouT7Kv86nu1/dRpTeTPYXUru6gZkn3Psdx/GX4GzJBZ/0p
         ye/i82bE+NmObHptot3Nxs2GkpsWypfz6227JszDCByE8lq1RhCySyJKbM4HH7wWsB
         5h42PST5HqQJOnomndBYHp/Zcpac8vfkexLBVG12aKKMr85A0NePnHsrwpoNzPMEAW
         gpybcREVaADhyqh56rWXL1MGzt+xtnHJAvyMOlwB5hNbFF1Lq8/Wn8UKisRTOfztZJ
         J036L4uN+ygug==
Date:   Thu, 15 Dec 2022 08:10:31 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: wipe tmp.arglist
Message-ID: <Y5tG94XQmBziqveE@magnolia>
References: <20221214215926.908628-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214215926.908628-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 14, 2022 at 01:59:26PM -0800, Leah Rumancik wrote:
> Make sure tmp.arglist is wiped before each run to avoid
> accidentally rerunning tests.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Makes sense to me, though it might help to put the exact sequence of
brokenness in the commit message since (like David) I wondered why the
_summary and _wrapup functions wouldn't zap $tmp.arglist.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index d2e51296..81a30928 100755
> --- a/check
> +++ b/check
> @@ -46,7 +46,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>  # by default don't output timestamps
>  timestamp=${TIMESTAMP:=false}
>  
> -rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
> +rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
>  
>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
