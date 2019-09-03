Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59135 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfICVm7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Sep 2019 17:42:59 -0400
Date: Wed, 4 Sep 2019 07:42:55 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 0/2] Add lease testing
Message-ID: <20190903214255.GK7777@dread.disaster.area>
References: <20190903210537.29142-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903210537.29142-1-ira.weiny@intel.com>
Sender: fstests-owner@vger.kernel.org
To: ira.weiny@intel.com
Cc: fstests@vger.kernel.org, john.hubbard@gmail.com, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Jeff Layton <jlayton@kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 03, 2019 at 02:05:35PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> To get to a point of developing and testing the new Lease semantics for long
> term file pins[1], add a simple lease test.

Hi Ira,

Can you co-ordinate with Jeff on this? He just posted a patch
to add F_SETLEASE testing with a new binary a few days
ago...

https://marc.info/?l=fstests&m=156690934513424&w=2

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
