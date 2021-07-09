Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA5EC07E9C
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Jul 2021 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F8861357
	for <linux-fstests@archiver.kernel.org>; Fri,  9 Jul 2021 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhGIPqL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232269AbhGIPqK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 9 Jul 2021 11:46:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FA93613B5;
        Fri,  9 Jul 2021 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625845407;
        bh=MEIXutGKUK/GyATGQqNS8yh9TwoDfSXU4gzuyqXy3H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyEjVMGqcwBPO/T9FfIAVrhF/UKkDAlFwVyU+XES+qUSLKdojRkVHCVYc00ZGd5vW
         GAXm13+2PZwe6SkSVHswa3tNJ0J0WHW1CHTxmtcvPVyr7G3Qov0xQeEgt4QRCyLw+L
         Nr7N4JO4cRwGtvghj90DAxnfvlJrBVKPWA1v+C9DDcbY0y2oCQFjKryMzb7c9PA8pW
         mtVkyl4ke67nQX9lTPlXNFUsfUjW8S/leytqivAxDAh0jdyIOEQFbZjY52BgOmHSfX
         3+FvWN3zDf/oW7gfGwJxuTtARE8blr+uvBWFeVgh7MgtQXVcQcjcxNomGXDDoznFza
         MN8mWknWKhyQw==
Date:   Fri, 9 Jul 2021 08:43:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/459: catch mount failure
Message-ID: <20210709154326.GE11571@locust>
References: <20210709061027.2282643-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709061027.2282643-1-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 09, 2021 at 04:10:27PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because if we don't, we freeze the root filesystem instead of
> $SCRATCH_MNT and it all goes downhill from there.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Heh, more mount failure whackamole. :(

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/459 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/459 b/tests/generic/459
> index 7fd7a6fa..e5e5e9ab 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -77,7 +77,9 @@ _mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
>  $LVM_PROG lvcreate  -k n -s $vgname/$lvname \
>  		    -n $snapname >>$seqres.full 2>&1
>  
> -_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT
> +# Catch mount failure so we don't blindly go an freeze the root filesystem
> +# instead of lvm volume.
> +_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT || _fail "mount failed"
>  
>  # Consume all space available in the volume and freeze to ensure everything
>  # required to make the fs consistent is flushed to disk.
> -- 
> 2.31.1
> 
