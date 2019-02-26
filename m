Received: from mail-ua1-f68.google.com ([209.85.222.68]:45670 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZLCU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Feb 2019 06:02:20 -0500
Received: by mail-ua1-f68.google.com with SMTP id u1so10678822uae.12
        for <fstests@vger.kernel.org>; Tue, 26 Feb 2019 03:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20190226070302.17756-1-yuchao0@huawei.com>
In-Reply-To: <20190226070302.17756-1-yuchao0@huawei.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 26 Feb 2019 11:02:07 +0000
Message-ID: <CAL3q7H4Xn=ncGQcKKwNBpHBWAUPLt8T8T=RVpmvqA6h83r5tug@mail.gmail.com>
Subject: Re: [PATCH] generic: test i_mode recovery after power failure
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 26, 2019 at 7:03 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> After fsync, filesystem should guarantee inode metadata including
> permission info being persisted, so even after sudden power-cut,
> during mount, we should recover i_mode fields correctly, in order
> to not loss those meta info.
>
> So adding this testcase to check whether generic filesystem can
> guarantee that.
>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  tests/generic/532     | 106 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/532.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 109 insertions(+)
>  create mode 100755 tests/generic/532
>  create mode 100644 tests/generic/532.out
>
> diff --git a/tests/generic/532 b/tests/generic/532
> new file mode 100755
> index 000000000000..d89f7ab09fcf
> --- /dev/null
> +++ b/tests/generic/532
> @@ -0,0 +1,106 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 532
> +#
> +# This testcase is trying to test recovery flow of generic filesystem,
> +# w/ below steps, once i_mode changes, after we fsync that file, we can
> +# expect that i_mode can be recovered after sudden power-cuts.
> +# 1. touch testfile or mkdir testdir
> +# 2. chmod 777 testfile/testdir
> +# 3. sync
> +# 4. chmod 755 testfile/testdir
> +# 5. fsync testfile/testdir
> +# 6. record last i_mode
> +# 7. godown
> +# 8. umount
> +# 9. mount
> +# 10. check i_mode
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
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_scratch
> +_require_scratch_shutdown

Is the use of the shutdown functionality necessary to trigger the bug on f2=
fs?
If not, I'd rather have it use dmflakey so that the test is able to
run as well on filesystems that don't support shutdown (btrfs for
example).
It also feels more natural then relying on a specific feature such as shutd=
own.

> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +
> +testfile=3D$SCRATCH_MNT/testfile
> +testdir=3D$SCRATCH_MNT/testdir
> +
> +do_check()
> +{
> +       target=3D$1
> +       is_dir=3D$2

Both should be declared as local.

> +
> +       _scratch_mount
> +
> +       if [ $is_dir =3D 1 ]; then
> +               mkdir $target
> +       else
> +               touch $target
> +       fi
> +
> +       echo "Test chmod $target" >> $seqres.full
> +
> +       chmod 777 $target
> +       sync
> +
> +       chmod 755 $target
> +       $XFS_IO_PROG $target -c "fsync" | _filter_xfs_io

No need to use the filter here.

> +
> +       before=3D`stat -c %a $target`

Should be local as well.

> +
> +       _scratch_shutdown | tee -a $seqres.full
> +       _scratch_cycle_mount
> +
> +       after=3D`stat -c %a $target`

Local as well.

> +
> +       # check inode's i_mode
> +       if [ "$before" !=3D "$after" ]; then
> +               echo "Before: $before"
> +               echo "After : $after"
> +       fi
> +       echo "Before: $before" >> $seqres.full
> +       echo "After : $after" >> $seqres.full

Seems pointless to dump the values to $seqres.full in case of success.

Thanks.

> +
> +       if [ $is_dir =3D 1 ]; then
> +               rmdir $target
> +       else
> +               rm -f $target
> +       fi
> +       _scratch_unmount
> +}
> +
> +echo "Silence is golden"
> +
> +do_check $testfile 0
> +do_check $testdir 1
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/532.out b/tests/generic/532.out
> new file mode 100644
> index 000000000000..1f7d4677c3be
> --- /dev/null
> +++ b/tests/generic/532.out
> @@ -0,0 +1,2 @@
> +QA output created by 532
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 31011ac872c2..2fc50fbbfb5c 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -534,3 +534,4 @@
>  529 auto quick attr
>  530 auto quick unlink
>  531 auto quick unlink
> +532 shutdown auto quick metadata
> --
> 2.18.0.rc1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
