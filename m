Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F1CC6FD1F
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Mar 2023 03:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjCYDpn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Mar 2023 23:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDpm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Mar 2023 23:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9950A9006
        for <fstests@vger.kernel.org>; Fri, 24 Mar 2023 20:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D6C962D3E
        for <fstests@vger.kernel.org>; Sat, 25 Mar 2023 03:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFF2C433EF;
        Sat, 25 Mar 2023 03:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679715939;
        bh=P0s/ko49cjhEgtgTo/MlPhw6rYj5yWXWYdpQFtEroIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdwduDQr7fFT6Yn5+4sPJtKcfNepOgmathZDHoDKCz75rkT3qFR8wchY2TJY9C5o6
         Fseu++CyVsM9FpPKEapeqtvcqSqffOqp95mtB1qBi44wsls3U+UvQmweV+1xdLcox3
         iUi+OImiZwrXFIAgEZie80m5whAMApRGGw0TSI0D/d8n/bKrZ6piBTFsEL8uFzyhh4
         3v8fuHJcqjOKDDh0Pnr6JoMVsm/m98j+NYmGgSOiamd9riWtzm55H29lvyiYhsGkjE
         flhH8Ws+of+QTWzo2NoKeQjMIRq1+TxgVQV/Mlj8oL2HpEPBVDO0mg13kd4eRpY1Nu
         t//V7VfnceENQ==
Date:   Fri, 24 Mar 2023 20:45:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Khem Raj <raj.khem@gmail.com>
Cc:     fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] m4: Check for FTW_ACTIONRETVAL along with nftw
Message-ID: <20230325034539.GA16209@frogsfrogsfrogs>
References: <20230325012858.587801-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325012858.587801-1-raj.khem@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 24, 2023 at 06:28:58PM -0700, Khem Raj wrote:
> FTW_ACTIONRETVAL is glibc specific extention which is used to implement
> xfsfind but it may not be available on other C library implementations on Linux
> e.g. musl. Therefore ensure that these defines are available before declaring
> nftw() to be usable
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Zorro Lang <zlang@redhat.com>
> ---
>  m4/package_libcdev.m4 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> index b41c087b..7f731044 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -132,7 +132,7 @@ AC_DEFUN([AC_HAVE_NFTW],
>  #include <stddef.h>
>  #include <ftw.h>
>      ]], [[
> -         nftw("/", (int (*)(const char *, const struct stat *, int, struct FTW *))1, 0, 0);
> +         nftw("/", (int (*)(const char *, const struct stat *, int, struct FTW *))1, 0, FTW_ACTIONRETVAL);

Seems fine, though xfsfind.c only uses FTW_CONTINUE and FTW_STOP, so
perhaps it'd better to modify the program not to use FTW_ACTIONRETVAL?

OTOH I'm not /that/ keen on using fuzzing xfs from musl so I'll add this
to my backlog and in the meantime

Looks good to me,
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

>      ]])],[have_nftw=yes
>         AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>      AC_SUBST(have_nftw)
> -- 
> 2.40.0
> 
