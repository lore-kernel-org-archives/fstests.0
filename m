Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03093C001B0
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 14:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjGMOE4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 10:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjGMOEz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 10:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDF21FF7
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 07:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C0FF61255
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 14:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E925FC433C8;
        Thu, 13 Jul 2023 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689257094;
        bh=c1UPMlnzteDRjTpwh4VHkm9oa4dwufpJNvdoT3cpOAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxL5kZ0SsTGsuDy3GQlPiVB4eLA+LpPhDse5P1MDhlaepdQEx8mKuMzpAAPtld/YJ
         YLNt9lDvd9kPhK59H6fWitgnXyjgfTVJtDPUFveTjhIs8a6h6g0FPeuvX7ztHayVgR
         B+kBKZDeZ6upGMUEGDjNnFFe40uALUJyqfdzy/1iSzTcVl7qJy4dexpHxEZ0k4SuBz
         qvyqxC8m/a0FqWrAzit+w/BNhzAm9UIN0/DQOd/wKrXUFCgzG8EhuCvnv+KeFQHFst
         wTookmvT8DjzXGY8/X9bT6A2WN5D8W45w7CUmrB+f7Gebx2HwnmyDumMWBgWLX2kQq
         VMJ+gBANMfR6Q==
Date:   Thu, 13 Jul 2023 07:04:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] common/rc: cleanup old .kmemleak files
Message-ID: <20230713140453.GI11442@frogsfrogsfrogs>
References: <20230713082631.10666-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713082631.10666-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 13, 2023 at 09:26:31AM +0100, Luís Henriques wrote:
> I've spent a non-negligible amount of time looking into a kmemleak that
> didn't exist in the code I was testing because there was an old .kmemleak
> file in the results directory.  I don't think this is an intended behaviour,
> so I'm proposing to remove these files everytime we capture the result of a
> new scan.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>

Looks good now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Changes since v2:
> Incorporated comment from Darrick to explain the usage of '-f' in the test
> 
> Changes since v1:
> I realised that _capture_kmemleak() is called with /dev/null as argument, so
> this version is probably better.
> 
> diff --git a/common/rc b/common/rc
> index 741579af82d2..5c4429ed0425 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4433,6 +4433,10 @@ _capture_kmemleak()
>  	local kern_knob="$DEBUGFS_MNT/kmemleak"
>  	local leak_file="$1"
>  
> +	# Some callers pass in /dev/null when they want to clear the
> +	# kernel's leak report file and do not care what was in that.
> +	[ -f "$leak_file" ] && rm -f "$leak_file"
> +
>  	# Tell the kernel to scan for memory leaks.  Apparently the write
>  	# returns before the scan is complete, so do it twice in the hopes
>  	# that twice is enough to capture all the leaks.
