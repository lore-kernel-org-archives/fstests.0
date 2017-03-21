Received: from mail-oi0-f66.google.com ([209.85.218.66]:36349 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756186AbdCUKzd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2017 06:55:33 -0400
Received: by mail-oi0-f66.google.com with SMTP id a144so5964031oib.3
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2017 03:55:32 -0700 (PDT)
In-Reply-To: <1490087883-24453-2-git-send-email-zlang@redhat.com>
References: <1490087883-24453-1-git-send-email-zlang@redhat.com> <1490087883-24453-2-git-send-email-zlang@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Mar 2017 06:55:31 -0400
Message-ID: <CAOQ4uxhfwuGD3NG5xfW11eXJT1LODi-7WyP6z9pPhOKaeFrcOQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] xfs/068: skip new fsstress operations mwrite and mread
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Zorro Lang <zlang@redhat.com>, Eric Sandeen <sandeen@sandeen.net>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 5:18 AM, Zorro Lang <zlang@redhat.com> wrote:
> The output of x/068 will be perturbed by new fsstress operations.
> For keep away breaking x/068's golden image, skip mread and
> mwrite which are brought in by a new fsstress patch.
>
> Reported-by: Eryu Guan <eguan@redhat.com>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/xfs/068 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/xfs/068 b/tests/xfs/068
> index 4dac95e..568ba60 100755
> --- a/tests/xfs/068
> +++ b/tests/xfs/068
> @@ -44,7 +44,7 @@ _supported_fs xfs
>  _supported_os Linux
>
>  # need to ensure new fsstress operations don't perturb expected output
> -FSSTRESS_AVOID=3D"-f insert=3D0 $FSSTRESS_AVOID"
> +FSSTRESS_AVOID=3D"-f insert=3D0 -f mwrite=3D0 -f mread=3D0 $FSSTRESS_AVO=
ID"

What?? This is so fragile!

If the test wanted to restrict fsstress to a pre-defined set of operations,=
 then
_create_dumpdir_stress_num() should have prefixed '_param' with -z and
mention all pre-defined ops (and not only the more frequent ones).

I am very surprised that Dave was the one that made this bandaid.

Eric,

Can you say if adding -z to _create_dumpdir_stress_num() params
would be fine with the 2 tests that use it - xfs/022 and xfs/068?

068 output would have to be fixed to accommodate this change,
but then we can remove the bandaid above and never think of
this ever again.




>  _create_dumpdir_stress_num 4096
>  _do_dump_restore
>
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3D7B_Fox-9vCw4xAJ5cW1GVVeARkWiBAFy-Bmpxg6ZBuE&s=3Dh38K-AlKoB7pMZoCp7s84E-4=
pClXFBq9pkXXWn0u-bo&e=3D=20
