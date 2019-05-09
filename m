Received: from userp2130.oracle.com ([156.151.31.86]:43498 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEIBzO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 May 2019 21:55:14 -0400
Date: Wed, 8 May 2019 18:55:06 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: question about xfstests case xfs/297
Message-ID: <20190509015505.GB5352@magnolia>
References: <5CD14717.7070205@cn.fujitsu.com>
 <20190507163711.GA5208@magnolia>
 <5CD27D5C.4040003@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CD27D5C.4040003@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: xuyang <xuyang2018.jy@cn.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, May 08, 2019 at 02:55:24PM +0800, xuyang wrote:
> on 2019/05/08 0:37, Darrick J. Wong wrote:
> 
> > [cc fstests]
> > 
> > On Tue, May 07, 2019 at 04:51:35PM +0800, xuyang wrote:
> > > Hi darrick
> > > 
> > > since commit d0e484a("check: wipe scratch devices between tests")is
> > > merged into xfstests, when I running xfs/297 on kernel 5.1.0-rc5+ with
> > > xfsprogs-4.18.0-3.el8.x86_64, it causes a failure that log size is too
> > > small to reach the minimum size, as below:
> > > 
> > > #wipefs -a /dev/sda11 (20G)
> > > /dev/sda11: 4 bytes were erased at offset 0x00000000 (xfs): 58 46 53 42
> > > #mkfs.xfs -f -d agcount=16,su=256k,sw=12 -l  su=256k,size=5120b /dev/sda11
> > > log size 5120 blocks too small, minimum size is 5184 blocks
> > That's not related to wipefs at all.
> > 
> > The problem here is that your vendor's xfsprogs package turns on reflink
> > by default.  The reflink feature increases the minimum log size
> > requirements, which this test doesn't account for, and hence it misses
> > by 64 blocks.  Evidently nobody at your vendor's QA department noticed?
> > 
> > I only noticed because I started carrying an "enable reflink by default"
> > patch last Thursday and it caused a bunch of regressions on tests that
> > call mkfs.xfs without looping in MKFS_OPTIONS.  I will be sending out
> > patches to fix all that shortly and will cc you on them.
>    I got it .
> > > upstream xfsprogs doesn't have this problem.
> > Upstream xfsprogs doesn't enable reflink by default.
> > 
> > > I am confused about why the min_logblocks becomes larger after wipefs.
> > > Is it a calculating minimum log size bug?  Perhaps, I can adjust the
> > > logsize to 5184b. Can you give some advise?
> > Wait for the corrections and help me test them, please? :)
> > 
> > --D
> > 
> Hi  Darrick
> 
>    I have tested your patchset for 20 times(run seven affected cases), it's ok on my machine.

Cool!  Could you reply to the patchset with your Tested-by, please? :)

--D

> 
> > > Kind regards,
> > > Yang Xu
> > > 
> > > 
> > > 
> > 
> > 
> 
> 
