Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:36125 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134AbaLVSpq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 22 Dec 2014 13:45:46 -0500
Message-ID: <549866D8.1030507@sandeen.net>
Date: Mon, 22 Dec 2014 12:45:44 -0600
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfstests: f2fs support
References: <1401717572-21731-1-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1401717572-21731-1-git-send-email-jaegeuk@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: jaegeuk@kernel.org, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforget.net
List-ID: <fstests@vger.kernel.org>

(redirecting to the new fstests list)

Dave, this got a review from Lukas, and seems fine.
Can you pull it in?

Thanks,
-Eric

On 6/2/14 8:59 AM, jaegeuk@kernel.org wrote:
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> This patch adds to support f2fs file system.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/config | 7 +++++++
>  common/rc     | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/common/config b/common/config
> index 0dbf0b9..0607294 100644
> --- a/common/config
> +++ b/common/config
> @@ -210,6 +210,7 @@ case "$HOSTOS" in
>          export MKFS_XFS_PROG="`set_prog_path mkfs.xfs`"
>          export MKFS_UDF_PROG="`set_prog_path mkudffs`"
>          export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
> +        export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
>          export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
>          export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
>          export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
> @@ -241,6 +242,9 @@ _mount_opts()
>  		# acls & xattrs aren't turned on by default on ext$FOO
>  		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
>  		;;
> +	f2fs)
> +		export MOUNT_OPTIONS="-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
> +		;;
>  	reiserfs)
>  		# acls & xattrs aren't turned on by default on reiserfs
>  		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
> @@ -295,6 +299,9 @@ _fsck_opts()
>  	reiserfs)
>  		export FSCK_OPTIONS="--yes"
>  		;;
> +	f2fs)
> +		export FSCK_OPTIONS=""
> +		;;
>  	*)
>  		export FSCK_OPTIONS="-n"
>  		;;
> diff --git a/common/rc b/common/rc
> index f27ee53..fcdabfe 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -105,6 +105,9 @@ case "$FSTYP" in
>      btrfs)
>  	 [ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
>  	 ;;
> +    f2fs)
> +	 [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
> +	 ;;
>      nfs)
>  	 ;;
>  esac
> @@ -511,6 +514,9 @@ _scratch_mkfs()
>      tmpfs)
>  	# do nothing for tmpfs
>  	;;
> +    f2fs)
> +        $MKFS_F2FS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
> +	;;
>      *)
>  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $SCRATCH_DEV
>  	;;
> 

