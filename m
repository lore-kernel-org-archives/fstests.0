Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F967C07E96
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 00:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBF361CB3
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 00:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGGA1h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 6 Jul 2021 20:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGGA1g (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Jul 2021 20:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85A9561C91;
        Wed,  7 Jul 2021 00:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625617497;
        bh=+z2R1A4i4zWEVn9oC3RHRzo7AoUURa9t96kJ5rU2fnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1wqVG2xoQ1xT3+BS/nWdfcehhUPRdGtw02fqdT6j29FDS46tHEXr4HWANWEUXo4M
         bRne3ccZ5D2mokuTZIILeUMK+sirBV94/f/ovxvYcXdRDMjK46M6fKDQWIXuFZ0Mld
         yrDbtHDeXPJ7IFGNfEj8pybdp59AsBhnR9OVlBghRtEB62AgRFWJ2NnkVIBrQ/tqG/
         NwbUrREQIDkoQMNcH8OZAxi2/WWmuhRUJkw9nmPE3mG3LurRAPNUlr6OHhoF8KK04U
         FhgTvr76VU2fAEtfOO15Ox1GD4xiCoCjLdZZJ4cFipgRRKiqgbglLLc1pDp8NiYDRa
         17fEXDButqv4g==
Date:   Tue, 6 Jul 2021 17:24:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] Test seeks from LLONG_MIN
Message-ID: <20210707002457.GB11634@locust>
References: <YOS5trAuJN+ho+Is@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOS5trAuJN+ho+Is@casper.infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 06, 2021 at 09:14:46PM +0100, Matthew Wilcox wrote:
> We don't currently test seeking from LLONG_MIN, which apparently can
> produce an UBSAN warning, although I've been unable to reproduce that.
> In any case, it's a good corner case to test and straightforward to add.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Seems reasonable to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index cb036f7b..76587b7f 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -395,8 +395,12 @@ static int test18(int fd, int testnum)
>  	int ret = 0;
>  
>  	/* file size doesn't matter in this test, set to 0 */
> +	ftruncate(fd, 0);
> +
>  	ret += do_lseek(testnum, 1, fd, 0, SEEK_HOLE, -1, -1);
>  	ret += do_lseek(testnum, 2, fd, 0, SEEK_DATA, -1, -1);
> +	ret += do_lseek(testnum, 3, fd, 0, SEEK_HOLE, LLONG_MIN, -1);
> +	ret += do_lseek(testnum, 4, fd, 0, SEEK_DATA, LLONG_MIN, -1);
>  
>  	return ret;
>  }
> 
