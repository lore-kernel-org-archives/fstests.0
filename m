Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1640C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712E261A04
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 09:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhCXJp6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhCXJpq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 05:45:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24DEC061763
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 02:45:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k8so20787528iop.12
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1a0hAm93/12fzcD8P+EljG6Vgm8Xm3NdyxoOTclYPI=;
        b=SMOyN7R2Kb2tVHRagqleljSkBGxvxbC2DL7++bypOGcFi3oZ16v9uukH0SmfpEqhg0
         sTMsaFQ5rXHSAC1wgC3jF4JQxjDc3WN3Aa19J4DvMEZ11bXXfCyNhM2llWWFQw/MC+oP
         tQzejYlSVVTqlo67E+VXwIFjYHDMPw1HxvYdiD9AVtKfiKGziS8SeeqJwGcHzPBKVicQ
         ahha+qRr8tIaxZSj4sjKJOgnfLENN+9jQL6pegj+ck+FnotmHL9Dzirrg7wvTjL76ZMw
         D9TdUFcBlpyHXud4glpEhq1qddQaSc4AUEdNfOO9N2NAIz+9kxv+DVyX0781JbO1skUV
         N1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1a0hAm93/12fzcD8P+EljG6Vgm8Xm3NdyxoOTclYPI=;
        b=J1Bd5JUyKZRjMlIH46AtzAIwUjNSaQpnDrsGrVx2jOn0xl6aj/W7sx9PmyJ67C4Tl/
         iSzaNm78tpNgTtTmmg7vY5fkAuj/9rc8jtivBIBVt1Aoi46FVeaJUfAJIEMJxKBvFmXj
         RJ9jTxWo1JAZpZ0T5zPOVO70QVqChmi6gF+2ZiFNAi9oA6oCaP7bJz0cdiEe/rPZCL/f
         jDNPjvSg+3RZmbFb5Yxdof6N9cpJAjg9Ah7oAIsxv1XjK1v9lwGCnwsaYwiUGIY1nX57
         urjxs2Fqy/vD+XHDdDDqmPDGlPBhBEAj0YTQXMghiNNh9O+49spPEYtjTbxDxQkfUNE+
         balQ==
X-Gm-Message-State: AOAM533lqIQWvElfohHwKZPSDmxke7xKWlGOgFeKW0jkxAzx5jnySRz+
        su7p3uRJraa6c0xfqaDp/vXWCg7PtojIWx7lXqK3QFRaCdY=
X-Google-Smtp-Source: ABdhPJxVHEgbAUgtkZvCDbcndt0fws/D26XJ2b/OA5249rFJtWzxfEvZgby9guleejyqbTkiL7c5YHYgbZxnmyCV4RY=
X-Received: by 2002:a5e:8d01:: with SMTP id m1mr1731453ioj.72.1616579145519;
 Wed, 24 Mar 2021 02:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210322134522.916512-1-brauner@kernel.org> <20210322134522.916512-2-brauner@kernel.org>
 <CAOQ4uxg6KyJLT9NnxFEnFPAkc02A0mmWSZphEd5to625x1cKxw@mail.gmail.com>
 <20210324075002.suuey4me7b4faruo@wittgenstein> <CAOQ4uxj=i=ppYtru0445Hzr74m6JZ_Z1gUoLoVjJnNsQiDi4fw@mail.gmail.com>
 <20210324083907.y6kn3xibr3qflius@wittgenstein>
In-Reply-To: <20210324083907.y6kn3xibr3qflius@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 11:45:34 +0200
Message-ID: <CAOQ4uxgx8ic0yH3CY_YQXpVkFbP0zS8M55+EaRF2_WkaWam2eA@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] generic/631: add test for detached mount propagation
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

On Wed, Mar 24, 2021 at 10:39 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Mar 24, 2021 at 10:04:39AM +0200, Amir Goldstein wrote:
> > On Wed, Mar 24, 2021 at 9:50 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Wed, Mar 24, 2021 at 09:40:50AM +0200, Amir Goldstein wrote:
> > > > On Mon, Mar 22, 2021 at 3:46 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > >
> > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > >
> > > > > Regression test to verify that creating a series of detached mounts,
> > > > > attaching them to the filesystem, and unmounting them does not trigger an
> > > > > integer overflow in ns->mounts causing the kernel to block any new mounts in
> > > > > count_mounts() and returning ENOSPC because it falsely assumes that the
> > > > > maximum number of mounts in the mount namespace has been reached, i.e. it
> > > > > thinks it can't fit the new mounts into the mount namespace anymore.
> > > > >
> > > > > The test is written in a way that it will leave the host's mount
> > > > > namespace intact so we are sure to never make the host's mount namespace
> > > > > unuseable!
> > > > >
> > > > > Link: https://git.kernel.org/torvalds/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557
> > > > > Cc: Eryu Guan <guan@eryu.me>
> > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > ---
> > > > > /* v1 - v8 */
> > > > > patch not present
> > > > >
> > > > > /* v9 */
> > > > > - Christian Brauner <christian.brauner@ubuntu.com>:
> > > > >   - Rebased on current master.
> > > > >
> > > > > /* v10 */
> > > > > - Eryu Guan <guan@eryu.me>:
> > > > >   - Add missing checks whether test is supported.
> > > > >   - Move status=$? assignment up.
> > > > > ---
> > > >
> > > > Technical nit: why did you add this extra --- line?
> > > > It causes all the patch changelog to appear in the commit message.
> > > > I don't think that was your intention? and I don't think it adds valuable
> > > > into to git log.
> > >
> > > I've not done that in any of the other patches or on any other patches I
> > > ever wrote so I think this was just a copy-paste error when I updated
> > > the changelog.
> > >
> >
> > Please note this glitch happened in all the patches in the series...
>
> Oh wait, actually looking at this again I think don't understand just
> yet. This is pretty common and when you apply the series git am will cut
> after the first
> ---
>
> And thinking about it so far I've never heard anyone complain about
> this. But likely I just misunderstand you and I really borked something.
>

I see. The reason I brought this up is because I fetched your branch from
https://github.com/brauner/xfstests/ idmapped_mounts_v2
and it has this changelog visible in git log.

So I am not sure how that came to be.

Thanks,
Amir.
