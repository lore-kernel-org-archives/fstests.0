Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04926C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 15:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245136AbiEPP3R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiEPP3Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 11:29:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00E839BAD
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 08:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8BF8B8121B
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 15:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6748BC385AA;
        Mon, 16 May 2022 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652714953;
        bh=/dvno9+OFUO0BeqH2ss2Vrxw9dxWks4HZ1giJw266rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4OpkImchgttraKIqaM8KpLDF/O8yDw7QMyetPtSW9tdA5+3QKiFS4P2mjhEbztv/
         e7ol21hsvnmvmmXRItNDdllBcZtZBeU0mALnQNgLWBYMKBbhI8cf1HAl6nw5OyE1t/
         BP98E4cHW+MJy3CVYkpAWupqPDZLC3pKDORHZ0Suq/+E1KD8KzKfFCq5FylWlOEd1Y
         /4FtQgEOxQvu82JMZQxJqUYGTQad+iaY1eAQNoEMkbbzAYIv008KSVn9lUuA8wBJwd
         rCQcVvaPgTnRjjLP25ik0km0mnRkUlIDwFUarLwrwbhlcItp4pW6Zks+C3FLgrbz5J
         JQgEEN0w5wdaA==
Date:   Mon, 16 May 2022 08:29:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/348: golden output is not correct
Message-ID: <YoJtyH6OnvDzVoDK@magnolia>
References: <20220516060807.1295102-1-david@fromorbit.com>
 <20220516060807.1295102-4-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516060807.1295102-4-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 04:08:07PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The output of xfs/348 encodes the observed behaviour at the time the
> test was written, not the correct behaviour that should occur.
> Recent improvements in verification checking in the upstream kernel
> (1eb70f54c445 "xfs: validate inode fork size against fork format")
> have resulted in the kernel having correct behaviour and now the
> test fails. Fix the test output to reflect correct behaviour.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Heh, I've long wondered (but never had the time) to go figure out why
more things weren't failing.  Thx for fixing the kernel.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/348.out | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/348.out b/tests/xfs/348.out
> index 0d407718..9130f42a 100644
> --- a/tests/xfs/348.out
> +++ b/tests/xfs/348.out
> @@ -108,7 +108,7 @@ would have junked entry "DATA" in directory PARENT_INO
>  would have junked entry "EMPTY" in directory PARENT_INO
>  would have junked entry "FIFO" in directory PARENT_INO
>  stat: 'SCRATCH_MNT/test/DIR' is a directory
> -stat: 'SCRATCH_MNT/test/DATA' is a directory
> +stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
>  stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
>  stat: cannot statx 'SCRATCH_MNT/test/SYMLINK': Structure needs cleaning
>  stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
> @@ -240,7 +240,7 @@ would have junked entry "DIR" in directory PARENT_INO
>  would have junked entry "EMPTY" in directory PARENT_INO
>  would have junked entry "FIFO" in directory PARENT_INO
>  stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning
> -stat: 'SCRATCH_MNT/test/DATA' is a symbolic link
> +stat: cannot statx 'SCRATCH_MNT/test/DATA': Structure needs cleaning
>  stat: cannot statx 'SCRATCH_MNT/test/EMPTY': Structure needs cleaning
>  stat: 'SCRATCH_MNT/test/SYMLINK' is a symbolic link
>  stat: cannot statx 'SCRATCH_MNT/test/CHRDEV': Structure needs cleaning
> -- 
> 2.35.1
> 
