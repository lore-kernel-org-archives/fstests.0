Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4897C433DB
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 02:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C6F6191F
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 02:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCVCho (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Mar 2021 22:37:44 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:50955 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhCVChH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Mar 2021 22:37:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0USq-D7b_1616380624;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0USq-D7b_1616380624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Mar 2021 10:37:05 +0800
Date:   Mon, 22 Mar 2021 10:37:04 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eryu Guan <guan@eryu.me>, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 0/4 REBASED] fstests: add idmapped mounts tests
Message-ID: <20210322023704.GC95214@e18g06458.et15sqa>
References: <20210316103627.2954121-1-christian.brauner@ubuntu.com>
 <YFdXmwkoZnN5uEH/@desktop>
 <20210321153200.t6cgg3sfm4m2aea3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321153200.t6cgg3sfm4m2aea3@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 21, 2021 at 04:32:00PM +0100, Christian Brauner wrote:
> On Sun, Mar 21, 2021 at 10:26:35PM +0800, Eryu Guan wrote:
> > On Tue, Mar 16, 2021 at 11:36:23AM +0100, Christian Brauner wrote:
> > > Hey everyone,
> > > 
> > > /* v9 */
> > > Rebased onto current master.
> > > Hopefully we can merge this soon so we can have regular testing asap and
> > > the rebasing is getting a bit tedious too. ;)
> > 
> > Sorry for the late review.. You don't have to rebase on every release if
> > updating the test seq number is the only thing changed. Seq number
> > conflicts all the time, usually I can fix it on commit.
> > 
> > Patch 2 is missing from the list, maybe it's too big to post, could you
> 
> _Sigh_, this seems like another vger issue. The individual Ccs/Tos
> should've all gotten the patch but it's missing from the list. This is a
> pattern I've seen quite a few times recently with vger. There's nothing
> to do apart from complain about it to the vger maintainer. :)
> 
> > please provide a git repo so I can pull from there?
> 
> For sure. It's available in three locations:
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/log/?h=idmapped_mounts_v2
> https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts_v2
> https://github.com/brauner/xfstests/tree/idmapped_mounts_v2

Ok, thanks!

> 
> (Are you fixing the things you pointed out in the individual patches
> yourself or should I resend a new version?)

New version please, I can fix trival things like typo, renumber the
test, code style, etc.

Thanks,
Eryu
