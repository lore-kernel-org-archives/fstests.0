Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE77C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A5A619F3
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 08:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCXIjT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:39:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35059 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhCXIjL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 04:39:11 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOz2h-0000F5-KA; Wed, 24 Mar 2021 08:39:07 +0000
Date:   Wed, 24 Mar 2021 09:39:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 1/6] generic/631: add test for detached mount
 propagation
Message-ID: <20210324083907.y6kn3xibr3qflius@wittgenstein>
References: <20210322134522.916512-1-brauner@kernel.org>
 <20210322134522.916512-2-brauner@kernel.org>
 <CAOQ4uxg6KyJLT9NnxFEnFPAkc02A0mmWSZphEd5to625x1cKxw@mail.gmail.com>
 <20210324075002.suuey4me7b4faruo@wittgenstein>
 <CAOQ4uxj=i=ppYtru0445Hzr74m6JZ_Z1gUoLoVjJnNsQiDi4fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj=i=ppYtru0445Hzr74m6JZ_Z1gUoLoVjJnNsQiDi4fw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 24, 2021 at 10:04:39AM +0200, Amir Goldstein wrote:
> On Wed, Mar 24, 2021 at 9:50 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 09:40:50AM +0200, Amir Goldstein wrote:
> > > On Mon, Mar 22, 2021 at 3:46 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > >
> > > > Regression test to verify that creating a series of detached mounts,
> > > > attaching them to the filesystem, and unmounting them does not trigger an
> > > > integer overflow in ns->mounts causing the kernel to block any new mounts in
> > > > count_mounts() and returning ENOSPC because it falsely assumes that the
> > > > maximum number of mounts in the mount namespace has been reached, i.e. it
> > > > thinks it can't fit the new mounts into the mount namespace anymore.
> > > >
> > > > The test is written in a way that it will leave the host's mount
> > > > namespace intact so we are sure to never make the host's mount namespace
> > > > unuseable!
> > > >
> > > > Link: https://git.kernel.org/torvalds/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557
> > > > Cc: Eryu Guan <guan@eryu.me>
> > > > Cc: David Howells <dhowells@redhat.com>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > ---
> > > > /* v1 - v8 */
> > > > patch not present
> > > >
> > > > /* v9 */
> > > > - Christian Brauner <christian.brauner@ubuntu.com>:
> > > >   - Rebased on current master.
> > > >
> > > > /* v10 */
> > > > - Eryu Guan <guan@eryu.me>:
> > > >   - Add missing checks whether test is supported.
> > > >   - Move status=$? assignment up.
> > > > ---
> > >
> > > Technical nit: why did you add this extra --- line?
> > > It causes all the patch changelog to appear in the commit message.
> > > I don't think that was your intention? and I don't think it adds valuable
> > > into to git log.
> >
> > I've not done that in any of the other patches or on any other patches I
> > ever wrote so I think this was just a copy-paste error when I updated
> > the changelog.
> >
> 
> Please note this glitch happened in all the patches in the series...

Oh wait, actually looking at this again I think don't understand just
yet. This is pretty common and when you apply the series git am will cut
after the first
---

And thinking about it so far I've never heard anyone complain about
this. But likely I just misunderstand you and I really borked something.

Fwiw, this format seems documented at
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

"The --- marker line serves the essential purpose of marking for patch
 handling tools where the changelog message ends.

 One good use for the additional comments after the --- marker is for a
 diffstat, to show what files have changed, and the number of inserted
 and deleted lines per file. A diffstat is especially useful on bigger
 patches. Other comments relevant only to the moment or the maintainer,
 not suitable for the permanent changelog, should also go here. A good
 example of such comments might be patch changelogs which describe what
 has changed between the v1 and v2 version of the patch.

 If you are going to include a diffstat after the --- marker, please use
 diffstat options -p 1 -w 70 so that filenames are listed from the top
 of the kernel source tree and don’t use too much horizontal space
 (easily fit in 80 columns, maybe with some indentation). (git generates
 appropriate diffstats by default.)"

And also at
https://www.ozlabs.org/~akpm/stuff/tpp.txt

"g) Non-changelog text:

    Sometimes you want to include text in the email which isn't designed to
    go into the changelog in the git repository.  Things like "this is already
    in Fred's tree" or "this is an updated version of last Friday's patch" or
    whatever.
 
    You should place such text below the "^---" separator so that it is
    auto-removed when being placed into the revision control system."

And there are quite a few examples that do it this way just one random
pick from my inbox:
https://lore.kernel.org/lkml/20210316204252.427806-8-mic@digikod.net

Christian
