Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:57652 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbeKOPif (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Nov 2018 10:38:35 -0500
Date: Thu, 15 Nov 2018 16:31:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Any method to limit page cache usage in test cases?
Message-ID: <20181115053115.GK6311@dastard>
References: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 14, 2018 at 08:31:05AM +0800, Qu Wenruo wrote:
> Hi,
> 
> Is there any (easy) method for a fstests test case to limit the page
> cache usage?
> 
> I triggered btrfs/139 failure with 2G vRAM VM, and located the root
> cause of the problem.
> 
> However it's only really reproducible for small ram VM, since it could
> trigger dirty page writeback due to memory pressure.
> 
> So I'm wondering if we could do such thing even for large RAM test machine.

src/usemem.c can currently be used to consume up to 2GB of RAM.

Update it to deal with amounts of more than 2^31 bytes, and then
calculate how much ram you want to lock away as unusable in the test
and call usemem to prevent the kernel from using than memory.

It's an easy way to drive the kernel into severe memory shortages
and trigger dirty page writeback from memory reclaim....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
