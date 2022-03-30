Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C8BC433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 15:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbiC3P6H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348540AbiC3P5o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 11:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42311A35
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 08:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11CBEB81D56
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 15:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A776C340EC;
        Wed, 30 Mar 2022 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648655756;
        bh=b9AvcR+vvASVwhsrql7wYv/R+93EkAiMWLxyVJPiJeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cF4fmBniK4loLd2qvPOtIGEhgehd7WAklp/BfxE3D1sBDr2lL0W1Xg0aNMRkMidVq
         5Cx8EQ+5tXU05rzRnhrA0wlrNxwc+bGZEqPkMW2YX8D3IZIehN8f0tYoYrT6Ytkcfj
         5e/BL4EUJV4uyCWORm5tOr0FLFdbwzvLT9YU+LQJngk1aM1gWUxRa4SRK8igWGkUdX
         Jzx2zcbIsuNLKCvxONdDg6sBdf+XQB5hyP9LgvI/RqMZ72NOBrP5LO4YJZawgtPpCK
         aJGemB1v6b3Cld88ktxprZZkyboZ+TiN2iT8byxKMi+7OmzuoPc6BQoemdsd5GAcsp
         Olhuq7oYaTu+w==
Date:   Wed, 30 Mar 2022 08:55:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/674: replace _require_scratch_reflink with
 _require_scratch_dedupe
Message-ID: <20220330155556.GA27665@magnolia>
References: <20220330060339.1528398-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330060339.1528398-1-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 30, 2022 at 02:03:39PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>

Not sure why this showed up 3x, but I'll RVB the newest one since this
is correct:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/674 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/674 b/tests/generic/674
> index bf0bcffb..920ed5f2 100755
> --- a/tests/generic/674
> +++ b/tests/generic/674
> @@ -18,7 +18,7 @@ _begin_fstest auto clone quick
>  # Modify as appropriate.
>  _supported_fs generic
>  _require_user
> -_require_scratch_reflink
> +_require_scratch_dedupe
>  _require_xfs_io_command dedupe
>  
>  _scratch_mkfs >> $seqres.full
> -- 
> 2.27.0
> 
