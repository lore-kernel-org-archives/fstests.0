Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70122C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 18:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391102AbiDUSFG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391101AbiDUSFE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 14:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68724B1D2
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 11:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0F061E18
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 18:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9198C385AB;
        Thu, 21 Apr 2022 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650564133;
        bh=WPU94CsrJlSHJu10dzR9jKDeofYIHkRKpZQfdPrmtnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tvbig43D/86KDPRta6RxHVmZhmaHxuKzXvy9moJkqunJKMlPnyVfbwx+dLBFvYuga
         LcfEud6W5Zop9445WmIidCbBLF6w15ib7PRFYEbKWw18ONwLT1KtO589dOcdRLDCNL
         JKicfHBLxffAJnL4GWEFGae03HVMN+KRfYd7Vsea7VQpio3sXr6FAOrRtdFRk/M+dw
         rdJOoT6aniZMslr7yQ7h2SSlqOPR7l0TT+BFJU2LPyHV7RGe1Aoofnc6fO8WUONbrA
         d27VGTMRxTfwke3wrzqEl36hLYyTIe0LDr7KlxQHkTDZxjRn7ma6BsTF23QbBGYO3U
         Kb8+6m+eWFzGA==
Date:   Thu, 21 Apr 2022 11:01:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/556: add a check to make sure ext4 supports
 encrypted casefolding
Message-ID: <YmGcDdLRlfSwUxmZ@sol.localdomain>
References: <20210621164901.1809010-1-tytso@mit.edu>
 <YNDOdrW0cEOhC9rZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNDOdrW0cEOhC9rZ@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 21, 2021 at 10:37:58AM -0700, Eric Biggers wrote:
> On Mon, Jun 21, 2021 at 12:49:01PM -0400, Theodore Ts'o wrote:
> > diff --git a/tests/generic/556 b/tests/generic/556
> > index 3145188c..7916a08e 100755
> > --- a/tests/generic/556
> > +++ b/tests/generic/556
> > @@ -16,6 +16,7 @@ status=1 # failure is thea default
> >  . ./common/attr
> >  
> >  _supported_fs generic
> > +_require_encrypted_casefold
> 
> This isn't an encrypt+casefold test though, but rather just a casefold test.  It
> only becomes an encrypt+casefold test when $MOUNT_OPTIONS includes
> test_dummy_encryption.
> 
> I think we shouldn't update the test itself, but rather make
> _require_scratch_casefold() call _require_encrypted_casefold() if
> test_dummy_encryption is in $MOUNT_OPTIONS.
> 

Hi Ted, just to follow up on this patch which never got merged:

I tried to reproduce the test failure with the 5.4 and 5.10 kernels, whose ext4
supported casefold but not encrypt+casefold.  However, it does *not* reproduce
with the "ext4/encrypt" configuration of kvm-xfstests, since
_require_scratch_casefold() already detects that the filesystem cannot mounted
with both the encrypt and casefold features:

        if ! _try_scratch_mount &>>seqres.full; then
                _notrun "kernel can't mount filesystem with the encoding set by userspace"
        fi

I think the problem is that you were running xfstests with test_dummy_encryption
but without adding "-O encrypt" to EXT_MKFS_OPTIONS.  That sort of works because
of the following code in __ext4_fill_super() in the kernel which force-enables
the encrypt feature if the test_dummy_encryption mount option was given:

	if (DUMMY_ENCRYPTION_ENABLED(sbi) && !sb_rdonly(sb) &&
	    !ext4_has_feature_encrypt(sb)) {
		ext4_set_feature_encrypt(sb);
		ext4_commit_super(sb);
	}

However, I don't think ext4 should be doing this.  The kernel should generally
not be messing with the feature flags, and this code can force-enable 'encrypt'
in cases where e2fsprogs would *not* allow it (e.g. the encrypt+casefold
situation being encountered here).  Also, f2fs doesn't allow this.

So I am planning to send a kernel patch to remove the above code from ext4.

- Eric
