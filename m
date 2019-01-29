Received: from mail-vs1-f67.google.com ([209.85.217.67]:40857 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2LcR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Jan 2019 06:32:17 -0500
MIME-Version: 1.0
References: <20190129071857.32473-1-wqu@suse.com>
In-Reply-To: <20190129071857.32473-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 29 Jan 2019 11:32:05 +0000
Message-ID: <CAL3q7H5hQsj8XBN23X__U2ikc7+xcW0ewjiHksj7ofZ12M__cQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Test if btrfs will commit too many transaction
 for balance
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 29, 2019 at 7:19 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Kernel commit 64403612b73a ("btrfs: rework
> btrfs_check_space_for_delayed_refs") is introducing a regression for
> btrfs balance performance.
>
> Since that commit will cause btrfs to commit transaction for nothing
> during transaction,

to commit transaction for nothing during transaction -> to commit too
many transactions for nothing during balance/relocation.

Also, for the subject, "transaction" -> "transactions" (plural).

> it will slow balance dramatically even we only need
> to relocate several megabytes.
>
> This test case will catch the problem by using super block generation as
> failure criteria.
> For small chunk relocated, we will commit 6 transaction for each block
> group, and the test case should only have 2 block groups, it should only
> commit 12 transactions.
>
> This test case will use 120 as the threshold to detect the failure.
>
> And in my test environment, with kernel fix btrfs committed 14
> transactions and finished in 6s.
> While without the fix btrfs committed 1734 transactions and takes 25s to
> finish.
>
> So the test case should be more than enough to detect the regression,
> while still keep the runtime small enough for failure.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
> - Remove the unnecessary workaround for ENOSPC balance
>   Since we know the cause of that false ENOSPC error, a simple sync
>   would be enough to take care of the problem
>
> - Remove unnecessary mount option of max_inline
>   The same reason above.
> ---
>  tests/btrfs/181     | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/181.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 104 insertions(+)
>  create mode 100755 tests/btrfs/181
>  create mode 100644 tests/btrfs/181.out
>
> diff --git a/tests/btrfs/181 b/tests/btrfs/181
> new file mode 100755
> index 00000000..869cb15f
> --- /dev/null
> +++ b/tests/btrfs/181
> @@ -0,0 +1,101 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 181
> +#
> +# Test if btrfs will commit too many transactions for nothing and cause
> +# performance regression during balance.
> +#
> +# This bug is going to be fixed by a patch for kenerl title

kenerl -> kernel

> +# "btrfs: don't end the transaction for delayed refs in throttle"
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
> +_require_btrfs_command inspect-internal dump-super
> +
> +_scratch_mkfs > /dev/null
> +
> +_scratch_mount
> +
> +nr_files=3D1024
> +nr_snapshots=3D8

nr_snapshots is unused in the test.

> +
> +get_super_gen()
> +{
> +       $BTRFS_UTIL_PROG inspect dump-super "$SCRATCH_DEV" | grep ^genera=
tion |\
> +               awk '{print $2}'
> +}
> +
> +$BTRFS_UTIL_PROG subv create "$SCRATCH_MNT/subvol" > /dev/null

subv -> subvolume

We always prefer to use full command names.

> +
> +# Create some small files to take up enough metadata reserved space
> +for ((i =3D 0; i < $nr_files; i++)) do
> +       _pwrite_byte 0xcd 0 1K "$SCRATCH_MNT/subvol/file_$i" > /dev/null
> +done
> +
> +# Commit the fs so we can get a stable super generation
> +sync
> +
> +before_gen=3D$(get_super_gen)
> +if [ -z $before_gen ]; then
> +       _fail "failed to get super block genreation"

genreation -> generation

> +fi

Also, this error checking should fit better in the get_super_gen function.
We check for the error here but not when getting "after_gen", which seems o=
dd.

> +
> +$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" > /dev/null
> +
> +after_gen=3D$(get_super_gen)
> +
> +# Since the fs is pretty small, we should have only 1 small metadata chu=
nk and
> +# one tiny system chunk.
> +# Relocating such small chunks only need 6 commits for each, thus 12 com=
mits for

need -> needs

> +# 2 chunks.
> +# Here we use 10x the theoretic value as threshold.
> +theoretic_gen=3D$(( 6 * 2 ))
> +threshold_gen=3D$(( 10 * $theoretic_gen ))
> +if [ $(( $after_gen - $before_gen )) -gt 120 ]; then
> +       echo "balance committed too many transactions"
> +       echo "super generation before balance: ${before_gen}"
> +       echo "super generation after balance:  ${after_gen}"
> +       echo "super generation difference:     $((after_gen - before_gen)=
)"
> +       echo "theoretic generation difference: ${theoretic_gen}"
> +       echo "threshold generation difference: ${threshold_gen}"
> +fi
> +
> +echo "super generation before balance: ${before_gen}" >> $seqres.full
> +echo "super generation after balance:  ${after_gen}" >> $seqres.full
> +echo "super generation difference:     $((after_gen - before_gen))" >> $=
seqres.full
> +echo "theoretic generation difference: ${theoretic_gen}" >> $seqres.full
> +echo "threshold generation difference: ${threshold_gen}" >> $seqres.full
> +
> +# success, all done
> +echo "Silence is golden"

Other than that, it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/181.out b/tests/btrfs/181.out
> new file mode 100644
> index 00000000..a5a93be6
> --- /dev/null
> +++ b/tests/btrfs/181.out
> @@ -0,0 +1,2 @@
> +QA output created by 181
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 03eb62f9..0db485cb 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -183,3 +183,4 @@
>  178 auto quick send
>  179 auto qgroup dangerous
>  180 auto quick qgroup limit
> +181 auto quick balance
> --
> 2.18.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
