Received: from mail-ua1-f68.google.com ([209.85.222.68]:40693 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfEHKiS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 May 2019 06:38:18 -0400
MIME-Version: 1.0
References: <20190508094504.15474-1-wqu@suse.com>
In-Reply-To: <20190508094504.15474-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Wed, 8 May 2019 11:38:05 +0100
Message-ID: <CAL3q7H5ODBJSAxwRoJM_Nt1YUy4rH-+b39JdGp=yPPUJ=h+axw@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: generic: Test if we can still do operations
 which don't take extra data space on a fs without data space
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, May 8, 2019 at 11:06 AM Qu Wenruo <wqu@suse.com> wrote:
>
> This test will test if we can still do the following operations when a
> fs has no extra data space:
> - buffered write into unpopulated preallocated extent
> - clone the untouched preallocated extent
> - fsync
> Above operations in a row should not fail, as they takes no extra data sp=
ace.
>
> Xfs passes the test, while btrfs fails at fsync.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
> - Change the comment and commit message to make it describe the test
>   itself, not the btrfs specific part.
> - Use $XFS_IO_PROG to replace xfs_io.
> ---
>  tests/generic/545     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/545.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 73 insertions(+)
>  create mode 100755 tests/generic/545
>  create mode 100644 tests/generic/545.out
>
> diff --git a/tests/generic/545 b/tests/generic/545
> new file mode 100755
> index 00000000..9efaf58c
> --- /dev/null
> +++ b/tests/generic/545
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 545
> +#
> +# Test when a fs is full we can still:
> +# - Do buffered write into a unpopulated preallocated extent
> +# - Clone the untouched part of that preallocated extent
> +# - Fsync
> +# All operations above should not fail.
> +#
> +# Xfs passes the test while btrfs fails. The fix for btrfs is:
> +# "btrfs: Flush before reflinking any extent to prevent NOCOW write fall=
ing
> +#  back to CoW without data reservation"

Again, this part that says it currently fails on btrfs, passes on xfs
and which patch fixes the problem for btrfs, should be in the
changelog and not on the test description.

> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
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
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch

Not needed, because below you do _require_scratch_reflink

> +_require_scratch_reflink
> +
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create preallocated extent where we can write into
> +$XFS_IO_PROG -f -c 'falloc 8k 64m' "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +# Use up all data space, to test later write-into-preallocate behavior
> +_pwrite_byte 0x00 0 512m "$SCRATCH_MNT/padding" >> $seqres.full 2>&1
> +
> +# This should not fail
> +_pwrite_byte 0xcd 1m 16m "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +# Do reflink here, we shouldn't use extra data space, thus it should not=
 fail
> +$XFS_IO_PROG -c "reflink ${SCRATCH_MNT}/foobar 8k 0 4k" "$SCRATCH_MNT/fo=
obar" \
> +       >> $seqres.full
> +
> +# Fsync to check if writeback is ok
> +$XFS_IO_PROG -c 'fsync'  "$SCRATCH_MNT/foobar"

It would be more useful to not only check that fsync does not return
an error, but also to check that if a power failure happens, when we
mount the fs again all the data previously written is there.

Thanks.

> +
> +echo "Silence is golden"
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/545.out b/tests/generic/545.out
> new file mode 100644
> index 00000000..920d7244
> --- /dev/null
> +++ b/tests/generic/545.out
> @@ -0,0 +1,2 @@
> +QA output created by 545
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 40deb4d0..f26b91fe 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -547,3 +547,4 @@
>  542 auto quick clone
>  543 auto quick clone
>  544 auto quick clone
> +545 auto quick clone enospc
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
