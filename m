Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077EFEB64DD
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 22:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjGLWGf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWGe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 18:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870179B
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 15:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25C6C6195D
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 22:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829ADC433C7;
        Wed, 12 Jul 2023 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689199592;
        bh=QteHI8HN0dD/5xFNJYwaFD/79KZ9wIVRUfPtkkvSuYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDKcLzszSYdWoFJvzcQwBgJw1f80Liyw9ITbXqBsco529SSyQD3tDE/tvgRRtmfpb
         iljw821AK12j5wX3XyJpkpThx4CRbrESJTiaJ8Y/MxAUQ5KEKC7CPMOu7FMmWOTXPX
         Q4D3senCPzkY+CslGpJx02vI3gHVuKLXYeuMgsc6PCsYXRl0z/DNQYVSS+iPhX/bZO
         uM1jtqNpNyMcGdfMInRVCTGw23moUY+7kOY/XUjYxgDMcP1RDsrXbmZWPPtPULm/6a
         9imZ0qA1MZiMzatPUMiwkgA0co3Kds9zzLignFIWDj4CSViBYdsUy/CaeJmcmrW3fN
         fght2ErGCcupA==
Date:   Wed, 12 Jul 2023 15:06:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: cleanup old .kmemleak files
Message-ID: <20230712220631.GF11442@frogsfrogsfrogs>
References: <20230712145101.4286-1-lhenriques@suse.de>
 <20230712163500.5871-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712163500.5871-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 12, 2023 at 05:35:00PM +0100, Luís Henriques wrote:
> I've spent a non-negligible amount of time looking into a kmemleak that
> didn't exist in the code I was testing because there was an old .kmemleak
> file in the results directory.  I don't think this is an intended behaviour,
> so I'm proposing to remove these files everytime we capture the result of a
> new scan.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  common/rc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Changes since v1:
> I realised that _capture_kmemleak() is called with /dev/null as argument, so
> this version is probably better.
> 
> diff --git a/common/rc b/common/rc
> index 741579af82d2..6850889e815e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4433,6 +4433,8 @@ _capture_kmemleak()
>  	local kern_knob="$DEBUGFS_MNT/kmemleak"
>  	local leak_file="$1"
>  
> +	[ -f "$leak_file" ] && rm -f "$leak_file"

I was hoping you'd incorporate the comment explaining why the test uses
-f and not -e.

--D

> +
>  	# Tell the kernel to scan for memory leaks.  Apparently the write
>  	# returns before the scan is complete, so do it twice in the hopes
>  	# that twice is enough to capture all the leaks.
