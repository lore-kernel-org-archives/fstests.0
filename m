Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F12C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  6 May 2022 04:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiEFEqO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 May 2022 00:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiEFEqN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 May 2022 00:46:13 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC57458E48
        for <fstests@vger.kernel.org>; Thu,  5 May 2022 21:42:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id CA17510E627C
        for <fstests@vger.kernel.org>; Fri,  6 May 2022 14:42:26 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nmpnN-008aDC-Sx
        for fstests@vger.kernel.org; Fri, 06 May 2022 14:42:25 +1000
Date:   Fri, 6 May 2022 14:42:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: faster group file creation
Message-ID: <20220506044225.GE1949718@dread.disaster.area>
References: <20220506031232.483883-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506031232.483883-1-david@fromorbit.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6274a733
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=x52NT5QFUjwWYSZd1HsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 06, 2022 at 01:12:32PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We don't need to execute every test just to check it's groups are
> valid. Just grab all the groups with grep, pull out the unique ones,
> then check them.

Oops, I broke the subgroup list building in .check. Let me go fix
that and I'll resubmit the patch.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
