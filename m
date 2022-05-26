Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686AC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 00:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbiEZANb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 May 2022 20:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345961AbiEZANa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 May 2022 20:13:30 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 500756391
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 17:13:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 740AF52C1A0;
        Thu, 26 May 2022 10:13:27 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nu182-00GQ7z-CX; Thu, 26 May 2022 10:13:26 +1000
Date:   Thu, 26 May 2022 10:13:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: remove redundant common/$FSTYP importing
Message-ID: <20220526001326.GX2306852@dread.disaster.area>
References: <20220525073427.3355242-1-zlang@kernel.org>
 <20220525073427.3355242-3-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525073427.3355242-3-zlang@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=628ec627
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=fomtgcQLiWgvaQUHhQkA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 25, 2022 at 03:34:27PM +0800, Zorro Lang wrote:
> As fstests intensively source specific common/$FSTYP files in
> common/rc, at the beginning of ./check running. Each single case
> doesn't need to import that again.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  tests/btrfs/177 | 1 -
>  tests/btrfs/258 | 1 -
>  tests/btrfs/259 | 1 -
>  tests/xfs/422   | 1 -
>  tests/xfs/423   | 1 -
>  tests/xfs/517   | 1 -
>  6 files changed, 6 deletions(-)
> 
> diff --git a/tests/btrfs/177 b/tests/btrfs/177
> index 2fd11e89..7b004b83 100755
> --- a/tests/btrfs/177
> +++ b/tests/btrfs/177
> @@ -10,7 +10,6 @@
>  _begin_fstest auto quick swap balance
>  
>  . ./common/filter
> -. ./common/btrfs
>  
>  # Modify as appropriate.
>  _supported_fs btrfs
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> index 158eaf79..8fc828df 100755
> --- a/tests/btrfs/258
> +++ b/tests/btrfs/258
> @@ -11,7 +11,6 @@
>  _begin_fstest auto defrag quick
>  
>  . ./common/btrfs
> -. ./common/filter

I think you removed the wrong line here.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
