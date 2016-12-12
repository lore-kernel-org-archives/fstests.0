Received: from mx1.redhat.com ([209.132.183.28]:45918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932490AbcLLLHY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Dec 2016 06:07:24 -0500
Date: Mon, 12 Dec 2016 19:07:21 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 7/7] xfs/ext4: check negative inode size
Message-ID: <20161212110721.GC29149@eguan.usersys.redhat.com>
References: <148149316504.31093.16129068344227450710.stgit@birch.djwong.org>
 <148149320892.31093.18280644018166858868.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148149320892.31093.18280644018166858868.stgit@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: ocfs2-devel@oss.oracle.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Dec 11, 2016 at 01:53:28PM -0800, Darrick J. Wong wrote:
> Craft a malicious filesystem image with a negative inode size,
> then try to trigger a kernel DoS by appending data to the file.
> Ideally this should trigger verifier errors instead of hanging.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/ext4/400   |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/401   |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/group |    2 ++
>  tests/xfs/400    |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/401    |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/group  |    2 ++
>  6 files changed, 290 insertions(+)
>  create mode 100755 tests/ext4/400
>  create mode 100755 tests/ext4/401
>  create mode 100755 tests/xfs/400
>  create mode 100755 tests/xfs/401
> 
> 
> diff --git a/tests/ext4/400 b/tests/ext4/400
> new file mode 100755
> index 0000000..5857549
> --- /dev/null
> +++ b/tests/ext4/400
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# FSQA Test No. 400
> +#
> +# Since loff_t is a signed type, it is invalid for a filesystem to load
> +# an inode with i_size = -1ULL.  Unfortunately, nobody checks this,
> +# which means that we can trivially DoS the VFS by creating such a file
> +# and appending to it.  This causes an integer overflow in the routines
> +# underlying writeback, which results in the kernel locking up.

The only difference between ext4/400 and ext4/401 is that 400 makes
i_size=-1 and 401 makes it 0xFFFFFFFFFFFFFE00, while xfs/400 and xfs/401
both create XFS with i_size -1. Is 0xFFFFFFFFFFFFFE00 a typo? Or update
the description accordingly if they are two different tests?

And I noticed that 400 is doing buffered I/O and 401 is doing direct
I/O, can the two be folded in one test?

> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016-2017 Oracle, Inc.  All Rights Reserved.
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
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +PIDS=""
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs ext2 ext3 ext4

Then it belongs to shared :)

Thanks,
Eryu
