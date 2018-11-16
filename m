Received: from mail-ua1-f65.google.com ([209.85.222.65]:40664 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQFq6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 17 Nov 2018 00:46:58 -0500
Received: by mail-ua1-f65.google.com with SMTP id n7so8677686uao.7
        for <fstests@vger.kernel.org>; Fri, 16 Nov 2018 11:33:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+EzBbDr7rxN1ptJKd5FOLQFxLQSRnvEod6+xvR4A6pFuG07fQ@mail.gmail.com>
In-Reply-To: <CA+EzBbDr7rxN1ptJKd5FOLQFxLQSRnvEod6+xvR4A6pFuG07fQ@mail.gmail.com>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Fri, 16 Nov 2018 13:33:02 -0600
Message-ID: <CA+EzBbDKZzW++xuzL3oefmbEAY=_65L_ux_V7a_6tYoXuMZpsQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstest: CrashMonkey tests ported to xfstest Inbox x
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Eryu Guan <guaneryu@gmail.com>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

Hi all,

This is a gentle reminder to review the patch porting the first set of
CrashMonkey tests to xfstest. Do let me know if this patch requires
any correction, so that I can incorporate them and send out all
patches as soon as possible.


> Here is the new patch porting the first set of CrashMonkey tests to
> xfstests. This patch batches 37 CrashMonkey tests, and tests them on a
> file system of size 200MB. Each sub test is also followed by fsck to
> check for metadata inconsistencies. This test is added to a new group
> - regress.
> Let me know if this looks good to you.
>
> ---
>
> diff --git a/tests/generic/517 b/tests/generic/517
> new file mode 100755
> index 0000000..3e92fbb
> --- /dev/null
> +++ b/tests/generic/517
> @@ -0,0 +1,183 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 The University of Texas at Austin.  All Rights Reserved.
> +#
> +# FS QA Test 517-link
> +#
> +# Test case created by CrashMonkey
> +#
> +# Test if we create a hard link to a file and persist either of the
> files, all the names persist.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1    # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +    _cleanup_flakey
> +    cd /
> +    rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# 200MB in byte
> +fssize=$((2**20 * 200))
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_nocheck
> +_require_dm_target flakey
> +
> +# initialize scratch device
> +_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +
> +stat_opt='-c "blocks: %b size: %s inode: %i links: %h"'
> +before=""
> +after=""
> +
> +
> +# Using _scratch_mkfs instead of cleaning up the  working directory,
> +# adds about 10 seconds of delay in total for the 37 tests.
> +_clean_dir()
> +{
> +    _mount_flakey
> +    rm -rf $SCRATCH_MNT/*
> +    sync
> +    _unmount_flakey
> +}
> +
> +_check_consistency()
> +{
> +    _flakey_drop_and_remount | tee -a $seqres.full
> +
> +    if [ -f $1 ]; then
> +        after=`stat "$stat_opt" $1`
> +    fi
> +
> +    if [ "$before" != "$after" ] && [ $2 -ne 1 ]; then
> +        echo "Before: $before"
> +        echo "After: $after"
> +    fi
> +
> +    _unmount_flakey
> +    _check_scratch_fs $FLAKEY_DEV
> +    [ $? -ne 0 ] && _fatal "fsck failed"
> +}
> +
> +# create a hard link $2 to file $1, and fsync $3, followed by power-cut
> +test_link_fsync()
> +{
> +    local sibling=0
> +    before=""
> +    after=""
> +    src=$SCRATCH_MNT/$1
> +    dest=$SCRATCH_MNT/$2
> +
> +    if [ "$3" == "./" ]; then
> +        fsync=$SCRATCH_MNT
> +    else
> +        fsync=$SCRATCH_MNT/$3
> +    fi
> +
> +    echo -ne "\n=== link $src $dest  with fsync $fsync ===\n" | _filter_scratch
> +    _mount_flakey
> +
> +    # Now execute the workload
> +    # Create the directory in which the source and destination files
> +    # will be created
> +    mkdir -p "${src%/*}"
> +    mkdir -p "${dest%/*}"
> +    touch $src
> +    ln $src $dest
> +
> +    # If the file being persisted is a sibling, create it first
> +    if [ ! -f $fsync ]; then
> +        sibling=1
> +        touch $fsync
> +    fi
> +
> +    $XFS_IO_PROG -c "fsync" $fsync
> +
> +    if [ $sibling -ne 1 ]; then
> +        before=`stat "$stat_opt" $src`
> +    fi
> +
> +    _check_consistency $src $sibling
> +    _clean_dir
> +}
> +
> +# create a hard link $2 to file $1, and sync, followed by power-cut
> +test_link_sync()
> +{
> +    src=$SCRATCH_MNT/$1
> +    dest=$SCRATCH_MNT/$2
> +    before=""
> +    after=""
> +    echo -ne "\n=== link $src $dest  with sync ===\n" | _filter_scratch
> +    _mount_flakey
> +
> +    # now execute the workload
> +    # Create the directory in which the source and destination files
> +    # will be created
> +    mkdir -p "${src%/*}"
> +    mkdir -p "${dest%/*}"
> +    touch $src
> +    ln $src $dest
> +    sync
> +    before=`stat "$stat_opt" $src`
> +
> +    _check_consistency $src 0
> +    _clean_dir
> +}
> +
> +
> +# Create different combinations to run the link test
> +# Group 0: Both files within root directory
> +file_names[0]="foo bar"
> +fsync_names[0]="./ foo bar"
> +
> +# Group 1: Create hard link in a sub directory
> +file_names[1]="foo A/bar"
> +fsync_names[1]="./ foo bar A A/bar A/foo"
> +
> +# Group 2: Create hard link in parent directory
> +file_names[2]="A/foo bar"
> +fsync_names[2]="./ foo bar A A/bar A/foo"
> +
> +# Group 3: Both files within a directory other than root
> +file_names[3]="A/foo A/bar"
> +fsync_names[3]="./ A A/bar A/foo"
> +
> +#Group 4: Exercise name reuse : Link file in sub-directory
> +file_names[4]="bar A/bar"
> +fsync_names[4]="./ foo bar A A/bar A/foo"
> +
> +#Group 5: Exercise name reuse : Link file in parent directory
> +file_names[5]="A/bar bar"
> +fsync_names[5]="./ foo bar A A/bar A/foo"
> +
> +for ((test_group=0; test_group<6; test_group++)); do
> +    for file in ${fsync_names[$test_group]}; do
> +        test_link_fsync ${file_names[$test_group]} $file
> +    done
> +    test_link_sync ${file_names[$test_group]}
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/517.out b/tests/generic/517.out
> new file mode 100644
> index 0000000..b0d75a1
> --- /dev/null
> +++ b/tests/generic/517.out
> @@ -0,0 +1,75 @@
> +QA output created by 517
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/foo ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/bar ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/bar  with sync ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/foo ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/bar ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A/bar ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A/foo ===
> +
> +=== link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with sync ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/foo ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/bar ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A/bar ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A/foo ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with sync ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A/bar ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A/foo ===
> +
> +=== link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with sync ===
> +
> +=== link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT ===
> +
> +=== link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/foo ===
> +
> +=== link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/bar ===
> +
> +=== link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A ===
> +
> +=== link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A/bar ===
> +
> +=== link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_MNT/A/foo ===
> +
> +=== link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with sync ===
> +
> +=== link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_MNT ===
> +
> +=== link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_MNT/foo ===
> +
> +=== link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_MNT/bar ===
> +
> +=== link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A ===
> +
> +=== link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A/bar ===
> +
> +=== link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_MNT/A/foo ===
> +
> +=== link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with sync ===
> diff --git a/tests/generic/group b/tests/generic/group
> index 47de978..3e81ae8 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -519,3 +519,4 @@
>  514 auto quick clone
>  515 auto quick clone
>  516 auto quick dedupe clone
> +517 regress
