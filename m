Received: from mx1.redhat.com ([209.132.183.28]:51308 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443AbbJVJrZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 Oct 2015 05:47:25 -0400
Date: Thu, 22 Oct 2015 17:47:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] dm-thinp demo test
Message-ID: <20151022094722.GL3558@dhcp-13-216.nay.redhat.com>
References: <5627FA00.70003@redhat.com>
 <5627FBE8.3030408@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5627FBE8.3030408@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 21, 2015 at 03:56:08PM -0500, Eric Sandeen wrote:
> Fairly trivial test to use the dm-thin infrastructure.
> 
> Right now it exhausts space in queue-on-error mode,
> adds more space, does a bit more IO, then unmounts &
> checks the fs.
> 
> Not sure if that's valid to test, but it works here and
> demonstrates the common/dmthin helpers.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> 
> 
> diff --git a/tests/generic/115 b/tests/generic/115
> new file mode 100755
> index 0000000..ef9d881
> --- /dev/null
> +++ b/tests/generic/115
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# FS QA Test No. generic/115
> +#
> +# Test very basic thin device usage, exhaustion, and growth
> +#
> +# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
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
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +BACKING_SIZE=$((500 * 1024 * 1024 / 512))	# 500M
> +VIRTUAL_SIZE=$((10 * $BACKING_SIZE))		# 5000M
> +GROW_SIZE=$((100 * 1024 * 1024 / 512))		# 100M
> +
> +_cleanup()
> +{
> +	_dmthin_cleanup
> +	rm -f $tmp.*
> +}
> +
> +_setup_thin()
> +{
> +	_dmthin_init $BACKING_SIZE $VIRTUAL_SIZE
> +	_dmthin_set_queue
> +	_mkfs_dev $DMTHIN_VOL_DEV
> +	_dmthin_mount
> +}
> +
> +_workout()
> +{
> +	# Overfill it by a bit
> +	for I in `seq 1 500`; do
> +		$XFS_IO_PROG -f -c "pwrite -W 0 1M" $SCRATCH_MNT/file$I &>/dev/null
> +	done
> +
> +	sync
> +
> +	_dmthin_grow  $GROW_SIZE
> +
> +	# Write a little more, but don't fill
> +	for I in `seq 501 510`; do
> +		$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/file$I &>/dev/null
> +	done
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/dmthin
> +
> +_supported_fs generic
> +_supported_os Linux
> +_need_to_be_root
> +_require_dm_target thin

This doesn't work for me with 4.3-rc4 kernel. I have to
"_require_dm_target thin-pool", modprobe dm-thin reports no module
found.

> +
> +_setup_thin
> +_dmthin_set_queue

This one or the one in _setup_thin can be removed?

> +_workout
> +_dmthin_check_fs

btrfs fails the fs check, because btrfs changes lv device name in df
output, from /dev/mapper/xxx to /dev/dm-x, so _check_scratch_fs couldn't
umount it and btrfsck runs on mounted btrfs.

Adding "$UMOUNT_PROG $SCRATCH_MNT" before _dmthin_check_fs is a
workaround, though I think it's a btrfs issue.

Thanks,
Eryu

> +_dmthin_cleanup
> +
> +echo "=== completed"
> +
> +status=0
> +exit
> diff --git a/tests/generic/115.out b/tests/generic/115.out
> new file mode 100644
> index 0000000..39ebd87
> --- /dev/null
> +++ b/tests/generic/115.out
> @@ -0,0 +1,2 @@
> +QA output created by 115
> +=== completed
> diff --git a/tests/generic/group b/tests/generic/group
> index 1dd4269..729578d 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -115,6 +115,7 @@
>  112 rw aio auto quick
>  113 rw aio auto quick
>  114 rw aio auto quick
> +115 rw thin auto quick
>  117 attr auto quick
>  120 other auto quick
>  123 perms auto quick
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
