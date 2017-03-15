Received: from mx1.redhat.com ([209.132.183.28]:42296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbdCOC2f (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Mar 2017 22:28:35 -0400
Date: Wed, 15 Mar 2017 10:28:34 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] DAX DIO: DAX mapped area DIO to non-DAX expected failure
Message-ID: <20170315022834.pqqbakxy2e2ibtpo@XZHOUW.usersys.redhat.com>
References: <1489463960-3579-1-git-send-email-xzhou@redhat.com>
 <20170314144403.GA25951@linux.intel.com>
 <20170314150702.GA1036@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314150702.GA1036@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 14, 2017 at 09:07:02AM -0600, Ross Zwisler wrote:
> On Tue, Mar 14, 2017 at 08:44:03AM -0600, Ross Zwisler wrote:
> > On Tue, Mar 14, 2017 at 11:59:20AM +0800, Xiong Zhou wrote:
> > > It's not supported on raw mode nvdimm, brd ramdisk:
> > > https://lists.01.org/pipermail/linux-nvdimm/2017-February/008959.html
> > > 
> > > It's working on "memory mode" nvdimm, memmap ramdisk.
> > > 
> > > Mute output of this subtest to stop the fake failure. Keep this
> > > routine for sanity check.
> > > 
> > > Updating generic/413 and xfs/260.
> > 
> > I don't understand how we can mute the errors that are due to DAX direct I/O
> > being used in unsupported configurations (raw mode nvdimm, brd ramdisk)
> > without also muting real errors that happen for supported configs (memory mode
> > nvidmm)?
> > 
> > It seems like for this test to give us proper coverage, we need to see this
> > output in all cases, and we just need to document to the user that this test
> > is expected to fail if you run it against brd or raw mode nvdimms?
> 
> Actually the best thing to do would probably be to teach xfstests which are
> the unsupported configs for DIO + DAX, and then just skip the tests so we
> don't report false positive failures.  I think we can do this by looking at
> the device (pmem vs brd), and by looking at the output from ndctl to see what
> mode the pmem namespace is in.  If they have a pmem namespace but no ndctl,
> just assume the test is runnable and run the risk of getting a false positive.

Yah. I've thought about this, ended up without a way good enough to me.
Thanks for the review. I'll try v2.
