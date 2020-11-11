Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D8C388F9
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FE3208B3
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Nov 2020 21:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddedsKLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKKVZM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKKVZM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Nov 2020 16:25:12 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BA720679;
        Wed, 11 Nov 2020 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605129912;
        bh=2lB1UDVjVw9G5qiHmt8DLSyscJ2GjVd2ZSrSZa0r4t0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddedsKLTNvEdVH5hv5+HchsIs3Kmr8+kZH/Zli9vv7emqj2zREkZlOiKfoLKYrZ7Z
         UqQmQ1kmMQph/3gdT1z3uCvIDv0/h0yu8CWLleHia/FRNfr/wX8tP1fW72TiBuoZeN
         AbFYycTMqJeQGknbnIyDbJ8aiM3QzWaaU9Y/68q8=
Date:   Wed, 11 Nov 2020 13:25:10 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [xfstests-bld PATCH] gen-tarball: add 'set -e'
Message-ID: <X6xWtkUQeUGcE786@sol.localdomain>
References: <20201101172450.479000-1-ebiggers@kernel.org>
 <20201111192152.GA335825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111192152.GA335825@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 11, 2020 at 11:21:52AM -0800, Eric Biggers wrote:
> On Sun, Nov 01, 2020 at 09:24:50AM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > The latest master branch of xfstests is missing a Makefile in
> > tests/ceph/, which broke xfstests's 'make install'.  But gen-tarball
> > didn't notice this.  Fix this by adding 'set -e', and to make this work
> > adjust a couple other commands that are expected to fail.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  gen-tarball | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> 
> Ping.  Ted, are you planning to apply this?  The master branch of xfstests is
> fixed now, but this gen-tarball change would still be good to have.
> 

Actually, I missed one case where a failure is expected -- the case where
kvm-xfstests/test-appliance/debs doesn't exist.  I'll send v2.

- Eric
