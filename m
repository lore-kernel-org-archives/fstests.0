Received: from mx1.redhat.com ([209.132.183.28]:52208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbcI2IBe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Sep 2016 04:01:34 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1858C0467D0
        for <fstests@vger.kernel.org>; Thu, 29 Sep 2016 08:01:33 +0000 (UTC)
Received: from localhost (dhcp-12-196.nay.redhat.com [10.66.12.196])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8T81WJH016802
        for <fstests@vger.kernel.org>; Thu, 29 Sep 2016 04:01:33 -0400
Date: Thu, 29 Sep 2016 16:01:32 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 1/2] generic/052: use _check_scratch_fs not _xfs_check
Message-ID: <20160929080132.GB4771@dhcp12-143.nay.redhat.com>
References: <1475034250-6909-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475034250-6909-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 28, 2016 at 11:44:09AM +0800, Eryu Guan wrote:
> generic/052 was made generic from an xfs test, and generic functions
> should be used not the xfs-specific ones.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/052 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/052 b/tests/generic/052
> index a81885b..74cf5b6 100755
> --- a/tests/generic/052
> +++ b/tests/generic/052
> @@ -72,7 +72,7 @@ _print_logstate
>  
>  # curious if FS consistent at start
>  if false; then
> -    if _xfs_check $SCRATCH_DEV; then
> +    if _check_scratch_fs; then

Looks good to me. Test passed on newest upstream kernel+xfsprogs and
RHEL-6.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>         echo "*** checked ok ***"
>      fi
>  fi
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
