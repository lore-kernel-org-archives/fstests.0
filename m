Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5ADC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGTS3d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiGTS3c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 14:29:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810AE71709
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 11:29:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E577CB8218B
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 18:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E01EC341CA;
        Wed, 20 Jul 2022 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658341768;
        bh=Zn1P4fTODYLxfZsyz+5f42tX2q7FtwcY+weovQh/bt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fK3jXs+KO63CvimQRv6Tzicw4EOxEUPsGr2gTRJV7poOL6hg4ehWzFiSdbUe4bYj5
         YIAFkkLGnHKiUfPn+uzQxj6u/faMlK+Zbh1ELLt+It24FWcL5vYN5YEyeBf3o6ppwg
         bpt3RqLo3t8ZA1w3/T82v9AlR3qstt7RkNeXDlZsXrFFdoNG5+LQQ1Ww2Qy+gCoAF1
         AfpVEOHZJ5nFv67RoLcYY06z2Pt7n/xBgg8vm2MZkUD26g+nOELEXLgE2elil+FFBl
         c+/zMWrGP/asxNCnRlnZmUN71lgDtO0wNoCxYDacNL37c6Ee7frIkAm6zVfq70AlfW
         8CaIG3yEnHYxg==
Date:   Wed, 20 Jul 2022 11:29:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] generic/475: skip test when using an external log
 device
Message-ID: <YthJh1RPO6nbgfPv@magnolia>
References: <20220720164356.4078789-1-tytso@mit.edu>
 <20220720164356.4078789-5-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720164356.4078789-5-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 20, 2022 at 12:43:56PM -0400, Theodore Ts'o wrote:
> This test tests log recovery by kicking off fstress on the scratch fs,
> then switching out the underlying the device with dm-error to see what
> happens when the disk goes down.  But when there is an external log
> device writes to the log device still succeed, while writes to the
> rest of the file system fail, and this leads to file system
> corruption.  So skip this test when there is an external log.

Hm, could you review the congruent operation length series[1], please?

Once that's done, I can move on to the next push, which is fixing up
dmerror[2] and fail-make-request[3] to handle external devices:

[1] https://lore.kernel.org/fstests/165826663647.3249494.13640199673218669145.stgit@magnolia/T/#t
[2] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=dmerror-on-rt-devices
[3] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fix-fail-make-reqest

--D

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/475 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/475 b/tests/generic/475
> index c426402e..43c26303 100755
> --- a/tests/generic/475
> +++ b/tests/generic/475
> @@ -34,6 +34,10 @@ _require_scratch
>  _require_dm_target error
>  _require_command "$KILLALL_PROG" "killall"
>  
> +if test "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ; then
> +    _notrun "Cannot have external log device"
> +fi
> +
>  echo "Silence is golden."
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> -- 
> 2.31.0
> 
