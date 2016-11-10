Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17188 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754384AbcKJCTy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Nov 2016 21:19:54 -0500
Date: Thu, 10 Nov 2016 13:19:44 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: btrfs: Check false ENOSPC bug caused by
 incorrect metadata reserve
Message-ID: <20161110021944.GW28177@dastard>
References: <20161108091515.20867-1-quwenruo@cn.fujitsu.com>
 <20161108105826.GN27776@eguan.usersys.redhat.com>
 <d9a9d224-2f21-5b77-a3e9-de271cd4e755@cn.fujitsu.com>
 <20161109094341.GY27776@eguan.usersys.redhat.com>
 <6ae5fc6d-afbb-c284-190e-a0d2625cff25@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae5fc6d-afbb-c284-190e-a0d2625cff25@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: Eryu Guan <eguan@redhat.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 10, 2016 at 08:34:20AM +0800, Qu Wenruo wrote:
> At 11/09/2016 05:43 PM, Eryu Guan wrote:
> >On Wed, Nov 09, 2016 at 08:24:38AM +0800, Qu Wenruo wrote:
> >>At 11/08/2016 06:58 PM, Eryu Guan wrote:
> >>>On Tue, Nov 08, 2016 at 05:15:15PM +0800, Qu Wenruo wrote:
> >We should use helpers and not open-code when helpers are available. So
> >we should really use _scratch_mkfs_sized here.
> >
> >And "-n 64k" is only to make bug easier to reproduce, but I don't think
> >it's necessary. In my testings, 50%-75% runs hit the ENOSPC failure on
> >my x86_64 test vm, even I removed the "-n 64k" mkfs option from the
> >test.
> >
> >So I'd say remove "-n 64k" and test whatever mkfs options user
> >specified.
> 
> I really don't like the idea to allow user to override any mount
> option to reduce the possibility.

That's not the point. Overriding mount options reduces test coverage
because it limits the test to only the exact configuration that
reproduced the bug that was seen. If a user is testing a specific
configuration, then we really want to run the test on that config.

> And further more, this testcase is not a generic test, but a
> regression/pinpoint test to expose one specific bug.

If you want to make sure that the bug doesn't return, then you need
to run the /entire test suite/ with the configuration that exposes
the problem. You wouldn't be suggesting this specific set of mount
options if users weren't using that configuration. Hence you really
need to run the entire test suite with that configuration to make
sure you haven't broken those user's systems....

And, yes, I test lots of different XFS configurations in their
entirity every day on every change I make or review, so I'm not
suggesting that you should do anything I don't already do.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
