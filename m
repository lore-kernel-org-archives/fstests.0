Received: from mx1.redhat.com ([209.132.183.28]:58806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752155AbeBFHlT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Feb 2018 02:41:19 -0500
Date: Tue, 6 Feb 2018 15:41:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: xfstests failures
Message-ID: <20180206074118.GP18267@eguan.usersys.redhat.com>
References: <94286394-157a-421b-7f73-52f10529f23f@intel.com>
 <20180206035443.GN18267@eguan.usersys.redhat.com>
 <20180206061320.zlma3t55ymtmhyeo@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206061320.zlma3t55ymtmhyeo@destitution>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Dave Jiang <dave.jiang@intel.com>, fstests@vger.kernel.org, "Zwisler, Ross" <ross.zwisler@intel.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 06, 2018 at 05:13:20PM +1100, Dave Chinner wrote:
> On Tue, Feb 06, 2018 at 11:54:43AM +0800, Eryu Guan wrote:
> > On Mon, Feb 05, 2018 at 02:40:40PM -0700, Dave Jiang wrote:
> > > xfs/191-input-validation
> > 
> > This tests mkfs.xfs behavior and AFAIK it fails after Dave's mkfs
> > refactor patchset, the test itself requires some fixes.
> 
> It failed before it, too. I'd just mark this test as broken and

It failed only with 4k-sector disk, but my memory may not be accurate..

> remove it for the auto group, because it isn't doing what I
> originally intended it to be used for.

Thanks for the info! Would you mind sending a patch for this?

Thanks,
Eryu
