Return-Path: <SRS0=W8IY=7E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA27C433DF
	for <linux-fstests@archiver.kernel.org>; Fri, 22 May 2020 05:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE43206F6
	for <linux-fstests@archiver.kernel.org>; Fri, 22 May 2020 05:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJwCPtVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgEVFhu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 22 May 2020 01:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgEVFhu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 22 May 2020 01:37:50 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16147C061A0E
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 22:37:50 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l20so9540658ilj.10
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 22:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w731qtK1JyHqMPplb0Kq/2Uyb7l77x2A9Kr6M8+AKV4=;
        b=jJwCPtVXa7Z8ItIhPJrYu8dv98f+BXkM+DllPws5YzgAuVQtngFgOuMcl7IwFYsega
         bECAn+QEDeEroODuQkDNw2uHwEfR8vQoLPDKeJ66ctGwj0qPFHjYopcTjHuGX+Wr0zal
         fNB0aVNXtEMlijwbS5nfgNYGu481UGjqqGCtkjnq9TcVlaEUmyLyZUZrx+91LladRlNg
         jauWKhl9N16hbQCpFlD/hlr10UHkXbNFqPdEaH2PP51hz0RG5fyFsSvYYrpUctNpOJYM
         Zi7Fwcg8i6tcIXyaLUAJvUaMTUkxuywJtdeqye44gXIxG20Zv67jhm1Q1+EDIXCWlIgS
         dQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w731qtK1JyHqMPplb0Kq/2Uyb7l77x2A9Kr6M8+AKV4=;
        b=O0nrIODsN5Z3TtYZtJVTCPJchqAy3/vqG2yZYXA+WoZOrwWnftI4YSCKJ51Ny8T5Po
         MOCxaptqR8j1na85YohTK7ygEyIjvaV+5tgU0v8flEPtG/HWzEALaux6kK6qM1JAeX+n
         5Uevmheev+UreAO23cbLGd8+VMp9mdjnXmv4ctTPdvI4aCMX262deSICbWqb0VI+I5BU
         eVxIcqeODPew5KQxhe2L/xyMQjK3rOgylQ9Y7fy4VvBi2VyCJKYYsZsC+bZuySwNMtE5
         qm7ghT9xurd6FvrDqwKWiudPKzGIy/gQj7e1Ksa8lASCqgGm5jR+l/rL6amZGGrGZVEX
         Umfg==
X-Gm-Message-State: AOAM5307LEn0Ec50EFpplqq7TZuyNdUyWihy4HjwZYCx77kwH1ninec5
        spktA4nWgU3OuAH6DVrFmgNbryWVdfkte+fk1ODpkL1h
X-Google-Smtp-Source: ABdhPJxVjbIFqBI47mv2t+lOSvIo06a+jpGEpusEtMsAhNl8ky6XtRcvI4rL7e4D/P14kjQyg9zAsYjZgSUIkseTHW4=
X-Received: by 2002:a92:4015:: with SMTP id n21mr4197351ila.137.1590125869238;
 Thu, 21 May 2020 22:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
 <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
 <CAOQ4uxi5C=XOpTS67hS8YOpb-Fo4f6PA5qsoNiDY_k=58r4qJg@mail.gmail.com> <20200522010652.x34k3tx7e47jmzzk@gmail.com>
In-Reply-To: <20200522010652.x34k3tx7e47jmzzk@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 May 2020 08:37:38 +0300
Message-ID: <CAOQ4uxi9B5XBay9+VVYoO_f-1h-jTG-JvTijmt_GZpoy=Jq1ZQ@mail.gmail.com>
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

