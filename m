Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:9880 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751633AbeDLA4d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Apr 2018 20:56:33 -0400
Date: Thu, 12 Apr 2018 10:56:30 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] generic/427: used mixed mode for Btrfs
Message-ID: <20180412005630.GH729@dastard>
References: <d928f86c748db034ca4efd849e01c5c2bf805199.1523490276.git.osandov@fb.com>
 <5273be80b04afae67e5ff2137e713924c7bfc0ff.1523490276.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5273be80b04afae67e5ff2137e713924c7bfc0ff.1523490276.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 11, 2018 at 04:47:30PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This test creates a 256 MB filesystem and then writes a 200 MB file.
> With separate data and metadata, Btrfs will run out of data space since
> it needs to allocate some metadata space. Use mixed mode, which is the
> recommendation for smaller filesystems.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  tests/generic/427 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/427 b/tests/generic/427
> index 9cde5f50..b2cb4526 100755
> --- a/tests/generic/427
> +++ b/tests/generic/427
> @@ -55,6 +55,8 @@ _require_test_program "feature"
>  _require_aiodio aio-dio-eof-race
>  
>  # limit the filesystem size, to save the time of filling filesystem
> +# Btrfs needs to use mixed mode for such a small filesystem
> +[ "$FSTYP" = "btrfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -M"


_scratch_mkfs_sized() should already be adding this for small btrfs
filesystems. Yup, it does:

    btrfs)                                                                       
        local mixed_opt=                                                         
        (( fssize <= 100 * 1024 * 1024 )) && mixed_opt='--mixed'                 
        $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV        
        ;;                                                                       

>  _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1

But this uses a filesystem larger than the mixed mode threshold in
_scratch_mkfs_sized(). Please update the generic threshold rather
than special case this test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
