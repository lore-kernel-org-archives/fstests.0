Received: from userp2130.oracle.com ([156.151.31.86]:47766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfGUOfl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jul 2019 10:35:41 -0400
Date: Sun, 21 Jul 2019 07:35:30 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: xfs/504 description
Message-ID: <20190721143530.GQ692234@magnolia>
References: <20190721132030.GA11688@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721132030.GA11688@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 21, 2019 at 03:20:30PM +0200, Christoph Hellwig wrote:
> Hi Darrick,
> 
> the description on top of tests/xfs/504 seems to have been copy and
> pasted from tests/generic/453 and does't seem to actually match the
> test cases.  Do you have a proper description?

Yeah, I was going to send Eryu a fix patch tomorrow once I finish
de-crazying from the merge window. :)

x/504 tests that online label setting and getting works, and has nothing
to do with directory entries.  Silly /me copypasta'd. :(

--D
