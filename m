Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD843C11F67
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Jun 2021 21:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22CD61D04
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Jun 2021 21:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhF2VKc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Jun 2021 17:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232602AbhF2VKb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 Jun 2021 17:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E36461D04;
        Tue, 29 Jun 2021 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625000884;
        bh=xuz0Nlfzbuvj/dfBUaDHy/qXf7/PWdJUUfZYmIbRYR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIgg+W1Z/+6cGvCxW6lbzSru/FqOXp2dsnpdRqKmgPNrganSq0eYKr7KI7UHKkIzi
         g3NWsO1kJoExjqbtbUI7xbazRA7WtufBiHoKcq7u2Iae0Py0RmQvrdwmhldvhWy1ee
         ff9Iq6eno3iVndXZxOTAEnvto6t0ib+J3BUcwP2NjGZZMpFHaDN5ROBjyMt7WZzk0y
         yA7BMgE+n/GbhhTGz8QZsudR4QXJrhJ373qLYhdm4qE0N7dMwTB5nyk1NK5Me6USA7
         GXPR3uHI0y92WujKRhoZrNv7xClclTBvCdiIbBMralALc6J9inLxKJWVyKqPAAfKhK
         szKJHlmblzmXg==
Date:   Tue, 29 Jun 2021 14:08:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix g/019 cleanup
Message-ID: <20210629210803.GE13767@locust>
References: <20210629005500.1687804-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629005500.1687804-1-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 29, 2021 at 10:55:00AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> This never worked properly and the failure was exposed by the recent
> rework of the fstest setup infrastructure.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks fine, and I have further cleanups for this test :P
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/019 | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tests/generic/019 b/tests/generic/019
> index 640c96ae..bd234815 100755
> --- a/tests/generic/019
> +++ b/tests/generic/019
> @@ -53,7 +53,6 @@ stop_fail_scratch_dev()
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -    poweron_scratch_dev
>      disallow_fail_make_request
>      rm -f $tmp.*
>  }
> @@ -156,5 +155,4 @@ _scratch_mount
>  allow_fail_make_request
>  _workout
>  status=$?
> -disallow_fail_make_request
>  exit
> -- 
> 2.31.1
> 
