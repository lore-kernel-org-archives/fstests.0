Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:54850 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755712AbcK2VCA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Nov 2016 16:02:00 -0500
Date: Wed, 30 Nov 2016 08:01:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 01/10] fstests: common: Introduce function to check
 qgroup correctness
Message-ID: <20161129210155.GD31101@dastard>
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
> +		_notrun "$BTRFS_UTIL_PROG too old (must support 'check --qgroup-report')"
> +	fi
> +}

Why wouldn't this just set a global variable that you then
check in _check_scratch_fs and run the _btrfs_check_scratch_qgroup()
call then?

What about all the tests that currently run without this
functionality being present? They will now notrun rather than use
the golden output match - this seems like a regression to me,
especially for distro QE testing older kernel/progs combinations...

> +
> +_btrfs_check_scratch_qgroup()
> +{
> +	_require_btrfs_check_qgroup

This needs to go in the test itself before the test is run,
not get hidden in a function call at the end of the test.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
