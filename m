Received: from mail-vk1-f194.google.com ([209.85.221.194]:39503 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbfEQPPV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 May 2019 11:15:21 -0400
Received: by mail-vk1-f194.google.com with SMTP id t18so2106499vkb.6
        for <fstests@vger.kernel.org>; Fri, 17 May 2019 08:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190517112422.20671-1-lhenriques@suse.com> <20190517112422.20671-2-lhenriques@suse.com>
In-Reply-To: <20190517112422.20671-2-lhenriques@suse.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Fri, 17 May 2019 16:15:09 +0100
Message-ID: <CAL3q7H4yBsg0=pbcsKTUk_5Ta=XcZMxA0cbYdVUeHKt2=A+Ogg@mail.gmail.com>
Subject: Re: [PATCH 1/2] generic/319: use numeric user and group IDs in getfacl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests <fstests@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Fri, May 17, 2019 at 12:49 PM Luis Henriques <lhenriques@suse.com> wrote=
:
>
> This prevents test failures if cases where, e.g., /etc/group doesn't
> include the 'root' group ID.
>
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/generic/319     | 4 ++--
>  tests/generic/319.out | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tests/generic/319 b/tests/generic/319
> index 02973d90cbe2..504cf627537b 100755
> --- a/tests/generic/319
> +++ b/tests/generic/319
> @@ -44,10 +44,10 @@ _scratch_mount
>
>  mkdir $SCRATCH_MNT/testdir
>  setfacl -d --set u::rwx,g::rwx,o::- $SCRATCH_MNT/testdir
> -getfacl --absolute-names $SCRATCH_MNT/testdir | _filter_scratch
> +getfacl -n --absolute-names $SCRATCH_MNT/testdir | _filter_scratch
>
>  mkdir $SCRATCH_MNT/testdir/testsubdir
> -getfacl --absolute-names $SCRATCH_MNT/testdir/testsubdir | _filter_scrat=
ch
> +getfacl -n --absolute-names $SCRATCH_MNT/testdir/testsubdir | _filter_sc=
ratch
>
>  # success, all done
>  status=3D0
> diff --git a/tests/generic/319.out b/tests/generic/319.out
> index b090bfaf6a04..bf6b4bc80462 100644
> --- a/tests/generic/319.out
> +++ b/tests/generic/319.out
> @@ -1,7 +1,7 @@
>  QA output created by 319
>  # file: SCRATCH_MNT/testdir
> -# owner: root
> -# group: root
> +# owner: 0
> +# group: 0
>  user::rwx
>  group::r-x
>  other::r-x
> @@ -10,8 +10,8 @@ default:group::rwx
>  default:other::---
>
>  # file: SCRATCH_MNT/testdir/testsubdir
> -# owner: root
> -# group: root
> +# owner: 0
> +# group: 0
>  user::rwx
>  group::rwx
>  other::---



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
