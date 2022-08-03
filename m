Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE0EC19F28
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 04:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiHCEgh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEgh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 00:36:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133146DA8
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 21:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3390CE2242
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 04:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D07CC433C1;
        Wed,  3 Aug 2022 04:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659501393;
        bh=Uz3fkjeCNsrhdRy4JgW/DKp6r9Zy6qtVJ8EslddETn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr20Izu102MiVIjtt7g+0oeBMhuWQRkBvNkqKGHBuqTVbf3iVsbpsXPWFABO+QJFS
         Lx41LCYJQPcLpbfzoyBAInxso0GofmtkVcod9OK9xbn4/IlBPxd/VK0GfhZRQ7MvNE
         fQZw/25fdPfT3IAgIDz02vaqLdhiL1qkhlR30xKm3alBytB2nQyxcaibJmFzm7LPHM
         rspulxxBtM/FFo2mG5VeLmVgy12e5q9MGrVg1OwG6l2nvZDP7ztg0FY0ZysqF2W1ac
         cuV+YhwKrAxmUVzjOm7d7xa9p82JkQpCMuUgAXpcM9EvLPFoApSmdRhIGm85XD/K0R
         aBXhUhLwwRb9w==
Date:   Tue, 2 Aug 2022 21:36:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add more dmerror related test cases into eio
 group
Message-ID: <Yun7UCM+uBHrrgt5@magnolia>
References: <20220731044650.3775-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731044650.3775-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jul 31, 2022 at 12:46:50PM +0800, Zorro Lang wrote:
> The g/484, g/628 and g/629 calls _dmerror_init and load error table
> for testing, better to count them in eio test group, then we won't
> miss them when we want to run all eio related cases.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Looks correct to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/484 | 2 +-
>  tests/generic/628 | 2 +-
>  tests/generic/629 | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/484 b/tests/generic/484
> index 40e83cbd..4f413352 100755
> --- a/tests/generic/484
> +++ b/tests/generic/484
> @@ -15,7 +15,7 @@
>  #    buffer: record blockdev write errors in super_block that it backs
>  
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick eio
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/628 b/tests/generic/628
> index 7dc6dfcd..380a7f0b 100755
> --- a/tests/generic/628
> +++ b/tests/generic/628
> @@ -11,7 +11,7 @@
>  # 5ffce3cc22a0 ("xfs: force the log after remapping a synchronous-writes file")
>  
>  . ./common/preamble
> -_begin_fstest auto quick rw clone
> +_begin_fstest auto quick rw clone eio
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/629 b/tests/generic/629
> index f501555e..dbd7ada8 100755
> --- a/tests/generic/629
> +++ b/tests/generic/629
> @@ -11,7 +11,7 @@
>  # 5ffce3cc22a0 ("xfs: force the log after remapping a synchronous-writes file")
>  
>  . ./common/preamble
> -_begin_fstest auto quick rw copy_range
> +_begin_fstest auto quick rw copy_range eio
>  
>  # Override the default cleanup function.
>  _cleanup()
> -- 
> 2.31.1
> 
