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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3613C433C1
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 08:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51A761A00
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 08:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhCXIFJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhCXIEv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 04:04:51 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB79C061763
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 01:04:51 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r8so20589891ilo.8
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 01:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOTWLyPKuiUkNcc6f8Vprh03zpXc+RqcS1uHcXzR94Y=;
        b=SFvffe7SjsNOtaJxiyb9aQ9JJswur0WToYb3iW6eIpgV6oQ0AgQU7v0uJgR2ksMCFi
         Hi0WDPu17FgcaKTrnkNxwUKLKGKw4cYr97FcGAFM0tXCxdcVAYdtq5M7cK/lYW1548Bz
         ofrNn+/nNIRFnd1wa2THPHboXpN49cmDoNDDw1BuzTMe58M1coKKL8NVYWTfwAQrmj+M
         PzoLTV+kcJb7yNps9F6JkLSu7LZSaYvac6Sxat/IIQ0j4b84+A6Hh+nqqTax3hgTbj/p
         KW2UqOCoRFRFEWMyWSRRUaO+muhUK0Lx86VjLycwpKHNkOHO9Bw3TKbpiGPHouh0u7Ut
         7lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOTWLyPKuiUkNcc6f8Vprh03zpXc+RqcS1uHcXzR94Y=;
        b=DlTexmWKpq+MgLOFyBPLgzVFsUGPJZ2aQUz6vOoEwHYtDRSj4UXi1FEau6T/4pGtAJ
         jBg47DeGnLDf0QlUvpnPoB0O3JPqdUunampQ4hMpnbtow64oh5RvwJYWCblyUgwT6mKA
         ij3B7bTuKEttbk0jlzHbsbojYGDipRgUmKO8UxRi2BrMgy9+wGrH2Mw/7y3/buEmo/As
         MUwaCMYTcSDa3/2FlBYfETd3Lb068HIUOU9O7fsKvQG2AmTCjt/i3gU18yO1fKnyu7bK
         mHaiBcJzWdycU9GdvTiSpAzMcdlrwqS+ZWg9DkXPa7ZAnHpCjNZOyeDm641AIW67yHC6
         dkqQ==
X-Gm-Message-State: AOAM532chcNJjGSbG3vQW/m+0hofTTUl5HLhDF+9a2wrn116Zoj2YvVK
        w4vssEF9AHhLDRtQgTyaoHOb2KSfdmZ5F+QHjek=
X-Google-Smtp-Source: ABdhPJw47/GGs6JfN1xPFj475bNyWg8nqbjhudprK5j3n5ZUcKesGMFET8Nu8DNFyxYCRInGmaTYjsYwuxPUIN8iXU4=
X-Received: by 2002:a92:50b:: with SMTP id q11mr1748767ile.250.1616573090990;
 Wed, 24 Mar 2021 01:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210322134522.916512-1-brauner@kernel.org> <20210322134522.916512-2-brauner@kernel.org>
 <CAOQ4uxg6KyJLT9NnxFEnFPAkc02A0mmWSZphEd5to625x1cKxw@mail.gmail.com> <20210324075002.suuey4me7b4faruo@wittgenstein>
In-Reply-To: <20210324075002.suuey4me7b4faruo@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 10:04:39 +0200
Message-ID: <CAOQ4uxj=i=ppYtru0445Hzr74m6JZ_Z1gUoLoVjJnNsQiDi4fw@mail.gmail.com>
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

On Wed, Mar 24, 2021 at 9:50 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Mar 24, 2021 at 09:40:50AM +0200, Amir Goldstein wrote:
> > On Mon, Mar 22, 2021 at 3:46 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > >
> > > Regression test to verify that creating a series of detached mounts,
> > > attaching them to the filesystem, and unmounting them does not trigger an
> > > integer overflow in ns->mounts causing the kernel to block any new mounts in
> > > count_mounts() and returning ENOSPC because it falsely assumes that the
> > > maximum number of mounts in the mount namespace has been reached, i.e. it
> > > thinks it can't fit the new mounts into the mount namespace anymore.
> > >
> > > The test is written in a way that it will leave the host's mount
> > > namespace intact so we are sure to never make the host's mount namespace
> > > unuseable!
> > >
> > > Link: https://git.kernel.org/torvalds/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557
> > > Cc: Eryu Guan <guan@eryu.me>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > ---
> > > /* v1 - v8 */
> > > patch not present
> > >
> > > /* v9 */
> > > - Christian Brauner <christian.brauner@ubuntu.com>:
> > >   - Rebased on current master.
> > >
> > > /* v10 */
> > > - Eryu Guan <guan@eryu.me>:
> > >   - Add missing checks whether test is supported.
> > >   - Move status=$? assignment up.
> > > ---
> >
> > Technical nit: why did you add this extra --- line?
> > It causes all the patch changelog to appear in the commit message.
> > I don't think that was your intention? and I don't think it adds valuable
> > into to git log.
>
> I've not done that in any of the other patches or on any other patches I
> ever wrote so I think this was just a copy-paste error when I updated
> the changelog.
>

Please note this glitch happened in all the patches in the series...

Thanks,
Amir.
