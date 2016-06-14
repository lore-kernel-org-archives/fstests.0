Received: from mx1.redhat.com ([209.132.183.28]:60317 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358AbcFNLnc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 07:43:32 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28309C05B1F1
	for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 11:43:32 +0000 (UTC)
Date: Tue, 14 Jun 2016 07:43:30 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 3/3] generic: test remount on I/O errors
Message-ID: <20160614114330.GC32443@bfoster.bfoster>
References: <1465890821-4388-1-git-send-email-eguan@redhat.com>
 <1465890821-4388-3-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465890821-4388-3-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 03:53:41PM +0800, Eryu Guan wrote:
> XFS had a bug to hang on remount in this case, this kernel commit fix
> the issue.
> 
> 5cb13dc cancel the setfilesize transation when io error happen
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/generic/354     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/354.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 81 insertions(+)
>  create mode 100755 tests/generic/354
>  create mode 100644 tests/generic/354.out
> 
> diff --git a/tests/generic/354 b/tests/generic/354
> new file mode 100755
> index 0000000..4791613
> --- /dev/null
> +++ b/tests/generic/354
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# FS QA Test 354
> +#
> +# Test remount on I/O errors.
> +#
> +# XFS had a bug to hang on remount in this case, this kernel commit fix
> +# the issue.
> +# 5cb13dc cancel the setfilesize transation when io error happen
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
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
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	$UMOUNT_PROG $fs_mnt
> +	_destroy_loop_device $loop_dev
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +# create a small filesystem to hold another filesystem image
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# create the sparse fs image and mount point
> +fs_img=$SCRATCH_MNT/fs.img
> +fs_mnt=$SCRATCH_MNT/mnt
> +$XFS_IO_PROG -fc "truncate 1g" $fs_img >>$seqres.full 2>&1
> +mkdir -p $fs_mnt
> +
> +# mount loop device and create a larger file to hit I/O errors on loop device
> +loop_dev=$(_create_loop_device $fs_img)
> +_mkfs_dev $loop_dev
> +_mount $loop_dev $fs_mnt
> +$XFS_IO_PROG -fc "pwrite 0 520m" $fs_mnt/testfile >>$seqres.full 2>&1
> +
> +# remount should not hang
> +$MOUNT_PROG -o remount,ro $fs_mnt
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/354.out b/tests/generic/354.out
> new file mode 100644
> index 0000000..8bc7ecf
> --- /dev/null
> +++ b/tests/generic/354.out
> @@ -0,0 +1,2 @@
> +QA output created by 354
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 0203afa..d33dd69 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -356,3 +356,4 @@
>  351 blockdev quick rw
>  352 auto quick metadata
>  353 auto quick metadata
> +354 auto quick
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
