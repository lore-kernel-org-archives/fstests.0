Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:54847 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933286AbbENCOV (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 13 May 2015 22:14:21 -0400
Date: Thu, 14 May 2015 12:14:06 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: be compatible with older mkfs.xfs which has no
 v5 support
Message-ID: <20150514021406.GO15721@dastard>
References: <1431258643-13620-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431258643-13620-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, May 10, 2015 at 07:50:43PM +0800, Eryu Guan wrote:
> With the change to CRCs by default, some tests are updated to call mkfs
> with "-m crc=0" option directly, and this breaks testings on older
> distros where mkfs.xfs doesn't have crc support.
> 
> Introduce a new variable to tell if mkfs.xfs supports v5 xfs and do
> tweaks in _scratch_mkfs_xfs_opts() based on it.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> This is based on Dave's commit "filter: inode size output of mkfs.xfs can change"
> 
> Tested on upstream kernel with upstream xfsprogs(v5 as default) and on RHEL7(v4
> as default) and on RHEL6(no v5 support), all seem fine, no failures caused by
> crc options.
> 
>  check         | 10 +++++++++-
>  common/rc     |  5 +++++
>  tests/xfs/073 |  4 +++-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index 4fa96ed..568c05b 100755
> --- a/check
> +++ b/check
> @@ -505,9 +505,17 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  
>  	if [ ! -z "$SCRATCH_DEV" ]; then
>  	  umount $SCRATCH_DEV 2>/dev/null
> +
> +	  # check if mkfs.xfs supports v5 xfs
> +	  if [ "$FSTYP" == "xfs" ]; then
> +		export XFS_MKFS_HAS_NO_META_SUPPORT=""
> +		if ! _scratch_mkfs -m crc=0 >/dev/null 2>&1; then
> +			export XFS_MKFS_HAS_NO_META_SUPPORT=true
> +		fi
> +	  fi
> +

Shouldn't this be somewhere in common/config, not in the check
script itself?

Also, _scratch_mkfs_xfs_supported already exists for checking
various options exist in mkfs.xfs....

> diff --git a/tests/xfs/073 b/tests/xfs/073
> index 45a3fdf..acac8b8 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -156,7 +156,9 @@ _verify_copy $imgs.image $SCRATCH_DEV $SCRATCH_MNT
>  
>  echo 
>  echo === copying scratch device to single target, large ro device
> -${MKFS_XFS_PROG} -m crc=0 -dfile,name=$imgs.source,size=100g | _filter_mkfs 2>/dev/null
> +mkfs_crc_opts="-m crc=0"
> +[ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ] && mkfs_crc_opts=""
> +${MKFS_XFS_PROG} $mkfs_crc_opts -dfile,name=$imgs.source,size=100g | _filter_mkfs 2>/dev/null

This is kinda messy. Just use if/then/else, it's much easy to read.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
