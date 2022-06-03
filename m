Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71371C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jun 2022 02:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiFCCls (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Jun 2022 22:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiFCClr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Jun 2022 22:41:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E1B217
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 19:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D170ACE21FD
        for <fstests@vger.kernel.org>; Fri,  3 Jun 2022 02:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD0CC34119;
        Fri,  3 Jun 2022 02:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654224101;
        bh=lBNq2E1w6PcNCTjajTVN6Npn8rKLaVF6YTd68avv1Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q10YRtSBfIrv3YrfdVe7Og8fPBjTEwmyW0YAbtWR9o3SI3jzNULraWW6zKtfTrhmW
         h9zbqVGNqp8WoB11JERFFbqigs2ZcPhaxUb86jmAmfrGrT6m+b3y5PbuJlnbYhkZMt
         W+h7lyYhtrc7UMKmIkhgQh93bzWqRfJsp5SXehM+yr/V6qTqSrO6mEnl+68tnKccfJ
         PZIfU6Z2uOPCcZ4cNmrO3TF5LsKhPsuAowWXfuOwjpoc0RYd+rmCvdm+3KUsuGilRY
         GX1mGynrW/TCFF/my0D8wO2Syk/Jiu7IEenpo1D58DAfKT+UmSU3v+gfOMl3G1MfSy
         YTD67WF7f76WA==
Date:   Thu, 2 Jun 2022 19:41:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 8/8 v2] xfs/189: systemd monitoring of /etc/fstab sucks
Message-ID: <Ypl05X1Gddfjzf63@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-9-david@fromorbit.com>
 <20220603015413.GP227878@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603015413.GP227878@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 03, 2022 at 11:54:13AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> On a recently upgraded system, xfs/189 still works just fine, but
> every test run after it now gets spammed from mount/systemd
> like so:
> 
> xfs/189 [not run] noattr2 mount option not supported on /dev/vdc
> xfs/190 1s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
>  1s
> xfs/192 3s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
>  2s
> xfs/193 2s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
>  2s
> xfs/194 1s ... mount: (hint) your fstab has been modified, but systemd still uses
>        the old version; use 'systemctl daemon-reload' to reload.
> 
> This is because xfs/189 modifies /etc/fstab during the test, then
> restores it to it's original condition so there's nothing to update.
> However, systemd is sees that the mtime of /etc/fstab has changed,
> and assumes they sky has fallen and so everything must be reloaded
> from scratch to silence the unnecessary "hint".
> 
> We can avoid this clumsiness by capturing the mtime of /etc/fstab
> before we modify it, and restore it afterwards and that means
> systemd doesn't even notice that we've being playing around with
> /etc/fstab.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
> V2:
> - use systemctl daemon-reload instead of mtime futzing as Darrick
>   suggested.

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
>  tests/xfs/189 | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/189 b/tests/xfs/189
> index e601881a..bc7ccca5 100755
> --- a/tests/xfs/189
> +++ b/tests/xfs/189
> @@ -32,6 +32,23 @@
>  #
>  # <---- Normal programming is resumed ---->
>  #
> +# <---- Bbbzzzzzzztttt ---->
> +#
> +# < systemd enters the chat >
> +#
> +# xfs/189 [not run] noattr2 mount option not supported on /dev/vdc
> +# xfs/190 1s ... mount: (hint) your fstab has been modified, but systemd still uses
> +#        the old version; use 'systemctl daemon-reload' to reload.
> +#  1s
> +#  xfs/192 3s ... mount: (hint) your fstab has been modified, but systemd still uses
> +#        the old version; use 'systemctl daemon-reload' to reload.
> +#
> +# mount/systemd sees that /etc/fstab has changed (because mtime changed)
> +# and so it whines that systemd needs updating on every mount from this point
> +# onwards. Yes, that's totally obnoxious behaviour from mount/systemd but we
> +# have to work around it.
> +#
> +# < systemd leaves the chat >
>  #
>  . ./common/preamble
>  _begin_fstest mount auto quick
> @@ -190,6 +207,10 @@ ENDL
>  # Example fstab entry
>  # /dev/sdb2            /mnt/scratch1        xfs       defaults 0 0
>  #
> +# Note that to avoid mnt/systemd whining about /etc/fstab being modified, we
> +# need to ensure that it reloads it's state once we restore the fstab to
> +# original.
> +#
>  _add_scratch_fstab()
>  {
>  	# comment out any existing SCRATCH_DEV
> @@ -201,7 +222,7 @@ _add_scratch_fstab()
>  
>  _modify_scratch_fstab()
>  {
> -	opts=$1
> +	local opts=$1
>  
>  	# modify our fstab entry that we added
>  	# modify opts by looking for last word which has non-space chars
> @@ -215,6 +236,9 @@ _putback_scratch_fstab()
>  
>  	# remove the one we added at the end
>  	$SED_PROG -i "/# $tag/d" /etc/fstab
> +
> +	# stop mount/systemd whining that /etcfstab was changed.
> +	command -v systemctl > /dev/null 2>&1 && systemctl daemon-reload
>  }
>  
>  # Import common functions.
> -- 
> Dave Chinner
> david@fromorbit.com
