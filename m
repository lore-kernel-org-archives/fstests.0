Received: from mail-yw1-f67.google.com ([209.85.161.67]:34978 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYMEE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Sep 2018 08:04:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id y76-v6so2270459ywd.2
        for <fstests@vger.kernel.org>; Mon, 24 Sep 2018 22:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180924214352.7fjpxbcnxpugnoms@eaf>
In-Reply-To: <20180924214352.7fjpxbcnxpugnoms@eaf>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Sep 2018 08:57:58 +0300
Message-ID: <CAOQ4uxibAJiKrBHV3diRoAqrqTbkNmknzbWv8VnOdGMwEogcWA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: add support for hfsplus
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: ernesto.mnd.fernandez@gmail.com
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <sandeen@sandeen.net>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 25, 2018 at 12:44 AM Ernesto A. Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com> wrote:
>
> Running tests on hfsplus requires patched versions of the mkfs and fsck
> tools [1] that support filesystems smaller than the device.

That's not accurate, is it? Wouldn't it be more accurate to say that the pa=
tched
tools are required to run the _scratch_mkfs_sized tests?

>
> [1] https://github.com/eafer/hfsprogs-linux.git
>
> Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
> ---
>  common/config | 10 ++++++++++
>  common/rc     | 15 ++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/common/config b/common/config
> index 1ba8d96c..315f8b1e 100644
> --- a/common/config
> +++ b/common/config
> @@ -229,6 +229,7 @@ case "$HOSTOS" in
>         export MKFS_CIFS_PROG=3D"false"
>         export MKFS_OVERLAY_PROG=3D"false"
>         export MKFS_REISER4_PROG=3D$(type -P mkfs.reiser4)
> +       export MKFS_HFSPLUS_PROG=3D$(type -P mkfs.hfsplus)
>         export E2FSCK_PROG=3D$(type -P e2fsck)
>         export TUNE2FS_PROG=3D$(type -P tune2fs)
>         export FSCK_OVERLAY_PROG=3D$(type -P fsck.overlay)
> @@ -313,6 +314,9 @@ _mount_opts()
>         ubifs)
>                 export MOUNT_OPTIONS=3D$UBIFS_MOUNT_OPTIONS
>                 ;;
> +       hfsplus)
> +               export MOUNT_OPTIONS=3D$HFSPLUS_MOUNT_OPTIONS
> +               ;;
>         *)
>                 ;;
>         esac
> @@ -380,6 +384,9 @@ _mkfs_opts()
>         f2fs)
>                 export MKFS_OPTIONS=3D"$F2FS_MKFS_OPTIONS"
>                 ;;
> +       hfsplus)
> +               export MKFS_OPTIONS=3D$HFSPLUS_MKFS_OPTIONS
> +               ;;
>         *)
>                 ;;
>         esac
> @@ -397,6 +404,9 @@ _fsck_opts()
>         f2fs)
>                 export FSCK_OPTIONS=3D""
>                 ;;
> +       hfsplus)
> +               export FSCK_OPTIONS=3D"-nX"
> +               ;;
>         *)
>                 export FSCK_OPTIONS=3D"-n"
>                 ;;
> diff --git a/common/rc b/common/rc
> index d5bb1fee..a843e9f6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -158,6 +158,12 @@ case "$FSTYP" in
>      ubifs)
>         [ "$UBIUPDATEVOL_PROG" =3D "" ] && _fatal "ubiupdatevol not found=
"
>         ;;
> +    hfsplus)
> +       [ "$MKFS_HFSPLUS_PROG" =3D "" ] && _fatal "mkfs.hfsplus not found=
"
> +       mkfs.hfsplus -X |& grep "invalid" &&
> +               _fatal "A patched version of mkfs.hfsplus is required:" \
> +                      "https://github.com/eafer/hfsprogs-linux.git"

Why fatal and not just notrun the _scratch_mkfs_sized tests if no -X suppor=
t?
Must all tests run with mkfs -X and fsck -X??

> +       ;;
>  esac
>
>  if [ ! -z "$REPORT_LIST" ]; then
> @@ -746,6 +752,10 @@ _scratch_mkfs()
>                 mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
>                 mkfs_filter=3D"grep -v -e ^mkfs\.ocfs2"
>                 ;;
> +       hfsplus)
> +               mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP -- -X"

-X here seems like a typo?

Thanks,
Amir.
