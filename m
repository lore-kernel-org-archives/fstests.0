Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E39C433DB
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jan 2021 03:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FF9224B8
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jan 2021 03:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbhASDtm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Jan 2021 22:49:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56912 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729303AbhASDtR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Jan 2021 22:49:17 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10J3mGBM020967
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 22:48:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 07FD015C399F; Mon, 18 Jan 2021 22:48:16 -0500 (EST)
Date:   Mon, 18 Jan 2021 22:48:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/046: skip test when ext4 doesn't support bs < ps
 with dioread_nolock
Message-ID: <YAZWfy6tYIXyiQ33@mit.edu>
References: <1610596503-17149-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20210117150624.GA2347@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117150624.GA2347@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jan 17, 2021 at 11:06:24PM +0800, Eryu Guan wrote:
> On Thu, Jan 14, 2021 at 11:55:03AM +0800, Yang Xu wrote:
> > When testing arm machine, this case fails because ps > bs and kernel doesn't
> > introduced commit c8cc88163f40 ("ext4: Add support for blocksize < pagesize in dioread_nolock").
> > Only skip this case when mounting failed.
> 
> Perhaps it's the kernel that should be fixed? i.e. backport the
> mentioned patch? Depends on if we treat it as a bug or a feature I
> think..

The dioread_nolock was introduced about ten years, and originally it
was an optimization that only worked when page size == block size.  A
little over a year ago (October 2019, in v5.5) this was relaxed so
that the dioread_nolock mount option would be accepted when the block
size < page size.

ARM's page size can be 4k, 64k, or 1MB.  At least on most ARM platform
that I've worked with (which are mobile handsets, admittedly) then
page size is 4k, and the default block size for ext4 file systems
created by ext4 is 4k.  You *can* ask mke2fs to create a 64k block
size, and in theory it should work, but I don't have access to any
platforms with 64k block sizes, so 64k support has a tendency to
regress.  We did fix some issues the last time someone tried to use an
ext4 file system with a 64k block sizes on an Itanium system, but that
was a couple of years ago.

As far as backporting dioread_nolock support to older kernels, it
requires a large restructuring of ext4 code to support it.  It's not
something that won't be acceptable for upstream LTS kernels.  I'm
assuming the issue here is that Fujitsu is trying to use some RHEL or
SLES kernel on a server-class ARM system with a 64k page size?

> At least we should check if it's really the bs < ps case before _notrun
> the test, otherwise we may fail to find dioread_nolock mount regression.

I'd tend to agree, but at least for ext4 upstream development, I run
the the full set of -g auto tests with dioread_nolock.  So if there a
dioread_nolock mount regression, I'd certainly notice.

	       	     		     	       - Ted
