Return-Path: <SRS0=WJEH=7B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22184C433DF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 May 2020 04:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0E12075F
	for <linux-fstests@archiver.kernel.org>; Tue, 19 May 2020 04:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4R1Jnes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgESE6g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 May 2020 00:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgESE6g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 May 2020 00:58:36 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17040C061A0C
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 21:58:36 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so13137919iow.8
        for <fstests@vger.kernel.org>; Mon, 18 May 2020 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJQmcbQYUXrmpKZSa1udSohYn77pTFdKz3pVD3R9H5M=;
        b=S4R1Jnes/VRjt5oh7lqo1GbnV8EdZpVqoEDxyesez9JK2CBzMVcW/XP7ORPxgsVNrb
         0ESXEF+s3g7EabQGGAAjm89nrSZGl9LmErZx3MMOeetLqu2JBFQT/A3JZNh6dmHKhq+L
         iREAlXsJrao5OE52hYbr+/sONNb/uvtMO1XVW8lzrNI5mSEiLSysM4MXdQfMqRio3TPa
         BXvfycxc1la/O6Fe/UbG8wVXXyR24beOSonaY8ebILqeh82Y2t+xg59r3RUSR33KiGDp
         bN6xSVbkDyFqqNrre3dKuSm5LOyF6RBJZYrtHciWfX0OqHrl2kG0mOPf7NxR9TW3yHNv
         R+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJQmcbQYUXrmpKZSa1udSohYn77pTFdKz3pVD3R9H5M=;
        b=l7yFSCD954DpDQSMxKFjctFiPEgKZ8xrzk0WIYqRWrB2EaUSj6nBpjD2EpOAyoRegI
         jlmwpZ9aCYOxADOAvv6aIUfmtYQbjvUO0N10N2m5lvS8vr+eqvgFCTNMlZ41VXIj4fw0
         hAVRC12JfgKljmlN+WG6uspDTAnBStXPcxnBm9Ew+CO/dXFYlWExAm/2TCBYNWQHqb2z
         FdXkmqe9e0F3zBgUzZhEbDQSEcUpqRYlce0H+a+1Vxjd91OEiXvfJ0YahglfJ1ReZHKK
         cry9JHz5X2VJRFknoYalmDm8PMBDEkucCcpKuwv3AshLc9LgQVdU1OyedCWci2rY9rhN
         0jzA==
X-Gm-Message-State: AOAM530qfVTM6uAqSDt5f/E145K7da3r1r2RE6TD6mM0MOdmB/HE3+be
        CmSTixgHFFh/PU3j8k68GcM8Jga/TnrTZY0wqUg=
X-Google-Smtp-Source: ABdhPJxkWxH43BaLYYOiUiE4u8/vyaIp6TJcpAxi7xryFpYaVXYg3MokP4AIyGFqSEe68OTAcCoZBRSoeUQ84bFpdQs=
X-Received: by 2002:a5d:898a:: with SMTP id m10mr16440825iol.203.1589864315222;
 Mon, 18 May 2020 21:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200518201551.2553-1-raghavan.arvind@gmail.com>
In-Reply-To: <20200518201551.2553-1-raghavan.arvind@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 May 2020 07:58:23 +0300
Message-ID: <CAOQ4uxiOQ_BjRX6Sz-URY8DJTuAERa9Ws64YJ18GV_1oaXA3xw@mail.gmail.com>
Subject: Re: [PATCH] src/fssum: Refactor recursive traversal
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 19, 2020 at 1:30 AM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> Moves some logic from the recursive directory traversal into a helper
> function to make it easier to add support for regular files. Does not
> change functionality.
>

Arvind,

The main comment is that this patch by itself is not eligible for merging.
It should be part of a patch series.

One more tip for ease of review - don't mix re-factor with moving chunks
of code. I reviewed this patch by moving sum_one() below sum(), where
the chunk of code was before the re-factoring and using diff -w.
Check it out to see how easy it is to review.

There is not really a reason to put the sum_one() helper on top as it
anyway depends on forward declaration of sum(), so it can be the other
way around.

See a couple of minor suggestions below.

Thanks,
Amir.


> Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> ---
>  src/fssum.c | 298 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 162 insertions(+), 136 deletions(-)
>
> diff --git a/src/fssum.c b/src/fssum.c
> index 3d97a70b..f2325ae0 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -502,6 +502,162 @@ malformed:
>                 excess_file(fn);
>  }
>
> +void
> +sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in);
> +
> +void
> +sum_one(int dirfd, int level, sum_t *dircs, char *path_prefix,
> +               char *path_in, char *name) {
> +       sum_t cs;
> +       sum_t meta;
> +       int fd;
> +       int ret;
> +       int excl;
> +       char* path;
> +       struct stat64 st;
> +       sum_file_data_t sum_file_data = flags[FLAG_STRUCTURE] ?
> +                       sum_file_data_strict : sum_file_data_permissive;

It's silly to do that every "one". flags is global and doesn't change,
so sum_file_data may be global as well and set on main.
Do that before refactoring patch.

[...]

>
>                 ret = fchdir(dirfd);
>                 if (ret == -1) {
> @@ -571,130 +710,17 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                 }
>                 ret = lstat64(namelist[i], &st);

If you change that to fstatat(dirfd, ... AT_SYMLINK_NOFOLLOW),
fchdir() above will not be needed.
that change you can do with the refactoring patch.

Thanks,
Amir.
