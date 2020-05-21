Return-Path: <SRS0=XlT/=7D=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F9C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D15C20759
	for <linux-fstests@archiver.kernel.org>; Thu, 21 May 2020 09:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+z/rHOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgEUJSX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 May 2020 05:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgEUJSX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 May 2020 05:18:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421EAC061A0E
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 02:18:23 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h10so6653972iob.10
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGun0qSkBRusqZ7DXqs0UBxrrCyciDj7nUpEa311pCY=;
        b=G+z/rHOyMi4o7f3moWJ4Ezg6RRaLyxh49B9Xs2HT77eJURv6AZ6nZxiPGraTv+WKk+
         WgFKcB63mkGm9zndJ0Yg9+QiZM0V+M/dpo5i4iYFKBd/2qz8bOuXR0Liy6PWolCsD0ar
         dcSeJcHfEq8hHkLJaI+Cdqi0VV7rpFBZxQc/AE4eb7kobgWzrxzLnaCiAmLOIlt1Txuk
         HvK0WEyCNLMHnvru/A0khimzsgUKi+DHPr2Lx6WGLN84vkqd0HkTgPeRC7V7CRcHfCYl
         I418M0VnJYA41LxHJPEA9H43BGDNAJENG2yOqHNCvw1qYVxoaQgYjYljjUj0xJd+8Trg
         0txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGun0qSkBRusqZ7DXqs0UBxrrCyciDj7nUpEa311pCY=;
        b=WZ5gOhbVt4KjK9bW9vjzyS/OC80Brk82O8SzvvTQu/8oaAPPasV12BxR6rQX/kFLlE
         6QLngopalBvYGue5CnOtxaaQJf1375Ypb1SUC9uen009cWdzjl13SleQGz9/59kp3o3A
         FkpgZ7XwUg06H54cy1ejGDIIWcs8tuYkLpaGQpugFzCDlZo3By0lAr9u3f7l1TbWnTGA
         kmCsD/QShQrVRDcogQ9wEIj4I+EghIFbi425FFq4DoVSNAFT9Vx1hzVdHeypiMuAmZsE
         9WRkLYVGRrDCnx/bfVJYgtr1hB0K3xPhy5M85MYDDY/RQdmtBoVa7TM4UrZ16FBM1hJS
         bbZQ==
X-Gm-Message-State: AOAM5339NVocjj//JThjviHHBNWa2hlDz9rGoWvFTD2x+rrJmbhTGcOg
        WIdf8Mhd5YWibA3VRnVHi7cOcRT+U5OeBT13a1aydg0l
X-Google-Smtp-Source: ABdhPJy//v+JThAxMOL9mDPbf5e5HcmFYXp7V442QtYqHnctsKIsh3V49ua7LzlNNHISBNedI//hljJwTA3SdAetDTI=
X-Received: by 2002:a02:b141:: with SMTP id s1mr2820102jah.123.1590052702504;
 Thu, 21 May 2020 02:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590006879.git.raghavan.arvind@gmail.com> <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
In-Reply-To: <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 May 2020 12:18:11 +0300
Message-ID: <CAOQ4uxi5C=XOpTS67hS8YOpb-Fo4f6PA5qsoNiDY_k=58r4qJg@mail.gmail.com>
Subject: Re: [PATCH 5/6] src/fssum: Allow single file input
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 21, 2020 at 3:10 AM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> Allow regular links and symlinks to be passed as input to fssum.
>
> Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> ---
>  src/fssum.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/src/fssum.c b/src/fssum.c
> index ece0f556..2d1624ca 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -29,6 +29,7 @@
>  #include <inttypes.h>
>  #include <assert.h>
>  #include <endian.h>
> +#include <libgen.h>
>
>  #define CS_SIZE 16
>  #define CHUNKS 128
> @@ -884,8 +885,40 @@ main(int argc, char *argv[])
>         if (gen_manifest)
>                 fprintf(out_fp, "Flags: %s\n", flagstring);
>
> +       struct stat64 path_st;
> +       if (fstat64(fd, &path_st)) {
> +               perror("fstat");
> +               exit(-1);
> +       }
> +
>         sum_init(&cs);
> -       sum(fd, 1, &cs, path, "");
> +
> +       if (S_ISDIR(path_st.st_mode)) {
> +               sum(fd, 1, &cs, path, "");
> +       } else if (S_ISREG(path_st.st_mode) || S_ISLNK(path_st.st_mode)) {
> +               // Copy because dirname may modify path
> +               char* path_copy = alloc(strlen(path));
> +               strcpy(path_copy, path);
> +
> +               char* dir_path = dirname(path);
> +               char* name = basename(path_copy);
> +
> +               int dirfd = open(dir_path, O_RDONLY);
> +               if (fd == -1) {
> +                       fprintf(stderr, "failed to open %s: %s\n", dir_path,
> +                               strerror(errno));
> +                       exit(-1);
> +               }
> +
> +               sum_one(dirfd, 1, &cs, dir_path, "", name);

Instead of all of the above, how about just:
               sum_one(fd, 1, &cs, path, "", "");

From looking at sum_one() code, it seems to me like that will work,
but I may be missing something.
It's not that you *want* the name in the checksum, it is not even
part of the metadata that is being synced with fsync.

Other than that patch set looks excellent.
Very pleasant for review :-)

One little thing is missing from the cover letter -
Which tests did you run to verify these changes do not regress existing
tests?

Feel free to add to all the other patches in the series:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

If you are able to change sum_one() of empty name as I suggested,
feel free to add that to this patch as well.

Thanks,
Amir.
