Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B75AC433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 02:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiETCAB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 22:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiETCAA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 22:00:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6428EBE88
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BD3CB829D8
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 01:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D125C385AA;
        Fri, 20 May 2022 01:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653011997;
        bh=Uws1OPktSHhn8IA4cUeqFh3SrKKw4xBl0NYWDTmh3VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrUPa7be9/Ws0RDI4ENv9ZVtGAtqjQewaXr6cZnZ0tJLebcI24z399Akv/6TSqvKX
         2LGY07fpVxbbEpejZGC6ZGVyuRlaHTIWwhlLhaS0N1Md9pJgm2sJ5yLM02mG1BKKp8
         uPvMkcu0jr4oE+dk/TddgNFgqsSb35aMoF9LIVbz0juUwyk08XXdqbfD4mdPPMDdZx
         FO11dhCKQizEKu+KAs/2s4doI9FuJGapSKuwYzorhLCMP/kMAmWnJK9PTtKkKHcjf8
         MYs5C37wxVs0ta3eTIn29mZFoDTWkMvwtynP4PuH/0sJKfkjmlNkSJafRCQRYgbhMy
         /pkL1Xr369BgQ==
Date:   Thu, 19 May 2022 18:59:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: tests should not source common/rc directly
Message-ID: <Yob2HJq6pu8ueqZx@magnolia>
References: <20220520012336.1542637-1-david@fromorbit.com>
 <20220520012336.1542637-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520012336.1542637-2-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 11:23:35AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> _begin_fstest() does this as every test needs it, so remove it from
> all the tests that source it a second time.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/btrfs/243   | 1 -
>  tests/btrfs/245   | 1 -
>  tests/ext4/053    | 1 -
>  tests/generic/644 | 1 -
>  tests/generic/645 | 1 -
>  tests/generic/647 | 1 -
>  tests/generic/677 | 1 -
>  tests/generic/678 | 1 -
>  tests/generic/679 | 1 -
>  tests/generic/690 | 1 -
>  10 files changed, 10 deletions(-)
> 
> diff --git a/tests/btrfs/243 b/tests/btrfs/243
> index 750b4323..09a63bcd 100755
> --- a/tests/btrfs/243
> +++ b/tests/btrfs/243
> @@ -20,7 +20,6 @@ _cleanup()
>  	rm -r -f $tmp.*
>  }
>  
> -. ./common/rc
>  . ./common/filter
>  . ./common/dmflakey
>  
> diff --git a/tests/btrfs/245 b/tests/btrfs/245
> index dadc8492..426aab1c 100755
> --- a/tests/btrfs/245
> +++ b/tests/btrfs/245
> @@ -11,7 +11,6 @@
>  _begin_fstest auto quick idmapped subvol
>  
>  # get standard environment, filters and checks
> -. ./common/rc
>  . ./common/filter
>  
>  # real QA test starts here
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index bf6e3f6b..187a2515 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -28,7 +28,6 @@ _cleanup()
>  }
>  
>  # get standard environment, filters and checks
> -. ./common/rc
>  . ./common/filter
>  . ./common/quota
>  
> diff --git a/tests/generic/644 b/tests/generic/644
> index edf9b03e..c48338d8 100755
> --- a/tests/generic/644
> +++ b/tests/generic/644
> @@ -10,7 +10,6 @@
>  _begin_fstest auto quick cap idmapped mount
>  
>  # get standard environment, filters and checks
> -. ./common/rc
>  . ./common/filter
>  
>  # real QA test starts here
> diff --git a/tests/generic/645 b/tests/generic/645
> index 74e0f589..556d2450 100755
> --- a/tests/generic/645
> +++ b/tests/generic/645
> @@ -10,7 +10,6 @@
>  _begin_fstest auto quick idmapped mount
>  
>  # get standard environment, filters and checks
> -. ./common/rc
>  . ./common/filter
>  
>  # real QA test starts here
> diff --git a/tests/generic/647 b/tests/generic/647
> index fa6edadc..8484fa8d 100755
> --- a/tests/generic/647
> +++ b/tests/generic/647
> @@ -18,7 +18,6 @@ _cleanup()
>  }
>  
>  # get standard environment, filters and checks
> -. ./common/rc
>  . ./common/filter
>  
>  # real QA test starts here
> diff --git a/tests/generic/677 b/tests/generic/677
> index 1d4eaa53..39af90a9 100755
> --- a/tests/generic/677
> +++ b/tests/generic/677
> @@ -18,7 +18,6 @@ _cleanup()
>  	rm -r -f $tmp.*
>  }
>  
> -. ./common/rc
>  . ./common/filter
>  . ./common/dmflakey
>  . ./common/punch
> diff --git a/tests/generic/678 b/tests/generic/678
> index 1c3cf6e3..3c3c05b7 100755
> --- a/tests/generic/678
> +++ b/tests/generic/678
> @@ -22,7 +22,6 @@ _cleanup()
>  }
>  
>  # get standard environment, filters and checks
> -. ./common/rc
>  . ./common/filter
>  
>  # real QA test starts here
> diff --git a/tests/generic/679 b/tests/generic/679
> index c32d42b9..a0094e48 100755
> --- a/tests/generic/679
> +++ b/tests/generic/679
> @@ -11,7 +11,6 @@
>  . ./common/preamble
>  _begin_fstest auto quick prealloc
>  
> -. ./common/rc
>  . ./common/filter
>  . ./common/punch
>  
> diff --git a/tests/generic/690 b/tests/generic/690
> index f03295a5..cef8d6e8 100755
> --- a/tests/generic/690
> +++ b/tests/generic/690
> @@ -24,7 +24,6 @@ _cleanup()
>  	rm -r -f $tmp.*
>  }
>  
> -. ./common/rc
>  . ./common/filter
>  . ./common/dmflakey
>  
> -- 
> 2.35.1
> 
