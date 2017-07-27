Received: from mx1.redhat.com ([209.132.183.28]:7024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbdG0FSe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 27 Jul 2017 01:18:34 -0400
Date: Thu, 27 Jul 2017 13:18:30 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests PATCH] gfs2: allow testing with gfs2
Message-ID: <20170727051830.GA9167@eguan.usersys.redhat.com>
References: <20170726184331.27953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170726184331.27953-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, cluster-devel@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 26, 2017 at 02:43:31PM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> For now, just have it avoid locking. With a fixed kernel,
> generic/441 now passes.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  common/config     | 1 +
>  common/rc         | 7 +++++++
>  tests/generic/441 | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 5091db9d5099..eb32efc105db 100644
> --- a/common/config
> +++ b/common/config
> @@ -244,6 +244,7 @@ case "$HOSTOS" in
>          export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
>  	export E2FSCK_PROG="`set_prog_path e2fsck`"
>  	export TUNE2FS_PROG="`set_prog_path tune2fs`"
> +        export MKFS_GFS2_PROG="`set_prog_path mkfs.gfs2`"
>          ;;
>  esac
>  
> diff --git a/common/rc b/common/rc
> index bd989bb5f4dd..70bb39225368 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -158,6 +158,9 @@ case "$FSTYP" in
>      ext4)
>  	 [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
>  	 ;;
> +    gfs2)
> +	 [ "$MKFS_GFS2_PROG" = "" ] && _fatal "mkfs.gfs2 not found"
> +	 ;;

The above two changes seem fine.

>      f2fs)
>  	 [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
>  	 ;;
> @@ -861,6 +864,10 @@ _scratch_mkfs()
>  		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
>  		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
>  		;;
> +	gfs2)
> +		mkfs_cmd="$MKFS_GFS2_PROG -p lock_nolock -O"
> +		mkfs_filter="cat"
> +		;;

This seems unnecessary, we already have gfs2 support and the
"-p lock_nolock -O" part is already added to MKFS_OPTIONS in
_mkfs_opts() in common/config (when MKFS_OPTIONS is empty).

generic/411 runs and fails (fails due to kernel bug, not test config
issue) now on gfs2 even without this change.

>  	*)
>  		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
>  		mkfs_filter="cat"
> diff --git a/tests/generic/441 b/tests/generic/441
> index 075d87723ca1..b98f709cb6eb 100755
> --- a/tests/generic/441
> +++ b/tests/generic/441
> @@ -55,7 +55,7 @@ case $FSTYP in
>  	btrfs)
>  		_notrun "btrfs has a specialized test for this"
>  		;;
> -	ext3|ext4|xfs)
> +	ext3|ext4|gfs2|xfs)

Without external log device support in _scratch_mkfs for gfs2, this
doesn't seem right to me. Perhaps we should add external log support for
gfs2 then update this test, in different patches?

Thanks,
Eryu

>  		# Do the more thorough test if we have a logdev
>  		_has_logdev && sflag=''
>  		;;
> -- 
> 2.13.3
> 
