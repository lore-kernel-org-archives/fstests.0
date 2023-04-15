Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F6C77B71
	for <linux-fstests@archiver.kernel.org>; Sat, 15 Apr 2023 00:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDOAle (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Apr 2023 20:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDOAle (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Apr 2023 20:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40610C9
        for <fstests@vger.kernel.org>; Fri, 14 Apr 2023 17:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658A764ADA
        for <fstests@vger.kernel.org>; Sat, 15 Apr 2023 00:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5EDC433EF;
        Sat, 15 Apr 2023 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681519291;
        bh=DxTG7LxIgBZCit5gqn2HmpF0ufPP4IMO678IJGhAc4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEBJ9pyu9labfWwkN/NfwhFByxvfjMKM068AWP0xz8XLr8XwBiHINM7h13hTcZU4c
         t0kRRAosjx1CgPKsaUmKGPpTQLBO7/tJ8jQM9vfdOeV8iarpbqhju/VM9WRbJwM6J8
         +5nt++YuFcua9Z7vl2WrN3aKoG9W+fiUokkTOiesLgLsVd1+Ges7e8bboUhhSjxOGl
         9kHoipCwo0IXm+FCyDX/mPAFpCq2xd7nK/D6NTvHE1sZ5wq+b175intjUpaI1HdvEl
         2j085o1vufbaOiZpP4GiibCdVnHSzFRBHSwTkC+jyoliyLiq/k7NoNxhTbBxzRWdE7
         NUbzWCQbFQDpQ==
Date:   Fri, 14 Apr 2023 17:41:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/2] check: _check_filesystems for errors even if test
 failed
Message-ID: <20230415004131.GC360885@frogsfrogsfrogs>
References: <20230414221133.3431400-1-leah.rumancik@gmail.com>
 <20230414221133.3431400-2-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414221133.3431400-2-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 14, 2023 at 03:11:33PM -0700, Leah Rumancik wrote:
> Previously, we would only run _check_filesystems to ensure that a test
> that appeared to pass did not have any filesystem corruption. However,
> in _check_filesystems, we also repair any errors found in the filesystem.
> Let's do this even if we already know the test failed so that subsequent
> tests aren't affected.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  check | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/check b/check
> index befbf465..c18f02ca 100755
> --- a/check
> +++ b/check
> @@ -972,6 +972,7 @@ function run_section()
>  			# Even though we failed, there may be something interesting in
>  			# dmesg which can help debugging.
>  			_check_dmesg
> +			(_adjust_oom_score 250; _check_filesystems)

Seeing as the test failed, do we care about the state of the scratch fs?
Would it be sufficient only to clean up the test fs to avoid cascading
damage?

(Asking as someone who knows how impactful slow filesystem checking can
be on fstests runtimes... ;))

--D

>  			tc_status="fail"
>  		else
>  			# The test apparently passed, so check for corruption
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
