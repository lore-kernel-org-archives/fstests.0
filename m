Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08308C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 22:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiERWLv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 May 2022 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiERWLu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 May 2022 18:11:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D93EF22
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 15:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC33615BE
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 22:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48FDC385A5;
        Wed, 18 May 2022 22:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652911908;
        bh=KcKzH+TGgaUQY0VniWBz62hRdjEGCoQBx49DxYq+wVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXGxpDev7nTyBRR952pguuzUDD9iRAOWN+PhUjwzic1pA6sbGjQDF7LIT+uccUbeQ
         EfE7qQcwb3Nc455N4u/7vNCudaLYxHsLHBeHn1ZaVoubh3B5M6tNd1d7TBG52Vpz8A
         8+JkCXXEbhi7DWRpLFB/LTxASoWTbg1/kdfRvwgAIusXmpPHTCvd2cwXUK8N7lXhtq
         6ElpwoQTad65nt0Sd6CnlSz/1nMdxCGud3djdDyxblf8RNEkkCurU1DAMiT9KCOijH
         L3RXvUjaIj/RhgWQKMd2teHLUX8k7atx2OkdKvnf4/pDTWVmwz4E6+y81sCzov9NVR
         2/7ZMf924qVbw==
Date:   Wed, 18 May 2022 15:11:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, zlang@redhat.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic/556: Adequate expected output to touch behavior
 change
Message-ID: <YoVvJPpQBSHbe53r@magnolia>
References: <20220518202214.481121-1-krisman@collabora.com>
 <YoVl7MVtEUuupODz@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoVl7MVtEUuupODz@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 18, 2022 at 02:32:28PM -0700, Eric Biggers wrote:
> On Wed, May 18, 2022 at 04:22:14PM -0400, Gabriel Krisman Bertazi wrote:
> > Coreutils commit d435cfc0bc55 ("touch: fix wrong
> > diagnostic (Bug#48106)"), released in coreutils v9.0, changed the error
> > reported by the tool when openat() fails with EINVAL.  Instead of
> > reporting a generic message for the failure of either openat() or the
> > following utimensat(), it now differentiates both failures with
> > different messages.
> > 
> > This change breaks generic/556, which relied on the parsing of that
> > message.  This test was originally developed by me on a Debian
> > Buster (coreutils v8.x), so I used the generic error message.  Now that
> > I tried to run it on a more modern distro, it reports a different error
> > message, which fails the test.
> > 
> > We could do it in a more flexible way to catch future changes.  These
> > are unlikely, and many other parts of fstests just use this generic
> > touch message, so don't bother with it here.
> > 
> > There is no change in behavior on the kernel side, just a broken test.
> > On both older and new distros, the kernel correctly rejects this invalid
> > sequence with -EINVAL, as shown in the strace hunk below:
> > 
> > ...
> > openat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
> > utimensat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
> > ...
> > 
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  tests/generic/556.out | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/generic/556.out b/tests/generic/556.out
> > index f9dd9542fb12..12c77a5b0176 100644
> > --- a/tests/generic/556.out
> > +++ b/tests/generic/556.out
> > @@ -12,5 +12,5 @@ user.foo="bar"
> >  # file: SCRATCH_MNT/xattrs/x/f1
> >  user.foo="bar"
> >  
> > -touch: setting times of 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
> > -touch: setting times of 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
> > +touch: cannot touch 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
> > +touch: cannot touch 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
> 
> This would break the test on systems that still have an older version of
> coreutils, right?  For example, currently kvm-xfstests test appliances are based
> on Debian Bullseye by default, which isn't very old, but it has coreutils 8.32.
> 
> Can you filter the output to allow the test to pass with both old and new
> coreutils versions?  Or, find another way to test the same thing without relying
> on a tool that has changed its output.

Seconded, those of us running ancient distros like Ubuntu 22.04 will
need compatibility with 8.32 for a few years yet... ;)

--D

> - Eric
