Received: from mail-qt0-f194.google.com ([209.85.216.194]:49835 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdKNIzf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Nov 2017 03:55:35 -0500
Received: by mail-qt0-f194.google.com with SMTP id p44so13123303qtj.6
        for <fstests@vger.kernel.org>; Tue, 14 Nov 2017 00:55:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8389cef1-9d9b-a9f2-e5b7-e409e42e2df3@jp.fujitsu.com>
References: <7a255645-5148-cd45-c0f7-1645982ca4e9@jp.fujitsu.com> <8389cef1-9d9b-a9f2-e5b7-e409e42e2df3@jp.fujitsu.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 14 Nov 2017 10:55:34 +0200
Message-ID: <CAOQ4uxjwYhJVR38pBbrTtLXfLoW3TaT_2TWEH+BqnU=Rf8Dyrw@mail.gmail.com>
Subject: Re: [PATCH 1/1] overlay/035: small fix for newer util-linux
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 14, 2017 at 3:10 AM, Misono, Tomohiro
<misono.tomohiro@jp.fujitsu.com> wrote:
> Modify filter in order make the test run correctly for
> both old (2.29) and new (2.30) util-linux.
>
> Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
> ---
>  tests/overlay/035 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/overlay/035 b/tests/overlay/035
> index 64fcd708..6f1627c6 100755
> --- a/tests/overlay/035
> +++ b/tests/overlay/035
> @@ -69,7 +69,8 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
>  $MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
>                         $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
>  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> -_scratch_remount rw 2>&1 | _filter_scratch
> +_scratch_remount rw 2>&1 | _filter_scratch \
> +       | sed -e "s,SCRATCH_MNT: ,," | sed -e "s,\.$,,"
>  $UMOUNT_PROG $SCRATCH_MNT
>


This change doesn't look right and/or not explained properly.
Any change to accommodate tool differences should be done
in the filter helpers, not in an individual test that filters the
output of a generic helper.

What is the change 2.29 -> 2.30 that causes the problem?
Without mentioning this, it is really hard to review if your change is correct.

Amir.
