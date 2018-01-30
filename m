Received: from userp2130.oracle.com ([156.151.31.86]:56440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeA3QOo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jan 2018 11:14:44 -0500
Date: Tue, 30 Jan 2018 08:14:37 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 2/2] generic/{274,315}: Require falloc -k support
Message-ID: <20180130161437.GA4844@magnolia>
References: <1517320499-14714-1-git-send-email-rostislav@tuxera.com>
 <1517320499-14714-3-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517320499-14714-3-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 30, 2018 at 01:54:59PM +0000, Rostislav Skudnov wrote:
> These test cases require filesystem support for FALLOC_FL_KEEP_SIZE
> flag in fallocate().
> 
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

> ---
>  tests/generic/274 | 2 +-
>  tests/generic/315 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/274 b/tests/generic/274
> index 7d09386..a3f8c75 100755
> --- a/tests/generic/274
> +++ b/tests/generic/274
> @@ -48,7 +48,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> -_require_xfs_io_command "falloc"
> +_require_xfs_io_command "falloc" "-k"
>  
>  echo "------------------------------"
>  echo "preallocation test"
> diff --git a/tests/generic/315 b/tests/generic/315
> index 4433b6c..954f8a9 100755
> --- a/tests/generic/315
> +++ b/tests/generic/315
> @@ -49,7 +49,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> -_require_xfs_io_command "falloc"
> +_require_xfs_io_command "falloc" "-k"
>  
>  rm -f $seqres.full
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
