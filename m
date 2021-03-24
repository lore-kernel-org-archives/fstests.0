Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B08C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 08:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF7C61A00
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 08:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhCXIEd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbhCXID6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 04:03:58 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CCC061763
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 01:03:56 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l5so20593353ilv.9
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+ph+SLLmu9C9eleaBqS1ueYTCZjWnOt9S3XdPMrSJo=;
        b=GLdBLGprBH7z0vjC1lvaItwzgG24azbQzz2Qw7WdiYAh9kKqoiSCJJyukErWpa/nMS
         /kPRd5qumne803/6T7rh9TKX4Vb8Kz4Q/gTPAaWularzjryIIkv15M3Zu19lxLPaDfnU
         oc7pcLDmcc9aMCDcjy1bq4RVPMVUqzjgaZAuqsy6CKMMJhPvcTkH+oXn1U4KYdL/FGsA
         NRlH2g8HYySy3dE64T0v3sAxcGY6WKyFHPq+y/VJN6NCI4MQWERIFNP4FnEqKXKBbtJX
         ZzdhQNqpP4msn9WqIwiHGJw3Wndts/iXVe4HU13bLDp4mLjndzKbpppnGc2PBjZHpx2N
         uFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+ph+SLLmu9C9eleaBqS1ueYTCZjWnOt9S3XdPMrSJo=;
        b=sv9eh7DzQD8rP4KXP7hJ+mbYAM4GSg8eyuRMwTOgpzICKtvWTXZ0GXpYle0zKBNjta
         +ZpkP0FpCIND4hWE5XnAIoNBp74cbP5hhSTXc7QblvBJGiR5g7tHVMk/WhjzqGFHZmV4
         A4tMJFIANYn/uqi5AJvDNik5rXJfgsGrWvcUEWBBtibabbm1NwTf+Maxmrc2JUZ9jyT0
         /25jIOuB9W64zYmqlFBOuBtdepmqYLnvPy3wnT+Zlz17TqegsBJt5nTd2L9fr8cDrz4T
         QJroSotrpBvARce0ION9WwSAXzp2OYSkNJam5nJI8ovXTG4L+s4rfR3FVGLNG9DvmZSu
         6x6g==
X-Gm-Message-State: AOAM5324yuMdi8iQbP9qfRf+tzpvyCMQH9kzAGUbfyc5Ie9c8LoG77+4
        lmYzLGsWWwTAZyu87DgRBdNYp2WEUMAMTtuPVli1W8DqYmc=
X-Google-Smtp-Source: ABdhPJwVQuYMjtsxy9H0YKG6YrZtiwFvfzG0B9xglEECrnEDL22oBlg26ZZ37KtgGgbiquWgCi7NvEVKtVJMUKQeX+8=
X-Received: by 2002:a92:2c08:: with SMTP id t8mr1657907ile.72.1616573034145;
 Wed, 24 Mar 2021 01:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210322134522.916512-1-brauner@kernel.org> <20210322135002.6tyexslvqfiaari7@wittgenstein>
 <20210322142115.4ehetdcopvmvs7fl@wittgenstein>
In-Reply-To: <20210322142115.4ehetdcopvmvs7fl@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 10:03:43 +0200
Message-ID: <CAOQ4uxjB3aDehSeomAvi-7rUJRZmmR=GQFAqod9SzSoGu5PjnA@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] fstests: add idmapped mounts tests
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 22, 2021 at 4:22 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Mon, Mar 22, 2021 at 02:50:02PM +0100, Christian Brauner wrote:
> > On Mon, Mar 22, 2021 at 02:45:16PM +0100, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > >
> > > Hey everyone,
> > >
> > > This series is available from:
> > > https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> > > https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
> > > https://github.com/brauner/xfstests/tree/idmapped_mounts
> >
> > I sent this series from my kernel.org mail address and patch 2/6 hasn't
> > made it through this time too. So it seems that vger is rejecting it due
> > to its size is my guess. I'll go poing the #korg folks to ask what's
> > going on and whether that can be handled.
>
> Ok, Konstantin confirmed that patch 2/6 got dropped because of it's
> size. Nothing to do about this now but just as an fyi.
>

Since 2/6 got dropped, I'll write a small nit here which is also
relevant to the rest of the series:

--- a/tests/generic/group
+++ b/tests/generic/group
@@ -634,3 +634,4 @@
 629 auto quick rw copy_range
 630 auto quick rw dedupe clone
 631 auto quick mount
+632 auto atime attr cap io_uring mount perms quick rw unlink

This is a mouthful of test tags, but that doesn't hurt.
I would personally not bother with obscure tags like 'unlink' but whatever.

Two things I would request are:
1. Keep 'auto quick' before all other tags. There is no strong rule about
    this format, but that's the common practice and it makes sense IMO
    because -g auto and -g quick are the far more commonly used groups of
    tests, so it's convenient to be able to 'eye grep' those tests in
the group file.
2. Please tags all the idmapped tests with a tag 'idmapped' (or whatever)
    This would be used for running tests with -g idmapped for quick sanity
    when modifiying idmapped mounts related code

Thanks,
Amir.
