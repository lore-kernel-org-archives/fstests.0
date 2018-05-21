Received: from mail-pf0-f194.google.com ([209.85.192.194]:37505 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeEUDEf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 May 2018 23:04:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id e9-v6so6365920pfi.4
        for <fstests@vger.kernel.org>; Sun, 20 May 2018 20:04:35 -0700 (PDT)
Date: Mon, 21 May 2018 11:04:31 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/btrfs: add helper to detect dump-tree or
 btrfs-debug-tree
Message-ID: <20180521030431.GK29080@desktop.hz.ali.com>
References: <20180517111814.19652-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517111814.19652-1-dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 01:18:14PM +0200, David Sterba wrote:
> The command btrfs-debug-tree is obsolete and was removed in btrfs-progs
> version 4.16.1.  The same functionality available as 'btrfs
> inspect-internal dump-tree', let's detect which one can be used.  Test
> btrfs/085 otherwise fails with btrfs-progs 4.16.1+.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  common/btrfs    | 11 +++++++++++
>  common/config   |  1 +
>  tests/btrfs/085 |  6 ++----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 79c687f73376..dd02a1c1589d 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -59,6 +59,17 @@ _require_btrfs_dump_super()
>  	fi
>  }
>  
> +_require_btrfs_dump_tree()
> +{
> +	if [ ! -x "$BTRFS_DUMP_TREE_PROG" ]; then
> +		_require_command "$BTRFS_UTIL_PROG" btrfs
> +		if ! $BTRFS_UTIL_PROG inspect-internal dump-tree --help >& /dev/null; then
> +			_notrun "Missing btrfs-debug-tree or inspect-internal dump-tree"
> +		fi

Looks like this part could be replaced by a simple

_require_btrfs_command inspect-internal dump-tree

And _require_btrfs_dump_super() could also take use of the same
_require_btrfs_command rule.

Thanks,
Eryu

> +		BTRFS_DUMP_TREE_PROG="$BTRFS_UTIL_PROG inspect-internal dump-tree"
> +	fi
> +}
> +
>  _run_btrfs_util_prog()
>  {
>  	run_check $BTRFS_UTIL_PROG $*
> diff --git a/common/config b/common/config
> index cc3180694e26..d121af4ee254 100644
> --- a/common/config
> +++ b/common/config
> @@ -233,6 +233,7 @@ case "$HOSTOS" in
>          export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
>          export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
>          export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
> +        export BTRFS_DUMP_TREE_PROG="`set_prog_path btrfs-debug-tree`"
>  	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
>          export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
>          export MKFS_NFS_PROG="false"
> diff --git a/tests/btrfs/085 b/tests/btrfs/085
> index 804899724cba..d81bef76b471 100755
> --- a/tests/btrfs/085
> +++ b/tests/btrfs/085
> @@ -55,16 +55,14 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch
>  _require_dm_target flakey
> -
> -BTRFS_DEBUG_TREE_PROG="`set_prog_path btrfs-debug-tree`"
> -_require_command "$BTRFS_DEBUG_TREE_PROG" btrfs-debug-tree
> +_require_btrfs_dump_tree
>  
>  rm -f $seqres.full
>  
>  has_orphan_item()
>  {
>  	INO=$1
> -	if $BTRFS_DEBUG_TREE_PROG $SCRATCH_DEV | \
> +	if $BTRFS_DUMP_TREE_PROG $SCRATCH_DEV | \
>  		grep -q "key (ORPHAN ORPHAN_ITEM $INO)"; then
>  		return 0
>  	fi
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
