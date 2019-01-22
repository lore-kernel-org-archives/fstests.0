Received: from mail-ua1-f68.google.com ([209.85.222.68]:39644 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAVWiz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 17:38:55 -0500
Received: by mail-ua1-f68.google.com with SMTP id c12so68907uas.6
        for <fstests@vger.kernel.org>; Tue, 22 Jan 2019 14:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20190121163316.20616-1-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-1-jeffm@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 22 Jan 2019 22:38:43 +0000
Message-ID: <CAL3q7H4mXQK-NPNtBbA5BGWfYk-8R567cNBVDZnHTAx4=-kyqg@mail.gmail.com>
Subject: Re: [PATCH 1/7] btrfs/010: don't run without /sys/fs/btrfs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 21, 2019 at 4:33 PM <jeffm@suse.com> wrote:
>
> From: Jeff Mahoney <jeffm@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good. Since it's a btrfs specific change/fix, it would have been
a good idea to cc linux-btrfs.

>
> Older kernels don't have /sys/fs/btrfs.  btrfs/010 will happily run
> until it goes to check its work against sysfs and finds those
> files don't exist.  This patch introduces a require check to
> ensure that the sysfs files are present before running.
>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  common/btrfs    | 8 ++++++++
>  tests/btrfs/010 | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/common/btrfs b/common/btrfs
> index 26dc0bb9..f6513c06 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -89,6 +89,14 @@ _require_btrfs_fs_feature()
>                 _notrun "Feature $feat not supported by the available btr=
fs version"
>  }
>
> +_require_btrfs_fs_sysfs()
> +{
> +       modprobe btrfs > /dev/null 2>&1
> +       [ -e /sys/fs/btrfs/features ] || \
> +               _notrun "Sysfs not supported by the available btrfs versi=
on"
> +
> +}
> +
>  _check_btrfs_filesystem()
>  {
>         device=3D$1
> diff --git a/tests/btrfs/010 b/tests/btrfs/010
> index 1a5f0146..72b2c727 100755
> --- a/tests/btrfs/010
> +++ b/tests/btrfs/010
> @@ -33,6 +33,7 @@ rm -f $seqres.full
>  _supported_fs btrfs
>  _supported_os Linux
>  _require_test
> +_require_btrfs_fs_sysfs
>
>  # Create 32k extents. All of these extents will be accounted as outstand=
ing and
>  # reserved.
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
