Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A4FC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Sep 2021 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F043461057
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Sep 2021 17:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbhICRte (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhICRtb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Sep 2021 13:49:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52C4E60E93;
        Fri,  3 Sep 2021 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630691311;
        bh=IJ6MVvZ1eCcFVd0Fr03yXsfICZUWofKGe0iqprdx4BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syRHsNbQDIhf+qgjotThF8C07XnNXepJIyE4Fch9uouiWE0sq4ZKLaNiOeq64AzQi
         wEOrX1rWlndUDAI3nJD80qDdRWksdSPKwONuzDvFrT85EhTf0+tjRwf8hJO9WUFIXW
         HPHuoAhp+L7lVblA619sNaFgJH3d9twIXPaUJR40OfMe4M7Ztf7xcpTKLcHoX12TsN
         ZzKk5ln5dRuxVUpaxLGDNzQmThr9OgXchZ6kb3PsSi5ODUD+fSRBTVssibAu+7h8ce
         CWhZOBan99RMsiBR4XS3RriPVMIu1c9wKuqCqZh+wV1GRaemy/kmX0uHDV3e7SPa/+
         ZyABwqX2cqqfw==
Date:   Fri, 3 Sep 2021 10:48:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Xiong Zhou <xzhou@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v3] common/rc: fix MKSWAP_PROG quoting
Message-ID: <20210903174830.GC9911@magnolia>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
 <20210831052632.p4kaygjeujipo4w5@fedora>
 <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
 <20210831134207.aa4e26xuyji4npia@fedora>
 <YS5hRsSXNHYQdUv9@mit.edu>
 <20210901054822.phzkg5xqoocx3duq@xzhoux.usersys.redhat.com>
 <20210901071545.GA1756565@dread.disaster.area>
 <20210901094024.424whsgozs5lwyzo@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901094024.424whsgozs5lwyzo@xzhoux.usersys.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 01, 2021 at 05:40:24PM +0800, Xiong Zhou wrote:
> After commit
>   0e4dd8b9 common/rc: fix ignoring of errors on
> we are getting this error message when running swapfiles tests:
>   +./common/rc: line 2553: MKSWAP_PROG: command not found
> 
> Rewrite the line.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>

Aha, I was wondering why the test counts were lower after last Sunday's
rebase.  Works for me, so:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> Thanks all for the suggestions!
> 
> v2:
>   rewrite the line and add a filter
>   source filters for generic/643
> v3:
>   drop the filter, use grep
> 
>  common/rc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 46b6b220..00f3023f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2550,7 +2550,8 @@ _format_swapfile() {
>  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
>  	# Ignore permission complaints on filesystems that don't support perms
> -	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
> +	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | \
> +		grep -v "insecure permission"
>  }
>  
>  _swapon_file() {
> -- 
> 2.20.1
> 
