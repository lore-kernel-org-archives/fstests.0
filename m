Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C13C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 30 May 2022 00:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiE3ALY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 20:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiE3ALX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 20:11:23 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEB8E75200
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 17:11:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id EAFE9535504;
        Mon, 30 May 2022 10:11:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nvT0C-000P31-S5; Mon, 30 May 2022 10:11:20 +1000
Date:   Mon, 30 May 2022 10:11:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] generic/139: require 512 bytes to be the minimum dio
 size
Message-ID: <20220530001120.GL3923443@dread.disaster.area>
References: <20220529105505.667891-1-zlang@kernel.org>
 <20220529105505.667891-2-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529105505.667891-2-zlang@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62940baa
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=dUPhxH_l29OlLeay8_0A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 29, 2022 at 06:55:01PM +0800, Zorro Lang wrote:
> Due to generic/139 tests base on 512 bytes aligned, so skip this test
> if the minimum dio write size >512. This patch also change the
> common/rc::_require_dio helper, supports a minimum aligned size
> argument.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  common/rc         | 11 ++++++++---
>  tests/generic/139 |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 2f31ca46..6f7a37fd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2721,7 +2721,8 @@ _require_xfs_io_command()
>  	fi
>  }
>  
> -# check that kernel and filesystem support direct I/O
> +# check that kernel and filesystem support direct I/O, and check if "$1" size
> +# aligned (optional) is supported
>  _require_odirect()
>  {
>  	if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
> @@ -2735,9 +2736,13 @@ _require_odirect()
>  		fi
>  	fi
>  	local testfile=$TEST_DIR/$$.direct
> -	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
> +	local opt
> +	if [ -n "$1" ];then
> +		opt="-b $1"
> +	fi
> +	$XFS_IO_PROG -F -f -d -c "pwrite $opt 0 20k" $testfile > /dev/null 2>&1

Local variables that are defined by incoming parameters need to be
declared at the top of the function, not inline. Also, there's a
simple way to set this up at initialisation, too:

	local alignment=${1:+"-b $1"}

If $1 is not set, alignment will be null, otherwise it will be set
to "-b $1".


>  	if [ $? -ne 0 ]; then
> -		_notrun "O_DIRECT is not supported"
> +		_notrun "O_DIRECT $1 is not supported"
>  	fi

		if [ -n "$alignment" ]; then
			_notrun "O_DIRECT aligned to $1 bytes is not supported" 
		else
			_notrun "O_DIRECT is not supported"
		fi

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
