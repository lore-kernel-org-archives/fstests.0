Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE847C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 21:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiERVcd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 May 2022 17:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243190AbiERVcc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 May 2022 17:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D8EAB94
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 14:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C790761214
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 21:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EC3C34113;
        Wed, 18 May 2022 21:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652909550;
        bh=lK6+sb5e4BxKPXA7X/oNXlKRhHZFk9L9q7CJTM5h5SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jL4cAUBPcfuFBJXgZmWiVGEMeESerpekRrGi2fnAJAh1Ye+d9swdjL2t4Q7AsYtR9
         z1d5VYmAS2go0sTUMzShtkMK8tUtVdWIxg05r5sU5ckc9RGiFcN1Epd+omv9hia2nU
         qTLoqCL+q5Kx96oYhjjScudM8mS+z8AGxF0UxTEICvvWSzo4jBh/H3O42lBzZsVVhO
         /VfzZTp49OlzRGcsFhVntt4Bs+HjFVdqSl7kPTkN11akQNRb1/UpBmjWa0l9ZPWjxE
         W1R1oRT4oE3/e44paAK/VUH1m6kP1kAZoeh0RjIhoKa4XaXpeWpA4TipN8b8OaWWHZ
         /FASUmbQXyTEA==
Date:   Wed, 18 May 2022 14:32:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     zlang@redhat.com, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/556: Adequate expected output to touch behavior
 change
Message-ID: <YoVl7MVtEUuupODz@sol.localdomain>
References: <20220518202214.481121-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518202214.481121-1-krisman@collabora.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 18, 2022 at 04:22:14PM -0400, Gabriel Krisman Bertazi wrote:
> Coreutils commit d435cfc0bc55 ("touch: fix wrong
> diagnostic (Bug#48106)"), released in coreutils v9.0, changed the error
> reported by the tool when openat() fails with EINVAL.  Instead of
> reporting a generic message for the failure of either openat() or the
> following utimensat(), it now differentiates both failures with
> different messages.
> 
> This change breaks generic/556, which relied on the parsing of that
> message.  This test was originally developed by me on a Debian
> Buster (coreutils v8.x), so I used the generic error message.  Now that
> I tried to run it on a more modern distro, it reports a different error
> message, which fails the test.
> 
> We could do it in a more flexible way to catch future changes.  These
> are unlikely, and many other parts of fstests just use this generic
> touch message, so don't bother with it here.
> 
> There is no change in behavior on the kernel side, just a broken test.
> On both older and new distros, the kernel correctly rejects this invalid
> sequence with -EINVAL, as shown in the strace hunk below:
> 
> ...
> openat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
> utimensat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
> ...
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  tests/generic/556.out | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/556.out b/tests/generic/556.out
> index f9dd9542fb12..12c77a5b0176 100644
> --- a/tests/generic/556.out
> +++ b/tests/generic/556.out
> @@ -12,5 +12,5 @@ user.foo="bar"
>  # file: SCRATCH_MNT/xattrs/x/f1
>  user.foo="bar"
>  
> -touch: setting times of 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
> -touch: setting times of 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
> +touch: cannot touch 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
> +touch: cannot touch 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument

This would break the test on systems that still have an older version of
coreutils, right?  For example, currently kvm-xfstests test appliances are based
on Debian Bullseye by default, which isn't very old, but it has coreutils 8.32.

Can you filter the output to allow the test to pass with both old and new
coreutils versions?  Or, find another way to test the same thing without relying
on a tool that has changed its output.

- Eric
