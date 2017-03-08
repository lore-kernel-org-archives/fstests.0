Received: from mail-oi0-f68.google.com ([209.85.218.68]:34108 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdCHKK6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2017 05:10:58 -0500
Received: by mail-oi0-f68.google.com with SMTP id m124so1899908oig.1
        for <fstests@vger.kernel.org>; Wed, 08 Mar 2017 02:10:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488957991-18194-1-git-send-email-zlang@redhat.com>
References: <1488957991-18194-1-git-send-email-zlang@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Mar 2017 12:01:33 +0200
Message-ID: <CAOQ4uxhq2h_WEKz1o+_AC8qFT6n6x40eUcBUpoe2eT1pfHAo7w@mail.gmail.com>
Subject: Re: [PATCH] generic/411: change sub-path name that's duplicate of TEST_DIR
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 8, 2017 at 9:26 AM, Zorro Lang <zlang@redhat.com> wrote:
> Darrick found generic/411 golden output mismatch if use
> TEST_DIR=/mnt. Because g/411 use some test path named
> /mnt/XXXX/mnt1/mnt2, _filter_test_dir will replace all
> "/mnt" things to "TEST_DIR".
>
> For stop this failure, change all directory names to be
> "$seq-XXX", that's less likely to be mistaken for TEST_*
> and SCRATCH_*.
>

Although you have a right to choose whichever names you
want top use for your test, this is papering over a bug.

I re-read the docuemtnation for \B:
http://www.rexegg.com/regex-boundaries.html#bengines

To my understanding, the expression "\B$TEST_DIR" will
match every instance of $TEST_DIR, where preceding character
is NOT a letter, number or underscore.
This is because $TEST_DIR must start with '/', which is not
a letter, number or underscore.

I think it should be safe to fix _filter_test_dir and _filter_scratch.

Eryu?

> Reported-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/generic/411     | 10 +++++-----
>  tests/generic/411.out |  8 ++++----
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tests/generic/411 b/tests/generic/411
> index 414d3a5..8a45f14 100755
> --- a/tests/generic/411
> +++ b/tests/generic/411
> @@ -123,18 +123,18 @@ crash_test()
>         start_test shared
>
>         _get_mount $SCRATCH_DEV $mpA
> -       mkdir $mpA/mnt1
> +       mkdir $mpA/${seq}-mnt1
>         $MOUNT_PROG --make-shared $mpA
>         _get_mount --bind $mpA $mpB
>         _get_mount --bind $mpA $mpC
>         $MOUNT_PROG --make-slave $mpB
>         $MOUNT_PROG --make-slave $mpC
> -       _get_mount $SCRATCH_DEV $mpA/mnt1
> -       mkdir $mpA/mnt1/mnt2
> +       _get_mount $SCRATCH_DEV $mpA/${seq}-mnt1
> +       mkdir $mpA/${seq}-mnt1/${seq}-mnt2
>
> -       _get_mount $SCRATCH_DEV $mpB/mnt1/mnt2
> +       _get_mount $SCRATCH_DEV $mpB/${seq}-mnt1/${seq}-mnt2
>         find_mnt
> -       fs_stress $mpB/mnt1/mnt2
> +       fs_stress $mpB/${seq}-mnt1/${seq}-mnt2
>
>         end_test
>         echo "crash test passed"
> diff --git a/tests/generic/411.out b/tests/generic/411.out
> index 16dadaf..01a0cdd 100644
> --- a/tests/generic/411.out
> +++ b/tests/generic/411.out
> @@ -2,11 +2,11 @@ QA output created by 411
>  ------
>  TEST_DIR/411 SCRATCH_DEV
>  mpA SCRATCH_DEV
> -mpA/mnt1 SCRATCH_DEV
> +mpA/411-mnt1 SCRATCH_DEV
>  mpB SCRATCH_DEV
> -mpB/mnt1 SCRATCH_DEV
> -mpB/mnt1/mnt2 SCRATCH_DEV
> +mpB/411-mnt1 SCRATCH_DEV
> +mpB/411-mnt1/411-mnt2 SCRATCH_DEV
>  mpC SCRATCH_DEV
> -mpC/mnt1 SCRATCH_DEV
> +mpC/411-mnt1 SCRATCH_DEV
>  ======
>  crash test passed
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
