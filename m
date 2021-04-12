Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA602C43460
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 07:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16806121E
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 07:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbhDLHXC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:23:02 -0400
Received: from verein.lst.de ([213.95.11.211]:47297 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhDLHXC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Apr 2021 03:23:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E022468C4E; Mon, 12 Apr 2021 09:22:41 +0200 (CEST)
Date:   Mon, 12 Apr 2021 09:22:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eryu Guan <guan@eryu.me>, Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v12 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <20210412072241.GA3246@lst.de>
References: <20210328223400.1800301-1-brauner@kernel.org> <20210328223400.1800301-3-brauner@kernel.org> <YHMH/JRmzg3ETcED@desktop> <20210411151249.6y34x7yatqtpcvi6@wittgenstein> <20210411151857.wd6gd46u53vlh2xv@wittgenstein> <YHMUAL/oD4fB3+R7@desktop> <20210411153223.vhcegiklrwoczy55@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411153223.vhcegiklrwoczy55@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 11, 2021 at 05:32:23PM +0200, Christian Brauner wrote:
> > > And it should actually skip the tests on all filesystems that don't
> > > support idmapped mounts which is every fs apart from xfs and ext4.
> > 
> > Yeah, looks like that's the case. So it seems the _require idmapped
> 
> Ah, ok I didn't know this needed to go in there. I thinke the following
> might be enough. Are you able to simply apply it on top?

No, this is broken.  It needs to do feature detection, not some arbitrary
whitelists.  And I'm pretty sure we got that right at some point by
doing the _notrun when mounting with the idmap option was not supported.
