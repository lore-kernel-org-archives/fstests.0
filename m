Received: from mail-vs1-f67.google.com ([209.85.217.67]:38531 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfA2LhI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Jan 2019 06:37:08 -0500
MIME-Version: 1.0
References: <20190128020413.16243-1-wqu@suse.com>
In-Reply-To: <20190128020413.16243-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 29 Jan 2019 11:36:56 +0000
Message-ID: <CAL3q7H7wN_VbdHhFcN5vsFPEyG1ran96P=PGsavd_onJ+TcEew@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Test if btrfs hits EDQUOT without trying to
 reclaim some space
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 28, 2019 at 2:05 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Commit a514d63882c3 ("btrfs: qgroup: Commit transaction in advance to red=
uce
> early EDQUOT") is no longer forcing transaction commit to reclaim space,
> and only commits transaction asynchronously in advance to address it.
>
> However the criteria used in async transaction commit is not
> comprehensive, thus it doesn't reclaim space automatically.
>
> This test case will check the behavior by:
> 1) Falloc a large padding file
>    This file will take 90% of the qgroup limit
>
> 2) Sync the fs
>    To reflect the qgroup changes
>
> 3) Delete the file
>    Qgroup won't reclaim the space until transaction committed.
>
> 4) Try to write a file
>    If kernel not fixed, qgroup will not automatically commit transaction
>    to reclaim the freed space and hit EDQUOT.
>
> This bug is going to be fxied by a patch for kernel titled

fxied -> fixed

titled -> titled:

> "btrfs: qgroup: Make qgroup async transaction commit more aggressive".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/180     | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/180.out |  3 +++
>  tests/btrfs/group   |  1 +
>  3 files changed, 66 insertions(+)
>  create mode 100755 tests/btrfs/180
>  create mode 100644 tests/btrfs/180.out
>
> diff --git a/tests/btrfs/180 b/tests/btrfs/180
> new file mode 100755
> index 00000000..df876310
> --- /dev/null
> +++ b/tests/btrfs/180
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 180
> +#
> +# Test if btrfs hits EDQUOT without reclaim already freed extents when q=
uota

reclaim -> reclaiming

> +# is enabled.
> +#
> +# This bug is going to be fxied by a patch for kernel titled
> +# "btrfs: qgroup: Make qgroup async transaction commit more aggressive"
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
> +_require_xfs_io_command falloc
> +
> +_scratch_mkfs > /dev/null
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG qgroup limit -e 1G "$SCRATCH_MNT"
> +
> +$XFS_IO_PROG -f -c "falloc 0 900M" "$SCRATCH_MNT/padding" | _filter_xfs_=
io

No need to use the _filter_xfs_io for falloc (it doesn't output
throughput values such as the write, reflink and dedupe commands).

> +
> +# Commit transaction to reflect the quota usage
> +sync
> +
> +rm "$SCRATCH_MNT/padding"

I would pass -f to rm. It's not uncommon to have setups with "alias rm=3D'r=
m -i'".

Other than that, it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +# Without the kernel fix, this will trigger EDQUOT.
> +_pwrite_byte 0xcd 0 512M "$SCRATCH_MNT/real_file" | _filter_xfs_io
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/180.out b/tests/btrfs/180.out
> new file mode 100644
> index 00000000..17187477
> --- /dev/null
> +++ b/tests/btrfs/180.out
> @@ -0,0 +1,3 @@
> +QA output created by 180
> +wrote 536870912/536870912 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 46dd3c95..03eb62f9 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -182,3 +182,4 @@
>  177 auto quick swap balance
>  178 auto quick send
>  179 auto qgroup dangerous
> +180 auto quick qgroup limit
> --
> 2.18.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
