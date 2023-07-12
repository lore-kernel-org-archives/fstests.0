Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E02EB64DA
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 16:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGLQcV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGLQcU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 12:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F507EA
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 09:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80EF6182E
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 16:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCCEC433C8;
        Wed, 12 Jul 2023 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179539;
        bh=D+R2gdtuFptHsJzPQB3pdB6TgevMzj6dFvpQQ3qieHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLNbv7IgkLthfJJbu3JktE66GTuUTggdEwUmiIs9hOC0sPeDtOfFH2Ey9FuWSSf9I
         L6M8lRaXTQe+Bu4AmyTXo/8SWn02A77a84rgqQ9/SyWtrOMVSMusHxnNBE8vSSWcU8
         PMRTfpNaAuNqT7j9C1GjmKtLXa3h69XZwyOkVzxmPzMXFQ7YFNPPKSdCEw/bDw/FmX
         9OhqKnaxdIzA9akReJ8sqCsXhjY5QhOWG4InpwUfPDIK4Gf6RFpS1F9N3hjW6jSY5g
         yzSCycvFJ1YLHVCd6txrfods37VR8FS17U8x49wk42ASJF45YFqMNX1Ms+2W6N2kO4
         l85A2BhjEaV/g==
Date:   Wed, 12 Jul 2023 09:32:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: cleanup old .kmemleak files
Message-ID: <20230712163218.GD11442@frogsfrogsfrogs>
References: <20230712145101.4286-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712145101.4286-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 12, 2023 at 03:51:01PM +0100, Luís Henriques wrote:
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
> diff --git a/common/rc b/common/rc
> index 741579af82d2..6aa6be704e51 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4433,6 +4433,8 @@ _capture_kmemleak()
>  	local kern_knob="$DEBUGFS_MNT/kmemleak"
>  	local leak_file="$1"
>  
> +	rm -f "$leak_file"

Some callers of this helper specify a device file when all they want to
do is clear the old kmemleak report data:

$ git grep -w _capture_kmemleak
common/rc:4490:_capture_kmemleak()
common/rc:4535:         _capture_kmemleak /dev/null
common/rc:4555:         _capture_kmemleak /dev/null
common/rc:4560: _capture_kmemleak "$leak_file"

The simplest fix here I think would be:

	# Some callers pass in /dev/null when they want to clear the
	# kernel's leak report file and do not care what was in that.
	test -f "$leak_file" && rm -f "$leak_file"

--D

> +
>  	# Tell the kernel to scan for memory leaks.  Apparently the write
>  	# returns before the scan is complete, so do it twice in the hopes
>  	# that twice is enough to capture all the leaks.
