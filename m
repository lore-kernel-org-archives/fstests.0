Received: from mail-yw1-f65.google.com ([209.85.161.65]:36782 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPEg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Mar 2019 10:04:36 -0500
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org>
In-Reply-To: <20190304140622.23997-1-fdmanana@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Mar 2019 17:04:23 +0200
Message-ID: <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 4, 2019 at 4:44 PM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that if we truncate a file to reduce its size, rename it and then
> fsync it, after a power failure the file has a correct size and name.
>

I am not sure that ext4/xfs semantics guaranty anything about
persisting file name after fsync of file?...

> This test is motivated by a bug found in btrfs, which is fixed by a
> patch for the linux kernel titled:
>
>   "Btrfs: fix incorrect file size after shrinking truncate and fsync"

At least the title of this patch says nothing about persisting the
name.

>
> This test currently passes on ext4, xfs, f2fs and patched btrfs.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/532     | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/532.out |  8 +++++++
>  tests/generic/group   |  1 +
>  3 files changed, 75 insertions(+)
>  create mode 100755 tests/generic/532
>  create mode 100644 tests/generic/532.out
>
> diff --git a/tests/generic/532 b/tests/generic/532
> new file mode 100755
> index 00000000..64992d85
> --- /dev/null
> +++ b/tests/generic/532
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 532
> +#
> +# Test that if we truncate a file to reduce its size, rename it and then fsync
> +# it, after a power failure the file has a correct size and name.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=/tmp/$$
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       _cleanup_flakey
> +       cd /
> +       rm -f $tmp.*
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
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test file with an initial size of 8000 bytes, then fsync it,
> +# followed by a truncate that reduces its size down to 3000 bytes.
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 8000" \
> +            -c "fsync" \
> +            -c "truncate 3000" \
> +            $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Now rename the file and fsync it again.
> +mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
> +
> +# Simulate a power failure and mount the filesystem to check that the file was
> +# persisted with the new name and has a size of 3000 bytes.
> +_flakey_drop_and_remount
> +
> +[ -f $SCRATCH_MNT/bar ] || echo "file name 'bar' is missing"
> +[ -f $SCRATCH_MNT/foo ] && echo "file name 'foo' still exists"
> +
> +echo "File content after power failure:"
> +od -A d -t x1 $SCRATCH_MNT/bar
> +
> +_unmount_flakey
> +
> +status=0
> +exit
> diff --git a/tests/generic/532.out b/tests/generic/532.out
> new file mode 100644
> index 00000000..554fbe2a
> --- /dev/null
> +++ b/tests/generic/532.out
> @@ -0,0 +1,8 @@
> +QA output created by 532
> +wrote 8000/8000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File content after power failure:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +0002992 ab ab ab ab ab ab ab ab
> +0003000
> diff --git a/tests/generic/group b/tests/generic/group
> index 31011ac8..7d63f303 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -534,3 +534,4 @@
>  529 auto quick attr
>  530 auto quick unlink
>  531 auto quick unlink
> +532 auto quick log
> --
> 2.11.0
>
