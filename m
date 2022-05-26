Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59996C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 23:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346060AbiEZXpL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 May 2022 19:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiEZXpJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 May 2022 19:45:09 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B8A22B1B0
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 16:45:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 414BF10E6BC7;
        Fri, 27 May 2022 09:45:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nuNAA-00GoIk-KC; Fri, 27 May 2022 09:45:06 +1000
Date:   Fri, 27 May 2022 09:45:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: filter out extra mount error
Message-ID: <20220526234506.GC3923443@dread.disaster.area>
References: <20220526095704.3772355-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526095704.3772355-1-zlang@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62901104
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=U9N2OM1oKVs3RTE9_yEA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 26, 2022 at 05:57:04PM +0800, Zorro Lang wrote:
> The lastest mount command (from util-linux) merged below commit:
>   79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
> which brought in a new error output when mount fails.
> 
> That cause some cases (e.g. xfs/005) fail as:
>   mount: Structure needs cleaning
>          dmesg(1) may have more information after failed mount system call
> 
> More failed cases like generic/050, ext4/002, xfs/154, etc ...
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Due to _try_scratch_mount is call in many places, so I'm not sure if it's good
> to filter this message in _try_scratch_mount. Maybe better to filter it in each
> failed cases? Or write another function (e.g. _try_scratch_mount_fail) ?
> Welcome review points.
> 
> Thanks,
> Zorro
> 
>  common/rc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 70a15f9c..67342760 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -335,7 +335,8 @@ _try_scratch_mount()
>  		_overlay_scratch_mount $*
>  		return $?
>  	fi
> -	_mount -t $FSTYP `_scratch_mount_options $*`
> +	_mount -t $FSTYP `_scratch_mount_options $*`  2> \
> +		>(grep -v "dmesg(1) may have more information after failed mount" >&2)

_filter_error_mount()?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