On Fri, May 22, 2020 at 4:06 AM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> On 05/21, Amir Goldstein wrote:
> > On Thu, May 21, 2020 at 3:10 AM Arvind Raghavan
> > <raghavan.arvind@gmail.com> wrote:
> > >
> > > Allow regular links and symlinks to be passed as input to fssum.
> > >
> > > Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> > > Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> > > Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> > > ---
> > >  src/fssum.c | 35 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 34 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/src/fssum.c b/src/fssum.c
> > > index ece0f556..2d1624ca 100644
> > > --- a/src/fssum.c
> > > +++ b/src/fssum.c
> > > @@ -29,6 +29,7 @@
> > >  #include <inttypes.h>
> > >  #include <assert.h>
> > >  #include <endian.h>
> > > +#include <libgen.h>
> > >
> > >  #define CS_SIZE 16
> > >  #define CHUNKS 128
> > > @@ -884,8 +885,40 @@ main(int argc, char *argv[])
> > >         if (gen_manifest)
> > >                 fprintf(out_fp, "Flags: %s\n", flagstring);
> > >
> > > +       struct stat64 path_st;
> > > +       if (fstat64(fd, &path_st)) {
> > > +               perror("fstat");
> > > +               exit(-1);
> > > +       }
> > > +
> > >         sum_init(&cs);
> > > -       sum(fd, 1, &cs, path, "");
> > > +
> > > +       if (S_ISDIR(path_st.st_mode)) {
> > > +               sum(fd, 1, &cs, path, "");
> > > +       } else if (S_ISREG(path_st.st_mode) || S_ISLNK(path_st.st_mode)) {
> > > +               // Copy because dirname may modify path
> > > +               char* path_copy = alloc(strlen(path));
> > > +               strcpy(path_copy, path);

If you stay with this code please use strdup().

> > > +
> > > +               char* dir_path = dirname(path);
> > > +               char* name = basename(path_copy);
> > > +
> > > +               int dirfd = open(dir_path, O_RDONLY);
> > > +               if (fd == -1) {
> > > +                       fprintf(stderr, "failed to open %s: %s\n", dir_path,
> > > +                               strerror(errno));
> > > +                       exit(-1);
> > > +               }
> > > +
> > > +               sum_one(dirfd, 1, &cs, dir_path, "", name);
> >
> > Instead of all of the above, how about just:
> >                sum_one(fd, 1, &cs, path, "", "");
> >
> > From looking at sum_one() code, it seems to me like that will work,
> > but I may be missing something.
> > It's not that you *want* the name in the checksum, it is not even
> > part of the metadata that is being synced with fsync.
>
> The issue here is that we preserved the code from sum which does
> all its opens using openat with the parent directory fd and a
> filename. Since we're trying to reuse that code I believe we need
> to have this somewhat ugly boilerplate.

Ok. But if you stay with this please add a comment about why
this is done with a hint for the future how to fix this properly.

Or (up to you) you can fix it by calling this helper instead of openat():

int open_one(int dirfd, const char *name)
{
    if (!name || !*name)
        return dup(dirfd);
    return openat(dirfd, name, 0);
}

fstatat() can take empty name with AT_EMPTY_PATH flag.
readlinkat() should be able to take an empty name, but documentation
is not clear whether fd must be O_PATH - need to verify if it works with
non O_PATH fd.

Again, you don't have to do this to get my reviewed-by its just if you
want to and then of course do it in a prep patch, the same one that
gets rid of fchdir and converts to fstatat() and readlinkat().

>
> > Other than that patch set looks excellent.
> > Very pleasant for review :-)
>
> Thanks! :)
>
> > One little thing is missing from the cover letter -
> > Which tests did you run to verify these changes do not regress existing
> > tests?
>
> I just ran the relevant tests and encountered a small issue with
> the refactoring patch. This is my bad, since we changed lstat to
> use fstatat, we are no longer doing a fchdir which a readlink
> call later on relies on. I can fix it by changing the readlink to
> a readlinkat.
>

I see two valid options. please chose the one you like.

1. Revert removal of fchdir. let refactoring be only refactoring.
2. Remove fchdir and convert to fstatat/readlinkat in separate prep patch
    (with or without the empty name support suggested above)

> I'll add that change and add the set of relevant patches to the
> cover letter in a V2.

For patches that did not change from v1 please add my reviewed-by
so I know I do not need to re-review them.

Please include summary of "changes since v1" in cover letter.

Thanks,
Amir.
