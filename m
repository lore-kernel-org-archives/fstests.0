Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1732FC433C1
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66CD619EC
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 09:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhCXJw5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 05:52:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37093 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhCXJwa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 05:52:30 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lP0Be-0007Af-Cv; Wed, 24 Mar 2021 09:52:26 +0000
Date:   Wed, 24 Mar 2021 10:52:25 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 1/6] generic/631: add test for detached mount
 propagation
Message-ID: <20210324095225.hoota4r4x2ixey4f@wittgenstein>
References: <20210322134522.916512-1-brauner@kernel.org>
 <20210322134522.916512-2-brauner@kernel.org>
 <CAOQ4uxg6KyJLT9NnxFEnFPAkc02A0mmWSZphEd5to625x1cKxw@mail.gmail.com>
 <20210324075002.suuey4me7b4faruo@wittgenstein>
 <CAOQ4uxj=i=ppYtru0445Hzr74m6JZ_Z1gUoLoVjJnNsQiDi4fw@mail.gmail.com>
 <20210324083907.y6kn3xibr3qflius@wittgenstein>
 <CAOQ4uxgx8ic0yH3CY_YQXpVkFbP0zS8M55+EaRF2_WkaWam2eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgx8ic0yH3CY_YQXpVkFbP0zS8M55+EaRF2_WkaWam2eA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 24, 2021 at 11:45:34AM +0200, Amir Goldstein wrote:
> On Wed, Mar 24, 2021 at 10:39 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 10:04:39AM +0200, Amir Goldstein wrote:
> > > On Wed, Mar 24, 2021 at 9:50 AM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > On Wed, Mar 24, 2021 at 09:40:50AM +0200, Amir Goldstein wrote:
> > > > > On Mon, Mar 22, 2021 at 3:46 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > >
> > > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > >
> > > > > > Regression test to verify that creating a series of detached mounts,
> > > > > > attaching them to the filesystem, and unmounting them does not trigger an
> > > > > > integer overflow in ns->mounts causing the kernel to block any new mounts in
> > > > > > count_mounts() and returning ENOSPC because it falsely assumes that the
> > > > > > maximum number of mounts in the mount namespace has been reached, i.e. it
> > > > > > thinks it can't fit the new mounts into the mount namespace anymore.
> > > > > >
> > > > > > The test is written in a way that it will leave the host's mount
> > > > > > namespace intact so we are sure to never make the host's mount namespace
> > > > > > unuseable!
> > > > > >
> > > > > > Link: https://git.kernel.org/torvalds/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557
> > > > > > Cc: Eryu Guan <guan@eryu.me>
> > > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > > ---
> > > > > > /* v1 - v8 */
> > > > > > patch not present
> > > > > >
> > > > > > /* v9 */
> > > > > > - Christian Brauner <christian.brauner@ubuntu.com>:
> > > > > >   - Rebased on current master.
> > > > > >
> > > > > > /* v10 */
> > > > > > - Eryu Guan <guan@eryu.me>:
> > > > > >   - Add missing checks whether test is supported.
> > > > > >   - Move status=$? assignment up.
> > > > > > ---
> > > > >
> > > > > Technical nit: why did you add this extra --- line?
> > > > > It causes all the patch changelog to appear in the commit message.
> > > > > I don't think that was your intention? and I don't think it adds valuable
> > > > > into to git log.
> > > >
> > > > I've not done that in any of the other patches or on any other patches I
> > > > ever wrote so I think this was just a copy-paste error when I updated
> > > > the changelog.
> > > >
> > >
> > > Please note this glitch happened in all the patches in the series...
> >
> > Oh wait, actually looking at this again I think don't understand just
> > yet. This is pretty common and when you apply the series git am will cut
> > after the first
> > ---
> >
> > And thinking about it so far I've never heard anyone complain about
> > this. But likely I just misunderstand you and I really borked something.
> >
> 
> I see. The reason I brought this up is because I fetched your branch from
> https://github.com/brauner/xfstests/ idmapped_mounts_v2
> and it has this changelog visible in git log.
> 
> So I am not sure how that came to be.

Oh now I understand you. That's intentional, non-final branches, i.e.
versioned branches of mine or branches where I'm not the one applying
the patches after pulling them via b4 still container the changelogs
because I need to assume I'll cut new version from it and will amend the
changelogs. This also ensures git format-patch will give retain the
changelog.

But the point is will taken. If I provide a branch to pull from I should
strip the changelogs. This is what I done now. You can find this series
(unchanged apart from the stripped changelog) here:
always have the changelog recorded to

https://github.com/brauner/xfstests/ idmapped_mounts

similar for gitlab and kernel.org.

Thanks for pointing that out!
Christian
