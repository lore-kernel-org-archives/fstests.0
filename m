Received: from mx1.redhat.com ([209.132.183.28]:53388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753284AbcK2IQZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Nov 2016 03:16:25 -0500
Date: Tue, 29 Nov 2016 16:16:23 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 01/10] fstests: common: Introduce function to check
 qgroup correctness
Message-ID: <20161129081623.GM22989@eguan.usersys.redhat.com>
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
 <20161129073303.14776-2-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161129073303.14776-2-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 29, 2016 at 03:32:54PM +0800, Qu Wenruo wrote:
> Old btrfs qgroup test cases uses fix golden output numbers, which limits
> the coverage since they can't handle mount options like compress or
> inode_map, and cause false alert.
> 
> Introduce _btrfs_check_scratch_qgroup() function to check qgroup
> correctness using "btrfs check --qgroup-report" function, which will
> follow the way kernel handle qgroup and are proved very reliable.
> 
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  common/rc | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 8c99306..35d2d56 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3018,6 +3018,25 @@ _require_deletable_scratch_dev_pool()
>  	done
>  }
>  
> +# We check if "btrfs check" support to check qgroup correctness
> +# Old fixed golden output can cover case like compress and inode_map
> +# mount options, which limits the coverage
> +_require_btrfs_check_qgroup()
> +{
> +	_require_command "$BTRFS_UTIL_PROG" btrfs
> +	output=$($BTRFS_UTIL_PROG check --help | grep "qgroup-report")
> +	if [ -z "$output" ]; then

No need to save command output to a var, you can check the return value
of btrfs, e.g.

	if ! $BTRFS_UTIL_PROG check --help | grep -q "qgroup-report"; then
		_notrun "..."
	fi

The output is only needed when we need to do further operations on it,
e.g. in _require_xfs_io_command.

> +		_notrun "$BTRFS_UTIL_PROG too old (must support 'check --qgroup-report')"
> +	fi
> +}
> +
> +_btrfs_check_scratch_qgroup()
> +{
> +	_require_btrfs_check_qgroup

This _require belongs to each test that calls
_btrfs_check_scratch_qgroup.

And I think you can put the introduction of this helper and the
conversions to use this helper all together in one patch (so we know why
it's introduced and how it gets used from one patch), and all adding
extra qgroup check updates to another patch.

Thanks,
Eryu

> +	$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 |\
> +		grep -E "Counts for qgroup.*are different"
> +}
> +
>  # We check for btrfs and (optionally) features of the btrfs command
>  _require_btrfs()
>  {
> -- 
> 2.7.4
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
