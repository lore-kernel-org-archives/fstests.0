Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E31C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Sep 2021 10:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2435B611B0
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Sep 2021 10:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhIVKRP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbhIVKRP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Sep 2021 06:17:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67FC061574
        for <fstests@vger.kernel.org>; Wed, 22 Sep 2021 03:15:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 194so7525956qkj.11
        for <fstests@vger.kernel.org>; Wed, 22 Sep 2021 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=naRqvmkgpPCUrUbS8WDVlPz2msx42ZQVIH6xooyTKGY=;
        b=R8LUbEcDyzCEGyRApnZP1qEIf67NS/C0zmh3b0pk+sShjxBL/OkcXA4xsjXbg49czc
         3dcgQeiZqsn1YyYSgxGyffI++cQARnxOLm7+OZ2WYbky2QwUUCX98adv75sEoX4gRO82
         MW4VqMj8pvlpYZA5IzzY15Lbsaie4M8NSxypMXNeXVY2WolAOCV+VCXbmJ4Oe74l0zdg
         P5GN06DOImvdwEcieSdBPdIcFbIfbjXnKHHJkqyX/aEWXHqQJCH98DimmGyAri1RrGZt
         9qs93XkTx5fKd1+IGwwSuFS0eE/guZN2wkl3zpJbPJHHnmj4xppqDXyL8HBnH5oiY4Yo
         9mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=naRqvmkgpPCUrUbS8WDVlPz2msx42ZQVIH6xooyTKGY=;
        b=EuNJFJr+4Hly5xL9gCfv4CIsES6lMWlF82SWIMIq6zHnAFOWIZOLrYRkFGe6ibaiUJ
         nWWvLQz0e/UlVo12MzgEs1SmpDX5GcHXGwlcx/2L2pD05/IN/VFFeCkKda3RydUrTPOf
         dbpP2bfT+yQEETa2V8uSE9D4+dFvxhycXg3fPkDanA1+eOiO4wxRWN7xZfQurGiodIwM
         qm53o/P3MBgW4K66VakNf+uxembHnH/AFRcT00uTt4ROvhum57jY4StAa5etP1uXmhGA
         pqhbVbF4UiZxuXaR1R5mlqJC5lQ4Ya6N7cC+Lnm9vt7RXosZ7EMtJOFv6CySUW/Hz243
         TpaA==
X-Gm-Message-State: AOAM532qSwsg8Reb63iu9/j3mvV6p5WKQBQzIuZ2pPhOZY+QjJr35UmW
        q9ZdyYsSxq017BCihcMoDbyekYFwij1eVEYKXNk=
X-Google-Smtp-Source: ABdhPJwj6g/7QmiKLqtguDXziiPUG2sMKFHdKEX1zfl2lMI4nJGW5Y6pysVlBRp15UoQxFtN12y6g3azH6MYUs51V+M=
X-Received: by 2002:a37:651:: with SMTP id 78mr12191685qkg.516.1632305744579;
 Wed, 22 Sep 2021 03:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210921175035.1286786-1-mcgrof@kernel.org>
In-Reply-To: <20210921175035.1286786-1-mcgrof@kernel.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 22 Sep 2021 11:15:08 +0100
Message-ID: <CAL3q7H4hvwDcio3qqTbQj0BK9GbEeGhfbx2F32WBpB3D5nKL8Q@mail.gmail.com>
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 21, 2021 at 6:51 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> I ran into an error with generic/083 with xfs due to check_cwd() but
> why it failed is not clear because there are two types of
> failures:
>
>   o stat64() failed (likely -ENOMEM is my guess)
>   o the inode actually changed
>
> Thow a bone out to developers so that in case en error does happen
> they know which rabbit hole to go down on.
>
> Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  ltp/fsstress.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index b4ddf5e2..d2f09901 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -9,6 +9,7 @@
>  #include <sys/uio.h>
>  #include <stddef.h>
>  #include <stdbool.h>
> +#include <string.h>
>  #include "global.h"
>
>  #ifdef HAVE_BTRFSUTIL_H
> @@ -943,9 +944,21 @@ check_cwd(void)
>  {
>  #ifdef DEBUG
>         struct stat64   statbuf;
> +       int ret;
> +
> +       ret =3D stat64(".", &statbuf);
> +       if (ret !=3D0) {
> +               fprintf(stderr, "fsstress: check_cwd stat64 failed with: =
%d (%s)\n",
> +                       ret, strerror(ret));

The error is not in 'ret' but instead in 'errno', so it should print
errno and strerror(errno).

> +               goto out;
> +       }
>
> -       if (stat64(".", &statbuf) =3D=3D 0 && statbuf.st_ino =3D=3D top_i=
no)
> +       if (statbuf.st_ino =3D=3D top_ino)
>                 return;
> +
> +       fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%ld) !=3D to=
p_ino (%ld)\n",
> +               (long)statbuf.st_ino, (long)top_ino);

ino_t is guaranteed to be an unsigned integer, and can be either 64 or
32 bits wide [1].
Casting to unsigned 64 bits would be better imo.

Thanks.

https://www.gnu.org/software/libc/manual/html_node/Attribute-Meanings.html

> +out:
>         assert(chdir(homedir) =3D=3D 0);
>         fprintf(stderr, "fsstress: check_cwd failure\n");
>         abort();
> --
> 2.30.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
