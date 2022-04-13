Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139EC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 00:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiDMAeW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDMAeV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 20:34:21 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30FF5541B4
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 17:32:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C6F0410C7C0A;
        Wed, 13 Apr 2022 10:31:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1neQvO-00H1e4-3N; Wed, 13 Apr 2022 10:31:58 +1000
Date:   Wed, 13 Apr 2022 10:31:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, dchinner@redhat.com
Subject: Re: [PATCH v2 1/3] common/attr: add and use _attr_get_max()
Message-ID: <20220413003158.GM1609613@dread.disaster.area>
References: <20220412105001.14325-1-ddiss@suse.de>
 <20220412105001.14325-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412105001.14325-2-ddiss@suse.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62561a00
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=oCmJMEOurdBoL1c44xkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 12, 2022 at 12:49:59PM +0200, David Disseldorp wrote:
> No functional change. The MAX_ATTRS and MAX_ATTRVAL_SIZE exports are
> only used by generic/020. In preparation for taking into account the
> attr name length when calculating MAX_ATTRVAL_SIZE, split the current
> logic out into a _attr_get_max() helper function.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/attr       | 163 +++++++++++++++++++++++++---------------------
>  tests/generic/020 |  10 ++-
>  2 files changed, 95 insertions(+), 78 deletions(-)

Hmmm. when you said you were going to make these helper functions,
I thought you meant you were going to move them to generic/020
as helper functions as that is the only place that uses them.

I don't see any point in making them single use helper functions
specific to a single test and then leaving them in common/attr....

Then you can get rid of the exported variable and use a test local
variable for MAX_ATTRS and MAX_ATTRVAL_SIZE....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
