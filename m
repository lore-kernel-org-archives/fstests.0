Received: from mail-ua1-f66.google.com ([209.85.222.66]:35711 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJLIS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Aug 2018 07:08:18 -0400
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20180810022032.28059-1-wqu@suse.com>
References: <20180810022032.28059-1-wqu@suse.com>
From: Filipe Manana <fdmanana@gmail.com>
Date: Fri, 10 Aug 2018 09:39:24 +0100
Message-ID: <CAL3q7H6rrhHwTQk_YME=i9smCkh6CX05Y0rfO36mQOJpZVdBEQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: Add test for corrupted childless
 qgroup numbers
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 10, 2018 at 3:20 AM, Qu Wenruo <wqu@suse.com> wrote:
> This bug is exposed by populating a high level qgroup, and then make it
> childless with old qgroup numbers, and finally do rescan.
>
> Normally rescan should zero out all qgroups' accounting number, but due
> to a kernel bug which won't mark childless qgroups dirty, their on-disk
> data is never updated, thus old numbers remain and cause qgroup
> corruption.
>
> Fixed by the following kernel patch:
> "btrfs: qgroup: Dirty all qgroups before rescan"
>
> Reported-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
>   Change the adjective for the offending group, from "orphan" to
>   "childless"

All the previous comments still apply as they weren't addressed, for
example using $BTRFS_UTIL_PROG instead of _run_btrfs_util_prog.
Thanks.

> ---
>  tests/btrfs/170     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/170.out |  3 ++
>  tests/btrfs/group   |  1 +
>  3 files changed, 87 insertions(+)
>  create mode 100755 tests/btrfs/170
>  create mode 100644 tests/btrfs/170.out
>
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> new file mode 100755
> index 000000000000..3a810e80562f
> --- /dev/null
> +++ b/tests/btrfs/170
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 170
> +#
> +# Test if btrfs can clear high level childless qgroup's accounting numbe=
rs
> +# during rescan.
> +#
> +# Fixed by the following kernel patch:
> +# "btrfs: qgroup: Dirty all qgroups before rescan"
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
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +
> +# Populate the fs
> +_run_btrfs_util_prog subvolume create "$SCRATCH_MNT/subvol"
> +_pwrite_byte 0xcdcd 0 1M "$SCRATCH_MNT/subvol/file1" | _filter_xfs_io > =
/dev/null
> +
> +# Ensure that file reach disk, so it will also appear in snapshot
> +sync
> +_run_btrfs_util_prog subvolume snapshot "$SCRATCH_MNT/subvol" "$SCRATCH_=
MNT/snapshot"
> +
> +
> +_run_btrfs_util_prog quota enable "$SCRATCH_MNT"
> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
> +
> +# Create high level qgroup
> +_run_btrfs_util_prog qgroup create 1/0 "$SCRATCH_MNT"
> +
> +# Don't use _run_btrfs_util_prog here, as it can return 1 to info user
> +# that qgroup is marked inconsistent, this is a bug in btrfs-progs, but
> +# to ensure it will work, we just ignore the return value.
> +$BTRFS_UTIL_PROG qgroup assign "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT=
"
> +
> +# Above assign will mark qgroup inconsistent due to the shared extents
> +# between subvol/snapshot/high level qgroup, do rescan here
> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
> +
> +# Now remove the qgroup relationship and make 1/0 childless
> +# Due to the shared extent outside of 1/0, we will mark qgroup inconsist=
ent
> +# and keep the number of qgroup 1/0
> +$BTRFS_UTIL_PROG qgroup remove "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_MNT=
"
> +
> +# Above removal also marks qgroup inconsistent, rescan again
> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
> +
> +# After the test, btrfs check will verify qgroup numbers to catch any
> +# corruption.
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
> new file mode 100644
> index 000000000000..9002199e48ed
> --- /dev/null
> +++ b/tests/btrfs/170.out
> @@ -0,0 +1,3 @@
> +QA output created by 170
> +WARNING: quotas may be inconsistent, rescan needed
> +WARNING: quotas may be inconsistent, rescan needed
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index b616c73d09bf..339c977135c0 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -172,3 +172,4 @@
>  167 auto quick replace volume
>  168 auto quick send
>  169 auto quick send
> +170 auto quick qgroup
> --
> 2.18.0
>



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
