Received: from mx1.redhat.com ([209.132.183.28]:39438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932872AbcLHEAy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Dec 2016 23:00:54 -0500
Date: Thu, 8 Dec 2016 12:00:43 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] fstests: common: rename and enhance _require_btrfs
 to _require_btrfs_subcommand
Message-ID: <20161208040043.GE29149@eguan.usersys.redhat.com>
References: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 08, 2016 at 10:04:55AM +0800, Qu Wenruo wrote:
> Rename _require_btrfs() to _require_btrfs_subcommand() to avoid
> confusion, as all other _require_btrfs_* has a quite clear suffix, like
> _require_btrfs_mkfs_feature() or _require_btrfs_fs_feature().
> 
> Also enhance _require_btrfs_subcommand() to accept 2nd level commands or
> options.
> Options will be determined by the first "-" char.
> This is quite useful for case like "btrfs inspect-internal dump-tree"
> and "btrfs check --qgroup-report".
> 
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  common/rc       | 29 ++++++++++++++++++++++++-----

Can you rebase on top of current master please? We've moved
btrfs-specific functions to common/btrfs

>  tests/btrfs/004 |  3 ++-
>  tests/btrfs/048 |  2 +-
>  tests/btrfs/059 |  2 +-
>  tests/btrfs/131 |  2 +-
>  5 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 8c99306..1703232 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3019,15 +3019,34 @@ _require_deletable_scratch_dev_pool()
>  }
>  
>  # We check for btrfs and (optionally) features of the btrfs command
> -_require_btrfs()
> +# _require_btrfs_subcommand <subcommand> [<subfunction>|<option>]
> +# It can handle both subfunction like "inspect-internal dump-tree"
> +# and options like "check --qgroup-report"
> +_require_btrfs_subcommand()

I'd prefer a name similar to _require_xfs_io_command, e.g.
_require_btrfs_command, "subcommand" seems not necessary to me.

>  {
> -	cmd=$1
> -	_require_command "$BTRFS_UTIL_PROG" btrfs
>  	if [ -z "$1" ]; then
> -		return 1;
> +		echo "Usage: _require_btrfs_subcommand command [subcommand]" 1>&2
> +		exit 1
>  	fi
> -	$BTRFS_UTIL_PROG $cmd --help >/dev/null 2>&1
> +	cmd=$1
> +	param=$2
> +
> +	_require_command "$BTRFS_UTIL_PROG" btrfs
> +	$BTRFS_UTIL_PROG $cmd --help &>/dev/null
>  	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd)"
> +
> +	test -z "$param" && return
> +
> +	# if $param is an option, replace leading "-"s for grep
> +	if [ ${param:0:1} == "-" ]; then
> +		param=$(echo $param | sed 's/^-*//')
> +		$BTRFS_UTIL_PROG $cmd --help | grep $param > /dev/null || \

Use "grep -w" to be safer? And "-q" instead of "> /dev/null"

> +			_not_run "$BTRFS_UTIL_PROG too old (must support $cmd $param)"

$param here is without leading "-", so the _notrun message is kind of
misleading. And _notrun not _not_run :)

Thanks,
Eryu
