Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C81C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 07:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D4C6121D
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 07:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhDLHbJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhDLHau (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Apr 2021 03:30:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 977EE61207;
        Mon, 12 Apr 2021 07:30:20 +0000 (UTC)
Date:   Mon, 12 Apr 2021 09:30:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eryu Guan <guan@eryu.me>, Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v12 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <20210412073017.a33i4ksvghmu4pqf@wittgenstein>
References: <20210328223400.1800301-1-brauner@kernel.org>
 <20210328223400.1800301-3-brauner@kernel.org>
 <YHMH/JRmzg3ETcED@desktop>
 <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
 <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
 <20210412072241.GA3246@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210412072241.GA3246@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 12, 2021 at 09:22:41AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 11, 2021 at 05:32:23PM +0200, Christian Brauner wrote:
> > > > And it should actually skip the tests on all filesystems that don't
> > > > support idmapped mounts which is every fs apart from xfs and ext4.
> > > 
> > > Yeah, looks like that's the case. So it seems the _require idmapped
> > 
> > Ah, ok I didn't know this needed to go in there. I thinke the following
> > might be enough. Are you able to simply apply it on top?
> 
> No, this is broken.  It needs to do feature detection, not some arbitrary
> whitelists.  And I'm pretty sure we got that right at some point by

I thought so too.

> doing the _notrun when mounting with the idmap option was not supported.

The thing is we need the fileystem type we're going to be tested on. I
can place this into src/feature.c if this can get access to the fstype
the test is going to be run on. It should be but if not we can do this
in src/idmapped-mounts/idmapped-mounts.c
directly to test whether the underlying fs we're being tested on
supports idmapped mounts and then return an error value from the binary
indicating that it doesn't so we can use _notrun.
I'll post an updated version of this today with the detection logic.

Christian
