Received: from mail-ot1-f66.google.com ([209.85.210.66]:34130 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFNso (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Aug 2019 09:48:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so92666351otk.1
        for <fstests@vger.kernel.org>; Tue, 06 Aug 2019 06:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190805222738.21422-1-agruenba@redhat.com>
In-Reply-To: <20190805222738.21422-1-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 6 Aug 2019 15:48:32 +0200
Message-ID: <CAHc6FU6wt_GDPuhrp-z3ZwptrM9rOu5V2fH_7N8BfGNKNQUVag@mail.gmail.com>
Subject: Re: [PATCH] generic/322: remove bad xfs_io sync_range
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, 6 Aug 2019 at 00:27, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> The xfs_io sync_range command requires offset and length arguments.  Those are
> missing here, so the command fails with:
>
>   bad argument count 1 to sync_range, expected at least 2 arguments
>
> This went unnoticed because xfs_io still exits with status 0 in such cases,
> which looks like a separate bug.
>
> I'm assuming that the test did catch regressions as is and that the sync_range
> command isn't needed.  If this isn't the case, please fix the test.

Copying Josef who seems to be the author of this test case.

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  tests/generic/322 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/322 b/tests/generic/322
> index 2afd7127..22797c04 100755
> --- a/tests/generic/322
> +++ b/tests/generic/322
> @@ -65,7 +65,7 @@ _write_after_fsync_rename_test()
>         echo "fsync rename test"
>         _mount_flakey
>         $XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" -c "pwrite 2M 1M" \
> -               -c "sync_range -b" $SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"
> +               $SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"
>         mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>         $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
>         md5sum $SCRATCH_MNT/bar | _filter_scratch
> --
> 2.20.1

Thanks,
Andreas
