Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5D7C001DE
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Aug 2023 21:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjHDVRI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Aug 2023 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHDVRH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Aug 2023 17:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D247E43
        for <fstests@vger.kernel.org>; Fri,  4 Aug 2023 14:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A232620DB
        for <fstests@vger.kernel.org>; Fri,  4 Aug 2023 21:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C268C433C8;
        Fri,  4 Aug 2023 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691183825;
        bh=JEM7ArDUx23pLjLGlAd3MJurogqiTYWlsJ+gtT5b8mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFU42geeO6FQIww/7pDXjzmSnN3eBPOA/wTmmfbEqrEPrwzI6K4uAJ5KaIms6AX9k
         CzUKCrALUvPxk//LTRUGoMwL9MpmTYqnkCAbdCGUN8bH/ZgnUqpupwEH+dDW+HBWXQ
         ld9d9e4/WLl22LiBwszgUcSlEMfJ19kLFIpMea6J8RMVJXy47JurB/Sa6kHmEKBK8+
         xgb2DMOK4pcssxM5Dvu9zecwH8REwIuTYn16jWpi1W6RzUAz7C99xW94OgZP2DqTj0
         kJnMe40SKjqCBxLJkJ+dC99jZdVyrTUklUN+4xayFDIdQsOT7nUHlvDZY0BUOvVbEb
         kb23z19l+rt4Q==
Date:   Fri, 4 Aug 2023 14:17:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fsx: add missing -K in usage() and cleanup
Message-ID: <20230804211704.GM11340@frogsfrogsfrogs>
References: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 04, 2023 at 01:40:03PM +0800, Shiyang Ruan wrote:
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Yes, thank you, this is much more readable.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  ltp/fsx.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index ffa64cfa0..753c472f4 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2393,11 +2393,17 @@ void
>  usage(void)
>  {
>  	fprintf(stdout, "usage: %s",
> -		"fsx [-dknqxBEFJLOWZ][-A|-U] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
> +		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> +	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> +	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> +	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> +	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
> +	   [--replay-ops opsfile] [--record-ops[=opsfile]] [--duration seconds]\n\
> +	   ... fname\n\
>  	-b opnum: beginning operation number (default 1)\n\
>  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
>  	-d: debug output for all operations\n\
> -	-f flush and invalidate cache after I/O\n\
> +	-f: flush and invalidate cache after I/O\n\
>  	-g X: write character X instead of random generated data\n\
>  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
>  	-j logid: prefix debug log messsages with this id\n\
> @@ -2412,15 +2418,15 @@ usage(void)
>  	-s style: 1 gives smaller truncates (default 0)\n\
>  	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
>  	-w writebdy: 4096 would make writes page aligned (default 1)\n\
> -	-x: preallocate file space before starting, XFS only (default 0)\n\
> -	-y synchronize changes to a file\n"
> +	-x: preallocate file space before starting, XFS only\n\
> +	-y: synchronize changes to a file\n"
>  
>  #ifdef AIO
>  "	-A: Use the AIO system calls, -A excludes -U\n"
>  #endif
>  #ifdef URING
>  "	-U: Use the IO_URING system calls, -U excludes -A\n"
> - #endif
> +#endif
>  "	-D startingop: debug output starting at specified operation\n"
>  #ifdef HAVE_LINUX_FALLOC_H
>  "	-F: Do not use fallocate (preallocation) calls\n"
> @@ -2449,18 +2455,19 @@ usage(void)
>  #ifdef FIEXCHANGE_RANGE
>  "	-0: Do not use exchange range calls\n"
>  #endif
> -"	-L: fsxLite - no file creations & no file size changes\n\
> +"	-K: Do not use keep size\n\
> +	-L: fsxLite - no file creations & no file size changes\n\
>  	-N numops: total # operations to do (default infinity)\n\
>  	-O: use oplen (see -o flag) for every op (default random)\n\
> -	-P: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
> +	-P dirpath: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
>  	-S seed: for random # generator (default 1) 0 gets timestamp\n\
>  	-W: mapped write operations DISabled\n\
>  	-X: Read file and compare to good buffer after every operation.\n\
> -        -R: read() system calls only (mapped reads disabled)\n\
> -        -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
> +	-R: read() system calls only (mapped reads disabled)\n\
> +	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
>  	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
>  	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
> -	--duration=seconds: ignore any -N setting and run for this many seconds\n\
> +	--duration seconds: ignore any -N setting and run for this many seconds\n\
>  	fname: this filename is REQUIRED (no default)\n");
>  	exit(90);
>  }
> -- 
> 2.41.0
> 
