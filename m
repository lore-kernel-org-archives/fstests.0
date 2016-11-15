Received: from mx1.redhat.com ([209.132.183.28]:51458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbcKOGxP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Nov 2016 01:53:15 -0500
Date: Tue, 15 Nov 2016 14:53:12 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: generic/098 update test for truncating a file
 into the middle of a hole
Message-ID: <20161115065312.GN27776@eguan.usersys.redhat.com>
References: <1478903404-25619-1-git-send-email-bo.li.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478903404-25619-1-git-send-email-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 11, 2016 at 02:30:04PM -0800, Liu Bo wrote:
> This updates generic/098 by adding a sync option, i.e. 'sync' after the second
> write, and with btrfs's NO_HOLES, we could still get wrong isize after remount.
> 
> This gets fixed by the patch
> 
> 'Btrfs: fix truncate down when no_holes feature is enabled'
> 
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>

Looks good to me, just some nitpicks inline :)

> ---
>  tests/generic/098     | 57 ++++++++++++++++++++++++++++++++-------------------
>  tests/generic/098.out | 10 +++++++++
>  2 files changed, 46 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/generic/098 b/tests/generic/098
> index 838bb5d..3b89939 100755
> --- a/tests/generic/098
> +++ b/tests/generic/098
> @@ -64,27 +64,42 @@ rm -f $seqres.full
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
>  
> -# Create our test file with some data and durably persist it.
> -$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 128K" $SCRATCH_MNT/foo | _filter_xfs_io
> -sync
> -
> -# Append some data to the file, increasing its size, and leave a hole between
> -# the old size and the start offset if the following write. So our file gets
> -# a hole in the range [128Kb, 256Kb[.
> -$XFS_IO_PROG -c "pwrite -S 0xbb 256K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
> -
> -# Now truncate our file to a smaller size that is in the middle of the hole we
> -# previously created. On most truncate implementations the data we appended
> -# before gets discarded from memory (with truncate_setsize()) and never ends
> -# up being written to disk.
> -$XFS_IO_PROG -c "truncate 160K" $SCRATCH_MNT/foo
> -
> -_scratch_cycle_mount
> -
> -# We expect to see a file with a size of 160Kb, with the first 128Kb of data all
> -# having the value 0xaa and the remaining 32Kb of data all having the value 0x00
> -echo "File content after remount:"
> -od -t x1 $SCRATCH_MNT/foo
> +workout()
> +{
> +	NEED_SYNC=$1

Use "local" to declare this var, and in lower case. Usually we use upper
case for global variables.

> +
> +	# Create our test file with some data and durably persist it.
> +	$XFS_IO_PROG -t -f -c "pwrite -S 0xaa 0 128K" $SCRATCH_MNT/foo | _filter_xfs_io
> +	sync
> +
> +	# Append some data to the file, increasing its size, and leave a hole between
> +	# the old size and the start offset if the following write. So our file gets
> +	# a hole in the range [128Kb, 256Kb[.
> +	$XFS_IO_PROG -c "pwrite -S 0xbb 256K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +	if [ $NEED_SYNC -eq 1 ]; then
> +		sync
> +	fi

Good to see some comments to explain why we need this to test
with/without sync case.

Thanks,
Eryu

> +
> +	# Now truncate our file to a smaller size that is in the middle of the hole we
> +	# previously created.
> +	# If we don't flush dirty page cache above, on most truncate
> +	# implementations the data we appended before gets discarded from
> +	# memory (with truncate_setsize()) and never ends up being written to
> +	# disk.
> +	$XFS_IO_PROG -c "truncate 160K" $SCRATCH_MNT/foo
> +
> +	_scratch_cycle_mount
> +
> +	# We expect to see a file with a size of 160Kb, with the first 128Kb of data all
> +	# having the value 0xaa and the remaining 32Kb of data all having the value 0x00
> +	echo "File content after remount:"
> +	od -t x1 $SCRATCH_MNT/foo
> +}
> +
> +workout 0
> +# flush after each write
> +workout 1
>  
>  status=0
>  exit
> diff --git a/tests/generic/098.out b/tests/generic/098.out
> index 37415ee..f87f046 100644
> --- a/tests/generic/098.out
> +++ b/tests/generic/098.out
> @@ -9,3 +9,13 @@ File content after remount:
>  0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  *
>  0500000
> +wrote 131072/131072 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 32768/32768 bytes at offset 262144
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File content after remount:
> +0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> +*
> +0400000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +0500000
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
