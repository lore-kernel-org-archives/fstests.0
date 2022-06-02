Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B0AC43334
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiFBAxJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiFBAxI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:53:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C71131
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFE94B81BA5
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 00:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46390C385A5;
        Thu,  2 Jun 2022 00:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654131185;
        bh=7zivtI2qgUzSR2/EygqsYYLr5gTb8oH8Vms+Fshc86I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LD31LCCUvHL9II6aIEJjmtgMDgQZrEuTd0b+HUwKE0Iv8IV9PCF6tPrdr01i4UlQL
         7f/wU8WH9TZoXHXaSDR1TPIB+PN238X4r6qdoqgjOdvjvVOs+8WyQza+oglIuC+SSG
         iDqGJu5Fy8mOM3O+HZejAW5/J2KOsGw1T6OSQbSSxSyBcWs4ecU2NwYEOBVDR2tC67
         psrc2fjm5iwj1C19R4a7NDGdYBm6bFHRe7bDTc3dEWswmIE7IyLXZYxoXvJn8/zAKN
         UAWP1vfsAGqo0nKVKAIxPiYgF71pOEDvnNjNujlky/CisOEHVwTt/NUeZeVRRXLtgb
         yZwyIcZNTIvPA==
Date:   Wed, 1 Jun 2022 17:53:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 7/8] xfs/167: adjust runtime with TIME_FACTOR
Message-ID: <YpgJ8B6ykz9ZRZUj@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-8-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-8-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:25AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> xfs/167 takes between 6 and 10 minutes to run on my SSD based test
> machines. It's running 50 loops of a unwritten extent conversion
> test program whilst running a heavy fsstress workload in the
> background. This does not need to run for 10 minutes on every auto
> group regression test run. Shorten it to loop 5 * TIME_FACTOR
> so that normal runtime drops to something sane but can still be
> easily ramped up if soak/stress testing is being run.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/167 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/xfs/167 b/tests/xfs/167
> index 5f985010..15bb1854 100755
> --- a/tests/xfs/167
> +++ b/tests/xfs/167
> @@ -47,13 +47,11 @@ _require_fs_space $SCRATCH_MNT 10485760
>  
>  TEST_FILE=$SCRATCH_MNT/test_file
>  TEST_PROG=$here/src/unwritten_sync
> -LOOPS=50
> +LOOPS=$((5 * $TIME_FACTOR))
>  
>  echo "*** test unwritten extent conversion under heavy I/O"
> -
> -workout
> -
>  rm -f $TEST_FILE
> +workout
>  $TEST_PROG $LOOPS $TEST_FILE
>  
>  echo "     *** test done"
> -- 
> 2.35.1
> 
