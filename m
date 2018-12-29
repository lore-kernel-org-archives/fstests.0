Received: from aserp2130.oracle.com ([141.146.126.79]:53956 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeL2TBX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Dec 2018 14:01:23 -0500
Date: Sat, 29 Dec 2018 11:01:17 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/nfs: add FSX_AVOID when testing on NFS
Message-ID: <20181229190117.GC20474@magnolia>
References: <20181229085304.4310-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229085304.4310-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Murphy Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 29, 2018 at 04:53:04PM +0800, Xiong Murphy Zhou wrote:
> copy_file_range on NFSv4.2 requires that src offset and dest offset
> are aligned with server blocksize. So does copy count, except that
> after this copy, we'll reach the EOF. See Linux commit 811b7b85.
> 
> ltp/fsx.c tests copy_file_range on random offset with random size
> by default. This makes these tests get EINVAL on NFS.
> 
> Signed-off-by: Xiong Murphy Zhou <xzhou@redhat.com>
> ---
>  common/nfs | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/common/nfs b/common/nfs
> index a03eaf48..5600147d 100644
> --- a/common/nfs
> +++ b/common/nfs
> @@ -33,3 +33,12 @@ _require_scratch_nfs_version()
>  	fi
>  	_scratch_unmount
>  }
> +
> +# copy_file_range on NFSv4.2 requires src offset and dest offset
> +# are aligned with server blocksize. So does copy count, except that
> +# after this copy, we'll reach the EOF. See Linux commit 811b7b85
> +# for details.
> +# ltp/fsx.c tests copy_file_range on random offset with random size
> +# by default. This makes these tests get EINVAL on NFS.

I think it's more appropriate to fix the vfs copy_file_range to fall
back to page cache copy when the nfs server declines to do it.

And, since we already know Dave Chinner is working on that, just wait
for the v2 patches.

> +# Now add FSX_AVOID to make fsx tests on NFS rational.
> +FSX_AVOID="-r 4096 -w 4096 -O -o 4096 -Z $FSX_AVOID"

How do you know the server blocksize is 4k?

Also, this forces /every/ fsx operation to be page aligned directio, I
don't think we want to apply such a big hammer.

--D

> 2.17.0.252.gfe0a9ea
> 
