Received: from mail-io0-f193.google.com ([209.85.223.193]:36659 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbcGTJZG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2016 05:25:06 -0400
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20160720073450.8952-1-wangxg.fnst@cn.fujitsu.com>
References: <20160720073450.8952-1-wangxg.fnst@cn.fujitsu.com>
From: Filipe Manana <fdmanana@gmail.com>
Date: Wed, 20 Jul 2016 10:25:04 +0100
Message-ID: <CAL3q7H4fVyrJ55_QggGQ85JOfhBAObKUOWSkEGVycMN-R=taXA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test whether fallocate(2) can preallocate half of
 the whole fs space
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 20, 2016 at 8:34 AM, Wang Xiaoguang
<wangxg.fnst@cn.fujitsu.com> wrote:
> Currently in btrfs, there is something wrong with data space reservation.
> For example, if we try to preallocate more than haf of whole fs space,
> ENOSPC will occur, but indeed fs still has free space to satisfy this
> request.
>
> To easily reproduce this bug, this test case needs fs is mixed mode(btrfs
> specific), so put this test case in btrfs group, not generic group.

Why does it need to be in mixed mode (why is it easier)? As far as I
can see from the corresponding btrfs patch (and its description),
the problem affects non-mixed mode, therefore it could be a generic test.

>
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
>  tests/btrfs/127     | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/127.out |  2 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 64 insertions(+)
>  create mode 100755 tests/btrfs/127
>  create mode 100644 tests/btrfs/127.out
>
> diff --git a/tests/btrfs/127 b/tests/btrfs/127
> new file mode 100755
> index 0000000..f95c72f
> --- /dev/null
> +++ b/tests/btrfs/127
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# FS QA Test 127
> +#
> +# Test whether fallocate(2) can preallocate half of the whole fs space.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
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
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +
> +MKFS_OPTIONS="-M"

This now overrides any specific mkfs options specified in the command
line, doesn't it?

> +_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +$XFS_IO_PROG -f -c "falloc 0 128M" $SCRATCH_MNT/testfile | _filter_xfs_io

No need for the filter here.

> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/127.out b/tests/btrfs/127.out
> new file mode 100644
> index 0000000..0af84c0
> --- /dev/null
> +++ b/tests/btrfs/127.out
> @@ -0,0 +1,2 @@
> +QA output created by 127
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index a21a80a..4c3ac00 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -129,3 +129,4 @@
>  124 auto replace
>  125 auto replace
>  126 auto quick qgroup
> +127 auto quick metadata enospc
> --
> 2.9.0
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Filipe David Manana,

"People will forget what you said,
 people will forget what you did,
 but people will never forget how you made them feel."
