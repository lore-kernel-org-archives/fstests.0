Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2126C433F5
	for <linux-fstests@archiver.kernel.org>; Thu,  5 May 2022 21:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378700AbiEEVtP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 May 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386103AbiEEVtO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 May 2022 17:49:14 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6499BE0EA
        for <fstests@vger.kernel.org>; Thu,  5 May 2022 14:45:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 14F5053474C;
        Fri,  6 May 2022 07:45:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nmjHt-008T6b-1g; Fri, 06 May 2022 07:45:29 +1000
Date:   Fri, 6 May 2022 07:45:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     fstests@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [RFC PATCH v2 2/2] generic: add tests for fscrypt policies with
 HCTR2
Message-ID: <20220505214529.GC1949718@dread.disaster.area>
References: <20220505193809.579026-1-nhuck@google.com>
 <20220505193809.579026-3-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505193809.579026-3-nhuck@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6274457b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=JnId85hdAAAA:8 a=7-415B0cAAAA:8
        a=TsTT_PPsN9OSknyJ6ssA:9 a=CjuIK1q_8ugA:10 a=n5m-N9b7J94A:10
        a=Z6pL95kxVIcA:10 a=auJVbxCGDDzI_Z1jI2v7:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 05, 2022 at 02:38:09PM -0500, Nathan Huckleberry wrote:
> This patch adds fscrypt policy tests for filename encryption using
> HCTR2.
> 
> More information on HCTR2 can be found here: "Length-preserving
> encryption with HCTR2" https://ia.cr/2021/1441

One test for all three verifications would be better - less tests to
run, less tests to maintain. Especially as these are effectively
one-line tests with a clear golden output which tells us exactly
which verification failed...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
