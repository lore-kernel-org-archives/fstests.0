Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7521CC4361A
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3411464FC4
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhCCAB7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Mar 2021 19:01:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381580AbhCBIFc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Mar 2021 03:05:32 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lH01M-0000Ng-MI; Tue, 02 Mar 2021 08:04:44 +0000
Date:   Tue, 2 Mar 2021 09:04:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/624: add fstests for idmapped mounts
Message-ID: <20210302080444.ggk6lvn4jeelm4gl@wittgenstein>
References: <20210301151712.1994033-1-christian.brauner@ubuntu.com>
 <20210301173251.GA5375@lst.de>
 <20210302014333.GF7269@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210302014333.GF7269@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 01, 2021 at 05:43:33PM -0800, Darrick J. Wong wrote:
> On Mon, Mar 01, 2021 at 06:32:51PM +0100, Christoph Hellwig wrote:
> > > +# Modify as appropriate.
> > > +_supported_fs ext4 xfs
> > 
> > I think this should be
> > 
> > _supported_fs generic
> > 
> > now that we do the probing for the actual support, and any file system
> > not supporting it will just do a _notrun from _require_idmapped_mounts.
> > 
> > Also the comment above this line should be dropped.
> 
> The rest of this series still hasn't shown up in my inbox...

This is probably vger being clogged again due to some gmail crap. I'll
paste the patch below in case it hasn't made it onto the list until you
show up but for fwiw the latest version can always found at:

[1]: https://github.com/brauner/xfstests/tree/idmapped_mounts
[2]: https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/log/?h=idmapped_mounts

with the main test suite being located under

src/idmapped_mounts/idmapped_mounts.c

> 
> ...but I did wonder, have you all tested file creation with idmapped
> mounts and quotas enabled?  I noticed after the fact (sorry...) that
> the dqalloc call just prior to creating the inode still uses
> current_fs[ug]id() and not the fs[ug]id_into_mnt() call that the
> conversion series uses.

I think I commented on that on the original patch series where that
question was brought up and we concluded that not using the mapping was
the correct thing to do in this codepath.
I'll try to add tests for quotas now and get them back to you by my EOD
hopefully as part of the patch series.

> 
> (The fact that xfs access the ids once for quota and again when actually
> creating the inode is screaming for a cleanup, by the way...)

Yeah. :)
