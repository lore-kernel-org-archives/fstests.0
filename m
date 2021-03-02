Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B39C4332E
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FF564F2B
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhCCAAF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Mar 2021 19:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574446AbhCBDgk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 1 Mar 2021 22:36:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57A816146B;
        Tue,  2 Mar 2021 03:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614656010;
        bh=Qn3wAjvUpz9s0EpcqjxBGqP1ek6Yqm/ak8x7gUtlrFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5uR2rfYXSzEAgZvs2zSbcgtQfU2fbI8v+vsqvo56GMikJJyf0UwfKhMXUsmq1zk2
         vOpiQcc3z1KefocFt3hcciC2kcGhJsefDPxm8cp6qdZxW2gM/TQV1k/zXiuKsmyLOJ
         ny1in3krbULiOzwnefrRpozaag+oaz2dA1+ZeW6snNMVstcO9JgoxNb6h7nUOldL0w
         8bHKzXSfen6J78VT/RG1Wfcpafo0doRiXV3MQJKslDUMVHHghqPf53xSiVfa6zjlTt
         k6rjj1wm/oHLztft9hE2MQXckehJme2vTYkvKNIY8rpLzIxxT5/kq/TXLahIl8orVP
         Las9HG52Iq++g==
Date:   Mon, 1 Mar 2021 19:33:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Su Yue <damenly.su@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test which tries to exercise AIO/DIO into
 unwritten space
Message-ID: <20210302033329.GG7269@magnolia>
References: <20210210205818.1494305-1-tytso@mit.edu>
 <20210301171440.GD7269@magnolia>
 <YD0ssnT0BCnwPXXk@mit.edu>
 <CABnRu57hdKav3Mi8vQYeowZrQtFToMSzK23h4H2DuqGL0Dea2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABnRu57hdKav3Mi8vQYeowZrQtFToMSzK23h4H2DuqGL0Dea2A@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 02, 2021 at 11:20:06AM +0800, Su Yue wrote:
> On Tue, Mar 2, 2021 at 2:10 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Mon, Mar 01, 2021 at 09:14:40AM -0800, Darrick J. Wong wrote:
> > > On Wed, Feb 10, 2021 at 03:58:18PM -0500, Theodore Ts'o wrote:
> > > > This test verifies that the an unwritten extent is properly marked as
> > > > written after writing into it.
> > > >
> > > > There was a hard-to-hit bug which would occasionally trigger with ext4
> > > > for which this test was a reproducer.  This has been fixed after
> > > > moving ext4 to use iomap for Direct I/O's, although as of this
> > > > writing, there are still some occasional failures on ext4 when block
> > > > size < page size.
> > >
> > > Are there still failures?
> >
> > Yes.  It's on Ritesh's todo list, but I don't believe it's bubbled up
> > to the top of his list.
> >
> > The failure rate is substantially less than what I had been seeing
> > with 4k block sizes before the move to iomap, and in practice it was
> > hard to hit in production.  We noticed on Google data center workloads
> > (but even then it was impossible to reliably repro before I found this
> > fio recipe); as far as I know no one else had reported seeing this
> > problem.
> >
> > So in summary, as of this writing, on 1k and 2k block sizes, this test
> > is still occasionally failing for ext4 (but not xfs, where it reliably
> > passes).  On 4k block sizes on x86 with ext4, this test is still
> > failing in on 5.4 and earler kernels, unless someone has managed to
> > backport DIO iomap support for ext4 into an enterprise linux kernel.
> >
> But both xfs and ext4 100% fail in v5.12-rc1 with 4k block size and 4k page
> size on x86_64. The test itself should be okay because btrfs passes.
> xfstests-dev version is 8cbc48b460b6 applied this patch. logs are attached.

Is this generic/623?  That test is new, and I've noticed it'll fail if
you have coredumps enabled because the test tries to induce a SIGBUS.

--D

> 
> # fio --version
> fio-3.25
> 
> #cat local.config
> export TEST_DEV=/dev/mapper/test-1
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV_POOL="/dev/mapper/test-[2-6]"
> export SCRATCH_MNT=/mnt/scratch
> export LOGWRITES_DEV="/dev/mapper/test-7"
> export KEEP_DMESG=yes
> 
> >                                         - Ted




