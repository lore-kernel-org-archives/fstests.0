Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF906C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 00:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiDMAek (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 20:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDMAek (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 20:34:40 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 373F5583A8
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 17:32:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6B3E610C8872;
        Wed, 13 Apr 2022 10:32:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1neQvj-00H1ek-4v; Wed, 13 Apr 2022 10:32:19 +1000
Date:   Wed, 13 Apr 2022 10:32:19 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, dchinner@redhat.com
Subject: Re: [PATCH v2 3/3] generic/020: fix unaligned MAX_ATTRVAL_SIZE
 output filter
Message-ID: <20220413003219.GN1609613@dread.disaster.area>
References: <20220412105001.14325-1-ddiss@suse.de>
 <20220412105001.14325-4-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412105001.14325-4-ddiss@suse.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62561a14
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=5Q8yCVD_iztFa0P1FvcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 12, 2022 at 12:50:01PM +0200, David Disseldorp wrote:
> The current attr -g "$max_attrval_name" output filter is broken if
> MAX_ATTRVAL_SIZE isn't 16-byte aligned, due to od's duplicate
> suppression behaviour.
> Fix it by having od only dump one byte per line.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  tests/generic/020     | 2 +-
>  tests/generic/020.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
