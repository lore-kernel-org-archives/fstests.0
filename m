Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF1EC43334
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355224AbiFARfS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 13:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352260AbiFARfR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 13:35:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E5A5014
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 10:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD619B81BBA
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EE7C385A5;
        Wed,  1 Jun 2022 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654104914;
        bh=HtZHvdvNQaL+dvsVSWtrmXC3wJAEA6wCILyh28SWxz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2qwEIBsx9gP8eSUzvXFjXglSKUB1MkMyOlHvqQj34KFjrg+vBmTU2MvkCgOs81nx
         6HnU4QaC/1qHLhXO9wSwptij5eZ4roX6Yruf/kmt9cGwSUS0gSD7piL+PYoBMhtyNJ
         sakh9nfGDQtYjOuyiDCZQajwNVNej2L7kR3CMmfAWpVVIz2sXnhW+llakXYoyCX9CK
         7VVjfePrleySVKEQJr/twLlrmOe1ROiwGWhJGHSpvr6l/KrZqb60ZIq4tZKri4UHJw
         LNjTSIdS3cVcCjZS2Dwq++wF8oq1ZLIpfuzT5oJ+c09nldjkhpUiOPnbkKrezO9P+m
         3lOMG7uoFfv2Q==
Date:   Wed, 1 Jun 2022 10:35:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/5] generic/506: call _require_quota before _qmount
Message-ID: <YpejUcnCx/LVAfk2@magnolia>
References: <20220601063730.1726879-1-zlang@kernel.org>
 <20220601063730.1726879-3-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601063730.1726879-3-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 01, 2022 at 02:37:27PM +0800, Zorro Lang wrote:
> The g/506 fails on some filesystems (e.g. overlay) which doesn't
> support prjquota:
> 
>   MOUNT_OPTIONS =  -o prjquota
>   qmount failed
> 
> To avoid this failure, call _require_quota before doing real quota
> mount.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/506 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/506 b/tests/generic/506
> index 25a5b0f8..ec91af78 100755
> --- a/tests/generic/506
> +++ b/tests/generic/506
> @@ -27,6 +27,7 @@ _begin_fstest shutdown auto quick metadata quota
>  _supported_fs generic
>  
>  _require_scratch
> +_require_quota
>  _require_scratch_shutdown
>  
>  _scratch_mkfs >/dev/null 2>&1
> -- 
> 2.31.1
> 
