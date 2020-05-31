Return-Path: <SRS0=JK2a=7N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2D1C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 31 May 2020 19:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618DD206DA
	for <linux-fstests@archiver.kernel.org>; Sun, 31 May 2020 19:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7373BfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgEaTb5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 May 2020 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgEaTb4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 May 2020 15:31:56 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8822CC061A0E
        for <fstests@vger.kernel.org>; Sun, 31 May 2020 12:31:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so4794679ioo.4
        for <fstests@vger.kernel.org>; Sun, 31 May 2020 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vniFOiMgLaDeRs+6uozWcasXoQTo5gNidhI1pdgCG3w=;
        b=t7373BfRsEjZfa1GF0JvaRXweDSaJ5GYB7BM6ct2+k9nmJIdSoKSkDrBf8WANceG7j
         p4qsoGRcSZhNNbxm84e037IlLDzgL8tAEdL6DV1ia0WGSuAqjiDrT00D1FUjkNzbmDTc
         MjroOZ9P//bFRanCqzic6dfgny7OYPv0AT7sNTbwdic1q1Tar+1OBVUx0ciQ6vHNt36S
         XozBXIXmjs/lECIfr5IMVGFgGfF6TFgEpdpfu87MDBurpqyeQzVRH0k6HyqTvyadOIB2
         e6992laK4ZThAVrTgMXBaXfwjXnRJh7VrxJFAYQ9t5IVFm3iFwjdoWrefpgeWDlOPpcC
         Ai7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vniFOiMgLaDeRs+6uozWcasXoQTo5gNidhI1pdgCG3w=;
        b=O2FCYYKerO4RJeES7SZrDMuL5OQrrF7iVVOl84L1dMhrx5l/OIvCQSx+KRQcpGAEbQ
         guvDh53Df9UDn+nA8aOk0h9LWsAi3rKvAjsDgleJJYfRD6rzw2e4XSR+FWO+jIrBkELw
         d7C28uiUGIEUcfmzH/LkdYUtJ73Uwoovvjg2rDsgzg95psbhM1v0tWqIWu6Zu+g1CATS
         MVoQyfp9ef2paoy804/9OztgKKvpL3wCUpJijVpmJiPSdtGVI4a0my2fesapPOEtDdm6
         DuncVxYPjGf0z5VGO2koiW/XgW186z/Iz3Wrwqrtr5LYUbZ1uN2ckAS6xy0OH7hB/RHq
         3Q7g==
X-Gm-Message-State: AOAM5330L8iV1lrF218ASJZ7NEAK2vqYBRu1IYxbohSIr+ggr0z3F+Hy
        lC1h8p+IrcEuuWz/Z6WhmSGs6wLFMiKxmUE1lWq5Zbyn
X-Google-Smtp-Source: ABdhPJwkvN2UaxsvgVg2YABzoPBFmdW/q+6NpfM28YzIySH8qVokvBMvxcJA22UzDnrqDgTYirGGnGxvYvFhdDBDHP4=
X-Received: by 2002:a02:c004:: with SMTP id y4mr17477782jai.81.1590953514838;
 Sun, 31 May 2020 12:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
 <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
 <CAOQ4uxi5C=XOpTS67hS8YOpb-Fo4f6PA5qsoNiDY_k=58r4qJg@mail.gmail.com>
 <20200522010652.x34k3tx7e47jmzzk@gmail.com> <CAOQ4uxi9B5XBay9+VVYoO_f-1h-jTG-JvTijmt_GZpoy=Jq1ZQ@mail.gmail.com>
 <20200531182858.nurku3vcztrzsy43@gmail.com>
In-Reply-To: <20200531182858.nurku3vcztrzsy43@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 31 May 2020 22:31:43 +0300
Message-ID: <CAOQ4uxjmgtPMsm2MsA=BjgX63-uCKUpp8swHHCkvwUwgLZvMpQ@mail.gmail.com>
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

