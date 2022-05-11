Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C68DC433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 04:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbiEKEzn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 00:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiEKEzm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 00:55:42 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9461BC1B
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 21:55:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4CEC35346C7;
        Wed, 11 May 2022 14:55:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1noeNt-00AZAB-3S; Wed, 11 May 2022 14:55:37 +1000
Date:   Wed, 11 May 2022 14:55:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] casefold: Fix expansion of seqres variable
Message-ID: <20220511045537.GF2306852@dread.disaster.area>
References: <20220511002520.352812-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511002520.352812-1-krisman@collabora.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=627b41cb
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=QX4gbG5DAAAA:8 a=7-415B0cAAAA:8
        a=z0GxwwAP52pGHsxrT58A:9 a=CjuIK1q_8ugA:10 a=AbAUZ8qAyYyZVLSsDulk:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 10, 2022 at 08:25:20PM -0400, Gabriel Krisman Bertazi wrote:
> seqres is not properly expanded on these error paths, causing a file
> called seqres.full to be created instead.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  common/casefold | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/casefold b/common/casefold
> index 9172d818125a..7e8f941211db 100644
> --- a/common/casefold
> +++ b/common/casefold
> @@ -25,7 +25,7 @@ _require_scratch_casefold()
>  		_notrun "$FSTYP does not support casefold feature"
>  	fi
>  
> -	if ! _scratch_mkfs_casefold &>>seqres.full; then
> +	if ! _scratch_mkfs_casefold &>>$seqres.full; then

PLease add a space between the &>> and $seqres.full while you are
fixing this. It's unreadable without proper whitespace separation...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
