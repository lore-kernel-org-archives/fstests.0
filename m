Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455EFC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 23:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiE2X5S (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 19:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiE2X5R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 19:57:17 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C630D49F3C
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 16:57:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4A90311004B4;
        Mon, 30 May 2022 09:57:14 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nvSmW-000Org-5s; Mon, 30 May 2022 09:57:12 +1000
Date:   Mon, 30 May 2022 09:57:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] generic/591: use proper sector size
Message-ID: <20220529235712.GK3923443@dread.disaster.area>
References: <20220529105505.667891-1-zlang@kernel.org>
 <20220529105505.667891-5-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529105505.667891-5-zlang@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6294085a
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=uEn5ets47facx6guQLUA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 29, 2022 at 06:55:04PM +0800, Zorro Lang wrote:
> The generic/591 fails if the sector size of TEST_DEV isn't 512:
> 
>   splice-test: write: /mnt/test/a: Invalid argument
> 
> To fix this issue, this patch help src/splice-test.c to get a specify
> sector size from the test case. Then let g/591 give it a proper
> sector size which dio aligned.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  src/dmiperf        | Bin 0 -> 31288 bytes
>  src/splice-test.c  |  37 +++++++++++++++++++++++++------------
>  src/t_locks_execve | Bin 0 -> 25904 bytes
>  tests/generic/591  |   6 ++++--

I don't think this commit should include built binaries....

-Dave
-- 
Dave Chinner
david@fromorbit.com
