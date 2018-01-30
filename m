Received: from aserp2120.oracle.com ([141.146.126.78]:47916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeA3QQJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jan 2018 11:16:09 -0500
Date: Tue, 30 Jan 2018 08:16:05 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 1/2] generic/307: Require ACL support
Message-ID: <20180130161605.GB4844@magnolia>
References: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
 <1517320499-14714-2-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517320499-14714-2-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 30, 2018 at 01:54:58PM +0000, Rostislav Skudnov wrote:
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

> ---
>  tests/generic/307 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/307 b/tests/generic/307
> index f5d0680..bbdc70f 100755
> --- a/tests/generic/307
> +++ b/tests/generic/307
> @@ -51,6 +51,7 @@ testfile=$SCRATCH_MNT/testfile.$seq
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_acls
>  
>  echo "Silence is golden"
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
