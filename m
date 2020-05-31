Return-Path: <SRS0=JK2a=7N=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C08CC433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 31 May 2020 18:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1834220801
	for <linux-fstests@archiver.kernel.org>; Sun, 31 May 2020 18:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGMbSutC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgEaS3C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 May 2020 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaS3C (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 May 2020 14:29:02 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF3C061A0E
        for <fstests@vger.kernel.org>; Sun, 31 May 2020 11:29:02 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u23so6164376otq.10
        for <fstests@vger.kernel.org>; Sun, 31 May 2020 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mVkN4U8LoDI/+8yAQrY3w/T8MeFfXgAH/DRJKuNITM8=;
        b=pGMbSutCUqfh/n58Dlha6MFVDyHHhfdy0w4L+PjK+3a8AaCqTJwOe8kMF08t33Zox8
         +Y23xUB5SXmq2h0Aj9wuw7X6A92oGvYleSjaoA7S7/M9ewOKhMEleFebUhKxMmIFtT9g
         cTmDLbqXSB7li/WKMhJcVxcXsdvfWOsNlyQptr57Ad7L1EI4OCLPrPR8bmZAZFOVmxxN
         meyZkId0UCuVtVAgSgMZyePLWYUzvCldJLlYXH7KfCdVw/+Tbbchys0OATSrV65QpIef
         jsASj9woCGkA7xFXEzGxuQnG9Nre/UFJcXa5ScIhi9pRuD9eSh5iNawsfhsmPC6uJPDA
         S1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mVkN4U8LoDI/+8yAQrY3w/T8MeFfXgAH/DRJKuNITM8=;
        b=gnhfiSWcjfD1uRD+2WWuuI5xtI+mWPOBJtEcB0JuQ75xVrxnQaLaGtScdzXdjF7f4h
         OdbEqoeS+sTGiMDCHctL3dh1UlZZnWhKv+NtAiWX8jHnlhTEOufBwojhufS/J6EFVxuL
         DMi9QJEj/vzAEi5c2ZZWCRry5AQxuUf8Aub9jOXMLtjj3PbQEGTyuvhl2rKuTlg+545w
         2ViaOANNCEw89zyDeU+dsrpPYjXqWNumaOAbV91w2jqgWMn27iR1cU7Ok3qo4hfttp/m
         ixGFY/vUXzHztjZIiUi5gpWS5Cl/jIuTSwiqCJkuJGVpXINyKPzP98NvbzseFiwedaq7
         pleg==
X-Gm-Message-State: AOAM532EIkdQxYJsVuStj3Dcpv4qaEk/wN4Us9AwZ8a4oSYsXDmJyYhb
        QyBKCT2wTaotLzvx2qdC1A==
X-Google-Smtp-Source: ABdhPJzv7cCmMNq0ZAzMM6yft2WPKL7ccqBofQwBRpfs/Hc7TI8hrZJ0dQ0oljjzV1re7FZWIy5Wvw==
X-Received: by 2002:a9d:5d13:: with SMTP id b19mr14852206oti.151.1590949741351;
        Sun, 31 May 2020 11:29:01 -0700 (PDT)
Received: from gmail.com (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id a7sm4426023otf.38.2020.05.31.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 11:29:00 -0700 (PDT)
Date:   Sun, 31 May 2020 13:28:58 -0500
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Subject: Re: [PATCH 5/6] src/fssum: Allow single file input
Message-ID: <20200531182858.nurku3vcztrzsy43@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
 <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
 <CAOQ4uxi5C=XOpTS67hS8YOpb-Fo4f6PA5qsoNiDY_k=58r4qJg@mail.gmail.com>
 <20200522010652.x34k3tx7e47jmzzk@gmail.com>
 <CAOQ4uxi9B5XBay9+VVYoO_f-1h-jTG-JvTijmt_GZpoy=Jq1ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi9B5XBay9+VVYoO_f-1h-jTG-JvTijmt_GZpoy=Jq1ZQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 05/22, Amir Goldstein wrote:
> On Fri, May 22, 2020 at 4:06 AM Arvind Raghavan
> <raghavan.arvind@gmail.com> wrote:
> >
> > On 05/21, Amir Goldstein wrote:
> > > On Thu, May 21, 2020 at 3:10 AM Arvind Raghavan
> > > <raghavan.arvind@gmail.com> wrote:
> > > >
> > > > Allow regular links and symlinks to be passed as input to fssum.
> > > >
> > > > Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> > > > Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> > > > Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> > > > ---
> > > >  src/fssum.c | 35 ++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 34 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/src/fssum.c b/src/fssum.c
> > > > index ece0f556..2d1624ca 100644
> > > > --- a/src/fssum.c
> > > > +++ b/src/fssum.c
> > > > @@ -29,6 +29,7 @@
> > > >  #include <inttypes.h>
> > > >  #include <assert.h>
> > > >  #include <endian.h>
> > > > +#include <libgen.h>
> > > >
> > > >  #define CS_SIZE 16
> > > >  #define CHUNKS 128
> > > > @@ -884,8 +885,40 @@ main(int argc, char *argv[])
> > > >         if (gen_manifest)
> > > >                 fprintf(out_fp, "Flags: %s\n", flagstring);
> > > >
> > > > +       struct stat64 path_st;
> > > > +       if (fstat64(fd, &path_st)) {
> > > > +               perror("fstat");
> > > > +               exit(-1);
> > > > +       }
> > > > +
> > > >         sum_init(&cs);
> > > > -       sum(fd, 1, &cs, path, "");
> > > > +
> > > > +       if (S_ISDIR(path_st.st_mode)) {
> > > > +               sum(fd, 1, &cs, path, "");
> > > > +       } else if (S_ISREG(path_st.st_mode) || S_ISLNK(path_st.st_mode)) {
> > > > +               // Copy because dirname may modify path
> > > > +               char* path_copy = alloc(strlen(path));
> > > > +               strcpy(path_copy, path);
> 
> If you stay with this code please use strdup().
> 
> > > > +
> > > > +               char* dir_path = dirname(path);
> > > > +               char* name = basename(path_copy);
> > > > +
> > > > +               int dirfd = open(dir_path, O_RDONLY);
> > > > +               if (fd == -1) {
> > > > +                       fprintf(stderr, "failed to open %s: %s\n", dir_path,
> > > > +                               strerror(errno));
> > > > +                       exit(-1);
> > > > +               }
> > > > +
> > > > +               sum_one(dirfd, 1, &cs, dir_path, "", name);
> > >
> > > Instead of all of the above, how about just:
> > >                sum_one(fd, 1, &cs, path, "", "");
> > >
> > > From looking at sum_one() code, it seems to me like that will work,
> > > but I may be missing something.
> > > It's not that you *want* the name in the checksum, it is not even
> > > part of the metadata that is being synced with fsync.
> >
> > The issue here is that we preserved the code from sum which does
> > all its opens using openat with the parent directory fd and a
> > filename. Since we're trying to reuse that code I believe we need
> > to have this somewhat ugly boilerplate.
> 
> Ok. But if you stay with this please add a comment about why
> this is done with a hint for the future how to fix this properly.
> 
> Or (up to you) you can fix it by calling this helper instead of openat():
> 
> int open_one(int dirfd, const char *name)
> {
>     if (!name || !*name)
>         return dup(dirfd);
>     return openat(dirfd, name, 0);
> }
> 
> fstatat() can take empty name with AT_EMPTY_PATH flag.
> readlinkat() should be able to take an empty name, but documentation
> is not clear whether fd must be O_PATH - need to verify if it works with
> non O_PATH fd.

I might be doing something wrong but I can't seem to get
AT_EMPTY_PATH to work with fstatat. I don't see it on the man
page and when I pass it to fstatat it errors out with invalid
argument.

In the case that fstatat doesn't support AT_EMPTY_PATH, do you
see another way to fix the above code?

Thanks,
Arvind
