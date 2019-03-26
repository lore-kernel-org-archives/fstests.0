Received: from userp2120.oracle.com ([156.151.31.85]:45040 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZPqs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Mar 2019 11:46:48 -0400
Date: Tue, 26 Mar 2019 08:46:35 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fstests: Don't delete seqres.full file in generic/077
Message-ID: <20190326154635.GC6537@magnolia>
References: <20190326150158.17700-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326150158.17700-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 26, 2019 at 05:01:58PM +0200, Nikolay Borisov wrote:
> When this test finishes there is no 079.full file with output from commands. 

"077.full" ?

> Sometimes this information is useful for post mortem so stop deleting the 
> file upon test completion. 
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Looks ok to me otherwise,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

> ---
>  tests/generic/077 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/077 b/tests/generic/077
> index 284e25253c9e..d11b49c6ff15 100755
> --- a/tests/generic/077
> +++ b/tests/generic/077
> @@ -73,6 +73,5 @@ cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
>  _check_scratch_fs
>  
>  echo "*** all done"
> -rm -f $seqres.full

I had wondered about this myself... :)

--D

>  status=0
>  exit
> -- 
> 2.7.4
> 
