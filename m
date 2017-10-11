Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:31591 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753731AbdJKFgl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Oct 2017 01:36:41 -0400
Date: Wed, 11 Oct 2017 16:35:25 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/3] common/rc: move _filter_xfs_dmesg() to common/rc
Message-ID: <20171011053525.GD15067@dastard>
References: <1507647298-9971-1-git-send-email-idryomov@gmail.com>
 <1507647298-9971-2-git-send-email-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507647298-9971-2-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 10, 2017 at 04:54:56PM +0200, Ilya Dryomov wrote:
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  common/rc  | 23 +++++++++++++++++++++++
>  common/xfs | 22 ----------------------
>  2 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 53bbb1187f81..e15c8fc27405 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2027,6 +2027,29 @@ _run_aiodio()
>      return $status
>  }
>  
> +# xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
> +# direct IO on the same file. This is a helper for _check_dmesg() to filter out
> +# such warnings.
> +_filter_xfs_dmesg()

it's a filter, so belongs in common/filter.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
