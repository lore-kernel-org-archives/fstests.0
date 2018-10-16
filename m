Received: from mail-yb1-f194.google.com ([209.85.219.194]:45023 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPVUR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Oct 2018 17:20:17 -0400
Received: by mail-yb1-f194.google.com with SMTP id x5-v6so8873759ybl.11
        for <fstests@vger.kernel.org>; Tue, 16 Oct 2018 06:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181016074559.24728-1-yi.zhang@huawei.com> <20181016074559.24728-5-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-5-yi.zhang@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Oct 2018 16:29:35 +0300
Message-ID: <CAOQ4uxhOvLMJnFBEysHM9HGrasgq0tbH7WqT=tJQ-MnqOP69QQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] overlay: add fsck.overlay exception tests
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 16, 2018 at 10:32 AM zhangyi (F) <yi.zhang@huawei.com> wrote:
>
> Introduce some exception test cases for fsck.overlay which runs on
> invalid/unnormal underlying dirs or invalid input parameters to test
> exception handling processes.
>
> This patch also change _overlay_fsck_dirs() helper function to be able
> to receive empty underlying dir arguments, which is used by this test
> to cover the case of incomplete underlying dirs.

I think this change is not needed and only adds noise (see below)

>
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  common/overlay        |   8 +-
>  tests/overlay/063     | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/063.out |  10 +++
>  tests/overlay/group   |   1 +
>  4 files changed, 234 insertions(+), 2 deletions(-)
>  create mode 100755 tests/overlay/063
>  create mode 100644 tests/overlay/063.out
>
> diff --git a/common/overlay b/common/overlay
> index 4cc2829..2896594 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -195,12 +195,16 @@ _overlay_fsck_dirs()
>         local lowerdir=$1
>         local upperdir=$2
>         local workdir=$3
> +       local dirs=""
>         shift 3
>
>         [[ ! -x "$FSCK_OVERLAY_PROG" ]] && return 0
>
> -       $FSCK_OVERLAY_PROG -o lowerdir=$lowerdir -o upperdir=$upperdir \
> -                          -o workdir=$workdir $*
> +       [[ -n "$lowerdir" ]] && dirs=$(echo -n "-o lowerdir=$lowerdir")
> +       [[ -n "$upperdir" ]] && dirs=$(echo -n "$dirs -o upperdir=$upperdir")
> +       [[ -n "$workdir" ]] && dirs=$(echo -n "$dirs -o workdir=$workdir")
> +

passing non last empty args in bash is asking for trouble to begin with.
the echo above is really unneeded, but anyway, this whole change gives
no benefit at all, because the only user calling with empty args is just better
off executing $FSCK_OVERLAY_PROG directly.
The test isn't going to run anyway if $FSCK_OVERLAY_PROG does not exist.

