Received: from mx2.suse.de ([195.135.220.15]:58377 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbeFUHLt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Jun 2018 03:11:49 -0400
Subject: Re: [PATCH] fstests: btrfs/085: replace btrfs-debug-tree with btrfs
 inspect-internal dump-tree
References: <20180621070422.25236-1-lufq.fnst@cn.fujitsu.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <473ce802-e95b-994b-09da-c9fda44af80c@suse.com>
Date: Thu, 21 Jun 2018 10:11:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180621070422.25236-1-lufq.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Lu Fengqi <lufq.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 21.06.2018 10:04, Lu Fengqi wrote:
> Since btrfs-dump-tree has been removed from btrfs-progs, use btrfs
> inspect-internal dump-tree instead of btrfs-dump-tree.
> 
> Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

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
> 
