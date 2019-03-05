Received: from mail-vk1-f193.google.com ([209.85.221.193]:33474 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfCEOmH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Mar 2019 09:42:07 -0500
Received: by mail-vk1-f193.google.com with SMTP id l62so2002713vkh.0
        for <fstests@vger.kernel.org>; Tue, 05 Mar 2019 06:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20190305114744.129633-1-yuchao0@huawei.com>
In-Reply-To: <20190305114744.129633-1-yuchao0@huawei.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 5 Mar 2019 14:41:54 +0000
Message-ID: <CAL3q7H5u28F8rOGAobzG=S2WGDxstLkOHJ__z2gpovH=VNNm1g@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power failure
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 5, 2019 at 11:48 AM Chao Yu <yuchao0@huawei.com> wrote:
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
> v2:
> change as Filipe suggested:
> - use dmflakey to simulate power-cut for generic filesystem which
> doesn't support godown ioctl interface.
> - minor code style change.
>  tests/generic/532     | 105 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/532.out |   2 +
>  tests/generic/group   |   1 +
>  3 files changed, 108 insertions(+)
>  create mode 100755 tests/generic/532
>  create mode 100644 tests/generic/532.out
>
> diff --git a/tests/generic/532 b/tests/generic/532
> new file mode 100755
> index 000000000000..1c5dffcdc4f6
> --- /dev/null
> +++ b/tests/generic/532
> @@ -0,0 +1,105 @@
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
> +# 7. flakey drop
> +# 8. remount
> +# 9. check i_mode
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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_scratch
> +_require_dm_target flakey
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +
> +testfile=3D$SCRATCH_MNT/testfile
> +testdir=3D$SCRATCH_MNT/testdir
> +
> +do_check()
> +{
> +       local target=3D$1
> +       local is_dir=3D$2
> +
> +       _mount_flakey
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
> +       $XFS_IO_PROG $target -c "fsync"
> +
> +       local before=3D`stat -c %a $target`
> +
> +       _flakey_drop_and_remount
> +
> +       local after=3D`stat -c %a $target`
> +
> +       # check inode's i_mode
> +       if [ "$before" !=3D "$after" ]; then
> +               echo "Before: $before"
> +               echo "After : $after"
> +       fi
> +
> +       if [ $is_dir =3D 1 ]; then
> +               rmdir $target
> +       else
> +               rm -f $target
> +       fi
> +       _unmount_flakey
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
> index 15227b6713f7..c19361667886 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -534,3 +534,4 @@
>  529 auto quick attr
>  530 auto quick unlink
>  531 auto quick unlink
> +532 shutdown auto quick metadata

Since the test now uses dmflakey, it should no longer belong to the
'shutdown' group and should
belong to the 'log' group like all other tests using dmflakey.
Probably Eryu can change that when
he picks the patch.

Other than that it looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> --
> 2.18.0.rc1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
