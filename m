Received: from mail-it0-f65.google.com ([209.85.214.65]:38070 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLL2g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Mar 2018 07:28:36 -0400
Date: Mon, 12 Mar 2018 19:28:26 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: test regression of -EEXIST on creating new
 file after log replay
Message-ID: <20180312112826.GK30836@localhost.localdomain>
References: <20180307235910.12313-1-bo.li.liu@oracle.com>
 <20180310235604.3206-1-bo.li.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310235604.3206-1-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Mar 10, 2018 at 04:56:04PM -0700, Liu Bo wrote:
> The regression is introduced to btrfs in linux v4.4 and it refuses to create
> new files after log replay by returning -EEXIST.
> 
> Although the problem is on btrfs only, there is no btrfs stuff in terms of
> test, so this makes it generic.
> 
> The kernel fix is
>   Btrfs: fix unexpected -EEXIST when creating new inode
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> ---
> v2: - Remove failed message from 481.out
>     - Drop the unnecessary write in creating a file
> 
>  tests/generic/481     | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/481.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/generic/481
>  create mode 100644 tests/generic/481.out
> 
> diff --git a/tests/generic/481 b/tests/generic/481
> new file mode 100755
> index 0000000..6a7e9dd
> --- /dev/null
> +++ b/tests/generic/481
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# FSQA Test No. 481
> +#
> +# Reproduce a regression of btrfs that leads to -EEXIST on creating new files
> +# after log replay.
> +#
> +# The kernel fix is
> +#   Btrfs: fix unexpected -EEXIST when creating new inode
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (C) 2018 Oracle. All Rights Reserved.
> +# Author: Bo Liu <bo.li.liu@oracle.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_dm_target flakey
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1

I added a "_require_metadata_journaling $SCRATCH_DEV" here, otherwise
test fails with ext2, which doesn't have journal.

Thanks,
Eryu
