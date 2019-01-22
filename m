Received: from mail-vs1-f65.google.com ([209.85.217.65]:35929 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfAVWlk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 17:41:40 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so142921vsc.3
        for <fstests@vger.kernel.org>; Tue, 22 Jan 2019 14:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20190121163316.20616-1-jeffm@suse.com> <20190121163316.20616-6-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-6-jeffm@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Tue, 22 Jan 2019 22:41:29 +0000
Message-ID: <CAL3q7H4p94foP+xbQiz+YG9pxVyx-atSo=Qi+pRhp8XYm4y47A@mail.gmail.com>
Subject: Re: [PATCH 6/7] btrfs/131: require support for free-space-tree
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 21, 2019 at 4:33 PM <jeffm@suse.com> wrote:
>
> From: Jeff Mahoney <jeffm@suse.com>
>
> btrfs/131 tests the free space tree, which older kernels won't have.  We
> shouldn't run there.
>
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good. Since it's a btrfs specific change/fix, it would have been
a good idea to cc linux-btrfs.

> ---
>  tests/btrfs/131 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/btrfs/131 b/tests/btrfs/131
> index 0da1e7be..3de7eef8 100755
> --- a/tests/btrfs/131
> +++ b/tests/btrfs/131
> @@ -34,6 +34,7 @@ _supported_fs btrfs
>  _supported_os Linux
>  _require_scratch
>  _require_btrfs_command inspect-internal dump-super
> +_require_btrfs_fs_feature free_space_tree
>
>  mkfs_v1()
>  {
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
