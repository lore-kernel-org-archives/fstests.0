Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81903C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5553060FC0
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 16:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhJ3RAx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 30 Oct 2021 13:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhJ3RAx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 30 Oct 2021 13:00:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0344060C4B;
        Sat, 30 Oct 2021 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635613103;
        bh=LEFkl8pxu+/a5M8LmiMUar+IdW1cJbemG3rie/WKDVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ryc+5s1qhvEn1nsTm53k8+WJ4sVFO/S6TFlcA6bELokW1gtWIcuQsUDA64WcEfw7E
         SQ0N2p2xmTHqdEzAA3mGZgbvARg7jPSRHQiDgxVAi63zHUWrdewVOc3javYcaP19zX
         pJZFgAO9lvQxcoii3erIujLOJEBvgstJGhXkz4tDyfn7RPxYYTEvXRNlldy5voCaL6
         dmpHKZOYjEDD+chhjFO4HyXonsPyLRaHxLh0IXOcjMh0pCbpkrsgBE8YJxje18UKnY
         XpjBwwARvC02zc6T1PntINuSkVTCJNcWyhnj+L4jeAVK5SWzFFL/zDplncB24OQFKw
         dXPyw//v0zEEw==
Date:   Sat, 30 Oct 2021 09:58:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/3] generic: fix description or typo in head comment
Message-ID: <20211030165822.GU24282@magnolia>
References: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
 <20211030083433.3616711-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030083433.3616711-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Oct 30, 2021 at 04:34:32PM +0800, Shiyang Ruan wrote:
> 1. update description according to the current testcase
> 2. "ENSPC" -> "ENOSPC" ,"an the end -> at the end"
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Yay, thanks for sending in these cleanups! :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/155 | 3 +--
>  tests/generic/269 | 2 +-
>  tests/generic/270 | 4 ++--
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/155 b/tests/generic/155
> index 2fe7894a..1ee04c67 100755
> --- a/tests/generic/155
> +++ b/tests/generic/155
> @@ -13,8 +13,7 @@
>  #   - CoW all the rest of the blocks of the copies
>  #   - Compare fs block usage to (2), (1), and (0)
>  #
> -# The main difference from 834 is that we use zero range, directio, and
> -# mmap to mix things up a bit.
> +# The main difference from generic/154 is that we use zero range to execute CoW.
>  #
>  . ./common/preamble
>  _begin_fstest auto quick clone zero
> diff --git a/tests/generic/269 b/tests/generic/269
> index d78b7463..838e696d 100755
> --- a/tests/generic/269
> +++ b/tests/generic/269
> @@ -4,7 +4,7 @@
>  #
>  # FSQA Test No. 269
>  #
> -# Run fsstress and ENSPC hitters in parallel, check fs consistency an the end
> +# Run fsstress and ENOSPC hitters in parallel, check fs consistency at the end
>  #
>  . ./common/preamble
>  _begin_fstest auto rw prealloc ioctl enospc stress
> diff --git a/tests/generic/270 b/tests/generic/270
> index 1fb5795a..8a6a2822 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -4,8 +4,8 @@
>  #
>  # FSQA Test No. 270
>  #
> -# Run fsstress and ENSPC hitters in parallel, check quota and 
> -# fs consistency an the end
> +# Run fsstress and ENOSPC hitters in parallel, check quota and
> +# fs consistency at the end
>  #
>  . ./common/preamble
>  _begin_fstest auto quota rw prealloc ioctl enospc stress
> -- 
> 2.33.0
> 
> 
> 
