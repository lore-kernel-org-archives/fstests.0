Received: from mail-yb0-f180.google.com ([209.85.213.180]:46817 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdLCJ3Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Dec 2017 04:29:16 -0500
Received: by mail-yb0-f180.google.com with SMTP id g187so5544591yba.13
        for <fstests@vger.kernel.org>; Sun, 03 Dec 2017 01:29:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512122736-6045-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1512122736-6045-1-git-send-email-xuyang.jy@cn.fujitsu.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 Dec 2017 11:29:15 +0200
Message-ID: <CAOQ4uxiesM5ENw=WB1U9UO88ibstvBWsVatZFOyDA50Y_r7RoQ@mail.gmail.com>
Subject: Re: [PATCH] generic/459: Fix check for ro-remount in extN
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: yang xu <xuyang.jy@cn.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>, Carlos Maiolino <cmaiolino@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 1, 2017 at 12:05 PM, yang xu <xuyang.jy@cn.fujitsu.com> wrote:
> Currently ,freeze failure caused by the lack of space can not
> guarantee to remount extN filesystem in read-only mode.
> We can add a touch to trigger the action which aborts journal
> and ro-remounts the fs.
>
> Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> ---
>  tests/generic/459 |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tests/generic/459 b/tests/generic/459
> index eb05fb8..197d729 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -132,9 +132,11 @@ ret=$?
>  #      - The filesystem turns into Read-Only and reject further writes
>  #      - The filesystem stays in Read-Write mode, but can be frozen/thawed
>  #        without getting stuck.
> -ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
> -
> -if [ $ret -ne 0 ]; then
> +if [ $ret -ne 0 ]; then
> +       # fsfreeze failed, filesystem should reject further writes and remount
> +       # as readonly
> +       touch $SCRATCH_MNT/newfile >/dev/null 2>&1
> +       ISRO=$(_fs_options /dev/mapper/$vgname-$snapname | grep -w "ro")
>         if [ -n "$ISRO" ]; then
>                 echo "Test OK"
>         else
> --

The ro-remount behavior that this test is checking is not documented anywhere
AFAIK nor is required from fs on failure to fsfreeze.
It is also not related to the XFS bug this test is covering.

I do not object to keeping this ro-remount check nor to keep fixing it
for other fs.
Just pointing out the possibility to pass the test if fsfreeze failed
regardless of
ro-remount, which is a logical, but not required behavior from fs.

Amir.
