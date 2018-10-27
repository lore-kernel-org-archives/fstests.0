Received: from mail-vs1-f68.google.com ([209.85.217.68]:37183 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeJ0SCq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 27 Oct 2018 14:02:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id r83so2328778vsc.4
        for <fstests@vger.kernel.org>; Sat, 27 Oct 2018 02:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181026115349.4241-1-tytso@mit.edu>
In-Reply-To: <20181026115349.4241-1-tytso@mit.edu>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Sat, 27 Oct 2018 10:22:16 +0100
Message-ID: <CAL3q7H4PN_Rz6HUkCrp4aEQsd+Jv_M9PBR+yRvXf7Y=Y2tZMMQ@mail.gmail.com>
Subject: Re: [PATCH] generic: update group file to indicate generic/456 uses {collapse,zero}_range
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Oct 26, 2018 at 12:53 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/group | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/generic/group b/tests/generic/group
> index 28452732..8a21970e 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -458,7 +458,7 @@
>  453 auto quick dir
>  454 auto quick attr
>  455 auto log replay
> -456 auto quick metadata
> +456 auto quick metadata collapse zero

Since it uses fallocate too, should also be in the 'prealloc' group.

Thanks.

>  457 auto log replay clone
>  458 auto quick clone collapse zero
>  459 auto thin
> --
> 2.18.0.rc0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
