Received: from mail-vs1-f68.google.com ([209.85.217.68]:46631 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfEWIhu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 May 2019 04:37:50 -0400
MIME-Version: 1.0
References: <20190523011101.4594-1-wqu@suse.com>
In-Reply-To: <20190523011101.4594-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Thu, 23 May 2019 09:37:37 +0100
Message-ID: <CAL3q7H6F7X4Nec1RAqHKhsU-b0WA1JePYLLQuMkKLJGDK3GjEQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: Validate that balance and qgroups work
 correctly when balance needs to be resumed on mount
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 23, 2019 at 2:11 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There are two regressions related to balance resume:
> - Kernel NULL pointer dereference at mount time
>   Introduced in v5.0
> - Kernel BUG_ON() just after mount
>   Introduced in v5.1
>
> The kernel fixes are:
> "btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
>  dereference"
> "btrfs: reloc: Also queue orphan reloc tree for cleanup to
>  avoid BUG_ON()"
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> changelog:
> v2:
> - Subject change to describe the test case in a more generic way
> - Update commit message and comment to avoid ambitious/confusing words
> - Add to 'balance' and 'qgroup' groups
> ---
>  tests/btrfs/188     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/188.out |  2 +
>  tests/btrfs/group   |  1 +
>  3 files changed, 95 insertions(+)
>  create mode 100755 tests/btrfs/188
>  create mode 100644 tests/btrfs/188.out
>
> diff --git a/tests/btrfs/188 b/tests/btrfs/188
> new file mode 100755
> index 00000000..e12db87c
> --- /dev/null
> +++ b/tests/btrfs/188
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 188
> +#
> +# A general test to validate that balance and qgroups work correctly whe=
n
> +# balance needs to be resumed on mount.
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
> +. ./common/dmlogwrites
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
> +# and we need extra device as log device
> +_require_log_writes
> +
> +nr_files=3D512                           # enough metadata to bump tree =
height
> +file_size=3D2048                         # small enough to be inlined
> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +
> +_log_writes_mount
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +# Create enough metadata for later balance
> +for ((i =3D 0; i < $nr_files; i++)); do
> +       _pwrite_byte 0xcd 0 $file_size $SCRATCH_MNT/file_$i > /dev/null
> +done
> +
> +# Flush delalloc so that balance has work to do.
> +sync
> +
> +# Balance metadata so we will have at least one transaction committed wi=
th
> +# valid reloc tree, and hopefully another commit with orphan reloc tree.
> +$BTRFS_UTIL_PROG balance start -f -m $SCRATCH_MNT >> $seqres.full
> +_log_writes_unmount
> +_log_writes_remove
> +
> +cur=3D$(_log_writes_find_next_fua 0)
> +echo "cur=3D$cur" >> $seqres.full
> +while [ ! -z "$cur" ]; do
> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqref.full
> +
> +       # Test that no crashes happen or any other kind of failure.
> +       _scratch_mount
> +       _scratch_unmount
> +
> +       # Don't trigger fsck here, as relocation get paused,
> +       # at that transistent state, qgroup number may differ
> +       # and cause false alert.
> +
> +       prev=3D$cur
> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> +       [ -z "$cur" ] && break
> +done
> +
> +# Now the fs has finished its balance and qgroup should be consistent.
> +# Fstest will automatically check the fs and btrfs check will report
> +# any qgroup inconsistent if something went wrong.
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
> new file mode 100644
> index 00000000..6f23fda0
> --- /dev/null
> +++ b/tests/btrfs/188.out
> @@ -0,0 +1,2 @@
> +QA output created by 188
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 44ee0dd9..cfad878f 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -190,3 +190,4 @@
>  185 volume
>  186 auto quick send volume
>  187 auto send dedupe clone balance
> +188 auto quick replay balance qgroup
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