> +       $FSCK_OVERLAY_PROG $dirs $*
>  }
>
>  # Run fsck and check the return value
> diff --git a/tests/overlay/063 b/tests/overlay/063
> new file mode 100755
> index 0000000..e2c771a
> --- /dev/null
> +++ b/tests/overlay/063
> @@ -0,0 +1,217 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. 063
> +#
> +# Exception test: test fsck.overlay runs on invalid underlying
> +# dirs or with invalid input options.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1        # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       $CHATTR_PROG -i $upperdir/testdir
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs overlay
> +_supported_os Linux
> +_require_scratch_nocheck
> +_require_attrs
> +_require_command "$FSCK_OVERLAY_PROG" fsck.overlay
> +_require_chattr i
> +
> +# remove all files from previous tests
> +_scratch_mkfs
> +
> +# Create a whiteout
> +make_whiteout()
> +{
> +       for arg in $*; do
> +               mknod $arg c 0 0
> +       done
> +}
> +
> +# Create a redirect directory
> +make_redirect_dir()
> +{
> +       local target=$1
> +       local value=$2
> +
> +       mkdir -p $target
> +       $SETFATTR_PROG -n $OVL_XATTR_REDIRECT -v $value $target
> +}
> +
> +# Create test directories
> +lowerdir=$OVL_BASE_SCRATCH_MNT/lower
> +lowerdir2=$OVL_BASE_SCRATCH_MNT/lower2
> +upperdir=$OVL_BASE_SCRATCH_MNT/upper
> +workdir=$OVL_BASE_SCRATCH_MNT/workdir
> +
> +make_test_dirs()
> +{
> +       rm -rf $lowerdir $lowerdir2 $upperdir $workdir
> +       mkdir -p $lowerdir $lowerdir2 $upperdir $workdir
> +}
> +
> +# Test incomplete underlying dirs, should fail
> +echo "+ Invalid input"
> +make_test_dirs
> +
> +none_dir=""
> +
> +_run_check_fsck $FSCK_USAGE $lowerdir "$none_dir" "$none_dir"
> +_run_check_fsck $FSCK_USAGE $lowerdir $upperdir "$none_dir"
> +_run_check_fsck $FSCK_USAGE "$none_dir" $upperdir $workdir
> +
> +
> +# Test invalid underlying dirs, should fail
> +echo "+ Invalid input(2)"
> +make_test_dirs
> +
> +invalid_dir=$OVL_BASE_SCRATCH_MNT/invalid_dir
> +
> +_run_check_fsck $FSCK_ERROR $lowerdir $upperdir $invalid_dir
> +_run_check_fsck $FSCK_ERROR $lowerdir $invalid_dir $workdir
> +_run_check_fsck $FSCK_ERROR $invalid_dir $upperdir $workdir
> +
> +
> +# Test conflict input options, should fail
> +echo "+ Invalid input(3)"
> +make_test_dirs
> +
> +_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -pn
> +_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -yn
> +_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -py
> +_run_check_fsck $FSCK_USAGE $lowerdir $upperdir $workdir -pyn
> +
> +
> +# Test upperdir and workdir belong to different base filesystems, should fail
> +echo "+ Invalid workdir"
> +make_test_dirs
> +
> +test_workdir=$OVL_BASE_TEST_DIR/work

When using test partition tests usually pick a more unique name,
e.g. work-$seq (even though it is not really unique among generic/$seq
and overlay/$seq).

> +mkdir -p $test_workdir
> +_run_check_fsck $FSCK_ERROR $lowerdir $upperdir $test_workdir
> +rm -rf $test_workdir

Similarly, tests usually clean dirs from test partition BEFORE using it
(maybe another test created a file named work?) and often leave it around
after the test, just so test partition gets aged and contains files.
But cleaning the test dir is fine as well.

> +
> +
> +# Test upperdir is subdir of workdir and vice versa, should fail
> +echo "+ Invalid workdir(2)"
> +make_test_dirs
> +
> +test_workdir=$upperdir/work
> +test_upperdir=$workdir/upper
> +mkdir -p $test_workdir $test_upperdir
> +
> +_run_check_fsck $FSCK_ERROR $lowerdir $upperdir $test_workdir
> +_run_check_fsck $FSCK_ERROR $lowerdir $test_upperdir $workdir
> +
> +
> +# Test upper layer is read-only, should fail in "!no" mode, and should
> +# return the real consistent result in "no" mode.
> +echo "+ Upper read-only"
> +make_test_dirs
> +
> +test_lowerdir=$OVL_BASE_TEST_DIR/lower

same comment as test workdir above.

> +mkdir -p $test_lowerdir
> +
> +# Let upper layer read-only
> +$MOUNT_PROG -o remount,ro $OVL_BASE_SCRATCH_MNT > /dev/null 2>&1
> +# Refuse to check read-only upper layer
> +_run_check_fsck $FSCK_ERROR $test_lowerdir $upperdir $workdir
> +_run_check_fsck $FSCK_ERROR $test_lowerdir $upperdir $workdir -p
> +_run_check_fsck $FSCK_ERROR $test_lowerdir $upperdir $workdir -y
> +# Allow to use "no" mode scan read-only upper layer
> +_run_check_fsck $FSCK_OK $test_lowerdir $upperdir $workdir -n
> +$MOUNT_PROG -o remount,rw $OVL_BASE_SCRATCH_MNT > /dev/null 2>&1

Problem: unless you add remount,rw for both base scratch and base test fs
in cleanup(), _check_filesystems() -> ... _overlay_check_fs() won't remount
it rw for the next test (in case _run_check_fsck has a fatal error).
IMO, it will be cleaner to fix that in _overlay_check_fs() and not just in
cleanup() of this test.
_check_generic_filesystem() will recover from a read-only scratch/test,
so it makes some sense that _overlay_check_fs() will provide a similar
guaranty and shouldn't be difficult at all to do:

Thanks,
Amir.
