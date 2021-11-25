Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7656C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 23:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhKYXLt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 18:11:49 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:38159 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345232AbhKYXJs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 18:09:48 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 13D81AD58E;
        Fri, 26 Nov 2021 10:06:34 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mqNp0-00DF41-NI; Fri, 26 Nov 2021 10:06:30 +1100
Date:   Fri, 26 Nov 2021 10:06:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Radoslav Kolev <radoslav.kolev@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: read only filesystem tests
Message-ID: <20211125230630.GA3154935@dread.disaster.area>
References: <e64129cb-dec9-f0bb-9a50-ede0a7b2aca6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64129cb-dec9-f0bb-9a50-ede0a7b2aca6@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61a016fb
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=NfO7pO3n9gXHZUVxX2AA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 15, 2021 at 01:18:25PM +0200, Radoslav Kolev wrote:
> Hello,
> 
> I am interested in read only filesystem tests, and more specifically
> squashfs. I saw that ~2 year ago there was a patch set submitted, but not
> accepted that added support for it with some feedback, that
> the tests are copied and double the maintenance burden, but sadly there is
> no easy way to avoid that.
> 
> What is the current mood about read only filesystem tests and fstests?
> Is this the right project to fill this need and is it worth it trying to
> address some of the problems with the old squashfs patches?

What sort of read only tests are you talking about? i.e. how does
the initial filesystem state that the test is going to run on get
generated? AFAICT you can't reuse any of the existing tests because
they all require writing to the filesystem to create the initial
test conditions. You can tell fsx/fsstress not do do modifying
operations from the command line, so you can still run stress tests
based on these on read-only filesystems.

There are definitely limits on what fstests can realistically
exercise w.r.t. read-only filesystems.  That said, there is
definitely scope for fstests to support read-only tests - just
create a tests/read-only directory, a common/read-only include file
and build the tests and infrastructure out from that. If the RO
tests have their own test group definitions (e.g. 'check -g
ro-auto'), then it won't impact on any of the existing read-write
filesystem tests or test groupings.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
