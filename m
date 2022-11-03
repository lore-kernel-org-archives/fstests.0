Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E373C43217
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Nov 2022 16:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKCQik (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiKCQiU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Nov 2022 12:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13E22BE6
        for <fstests@vger.kernel.org>; Thu,  3 Nov 2022 09:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EAE761F63
        for <fstests@vger.kernel.org>; Thu,  3 Nov 2022 16:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6323C433D7;
        Thu,  3 Nov 2022 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667493268;
        bh=3ZS6DXUvRGRXct1aysKFD72LykiJSNpTO5gYg3AdrhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAJe2tIVLNHNPrPoMWPlIBUlw3ANbMhYhEv7w5GlmqkwKOALXFPeA4LHi6//DYfou
         rbvUG5wTWDDa5FiJJ37moWpDBN3IVBg7B/y2RTrf0h1Cm/V2lId7WCLZPLq+RCd2VK
         r7uzqGg1D1AYaqeoGrj1smvFLWPA72KpNqgD7PGvdaiLi5Bvtw4s5pQkTpfLsFIERR
         P/SX7oXWdM+SBq4cyT9B+47rVaXH92J0cVmhv0DpByQNzbIPQjA11ZcZeSCStQmAjq
         xaFxHJ70G4xv9lrKMH7kkSAJ41bOW9NgMRTZb1h3PHPDxy+/a98abGC0d3ikIRcvhh
         TIaB5TE6kPxvA==
Date:   Thu, 3 Nov 2022 16:34:27 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/577: add missing fsverity metadata cleaning
Message-ID: <Y2PtkwvY0PfKuMpG@gmail.com>
References: <20221102165134.169135-1-aalbersh@redhat.com>
 <Y2LyIiDDR9/RS773@sol.localdomain>
 <20221103102321.73kklwrpjmslyl5s@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103102321.73kklwrpjmslyl5s@aalbersh.remote.csb>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 03, 2022 at 11:23:21AM +0100, Andrey Albershteyn wrote:
> On Wed, Nov 02, 2022 at 03:41:38PM -0700, Eric Biggers wrote:
> > Thank you for reporting this.  How did you notice this?  This test actually is
> > currently passing, because there is another test bug that makes
> > _fsv_have_hash_algorithm always return false here.  That really needs to be
> > fixed first, as otherwise your fix doesn't really do anything.
> 
> Hmm, it fails for me. _fsv_have_hash_algorithm also seems to work
> (returns 0), what bug do you mean? Don't see anything obvious.
> 
> I was running -g verity on ext4/xfs (I'm working on adding fsverity
> support to xfs).

That's exciting that you're working on fsverity support for xfs!  I wasn't aware
that someone was working on that.

If the test is failing even on ext4 for you, then you must have changed
something, either in the kernel or in the tests, that exposed the issue.

Anyway, for _fsv_have_hash_algorithm() to work properly, it needs to set the
fs.verity.require_signatures sysctl to 0 temporarily (if it was 1).  I'll send
out a patch if you don't get to it first.

- Eric
