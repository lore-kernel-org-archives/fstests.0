Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FDC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 21 May 2022 23:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiEUXRw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 May 2022 19:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEUXRw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 May 2022 19:17:52 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E8AB3F312
        for <fstests@vger.kernel.org>; Sat, 21 May 2022 16:17:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 51453534689;
        Sun, 22 May 2022 09:17:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nsYM0-00Eotf-Of; Sun, 22 May 2022 09:17:48 +1000
Date:   Sun, 22 May 2022 09:17:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH] tools/mkgroupfile: help the cases of group.list in
 number order
Message-ID: <20220521231748.GZ2306852@dread.disaster.area>
References: <20220521054349.1691473-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521054349.1691473-1-zlang@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6289731e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=3LmDQVbRnJzJF7KThL4A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 21, 2022 at 01:43:49PM +0800, Zorro Lang wrote:
> The mkgroupfile doesn't sort cases in number order, that cause
> fstests' ./new script can't find a proper number which isn't taken.
> The unsorted case number might cause more problems, so fix it.

Yet more reason for these group lists to die and get replaced with a
common generation function.

> Fixes: 441606d28681 ("fstests: faster group file creation")
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> If you'd like to fix this issue seperately, I can merge this patch with Dave's
> "[PATCH 04/12] fstests: fix group list generation for whacky test names"
> together.

It needs documentation updates, too. I had no idea that the group
list files were used by the new script or that there was a
requirement for them to be sorted into numerical order.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
