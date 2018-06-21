Received: from mail-pl0-f68.google.com ([209.85.160.68]:42619 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932435AbeFUI5e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jun 2018 04:57:34 -0400
Date: Thu, 21 Jun 2018 16:57:28 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: btrfs/085: replace btrfs-debug-tree with btrfs
 inspect-internal dump-tree
Message-ID: <20180621085728.GL2780@desktop>
References: <20180621070422.25236-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621070422.25236-1-lufq.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 21, 2018 at 03:04:22PM +0800, Lu Fengqi wrote:
> Since btrfs-dump-tree has been removed from btrfs-progs, use btrfs
> inspect-internal dump-tree instead of btrfs-dump-tree.
> 
> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>

Then there's no user of $BTRFS_DEBUG_TREE_PROG, I think we could remove
the definition too in common/config

	export BTRFS_DEBUG_TREE_PROG=$(type -P btrfs-debug-tree)

I'll remove it on commit.

Thanks,
Eryu

> ---
>  tests/btrfs/085 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/085 b/tests/btrfs/085
> index 8cc69c21c0dd..4773ed8041fd 100755
> --- a/tests/btrfs/085
> +++ b/tests/btrfs/085
> @@ -39,14 +39,14 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch
>  _require_dm_target flakey
> -_require_command "$BTRFS_DEBUG_TREE_PROG" btrfs-debug-tree
> +_require_btrfs_command inspect-internal dump-tree
>  
>  rm -f $seqres.full
>  
>  has_orphan_item()
>  {
>  	INO=$1
> -	if $BTRFS_DEBUG_TREE_PROG $SCRATCH_DEV | \
> +	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV | \
>  		grep -q "key (ORPHAN ORPHAN_ITEM $INO)"; then
>  		return 0
>  	fi
> -- 
> 2.17.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
