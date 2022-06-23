Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC5C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 23 Jun 2022 19:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiFWTNu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiFWTN3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 15:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D863636
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 11:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 797B6B824B8
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 18:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A6BC3411B;
        Thu, 23 Jun 2022 18:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656008265;
        bh=jIU8W+d7RPWvMvPlEiMseDP+rdN3k8og4YwRXnHtF1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4kPlvQ3lFq3wQoVdtGSgD+BgLAc+ylPROYBL8ueUxIO8KyaPNzNwpVmAdgEgIOHE
         SaBaCRgQzxx8RpY7TaHRi5UPk4fvMrDkgiG3ymgCMmZR8cKp1Ry66/iMZDxi/XzME8
         e4J9zb7JYooaXtbELpHU+0Zk7Fa70runKT+yAoF6TYIBhM2rhESmb5XMcf5eIqh23b
         GMDhGs3O+knCht/WZl3iJDk8TBclZeJnBt70cshf3Sgg92OtBXZG87pabujJN8fFdf
         3hf2YL8Wvt/3D4RrIJwzbddl0eg595g/irdbj6vgvRW0Lz24yvbSIhu+gSF8+std6+
         XcR3yQLaQKA4A==
Date:   Thu, 23 Jun 2022 11:17:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <YrSuSKLKA6LMjyf/@magnolia>
References: <20220623160825.31788-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623160825.31788-1-lan@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 12:08:25AM +0800, An Long wrote:
> _scratch_mkfs_sized() only receive integer number of bytes as a valid
> input. But if the MKFS_OPTIONS variable exists, it will use the value of
> block size in MKFS_OPTIONS to override input. In case of
> MKFS_OPTIONS="-b 4k", would result in blocksize=4 but not 4096. This
> will give errors to ext2/3/4 etc, and brings potential bugs to xfs or
> btrfs.
> 
> Therefore, add validation check to force MKFS_OPTIONS to use pure
> integer in bytes for any size value.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  README        | 3 ++-
>  common/config | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 80d148be..7c2d3334 100644
> --- a/README
> +++ b/README
> @@ -241,7 +241,8 @@ Misc:
>     this option is supported for all filesystems currently only -overlay is
>     expected to run without issues. For other filesystems additional patches
>     and fixes to the test suite might be needed.
> -
> + - If MKFS_OPTIONS is used, the size value must be an integer number of bytes
> +   without units. For example, set MKFS_OPTIONS="-b 4096" but not "-b 4k".

IDGI.  mkfs.$FSTYP does its own input validation, which means that fstest
runners are required to set MKFS_OPTIONS to something that mkfs will
accept.  It's not the job of fstests to add /another/ layer of
validation...

>  ______________________
>  USING THE FSQA SUITE
>  ______________________
> diff --git a/common/config b/common/config
> index de3aba15..ec723ac4 100644
> --- a/common/config
> +++ b/common/config
> @@ -896,5 +896,10 @@ else
>  	fi
>  fi
>  
> +# check the size value in $MKFS_OPTIONS is an integer
> +if [[ $MKFS_OPTIONS =~ [0-9]+[^0-9\ ] ]] ; then

...because this regex will break /any/ MKFS_OPTIONS with a number
followed by a letter.  mkfs.xfs handles units just fine, so I don't
understand why you're adding this blunt instrument.

MKFS_OPTIONS='-b size=1k' works just fine for XFS.

--D

> +        _fatal "error: \$MKFS_OPTIONS: Only number in bytes is allowed, no units."
> +fi
> +
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.35.3
> 
