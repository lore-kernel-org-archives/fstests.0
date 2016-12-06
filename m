Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:65515 "EHLO
        ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751372AbcLFWzQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Dec 2016 17:55:16 -0500
Date: Wed, 7 Dec 2016 09:54:03 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/35[67]: update selinux context for mkswap
Message-ID: <20161206225403.GG4219@dastard>
References: <20161206080927.22379-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206080927.22379-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Dec 06, 2016 at 04:09:27PM +0800, Eryu Guan wrote:
> With selinux enabled & the default selinux context in fstests,
> mkswap is denied, generic/35[67] fail as:
> 
> +mkswap: unable to relabel /mnt/testarea/scratch/test-357/file1 to system_u:object_r:swapfile_t:s0: Operation not supported
> 
> So mount SCRATCH_DEV with swapfile selinux context if selinux is
> enabled (SELINUX_MOUNT_OPTIONS not empty).
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/356 | 4 ++++
>  tests/generic/357 | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tests/generic/356 b/tests/generic/356
> index 6bb90c0..8bebad2 100755
> --- a/tests/generic/356
> +++ b/tests/generic/356
> @@ -49,6 +49,10 @@ _require_cp_reflink
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> +# the default selinux context won't allow mkswap
> +if [ "$SELINUX_MOUNT_OPTIONS" != "" ]; then
> +	export SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
> +fi
>  _scratch_mount >> $seqres.full 2>&1
>  
>  testdir=$SCRATCH_MNT/test-$seq
> diff --git a/tests/generic/357 b/tests/generic/357
> index 439b314..8941927 100755
> --- a/tests/generic/357
> +++ b/tests/generic/357
> @@ -49,6 +49,10 @@ _require_cp_reflink
>  
>  echo "Format and mount"
>  _scratch_mkfs > $seqres.full 2>&1
> +# the default selinux context won't allow mkswap
> +if [ "$SELINUX_MOUNT_OPTIONS" != "" ]; then
> +	export SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
> +fi

Can we put this inside the proprosed _require_scratch_swap()
function or - better - just add the swapfile capability to the
default SELINUX_MOUNT_OPTIONS parameters that we set?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
