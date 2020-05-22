Return-Path: <SRS0=W8IY=7E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77684C433DF
	for <linux-fstests@archiver.kernel.org>; Fri, 22 May 2020 01:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8CC2072C
	for <linux-fstests@archiver.kernel.org>; Fri, 22 May 2020 01:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGBJgkyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgEVBG4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 May 2020 21:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgEVBGz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 May 2020 21:06:55 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB627C061A0E
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 18:06:55 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id u190so1835987ooa.10
        for <fstests@vger.kernel.org>; Thu, 21 May 2020 18:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=923J+WzD3U+p5+tidrP/64AnkF0BD30ki/hAL5OeKHY=;
        b=UGBJgkyf32R/gjRpgvxqfZAUU6cCyDU6YPPZLzzNu5HRSYQr+OSTkdZia7q76PkzGo
         EsDYZNqVZ5QNdMOAfO9NZrkVdwXZio/t0L92d+t3mdyOfOFS0jbgXZGEwPCSeW31bqw5
         PIrHYmIrXUT6AmRVMlEqv64XMWg7AeNjEc3V4yc0vgo9W7UFHwrvU4iu75VUF9XhlhlP
         WNxCSod5W0VW+hMjvcfHRLjM8TXv1z0C0huiaFtU+2v238IORLWa8k3Yda9u660PZXsX
         7xKHHwtn/HpkHXkCIgrVzXIeyvVzipEwRh+ipSXIl/YuOswGZk8XYLqXIoYUzMCc8spP
         Ftzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=923J+WzD3U+p5+tidrP/64AnkF0BD30ki/hAL5OeKHY=;
        b=tapXbWvfycAWXlayYPe0wbmqla8mg2n/RLT8HRMXZFLseF1FCkf76fsb9g5kjqjNc3
         DBuoFhoQvewxN0mZ2P+u8xIeAF6MzgjvhSh9awINF+25CVqJlY1x3HDXikw10w+LpRNF
         1wWHx5Xb1CGECQp+NmU22dSlUnouyzBTwJdtbucIh0GuqWMtDiI3XBS3h0tKGCH6hMhf
         zNu+VRwyBWwcPXDhrMouxY9/b7sLtLqhhM2CgY2jMiNWkwlrCR5DNK2dusDiNExnBD3K
         3F/cUyIqndvMCiiVecsOq+M2ylz3GxOIHJ7552jDFtHVjJU8aKztIINSmv8sv9WTJLmD
         EHKA==
X-Gm-Message-State: AOAM530XkJNvm8wKEQPfUO3f1To+VfxP2VIrsLybpmGoV20M3JFh5j+M
        n9GOcD+97TfrYU8ylx27Ce//poiPkA==
X-Google-Smtp-Source: ABdhPJw2W8pJQN+ZCR6S0yx+ZPNsrRSB8/LwcxtjyFiDbQqQ0h/msZqLydPzWdRbI9zSzy3xJkLrqw==
X-Received: by 2002:a4a:2511:: with SMTP id g17mr1165714ooa.24.1590109614982;
        Thu, 21 May 2020 18:06:54 -0700 (PDT)
Received: from gmail.com ([2605:6000:1023:1fd0::cc])
        by smtp.gmail.com with ESMTPSA id 95sm2069279otf.72.2020.05.21.18.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 18:06:54 -0700 (PDT)
Date:   Thu, 21 May 2020 20:06:52 -0500
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        fstests <fstests@vger.kernel.org>
Cc:     Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Subject: Re: [PATCH 5/6] src/fssum: Allow single file input
Message-ID: <20200522010652.x34k3tx7e47jmzzk@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
 <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
 <CAOQ4uxi5C=XOpTS67hS8YOpb-Fo4f6PA5qsoNiDY_k=58r4qJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi5C=XOpTS67hS8YOpb-Fo4f6PA5qsoNiDY_k=58r4qJg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 05/21, Amir Goldstein wrote:
> On Thu, May 21, 2020 at 3:10 AM Arvind Raghavan
> <raghavan.arvind@gmail.com> wrote:
> >
> > Allow regular links and symlinks to be passed as input to fssum.
> >
> > Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> > Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> > Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> > ---
> >  src/fssum.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/fssum.c b/src/fssum.c
> > index ece0f556..2d1624ca 100644
> > --- a/src/fssum.c
> > +++ b/src/fssum.c
> > @@ -29,6 +29,7 @@
> >  #include <inttypes.h>
> >  #include <assert.h>
> >  #include <endian.h>
> > +#include <libgen.h>
> >
> >  #define CS_SIZE 16
> >  #define CHUNKS 128
> > @@ -884,8 +885,40 @@ main(int argc, char *argv[])
> >         if (gen_manifest)
> >                 fprintf(out_fp, "Flags: %s\n", flagstring);
> >
> > +       struct stat64 path_st;
> > +       if (fstat64(fd, &path_st)) {
> > +               perror("fstat");
> > +               exit(-1);
> > +       }
> > +
> >         sum_init(&cs);
> > -       sum(fd, 1, &cs, path, "");
> > +
> > +       if (S_ISDIR(path_st.st_mode)) {
> > +               sum(fd, 1, &cs, path, "");
> > +       } else if (S_ISREG(path_st.st_mode) || S_ISLNK(path_st.st_mode)) {
> > +               // Copy because dirname may modify path
> > +               char* path_copy = alloc(strlen(path));
> > +               strcpy(path_copy, path);
> > +
> > +               char* dir_path = dirname(path);
> > +               char* name = basename(path_copy);
> > +
> > +               int dirfd = open(dir_path, O_RDONLY);
> > +               if (fd == -1) {
> > +                       fprintf(stderr, "failed to open %s: %s\n", dir_path,
> > +                               strerror(errno));
> > +                       exit(-1);
> > +               }
> > +
> > +               sum_one(dirfd, 1, &cs, dir_path, "", name);
> 
> Instead of all of the above, how about just:
>                sum_one(fd, 1, &cs, path, "", "");
> 
> From looking at sum_one() code, it seems to me like that will work,
> but I may be missing something.
> It's not that you *want* the name in the checksum, it is not even
> part of the metadata that is being synced with fsync.

The issue here is that we preserved the code from sum which does
all its opens using openat with the parent directory fd and a
filename. Since we're trying to reuse that code I believe we need
to have this somewhat ugly boilerplate.

> Other than that patch set looks excellent.
> Very pleasant for review :-)

Thanks! :)

> One little thing is missing from the cover letter -
> Which tests did you run to verify these changes do not regress existing
> tests?

I just ran the relevant tests and encountered a small issue with
the refactoring patch. This is my bad, since we changed lstat to
use fstatat, we are no longer doing a fchdir which a readlink
call later on relies on. I can fix it by changing the readlink to
a readlinkat.

I'll add that change and add the set of relevant patches to the
cover letter in a V2.

> Feel free to add to all the other patches in the series:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> If you are able to change sum_one() of empty name as I suggested,
> feel free to add that to this patch as well.
> 
> Thanks,
> Amir.
