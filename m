Return-Path: <SRS0=Qan3=6O=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E435FC83001
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 06:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81CE2173E
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Apr 2020 06:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epqZSUBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3Gaw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbgD3Gaw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Apr 2020 02:30:52 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4B2C035494
        for <fstests@vger.kernel.org>; Wed, 29 Apr 2020 23:30:51 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u11so301848iow.4
        for <fstests@vger.kernel.org>; Wed, 29 Apr 2020 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdEos5u27HyJXZM1BaBbZ50sJ1eOHkdDTj97ibPJu0I=;
        b=epqZSUBTPykmru1tpuNenopPpxVx7e4QWgGYVHYzzUYfcelfOOreSsWvNJct4R/PKj
         iyu6OByChEyV+yZnyTL6v/iyMTLRrxde6kkCTrreh38BnoXtTByNHpZ8ysW2oXoWdaat
         YYlU20s9DzVUjIjDD7lbW9TP+V9UM8CJ1TCmsJWOZZ06CbyAg7P7Ztpo5ny0icWfHF4z
         1xZ//DT5MnmTc42ydbfb6VE38lAjuB/i1Bb3XRV88LUURV2AmxnU8Nig24Jr8/xfGlrM
         vscp+CLr2LQhdQv6t61em/8oQRtFj8v87hfOvtv3gWmPyHgyGcfTzrwwYebY3Jcu7l7G
         BOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdEos5u27HyJXZM1BaBbZ50sJ1eOHkdDTj97ibPJu0I=;
        b=LHCY0EO414xGwknzTGat0BfZ4bpcxmxH/xhKjKxYxJtcxBzd1h41qYSs3uX+bpcj99
         MR6rtsj4QQAySM2WT+VF6QCTRG4XTxn5RM8z4xyhK4NpAG+Lt6Yb653ZOKLRFODGyJ0p
         gzaY+Ee3y3WoCF5Pyltmp7OnO9+2VjdejapDzoeAe1+q5ebTabowbDOl/bMTIQWDGGPn
         sne3LisIxSpv7PuiH/MKpTdM2ReltvHe/zNIjjUOQzoKU/lcMagSfnYZeacFA1mjV5JA
         2PZqHDsPgnoLvVxnPdGvAgtoohxEzRGttNF7mPoa/P9ftlDB/H4EOmIlDOYVxmLkDC6x
         eo8g==
X-Gm-Message-State: AGi0PuYJit1AZj0sE7zKnhrUEbka+/mQARxC5BHzKjF2GhgNhL3JoYwu
        W4kXcxW5F+lFmAUH+cPuWBnH6Jfvya1dstEO68nujOru
X-Google-Smtp-Source: APiQypLnJe2OOHrGjFaZDciSkOe1417dQU3hR9z4q4nY6sIznEjr+THxv7h9tEPixTwKKrbmceQRPteHXDIbHabjjrM=
X-Received: by 2002:a6b:cd4a:: with SMTP id d71mr413184iog.5.1588228251142;
 Wed, 29 Apr 2020 23:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200430001354.1652-1-raghavan.arvind@gmail.com>
In-Reply-To: <20200430001354.1652-1-raghavan.arvind@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 Apr 2020 09:30:40 +0300
Message-ID: <CAOQ4uxhAR2_D2-cQ5H2LDeoBZuNk-e9xFKrn93Do6SoG33BVsg@mail.gmail.com>
Subject: Re: [v2] fstests: Fix duplicate CLI arguments in fssum
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 30, 2020 at 3:14 AM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> fssum currently has a duplicate '-x' flag, which is used for both
> excluding paths and including xattrs. As the former is the only one
> currently used in xfstests, this patch renames the latter to use '-t'.
>
> Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  src/fssum.c | 49 +++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/src/fssum.c b/src/fssum.c
> index a243839a..3d97a70b 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -77,7 +77,7 @@ enum _flags {
>         NUM_FLAGS
>  };
>
> -const char flchar[] = "ugoamcdxes";
> +const char flchar[] = "ugoamcdtes";
>  char line[65536];
>
>  int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0};
> @@ -131,28 +131,27 @@ usage(void)
>  {
>         fprintf(stderr, "usage: fssum <options> <path>\n");
>         fprintf(stderr, "  options:\n");
> -       fprintf(stderr, "    -f          : write out a full manifest file\n");
> -       fprintf(stderr, "    -w <file>   : send output to file\n");
> -       fprintf(stderr, "    -v          : verbose mode (debugging only)\n");
> -       fprintf(stderr,
> -               "    -r <file>   : read checksum or manifest from file\n");
> -       fprintf(stderr, "    -[ugoamcdxe]: specify which fields to include in checksum calculation.\n");
> -       fprintf(stderr, "         u      : include uid\n");
> -       fprintf(stderr, "         g      : include gid\n");
> -       fprintf(stderr, "         o      : include mode\n");
> -       fprintf(stderr, "         m      : include mtime\n");
> -       fprintf(stderr, "         a      : include atime\n");
> -       fprintf(stderr, "         c      : include ctime\n");
> -       fprintf(stderr, "         d      : include file data\n");
> -       fprintf(stderr, "         x      : include xattrs\n");
> -       fprintf(stderr, "         e      : include open errors (aborts otherwise)\n");
> -       fprintf(stderr, "         s      : include block structure (holes)\n");
> -       fprintf(stderr, "    -[UGOAMCDXES]: exclude respective field from calculation\n");
> -       fprintf(stderr, "    -n          : reset all flags\n");
> -       fprintf(stderr, "    -N          : set all flags\n");
> -       fprintf(stderr, "    -x path     : exclude path when building checksum (multiple ok)\n");
> -       fprintf(stderr, "    -h          : this help\n\n");
> -       fprintf(stderr, "The default field mask is ugoamCdES. If the checksum/manifest is read from a\n");
> +       fprintf(stderr, "    -f           : write out a full manifest file\n");
> +       fprintf(stderr, "    -w <file>    : send output to file\n");
> +       fprintf(stderr, "    -v           : verbose mode (debugging only)\n");
> +       fprintf(stderr, "    -r <file>    : read checksum or manifest from file\n");
> +       fprintf(stderr, "    -[ugoamcdtes]: specify which fields to include in checksum calculation.\n");
> +       fprintf(stderr, "         u       : include uid\n");
> +       fprintf(stderr, "         g       : include gid\n");
> +       fprintf(stderr, "         o       : include mode\n");
> +       fprintf(stderr, "         m       : include mtime\n");
> +       fprintf(stderr, "         a       : include atime\n");
> +       fprintf(stderr, "         c       : include ctime\n");
> +       fprintf(stderr, "         d       : include file data\n");
> +       fprintf(stderr, "         t       : include xattrs\n");
> +       fprintf(stderr, "         e       : include open errors (aborts otherwise)\n");
> +       fprintf(stderr, "         s       : include block structure (holes)\n");
> +       fprintf(stderr, "    -[UGOAMCDTES]: exclude respective field from calculation\n");
> +       fprintf(stderr, "    -n           : reset all flags\n");
> +       fprintf(stderr, "    -N           : set all flags\n");
> +       fprintf(stderr, "    -x path      : exclude path when building checksum (multiple ok)\n");
> +       fprintf(stderr, "    -h           : this help\n\n");

Changing whitespaces on unrelated lines clutters the diff from the
actual changes.
I would fight the urge to do that or do it in a separate patch.

Thanks,
Amir.
