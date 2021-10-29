Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1744C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F717611C8
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 15:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhJ2Pnf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhJ2Pnf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Oct 2021 11:43:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3A061165;
        Fri, 29 Oct 2021 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635522066;
        bh=nxZLTV6B9/jYNmeEWJ4vv8phqqK4t29MgtNujG2txdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xtqw//TJqdZMN1YRlHOvH0aIk2CjMslorN7fUqrh5NZeNsb5NZ1+TzSoRnPu513da
         ZXb1GPkb1ZCPJff1rE34f4cfSc+diJ3K0yIzq6ON3CCAolv/qoM20/b/znRAfqlQVt
         G0WF8TsLguaoKhSi4WkqF0+RQhjMr7SozVD00N7vsbnA2psIvVDZ4047A3VDUTqpUF
         GsBKtf/BHHZcKRo7ao13bgAd7s8OROVkonUFwR4oGYKRLT84/w3cmOpTKdvEVF6CV2
         zNM4ai/zt9denFdPlQ/aR8PcyBUosYD3Vl/vQCcAhTgZ1uNfitCGC7A3Nn1+ohv5Wd
         2JnX8lIm3EF2w==
Date:   Fri, 29 Oct 2021 08:41:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] generic: fix description or typo in head comment
Message-ID: <20211029154106.GR24282@magnolia>
References: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
 <20211029065943.3556529-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029065943.3556529-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 29, 2021 at 02:59:42PM +0800, Shiyang Ruan wrote:
> 1. update description according to the current testcase
> 2. "an the end -> at the end"
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tests/generic/155 | 3 +--
>  tests/generic/269 | 2 +-
>  tests/generic/270 | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/155 b/tests/generic/155
> index 2fe7894a..13292fbb 100755
> --- a/tests/generic/155
> +++ b/tests/generic/155
> @@ -13,8 +13,7 @@
>  #   - CoW all the rest of the blocks of the copies
>  #   - Compare fs block usage to (2), (1), and (0)
>  #
> -# The main difference from 834 is that we use zero range, directio, and
> -# mmap to mix things up a bit.
> +# The main difference from No. 154 is that we use zero range to execute CoW.

'The main difference from generic/154 is that...'

>  #
>  . ./common/preamble
>  _begin_fstest auto quick clone zero
> diff --git a/tests/generic/269 b/tests/generic/269
> index d78b7463..60a07b44 100755
> --- a/tests/generic/269
> +++ b/tests/generic/269
> @@ -4,7 +4,7 @@
>  #
>  # FSQA Test No. 269
>  #
> -# Run fsstress and ENSPC hitters in parallel, check fs consistency an the end
> +# Run fsstress and ENSPC hitters in parallel, check fs consistency at the end

ENOSPC, not ENSPC

>  #
>  . ./common/preamble
>  _begin_fstest auto rw prealloc ioctl enospc stress
> diff --git a/tests/generic/270 b/tests/generic/270
> index 1fb5795a..35141e05 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -5,7 +5,7 @@
>  # FSQA Test No. 270
>  #
>  # Run fsstress and ENSPC hitters in parallel, check quota and 
> -# fs consistency an the end
> +# fs consistency at the end

This looks good to me, assuming the lack of a period at the end of the
sentence doesn't bother anyone.  Apparently that's the new style in this
'texting' thing I keep hearing about. ;)

--D

>  #
>  . ./common/preamble
>  _begin_fstest auto quota rw prealloc ioctl enospc stress
> -- 
> 2.33.0
> 
> 
> 
