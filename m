Received: from mail-yw1-f65.google.com ([209.85.161.65]:36646 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLCHZf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 02:25:35 -0500
Received: by mail-yw1-f65.google.com with SMTP id y194so4995903ywg.3
        for <fstests@vger.kernel.org>; Sun, 02 Dec 2018 23:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20181203064256.26768-1-david@fromorbit.com> <20181203064256.26768-4-david@fromorbit.com>
In-Reply-To: <20181203064256.26768-4-david@fromorbit.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Dec 2018 09:25:19 +0200
Message-ID: <CAOQ4uxgddSnVGC6+JmpiseAGKcKVjSq6nYOD4tAMUx5y8Yx3XA@mail.gmail.com>
Subject: Re: [PATCH 3/3] generic: copy_file_range bounds test
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>, Olga Kornievskaia <kolga@netapp.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 3, 2018 at 8:43 AM Dave Chinner <david@fromorbit.com> wrote:
>
> From: Dave Chinner <dchinner@redhat.com>
>
> Test that copy_file_range will return the correct errors for various
> error conditions and boundary constraints.
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/530     | 165 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/530.out |  62 ++++++++++++++++
>  tests/generic/group   |   1 +
>  3 files changed, 228 insertions(+)
>  create mode 100755 tests/generic/530
>  create mode 100644 tests/generic/530.out
>
> diff --git a/tests/generic/530 b/tests/generic/530
> new file mode 100755
> index 000000000000..42243cc70914
> --- /dev/null
> +++ b/tests/generic/530
> @@ -0,0 +1,165 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 530
> +#
> +# Exercise copy_file_range() syscall error conditions.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 7 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -rf $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_os Linux
> +_supported_fs generic
> +
> +rm -f $seqres.full
> +
> +_require_test
> +_require_scratch
> +_require_xfs_io_command "copy_range"
> +_require_user
> +_require_test_swapfile
> +
> +_scratch_mkfs 2>&1 >> $seqres.full
> +_scratch_mount
> +
> +
> +testdir=$TEST_DIR/test-$seq
> +rm -rf $testdir
> +mkdir $testdir
> +rm -f $seqres.full
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $testdir/file >> $seqres.full 2>&1
> +chmod 777 $testdir/file
> +
> +echo swap files return ETXTBUSY
> +_format_swapfile $testdir/swapfile 16m
> +swapon $testdir/swapfile
> +$XFS_IO_PROG -f -c "copy_range -l 32k $testdir/file" $testdir/swapfile
> +$XFS_IO_PROG -f -c "copy_range -l 32k $testdir/swapfile" $testdir/copy
> +swapoff $testdir/swapfile
> +
> +# we have to open the file to be immutable rw and hold it open over the
> +# chattr command to set it immutable, otherwise we won't be able to open it for
> +# writing after it's been made immutable. (i.e. would exercise file mode checks,
> +# not immutable inode flag checks).
> +echo
> +echo immutable file returns EPERM
> +$XFS_IO_PROG -f -c "pwrite -S 0x61 0 64k" -c fsync $testdir/immutable | _filter_xfs_io
> +$XFS_IO_PROG -f -c "chattr +i" -c "copy_range -l 32k $testdir/file" $testdir/immutable
> +$XFS_IO_PROG -f -r -c "chattr -i" $testdir/immutable
> +rm -f $testdir/immutable
> +
> +# can't test this as root, because root is allowed to write to files do not
> +# have write permission bits set.
> +echo
> +echo no write perms on destination returns EACCES
> +chown $qa_user:12345 $testdir/copy
> +su $qa_user -c "$XFS_IO_PROG -f -c 'chmod -r' -c 'copy_range -l 32k $testdir/file' $testdir/copy"
> +rm -f $testdir/copy
> +
> +echo
> +echo source range overlaps EOF returns EINVAL
> +$XFS_IO_PROG -f -c "copy_range -s 112k -l 32k $testdir/file" $testdir/copy
> +
> +echo
> +echo source range beyond EOF returns EINVAL
> +$XFS_IO_PROG -f -c "copy_range -s 128k -l 32k $testdir/file" $testdir/copy
> +
> +echo
> +echo source range overlaps destination range in same file returns EINVAL
> +$XFS_IO_PROG -f -c "copy_range -s 32k -d 48k -l 32k $testdir/file" $testdir/file
> +
> +echo
> +echo destination file O_RDONLY returns EBADF
> +$XFS_IO_PROG -f -r -c "copy_range -l 32k $testdir/file" $testdir/copy
> +
> +echo
> +echo destination file O_APPEND returns EBADF
> +$XFS_IO_PROG -f -a -c "copy_range -l 32k $testdir/file" $testdir/copy
> +
> +echo
> +echo source/destination as directory returns EISDIR
> +$XFS_IO_PROG -c "copy_range -l 32k $testdir/file" $testdir
> +$XFS_IO_PROG -f -c "copy_range -l 32k $testdir" $testdir/copy
> +
> +echo
> +echo source/destination as blkdev returns EINVAL
> +mknod $testdir/dev1 b 1 3
> +$XFS_IO_PROG -c "copy_range -l 32k $testdir/file" $testdir/dev1
> +$XFS_IO_PROG -f -c "copy_range -l 32k $testdir/dev1" $testdir/copy
> +
> +echo
> +echo source/destination as chardev returns EINVAL
> +mknod $testdir/dev2 c 1 3
> +$XFS_IO_PROG -c "copy_range -l 32k $testdir/file" $testdir/dev2
> +$XFS_IO_PROG -f -c "copy_range -l 32k $testdir/dev2" $testdir/copy
> +
> +echo
> +echo source/destination as FIFO returns EINVAL
> +mkfifo $testdir/fifo
> +$XFS_IO_PROG -c "copy_range -l 32k $testdir/file" $testdir/fifo
> +$XFS_IO_PROG -f -c "copy_range -l 32k $testdir/fifo" $testdir/copy
> +
> +max_off=$((8 * 2**60 - 65536 - 1))
> +min_off=65537
> +
> +echo
> +echo length beyond 8EiB wraps around 0 returns EOVERFLOW
> +$XFS_IO_PROG -f -c "copy_range -l 10e -s $max_off $testdir/file" $testdir/copy
> +$XFS_IO_PROG -f -c "copy_range -l 10e -d $max_off $testdir/file" $testdir/copy
> +
> +echo
> +echo source range beyond 8EiB returns EINVAL
> +$XFS_IO_PROG -c "truncate $((max_off + 65536))" $testdir/file
> +$XFS_IO_PROG -c "truncate $((max_off + 65536))" $testdir/copy
> +$XFS_IO_PROG -c "copy_range -s $max_off -l $min_off -d 0 $testdir/file" $testdir/copy
> +$XFS_IO_PROG -c "copy_range -s $min_off -l $max_off -d 0 $testdir/file" $testdir/copy
> +
> +echo
> +echo destination range beyond 8TiB returns EFBIG
> +$XFS_IO_PROG -c "copy_range -l $min_off -s 0 -d $max_off $testdir/file" $testdir/copy
> +
> +echo
> +echo destination larger than rlimit returns EFBIG
> +rm -f $testdir/copy
> +$XFS_IO_PROG -c "truncate 128k" $testdir/file
> +
> +# need a wrapper so the "File size limit exceeded" error can be filtered
> +do_rlimit_copy()
> +{
> +       $XFS_IO_PROG -f -c "copy_range -l 32k -s 0 -d 16m $testdir/file" $testdir/copy
> +}
> +
> +ulimit -f $((8 * 1024))
> +ulimit -c 0
> +do_rlimit_copy 2>&1 | grep -o "File size limit exceeded"
> +ulimit -f unlimited
> +
> +echo
> +echo copy across devices
> +$XFS_IO_PROG -f -c "copy_range -l 128k $testdir/file" $SCRATCH_MNT/copy
> +cmp $testdir/file $SCRATCH_MNT/copy
> +echo "md5sums after xdev copy:"
> +md5sum $testdir/file $SCRATCH_MNT/copy | _filter_test_dir | _filter_scratch
> +


All the test cases above check for bugs, which I presume your kernel patch
series is aimed at fixing(?)

This one last test case tests for new functionality that is not
currently available
for any filesystem in upstream kernel.

Does your kernel patch set also add this functionality to xfs? to generic?
IMO, it would be better to split this test case for new functionality to a new
test, so that this one can pass on stable kernels once all the bug
fixes have been
applied.

Thanks,
Amir.
