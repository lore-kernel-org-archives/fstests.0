Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F1FC7EE2D
	for <linux-fstests@archiver.kernel.org>; Tue, 23 May 2023 00:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjEWAk4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 May 2023 20:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjEWAGa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 May 2023 20:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418981BD6
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 16:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9AE56202B
        for <fstests@vger.kernel.org>; Mon, 22 May 2023 23:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F43DC433EF;
        Mon, 22 May 2023 23:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684799149;
        bh=ES5USFzoCkghLAdyZjwNy4vZuUZIKHrc+tVq2hhToqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFrxGDFWW/nELpK2XwnLpmg9EUMsMArBgNc0nWfmsL953iKrsa7YjNp968qomvFzv
         6JE/Uta5tbeguSgJ9zmh7D8314U8E6f4mLXvJeZJ6jLIjpDXCz/un+NK0J5lOj9E2k
         b01xa1bVS1EPNcJDWqgGEDTxzKCZeaNBku6q/n95a7ARhqFKKGsqoJzyEAEI5oc6jj
         Jiab81lKyO/QeG4dguMU3kGzz98XQMjrSzJQkFkyeorBTqYqazwz9YVebjSl87okPu
         xX1/N7oD7nNuyXEhy90pFBjeoWbKeEdEOQby6aIF2ira5A+11RweQaWIwZZjFROm5M
         VRpG68yp37W6g==
Date:   Mon, 22 May 2023 16:45:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fuzzy: skip online scrub and health checks if not
 supported
Message-ID: <20230522234548.GB11607@frogsfrogsfrogs>
References: <20230522212712.97846-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522212712.97846-1-ailiop@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 22, 2023 at 11:27:12PM +0200, Anthony Iliopoulos wrote:
> Commit a27e6e6f4c18 introduced xfs health checking on no-repair fuzz,
> which in turn requires scrub to be run before that. The health checks
> are done only if scrub returns with an error (which is expected as an
> indication that fuzzed metadata errors were picked up), but the code
> does not discern between xfs_scrub returning an error because of
> uncorrected metadata vs failing because the kernel does not support
> scrub at all.
> 
> This causes all tests that do fuzzing with no-repair strategy to fail on
> kernels compiled without online scrub support (CONFIG_XFS_ONLINE_SCRUB).
> 
> Skip scrub and health checks altogether, if the kernel does not support
> it, since the tests are still valuable.
> 
> Fixes: a27e6e6f4c18 ("common: check xfs health after doing an online scrub")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

At first I thought "Doesn't the _require_scrub in (say) xfs/466 prevent
this test from running at all?"  But then I remembered that helper only
checks for the existence of the xfs_scrub program; it doesn't actually
verify that the kernel works.

I probably need to do more work making sure that the
online/offline/bothrepair tests actually go away if the kernel support
isn't there.  In the meantime, I think this is correct so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> ---
>  common/fuzzy | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/common/fuzzy b/common/fuzzy
> index 4365e7343e92..a78a354142df 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -422,6 +422,12 @@ __scratch_xfs_fuzz_field_norepair() {
>  		return 1
>  	fi
>  
> +	# Skip scrub and health check if scrub is not supported
> +	if ! _supports_xfs_scrub $SCRATCH_MNT $SCRATCH_DEV; then
> +		__scratch_xfs_fuzz_unmount
> +		return 0
> +	fi
> +
>  	# Make sure online scrub will catch whatever we fuzzed
>  	__fuzz_notify "++ Detect fuzzed field (online)"
>  	_scratch_scrub -n -a 1 -e continue 2>&1
> -- 
> 2.40.0
> 
