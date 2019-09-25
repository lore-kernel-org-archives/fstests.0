Received: from mail-vk1-f196.google.com ([209.85.221.196]:34665 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfIYJsv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 05:48:51 -0400
MIME-Version: 1.0
References: <20190923124347.30850-1-wqu@suse.com>
In-Reply-To: <20190923124347.30850-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Wed, 25 Sep 2019 10:48:38 +0100
Message-ID: <CAL3q7H6Fo+79a36Bp1kRpfyczK5diRwtgkcNLewEY1Fj=dTPiQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/011: Fill the fs to ensure we have enough
 data for dev-replace
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 24, 2019 at 6:02 PM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When btrfs/011 is executed on a fast enough system (fully memory backed
> VM, with test device has unsafe cache mode), the test can fail like
> this:
>
>   btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /home/a=
dam/xfstests-dev/results//btrfs/011.out.bad)
>     --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
>     +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-09-1=
8 14:49:28.308798022 +0800
>     @@ -1,3 +1,4 @@
>      QA output created by 011
>      *** test btrfs replace
>     -*** done
>     +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>     +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)
>     ...
>
> [CAUSE]
> Looking into the full output, it shows:
>   ...
>   Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2
>
>   # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/mapper=
/test-scratch2 /mnt/scratch
>   # /usr/bin/btrfs replace cancel /mnt/scratch
>   INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
>   failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>
> So this means the replace is already finished before we cancel it.
> For fast system, it's very common.
>
> [FIX]
> In fill_scratch() after all the original file creations, do a timer
> based direct IO write.
> The extra write will take 2 * $wait_time, utilizing direct IO with 64K
> block size, the write performance should be very comparable (although a
> little faster) to replace performance.
>
> So later cancel should be able to really cancel the dev-replace without
> it finished too early.
>
> Also, do extra check about the above write. If we hit ENOSPC we just
> skip the test as the system is really too fast and the fs is not large
> enough.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/011 | 45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 89bb4d11..dc86539c 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -34,7 +34,7 @@ _cleanup()
>                 kill -TERM $noise_pid
>         fi
>         wait
> -       rm -f $tmp.tmp
> +       rm -f $tmp.*
>         # we need this umount and couldn't rely on _require_scratch to um=
ount
>         # it from next test, because we would replace SCRATCH_DEV, which =
is
>         # needed by _require_scratch, and make it umounted.
> @@ -54,13 +54,17 @@ _require_scratch_dev_pool_equal_size
>  _require_command "$WIPEFS_PROG" wipefs
>
>  rm -f $seqres.full
> -rm -f $tmp.tmp
> +rm -f $tmp.*
>
>  echo "*** test btrfs replace"
>
> +# In seconds
> +wait_time=3D1
> +
>  fill_scratch()
>  {
>         local fssize=3D$1
> +       local filler_pid
>
>         # Fill inline extents.
>         for i in `seq 1 500`; do
> @@ -75,6 +79,33 @@ fill_scratch()
>         for i in `seq $fssize`; do
>                 cp $SCRATCH_MNT/t0 $SCRATCH_MNT/t$i || _fail "cp failed"
>         done > /dev/null 2>> $seqres.full
> +
> +       # Ensure we have enough data so that dev-replace would take at le=
ast
> +       # 2 * $wait_time, allowing we cancel the running replace.
> +       # Some extra points:
> +       # - Use XFS_IO_PROG instead of dd
> +       #   fstests wraps dd, making it pretty hard to kill the real dd p=
id
> +       # - Use 64K block size with Direct IO
> +       #   64K is the same stripe size used in replace/scrub. Using Dire=
ct IO
> +       #   ensure the IO speed is near device limit and comparable to re=
place
> +       #   speed.
> +       $XFS_IO_PROG -f -d -c "pwrite -b 64k 0 1E" "$SCRATCH_MNT/t_filler=
" &>\
> +               $tmp.filler_result &
> +       filler_pid=3D$!
> +       sleep $((2 * $wait_time))
> +       kill -KILL $filler_pid &> /dev/null
> +       wait $filler_pid &> /dev/null
> +
> +       # If the system is too fast and the fs is too small, then skip th=
e test
> +       if grep -q "No space left" $tmp.filler_result; then
> +               ls -alh $SCRATCH_MNT >> $seqres.full
> +               cat $tmp.filler_result >> $seqres.full
> +               _notrun "system too fast and/or too small fs"

It would probably be better to require so minimal size for the
filesystem instead.

> +       fi
> +       # If killed properly, this file should be empty.

Confusing comment for me. If killed properly? How does that influence
the file being empty?
What influences the file being empty is that it's impossible (in
practice) for xfs_io to complete the write in less then 2 seconds,
assuming the fs isn't very small and it hits ENOSPC in less than 2
seconds.

I would rephrase that or remove that line.

Other than that it looks ok to me.

Thanks

> +       # If something other than ENOSPC happened, output to make sure we=
 can
> +       # detect the error
> +       cat $tmp.filler_result
>         sync; sync
>  }
>
> @@ -147,7 +178,7 @@ btrfs_replace_test()
>         if [ "${with_cancel}Q" =3D "cancelQ" ]; then
>                 # background the replace operation (no '-B' option given)
>                 _run_btrfs_util_prog replace start -f $replace_options $s=
ource_dev $target_dev $SCRATCH_MNT
> -               sleep 1
> +               sleep $wait_time
>                 _run_btrfs_util_prog replace cancel $SCRATCH_MNT
>
>                 # 'replace status' waits for the replace operation to fin=
ish
> @@ -157,10 +188,10 @@ btrfs_replace_test()
>                 grep -q canceled $tmp.tmp || _fail "btrfs replace status =
(canceled) failed"
>         else
>                 if [ "${quick}Q" =3D "thoroughQ" ]; then
> -                       # On current hardware, the thorough test runs
> -                       # more than a second. This is a chance to force
> -                       # a sync in the middle of the replace operation.
> -                       (sleep 1; sync) > /dev/null 2>&1 &
> +                       # The thorough test runs around 2 * $wait_time se=
conds.
> +                       # This is a chance to force a sync in the middle =
of the
> +                       # replace operation.
> +                       (sleep $wait_time; sync) > /dev/null 2>&1 &
>                 fi
>                 _run_btrfs_util_prog replace start -Bf $replace_options $=
source_dev $target_dev $SCRATCH_MNT
>
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
