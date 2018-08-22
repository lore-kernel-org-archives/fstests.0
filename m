Received: from mail-vk0-f66.google.com ([209.85.213.66]:35907 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbeHVPOY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Aug 2018 11:14:24 -0400
Received: by mail-vk0-f66.google.com with SMTP id y9-v6so727386vky.3
        for <fstests@vger.kernel.org>; Wed, 22 Aug 2018 04:49:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
References: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
From: Filipe Manana <fdmanana@gmail.com>
Date: Wed, 22 Aug 2018 12:49:47 +0100
Message-ID: <CAL3q7H4UVg8Rz5afkG5K4MOWymCe=w8DH5wKfMv_+PZeVbPmHQ@mail.gmail.com>
Subject: Re: [PATCH] xfstests: generic/062: Change output of empty attribute values
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Su Yue <suy.fnst@cn.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 22, 2018 at 9:32 AM, Su Yue <suy.fnst@cn.fujitsu.com> wrote:
> Since v2.4.47 of attr(5)[1], commit 0550d2bc989d (Properly
> set and report empty attribute values) changed output format of
> empty attribute value with quotes.
>
> Here, change generic/062.out to match the actual output.

This will break the test on systems with older versions of the tool
(think enterprise distros for example).
The correct way to do this in fstests is to use filters (we have
numerous examples around).

>
> [1]: https://git.savannah.nongnu.org/git/attr.git
>
> Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
> ---
>  tests/generic/062.out | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/tests/generic/062.out b/tests/generic/062.out
> index 8cc3c655..9b9cd744 100644
> --- a/tests/generic/062.out
> +++ b/tests/generic/062.out
> @@ -13,7 +13,7 @@ SCRATCH_MNT/reg
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/reg
> -user.name
> +user.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -42,7 +42,7 @@ user.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/reg
> -user.name2
> +user.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/reg
> @@ -60,7 +60,7 @@ user.name3=3D0xdeface
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/dir
> -user.name
> +user.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -89,7 +89,7 @@ user.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/dir
> -user.name2
> +user.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/dir
> @@ -207,7 +207,7 @@ SCRATCH_MNT/dev/p: user.name2: No such attribute or o=
peration not permitted
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/reg
> -trusted.name
> +trusted.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -236,7 +236,7 @@ trusted.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/reg
> -trusted.name2
> +trusted.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/reg
> @@ -256,7 +256,7 @@ user.name3=3D0xdeface
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/dir
> -trusted.name
> +trusted.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -285,7 +285,7 @@ trusted.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/dir
> -trusted.name2
> +trusted.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/dir
> @@ -305,7 +305,7 @@ user.name3=3D0xdeface
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/lnk
> -trusted.name
> +trusted.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -334,7 +334,7 @@ trusted.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/lnk
> -trusted.name2
> +trusted.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/lnk
> @@ -352,7 +352,7 @@ trusted.name3=3D0xdeface
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/dev/b
> -trusted.name
> +trusted.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -381,7 +381,7 @@ trusted.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/dev/b
> -trusted.name2
> +trusted.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/dev/b
> @@ -399,7 +399,7 @@ trusted.name3=3D0xdeface
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/dev/c
> -trusted.name
> +trusted.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -428,7 +428,7 @@ trusted.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/dev/c
> -trusted.name2
> +trusted.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/dev/c
> @@ -446,7 +446,7 @@ trusted.name3=3D0xdeface
>
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/dev/p
> -trusted.name
> +trusted.name=3D""
>
>  *** overwrite empty, set several new attributes
>  *** fetch several attribute names and values (hex)
> @@ -475,7 +475,7 @@ trusted.name3=3D0xdeface
>
>  *** set an empty value for second attribute
>  # file: SCRATCH_MNT/dev/p
> -trusted.name2
> +trusted.name2=3D""
>
>  *** overwrite empty value
>  # file: SCRATCH_MNT/dev/p
> --
> 2.18.0
>
>
>



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
