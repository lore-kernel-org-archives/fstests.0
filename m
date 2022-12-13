Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B86EC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Dec 2022 05:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiLMFvP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Dec 2022 00:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiLMFvO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2022 00:51:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B021A22E
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 21:51:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B82C0B810D9
        for <fstests@vger.kernel.org>; Tue, 13 Dec 2022 05:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C5CC433D2;
        Tue, 13 Dec 2022 05:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670910671;
        bh=Y/Zkh+tnT+UhqNTU3GieBPVoKiJZJmGTDoWpPoSuKQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsNvQ1EMZx61FgY2lxml3g3l4e1/0gdYZb4OVqTyPKmo0B9azjrd2KDFcpSZnj13W
         Lo3FtRFaVwtzm8M2YaX1b6KlbuA4g1x9pAtUlB338BtoEPrd/RSQJ4lzBM7uB3ssI5
         rKwR4782fz2tM1xeAK0yuWUQIbwCaS0RaGBT8LIBKKYesd0+KrHH3GUGTMcFOjUslR
         QynFxKU6XMROya0zA+7Mxyxz1N0v9c0IIUv2IAjG0olRpFDhXmAyqVFfiAxAi9E1Po
         msbgSfJo+79l9RFWkl5Nw5CMoHwbqaA0Wr9FVpox5ld0xAwlOy6YS9DMpPW+mdI0en
         hw7qnE20n6NHw==
Date:   Mon, 12 Dec 2022 21:51:09 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] tests/generic/027: use c-style for loops
Message-ID: <Y5gSzdGm2et5E1r+@sol.localdomain>
References: <20221212230820.3466-1-ddiss@suse.de>
 <20221212230820.3466-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212230820.3466-2-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 13, 2022 at 12:08:19AM +0100, David Disseldorp wrote:
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  tests/generic/027 | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/generic/027 b/tests/generic/027
> index 47f1981d..002be120 100755
> --- a/tests/generic/027
> +++ b/tests/generic/027
> @@ -53,22 +53,18 @@ fi
>  
>  dir=$SCRATCH_MNT/testdir
>  echo -n "iteration" >>$seqres.full
> -i=1
> -while [ $i -le $loop ]; do
> +for ((i = 1; i < loop; i++)); do

This does one fewer iteration than before.

- Eric
