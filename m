Received: from mx1.redhat.com ([209.132.183.28]:43192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754998AbeARIqr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 03:46:47 -0500
Date: Thu, 18 Jan 2018 16:46:45 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 3/3] xfs: Regression test for invalid sb_logsunit
Message-ID: <20180118084645.GT3102@eguan.usersys.redhat.com>
References: <20180116040254.GE3102@eguan.usersys.redhat.com>
 <1516087617-2077-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1516087617-2077-3-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516087617-2077-3-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: xiao yang <yangx.jy@cn.fujitsu.com>
Cc: david@fromorbit.com, bfoster@redhat.com, fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 16, 2018 at 03:26:57PM +0800, xiao yang wrote:
> If log stripe unit isn't a multiple of the fs blocksize and mounting,
> the invalid sb_logsunit leads to crash as soon as we try to write to
> the log.
> 
> Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/xfs/439     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/439.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 89 insertions(+)
>  create mode 100755 tests/xfs/439
>  create mode 100644 tests/xfs/439.out
> 
> diff --git a/tests/xfs/439 b/tests/xfs/439
> new file mode 100755
> index 0000000..5dfed1a
> --- /dev/null
> +++ b/tests/xfs/439
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# FS QA Test No. 439
> +#
> +# Regression test for commit:
> +# 9c92ee2 ("xfs: validate sb_logsunit is a multiple of the fs blocksize")
> +#
> +# If log stripe unit isn't a multiple of the fs blocksize and mounting,
> +# the invalid sb_logsunit leads to crash as soon as we try to write to
> +# the log.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 FUJITSU.  All Rights Reserved.
> +# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
> +
> +seq=`basename "$0"`
> +seqres="$RESULT_DIR/$seq"
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	rm -rf $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs xfs
> +_require_scratch
> +# We corrupt XFS on purpose, and debug built XFS would crash due to
> +# assert failure, so skip if we're testing on a debug built XFS
> +_require_no_xfs_debug

If we agree to introduce a new _require_no_xfs_bug_on_assert, the
comments and require rule here can be updated too.

> +
> +rm -f "$seqres.full"
> +
> +# Format
> +_scratch_mkfs > $seqres.full 2>&1 || _fail "mkfs failed"
> +
> +# Set logsunit to a value which is not a multiple of the fs blocksize
> +blksz=$(_scratch_xfs_get_sb_field blocksize)
> +_scratch_xfs_set_sb_field logsunit $((blksz - 1)) >> $seqres.full 2>&1
> +
> +# Check if logsunit is set correctly
> +lsunit=$(_scratch_xfs_get_sb_field logsunit)
> +[ $lsunit -ne $((blksz - 1)) ] && _notrun "failed to set sb_logsunit"
> +
> +# Mount and writing log may trigger a crash on buggy kernel
> +# The fix applied kernel refuses to mount, so a mount failure is
> +# expected
> +if _scratch_mount >> $seqres.full 2>&1; then
> +	for i in $(seq 1 1000); do
> +		echo > ${SCRATCH_MNT}/$i
> +	done
> +	_scratch_unmount
> +fi
> +
> +# Mount may trigger ASSERT failure and warnings on the fix applied
> +# kernel if logsunit is invalid on CONFIG_XFS_WARN build, so filter them.

and when bug_on_assert=0 :)

Thanks,
Eryu

> +_check_dmesg _filter_assert_dmesg
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/439.out b/tests/xfs/439.out
> new file mode 100644
> index 0000000..9712295
> --- /dev/null
> +++ b/tests/xfs/439.out
> @@ -0,0 +1,2 @@
> +QA output created by 439
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 04a63b7..0b281a8 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -436,3 +436,4 @@
>  436 auto quick clone fsr
>  437 auto quick other
>  438 auto quick quota dangerous
> +439 auto quick dangerous_fuzzers log
> -- 
> 1.8.3.1
> 
> 
> 
