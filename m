Received: from mail-pg1-f194.google.com ([209.85.215.194]:33450 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfCBQIt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 2 Mar 2019 11:08:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id h11so470537pgl.0
        for <fstests@vger.kernel.org>; Sat, 02 Mar 2019 08:08:48 -0800 (PST)
Date: Sun, 3 Mar 2019 00:08:43 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] ext4/035: Verify directory shrinking
Message-ID: <20190302160843.GF2824@desktop>
References: <20190228000316.238620-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228000316.238620-1-harshadshirwadkar@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

On Wed, Feb 27, 2019 at 04:03:16PM -0800, Harshad Shirwadkar wrote:
> Add test to verify that directory shrinking works for ext4 and also
> doing so repeatedly does not introduce any errors in file system.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks for the test! But a couple of issues in line :)

But one major problem is that, we need a way to check if the ext4 being
tested supports shrinking directory, and skip the test if it doesn't, as
shrink directory is a new feature, we don't want the test to report
failure on unpatched ext4, which gives false failure.

And it seems like this test is not ext4-specific, some other filesystems
support shrink directory as well, e.g. xfs and btrfs, so the test could
be a generic test, as long as we could detect if the filesystem supports
the feature or not.

> ---
>  tests/ext4/035     | 109 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/035.out |   9 ++++
>  tests/ext4/group   |   1 +

If adding a new fs-specific test, it'd be better to cc the fs's mailing
list too, e.g. linux-ext4@vger.kernel.org in this case.

>  3 files changed, 119 insertions(+)
>  create mode 100644 tests/ext4/035

Add new test with 0755 permission. It's highly recommended to use the
'new' script to create new test template, it's handling such issues for
you already. e.g.

./new ext4

>  create mode 100644 tests/ext4/035.out
> 
> diff --git a/tests/ext4/035 b/tests/ext4/035
> new file mode 100644
> index 00000000..46898d99
> --- /dev/null
> +++ b/tests/ext4/035
> @@ -0,0 +1,109 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Google, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 035
> +#
> +# Verify that directory shrinking works and that it does not introduce any
> +# errors.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    cd /
> +    #rm -f $tmp.*

Use tab as indention, not spaces, and remove $tmp.* even if you're not
using it in test explicitly, as the common functions may create $tmp.*
files too. Again, the 'new' script sets up template correctly.

> +}
> +
> +_make_files()

Local functions don't need the leading underscore.

> +{
> +    dirname=$1
> +    num_files=$2

And declare local variables as 'local'.

> +    for x in `seq 1 $num_files`; do
> +        fname="$(printf "%.255s\n" "$(perl -e "print \"${x}_\" x 500;")")"

Looks like you're copying test from ext4/017 and modifying based on
that. But I don't think this test doesn't need a specific pattern for file name, as
long as its name is long enough to take much directory space. So just do
$(perl -e 'print "a" x 255;') ?

> +        touch "${dirname}/${fname}"

echo > ${dirname}/${fname} would be a little faster, especially when
you're creating many files, that saves test time.

> +    done
> +}
> +
> +_make_dirs_and_files()
> +{
> +    parent_dir=$1
> +    num_dirs=$2
> +    num_files=$3
> +    for x in `seq 1 $num_dirs`; do
> +	mkdir ${parent_dir}/${x}
> +        _make_files "${parent_dir}/${x}" $num_files
> +    done
> +}
> +
> +_remove_dirs()
> +{
> +    parent_dir=$1
> +    num_dirs=$2
> +    for x in `seq 1 $num_dirs`; do
> +        find ${parent_dir}/${x} -type f -exec rm '{}' \;
> +    done
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr

attr is not used, no need to source common/attr.

> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +
> +_require_scratch
> +# test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
> +_require_attrs

Above two lines could be removed.

> +
> +rm -f $seqres.full
> +TESTDIR="${SCRATCH_MNT}/scratchdir"
> +TESTFILE="${TESTDIR}/testfile"

TESTDIR is only used in TESTFILE, but TESTFILE is not used in this test.

And we have a global TEST_DIR variable (mount point for $TEST_DEV), so
TESTDIR is a bad name, which may make people think it's TEST_DIR.

> +
> +echo "+ create scratch fs"
> +_scratch_mkfs_ext4 > /dev/null 2>&1

_scratch_mkfs, no need to call _scratch_mkfs_ext4 explicitly.

> +
> +echo "+ mount fs image"
> +_scratch_mount
> +
> +mkdir -p ${SCRATCH_MNT}/test
> +
> +echo "+ create files"
> +blksz="$(stat -f -c '%s' "${SCRATCH_MNT}")"
> +_make_files ${SCRATCH_MNT}/test $((blksz * 4 / 256))

Any reason to create $((blksz * 4 / 256)) files?

> +
> +size_before=$(du -s "${SCRATCH_MNT}/test" | gawk '{print $1}')

I think you're going to take the size of the "test" dir inode not the
size of all the files within it? So it should be
"stat -c %s $SCRATCH_MNT/test"?

> +
> +echo "+ remove files"
> +rm ${SCRATCH_MNT}/test/*
> +
> +size_after=$(du -s "${SCRATCH_MNT}/test" | gawk '{print $1}')
> +
> +if [ $size_after -lt $size_before ]; then
> +  echo "+ directory shrinked"
> +else
> +  _fail "directory did not shrink"

Just echo "directory did not shrink", no need to _fail, the test harness
would capture the output and compare it with the golden output and fails
the test if they don't match.

> +fi
> +
> +echo "+ create many directories and files"
> +_make_dirs_and_files ${SCRATCH_MNT} 4 10240
> +
> +echo "+ empty dirs"
> +_remove_dirs ${SCRATCH_MNT} 4
> +
> +umount "${SCRATCH_MNT}"

_scratch_umount

> +
> +echo "+ check fs"
> +e2fsck -fn ${SCRATCH_DEV} >> $seqres.full 2>&1 || _fail "fsck should not fail"

No need to umount & check fs explicitly, test harness would do it for
you as well.

Thanks,
Eryu

> +
> +status=0
> +exit
> diff --git a/tests/ext4/035.out b/tests/ext4/035.out
> new file mode 100644
> index 00000000..2d9a34e1
> --- /dev/null
> +++ b/tests/ext4/035.out
> @@ -0,0 +1,9 @@
> +QA output created by 035
> ++ create scratch fs
> ++ mount fs image
> ++ create files
> ++ remove files
> ++ directory shrinked
> ++ create many directories and files
> ++ empty dirs
> ++ check fs
> diff --git a/tests/ext4/group b/tests/ext4/group
> index eb744a12..c25205dd 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -37,6 +37,7 @@
>  032 auto quick ioctl resize
>  033 auto ioctl resize
>  034 auto quick quota
> +035 auto
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.21.0.rc2.261.ga7da99ff1b-goog
> 