On Sun, May 31, 2020 at 9:29 PM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> On 05/22, Amir Goldstein wrote:
> > On Fri, May 22, 2020 at 4:06 AM Arvind Raghavan
> > <raghavan.arvind@gmail.com> wrote:
> > >
> > > On 05/21, Amir Goldstein wrote:
> > > > On Thu, May 21, 2020 at 3:10 AM Arvind Raghavan
> > > > <raghavan.arvind@gmail.com> wrote:
> > > > >
> > > > > Allow regular links and symlinks to be passed as input to fssum.
> > > > >
> > > > > Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> > > > > Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> > > > > Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> > > > > ---
> > > > >  src/fssum.c | 35 ++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 34 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/src/fssum.c b/src/fssum.c
> > > > > index ece0f556..2d1624ca 100644
> > > > > --- a/src/fssum.c
> > > > > +++ b/src/fssum.c
> > > > > @@ -29,6 +29,7 @@
> > > > >  #include <inttypes.h>
> > > > >  #include <assert.h>
> > > > >  #include <endian.h>
> > > > > +#include <libgen.h>
> > > > >
> > > > >  #define CS_SIZE 16
> > > > >  #define CHUNKS 128
> > > > > @@ -884,8 +885,40 @@ main(int argc, char *argv[])
> > > > >         if (gen_manifest)
> > > > >                 fprintf(out_fp, "Flags: %s\n", flagstring);
> > > > >
> > > > > +       struct stat64 path_st;
> > > > > +       if (fstat64(fd, &path_st)) {
> > > > > +               perror("fstat");
> > > > > +               exit(-1);
> > > > > +       }
> > > > > +
> > > > >         sum_init(&cs);
> > > > > -       sum(fd, 1, &cs, path, "");
> > > > > +
> > > > > +       if (S_ISDIR(path_st.st_mode)) {
> > > > > +               sum(fd, 1, &cs, path, "");
> > > > > +       } else if (S_ISREG(path_st.st_mode) || S_ISLNK(path_st.st_mode)) {
> > > > > +               // Copy because dirname may modify path
> > > > > +               char* path_copy = alloc(strlen(path));
> > > > > +               strcpy(path_copy, path);
> >
> > If you stay with this code please use strdup().
> >
> > > > > +
> > > > > +               char* dir_path = dirname(path);
> > > > > +               char* name = basename(path_copy);
> > > > > +
> > > > > +               int dirfd = open(dir_path, O_RDONLY);
> > > > > +               if (fd == -1) {
> > > > > +                       fprintf(stderr, "failed to open %s: %s\n", dir_path,
> > > > > +                               strerror(errno));
> > > > > +                       exit(-1);
> > > > > +               }
> > > > > +
> > > > > +               sum_one(dirfd, 1, &cs, dir_path, "", name);
> > > >
> > > > Instead of all of the above, how about just:
> > > >                sum_one(fd, 1, &cs, path, "", "");
> > > >
> > > > From looking at sum_one() code, it seems to me like that will work,
> > > > but I may be missing something.
> > > > It's not that you *want* the name in the checksum, it is not even
> > > > part of the metadata that is being synced with fsync.
> > >
> > > The issue here is that we preserved the code from sum which does
> > > all its opens using openat with the parent directory fd and a
> > > filename. Since we're trying to reuse that code I believe we need
> > > to have this somewhat ugly boilerplate.
> >
> > Ok. But if you stay with this please add a comment about why
> > this is done with a hint for the future how to fix this properly.
> >
> > Or (up to you) you can fix it by calling this helper instead of openat():
> >
> > int open_one(int dirfd, const char *name)
> > {
> >     if (!name || !*name)
> >         return dup(dirfd);
> >     return openat(dirfd, name, 0);
> > }
> >
> > fstatat() can take empty name with AT_EMPTY_PATH flag.
> > readlinkat() should be able to take an empty name, but documentation
> > is not clear whether fd must be O_PATH - need to verify if it works with
> > non O_PATH fd.
>
> I might be doing something wrong but I can't seem to get
> AT_EMPTY_PATH to work with fstatat. I don't see it on the man
> page and when I pass it to fstatat it errors out with invalid
> argument.
>

https://www.man7.org/linux/man-pages/man2/stat.2.html

Says:
       AT_EMPTY_PATH (since Linux 2.6.39)
... This flag is Linux-specific; define _GNU_SOURCE to obtain its definition.

And I see that fssum.c does define _GNU_SOURCE, so not sure what the
problem is.

> In the case that fstatat doesn't support AT_EMPTY_PATH, do you
> see another way to fix the above code?
>

Yes, you can pass path_st to sum_one() you already have it.

But I don't think that you or anyone that cares about xfstests is running
a kernel older than 2.6.39...

Thanks,
Amir.
