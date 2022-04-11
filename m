Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE832C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 05:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiDKFtb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 01:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244783AbiDKFta (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 01:49:30 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BF1D2CE18
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 22:47:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A4B6410CF5F4;
        Mon, 11 Apr 2022 15:47:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ndmtO-00GJor-Fd; Mon, 11 Apr 2022 15:47:14 +1000
Date:   Mon, 11 Apr 2022 15:47:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/attr: reduce MAX_ATTRVAL_SIZE for NFS
Message-ID: <20220411054714.GI1609613@dread.disaster.area>
References: <20220408191943.27655-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408191943.27655-1-ddiss@suse.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6253c0e3
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=uYpj7rBFHCEEPe85gyYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 08, 2022 at 09:19:43PM +0200, David Disseldorp wrote:
> When testing against an NFS export backed by a Btrfs filesystem,
> generic/020 may fail, e.g.
> 
>   --- /xfstests/tests/generic/020.out
>   +++ /xfstests/results/generic/020.out.bad
>   @@ -47,9 +47,13 @@
>    user.snrub="fish2\012"
> 
>    *** really long value
>   -0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   -*
>   -ATTRSIZE
>   +attr_set: No space left on device
>   +Could not set "long_attr" for <TESTFILE>
>   +attr_get: No data available
>   +Could not get "long_attr" for <TESTFILE>
>   +0000000
>   +attr_remove: No data available
>   +Could not remove "long_attr" for <TESTFILE>
> 
> This is due to the MAX_ATTRVAL_SIZE=65536 setting for NFS, which exceeds
> the Btrfs (and XFS) limit of MAX_ATTRVAL_SIZE=64. Change NFS to use this
> lower bound value.

I think that what XFS/UDF/BTRFS set here is bogus.

There is *one* test - generic/020 - that uses MAX_ATTRS and
MAX_ATTRVAL_SIZE, and  it uses MAX_ATTRVAL_SIZE as a byte count.

Which means for those 3 filesytems, the correct value for them is
65536, not 64....

This looks like it was broken back when the test was made generic
- the dd command before this used a bs=1024, so a maz size of 64
would have been correct. Except the dd command also go changed to
use bs=1, which meant 64 bytes....

So, yeah, the test got "broken" for XFS back in 2012 and so the
correct fix here is to change (at least) XFS and btrfs to have a
MAX_ATTRVAL_SIZE=65536....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
