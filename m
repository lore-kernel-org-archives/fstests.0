Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22357C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3C561972
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 09:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCVJuB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Mar 2021 05:50:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43784 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhCVJtu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Mar 2021 05:49:50 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOHBn-0002gv-74; Mon, 22 Mar 2021 09:49:35 +0000
Date:   Mon, 22 Mar 2021 10:49:33 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Eryu Guan <guan@eryu.me>, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 0/4 REBASED] fstests: add idmapped mounts tests
Message-ID: <20210322094933.xjjossqxdifhbxtl@wittgenstein>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
 <YFdXmwkoZnN5uEH/@desktop>
 <20210321153200.t6cgg3sfm4m2aea3@wittgenstein>
 <20210322023704.GC95214@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322023704.GC95214@e18g06458.et15sqa>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 22, 2021 at 10:37:04AM +0800, Eryu Guan wrote:
> On Sun, Mar 21, 2021 at 04:32:00PM +0100, Christian Brauner wrote:
> > On Sun, Mar 21, 2021 at 10:26:35PM +0800, Eryu Guan wrote:
> > > On Tue, Mar 16, 2021 at 11:36:23AM +0100, Christian Brauner wrote:
> > > > Hey everyone,
> > > > 
> > > > /* v9 */
> > > > Rebased onto current master.
> > > > Hopefully we can merge this soon so we can have regular testing asap and
> > > > the rebasing is getting a bit tedious too. ;)
> > > 
> > > Sorry for the late review.. You don't have to rebase on every release if
> > > updating the test seq number is the only thing changed. Seq number
> > > conflicts all the time, usually I can fix it on commit.
> > > 
> > > Patch 2 is missing from the list, maybe it's too big to post, could you
> > 
> > _Sigh_, this seems like another vger issue. The individual Ccs/Tos
> > should've all gotten the patch but it's missing from the list. This is a
> > pattern I've seen quite a few times recently with vger. There's nothing
> > to do apart from complain about it to the vger maintainer. :)
> > 
> > > please provide a git repo so I can pull from there?
> > 
> > For sure. It's available in three locations:
> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/log/?h=idmapped_mounts_v2
> > https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts_v2
> > https://github.com/brauner/xfstests/tree/idmapped_mounts_v2
> 
> Ok, thanks!
> 
> > 
> > (Are you fixing the things you pointed out in the individual patches
> > yourself or should I resend a new version?)
> 
> New version please, I can fix trival things like typo, renumber the

I'll give you a new version hopefully today (CET).

> test, code style, etc.

Thanks!

Christian
