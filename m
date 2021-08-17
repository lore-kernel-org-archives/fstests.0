Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EFFC4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Aug 2021 12:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2EE60F5C
	for <linux-fstests@archiver.kernel.org>; Tue, 17 Aug 2021 12:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhHQMcC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 Aug 2021 08:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhHQMcC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 17 Aug 2021 08:32:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD7B60F41;
        Tue, 17 Aug 2021 12:31:27 +0000 (UTC)
Date:   Tue, 17 Aug 2021 14:31:25 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 0/8] Extend idmapped mount testsuite
Message-ID: <20210817123125.shz5hsbrpn5vmpyj@wittgenstein>
References: <20210814104805.1124023-1-brauner@kernel.org>
 <20210815164611.hkbrnmubliubprin@wittgenstein>
 <20210817031116.GN60846@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210817031116.GN60846@e18g06458.et15sqa>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 17, 2021 at 11:11:16AM +0800, Eryu Guan wrote:
> On Sun, Aug 15, 2021 at 06:46:11PM +0200, Christian Brauner wrote:
> > On Sat, Aug 14, 2021 at 12:47:57PM +0200, Christian Brauner wrote:
> > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > 
> > > Hey everyone,
> > > 
> > > This is v4 with only a minimal change to getopt_long_only(). The rest is
> > > identical. In v3 the changes requested by Christoph and his Reviewed-bys
> > > added. I've also added Josef's Reviewed-by for the newly added btrfs
> > > specific idmapped mount testsuite. There are no major changes to v2.
> > > 
> > > This time around I've put everyone in To: to make sure that they receive
> > > all patches. The list apparently still refues patches if they are fairly
> > > huge. The series can be pulled from three locations:
> > > 
> > > git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/xfstests-dev fs.idmapped.nested_userns
> > > git@gitlab.com:brauner/xfstests.git fs.idmapped.nested_userns
> > > git@github.com:brauner/xfstests.git fs.idmapped.nested_userns
> > > 
> > > This adds three new tests:
> > > - a regression test for vfs capabilities
> > > - a new test with nested and complex idmapping layouts
> > > - a new btrfs specific idmapped mount testsuite
> > > 
> > > Since v2 patches to support idmapped mounts on btrfs have been merged
> > > into btrfs' for-next tree:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-next&id=f691ae1e0bc591df5e9897387d726adbb440fc4c
> > > and so are on track to be included for v5.15.  I'd like to get the btrfs
> > > tests merged now so linux-next can be tested with the them. I hope
> > > that's ok.
> > > 
> > > I ran:
> > > git rebase -i -x "make -j4 clean && make -j4 && sudo ./check -g idmapped" HEAD~8
> > > on the whole series. Everthing passes.
> > 
> > Hey Eryu,
> > 
> > Sorry for asking but it's been a few months. Did you miss this series
> > intentionally this iteration? After last weeks mail I added all
> > Acks/Reviewed-bys that came in so this should hopefully be good to go.
> 
> Thanks for the revision, that really helps! And I left this patchset
> intentionally, as it's a big patchset that may need more exposure time.
> 
> > 
> > I'd really like to see these new tests going in rather soon as their
> > quite crucial to ensure correct functionality especially since we're
> > seeing new filesystems making use of idmapped mounts.
> 
> Sure, I'll merge them this week if there's no more comments.

Perfect, thank you!
Christian
