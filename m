Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBFC07E95
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293B261CC2
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhGGOyj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhGGOyj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Jul 2021 10:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B8B061130;
        Wed,  7 Jul 2021 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625669519;
        bh=y+6+juX19wCKgG3hqMKyhqmHMbeSltLDm0VofFVtnwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4SJ0kPMGK+WHC9U59x54UL8oVWFID0CAzdMk/sgZkvcdRXwJvv6N+MUufUMoPnS+
         NPUTnXJEEbkEmOOSsTtJrYHo0USTtQ1uTySHnfIJe1kvVW7/NyhINB+AaG8fbPEBJh
         Qf4AFeq4svm+dLSSgMIbhH7NILVwDLswTO1D+ZrXNLULltR63wy2hO/raMAhC682S7
         8t4UlvPudSc8T9DHppTHkAV+MUvRnqHWPR1FPXgIr3NJkhZEd4IRCUoYraPeKJaHoI
         3hVKlIIq/WZ2d2EhmVEDyXvznxf9JRSL1ZwfUVjSe945+uPKZGbgxxkYhD8/AChE7h
         BFvg/j1DrmoWQ==
Date:   Wed, 7 Jul 2021 07:51:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, shreeya.patel@collabora.com
Subject: Re: [PATCH 1/1] generic/453: Do NOT run for FSs restricting names
Message-ID: <20210707145158.GC11571@locust>
References: <20210707102007.66774-1-preichl@redhat.com>
 <20210707102007.66774-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707102007.66774-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 07, 2021 at 12:20:07PM +0200, Pavel Reichl wrote:
> Running generic/453 test is probably only useful for filesystems that
> allow unrestricted byte streams for names.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/rc         | 11 +++++++++++
>  tests/generic/453 |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index d4ad421e..7a352445 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4599,6 +4599,17 @@ _require_od_endian_flag()
>  		_notrun "od does not support endian flag"
>  }
>  
> +_require_names_are_bytes() {

This helper needs a short description.

# Skip this test unless the filesystem treats names (directory entries,
# fs labels, and extended attribute names) as raw byte sequences.

> +        case "$FSTYP" in
> +        ext2|ext3|ext4|xfs|btrfs)

Does this need to _notrun ext4 filesystems that have casefolding
enabled?  (Or: should we let the ext4 developers figure that out?)

> +		# do nothing
> +	        ;;
> +	*)
> +                _notrun "$FSTYP does now allow unrestricted byte streams for names"
> +		;;
> +        esac
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/453 b/tests/generic/453
> index 55ddcc01..a0fb802e 100755
> --- a/tests/generic/453
> +++ b/tests/generic/453
> @@ -15,6 +15,7 @@ _begin_fstest auto quick dir
>  # Import common functions.
>  
>  _require_scratch
> +_require_names_are_bytes

Do you need this for generic/454 as well?

--D

>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> -- 
> 2.31.1
> 
