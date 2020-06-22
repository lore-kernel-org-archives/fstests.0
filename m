Return-Path: <SRS0=/J1n=AD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A740FC433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Jun 2020 06:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A021253CE
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Jun 2020 06:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWVj8vSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgFVGrz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgFVGry (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jun 2020 02:47:54 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92514C061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 23:47:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z2so14906659ilq.0
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 23:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9fKkSJxDf7pXi3uqlpn00OhUumIG+8QhsMvo1CKn5E=;
        b=gWVj8vSOAk+5J1nlq0hdeOaxVXfyw4EjL4o98wLQGuv0OUMcWTgiESFyv7TK3ANSpE
         WIReh8p+4Fedki/D6OGZBSpYJKxPK0JPkBV42uWAsoK1KbxgPl0R8WH61oRArHyMwqXI
         y8HV8kAjEyuJ1fx9YjPbXVi6ksG1T6kvo5J8pqUU82oZJpBNUmJqkzKFuH9z13AJ6Q7t
         t8BZwlFGxy0DvL05nSTrP8TLwnfKynBOuQP1cS00lz+EjYEr9qe0C8UlJ4VIH09A3NRb
         vaJ+FfCSwpxrUHNtYcypj7giWkhA2xlLkpylvgSNG2siXJAngB2UfXhLAp/nHc5ZRXOC
         L/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9fKkSJxDf7pXi3uqlpn00OhUumIG+8QhsMvo1CKn5E=;
        b=tccmfLKj4qE4MprTtpa2JDU+A9umhpiDcybFaHVJ+JsmsUg1UhtwbZFaYzdvBjmcXJ
         2n8MFen98N5LFLa9bsqcEjPXUmTAGW/9jgdbaRUFmwWVErSmQG4l4MUrgkfNZeKNFdXY
         xA9A+nk2gcwwbRPbslfkQW5R/BHrZp6npGWpgmBIwLcWz8+EXJxe+bTt7f2Wi/FehFwB
         G29Apv3ZgnhjLQ646XBJCoaesk7Nlwbh5LT+ksgRr2bj4Q5ar7q09qP1z5hCgdOW0Dis
         vxSUNqTteJv7X/o7PdBld9MnS3h5QqzFBb4wmcPCwEz6gdJCh5LkVV/s//2PSYMWNhph
         hsjQ==
X-Gm-Message-State: AOAM531gnMwkNc6KjrJ1LqCRDn86KX0W6JKE87pm5ecEjzy8KdVEiHSG
        VgmhlWuwlTXsPpZsIZdNM62sAPeaZbuuTAgdglzdU1Np
X-Google-Smtp-Source: ABdhPJwn33QTSS6KsEBmSpPSPBdtUbK6nMCIDxrg0fsPNmv3GMvR11aylnYUKkCH+Co2V2tXLrrvBkjJ6K/4T4Vanfs=
X-Received: by 2002:a92:5856:: with SMTP id m83mr16086961ilb.72.1592808473965;
 Sun, 21 Jun 2020 23:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592779555.git.raghavan.arvind@gmail.com> <5241e1c1d58435f34060c45d453c73670514dbd4.1592779555.git.raghavan.arvind@gmail.com>
In-Reply-To: <5241e1c1d58435f34060c45d453c73670514dbd4.1592779555.git.raghavan.arvind@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Jun 2020 09:47:43 +0300
Message-ID: <CAOQ4uxid47HyewY-NdcGk1BXE04iYWAj1dLjtDPB2H6HTP5Mvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] src/fssum: Refactoring changes for recursive traversal
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 22, 2020 at 2:15 AM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> Refactoring changes needed for recursive traversal and single file
> input. Makes fstat and readlink use the 'at' alternatives, and creates a
> helper function for opening files.
>
> Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  src/fssum.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/src/fssum.c b/src/fssum.c
> index 30f456c2..135dd60f 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -503,6 +503,13 @@ malformed:
>                 excess_file(fn);
>  }
>
> +int open_one(int dirfd, const char *name)
> +{
> +       if (!name || !*name)
> +               return dup(dirfd);
> +       return openat(dirfd, name, 0);
> +}
> +
>  void
>  sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>  {
> @@ -563,12 +570,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                                 goto next;
>                 }
>
> -               ret = fchdir(dirfd);
> -               if (ret == -1) {
> -                       perror("fchdir");
> -                       exit(-1);
> -               }
> -               ret = lstat64(namelist[i], &st);
> +               ret = fstatat64(dirfd, namelist[i], &st, AT_SYMLINK_NOFOLLOW);
>                 if (ret) {
>                         fprintf(stderr, "stat failed for %s/%s: %s\n",
>                                 path_prefix, path, strerror(errno));
> @@ -597,7 +599,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                         sum_add_time(&meta, st.st_ctime);
>                 if (flags[FLAG_XATTRS] &&
>                     (S_ISDIR(st.st_mode) || S_ISREG(st.st_mode))) {
> -                       fd = openat(dirfd, namelist[i], 0);
> +                       fd = open_one(dirfd, namelist[i]);
>                         if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
>                                 sum_add_u64(&meta, errno);
>                         } else if (fd == -1) {
> @@ -618,7 +620,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                         }
>                 }
>                 if (S_ISDIR(st.st_mode)) {
> -                       fd = openat(dirfd, namelist[i], 0);
> +                       fd = open_one(dirfd, namelist[i]);
>                         if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
>                                 sum_add_u64(&meta, errno);
>                         } else if (fd == -1) {
> @@ -635,7 +637,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                                 if (verbose)
>                                         fprintf(stderr, "file %s\n",
>                                                 namelist[i]);
> -                               fd = openat(dirfd, namelist[i], 0);
> +                               fd = open_one(dirfd, namelist[i]);
>                                 if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
>                                         sum_add_u64(&meta, errno);
>                                 } else if (fd == -1) {
> @@ -659,7 +661,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                                 }
>                         }
>                 } else if (S_ISLNK(st.st_mode)) {
> -                       ret = readlink(namelist[i], buf, sizeof(buf));
> +                       ret = readlinkat(dirfd, namelist[i], buf, sizeof(buf));
>                         if (ret == -1) {
>                                 perror("readlink");
>                                 exit(-1);
> --
> 2.20.1
>
