Received: from mga17.intel.com ([192.55.52.151]:39980 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933297AbeFUQeG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Jun 2018 12:34:06 -0400
Date: Thu, 21 Jun 2018 10:34:05 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [fstests PATCH 2/2] generic/999: test DAX DMA vs
 truncate/hole-punch
Message-ID: <20180621163405.GA7014@linux.intel.com>
References: <20180620225147.12151-1-ross.zwisler@linux.intel.com>
 <20180620225147.12151-2-ross.zwisler@linux.intel.com>
 <20180621021842.GB13748@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621021842.GB13748@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org, Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 21, 2018 at 12:18:42PM +1000, Dave Chinner wrote:
> On Wed, Jun 20, 2018 at 04:51:47PM -0600, Ross Zwisler wrote:
<>
> > +rm -f $seqres.full
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test
> > +_require_test_program "t_mmap_collision"
> > +
> > +# turn off DAX on our scratch device so we can get normal O_DIRECT behavior
> > +export MOUNT_OPTIONS=""
> > +_scratch_unmount >> $seqres.full 2>&1
> > +_scratch_mount >> $seqres.full 2>&1
> 
> _exclude_scratch_mount_option "dax"
> 
> i.e. we skip the test if "-o dax" is in the mount options. We try
> not to turn off all mount options, because then we never exercise
> any filesystem configuration other than mount defaults, regardless of
> what other mount options the tester has specified on the CLI or
> in config files...
> 
> > +Silence is golden
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 83a6fdab..793f71ed 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -501,3 +501,4 @@
> >  496 auto quick swap
> >  497 auto quick swap collapse
> >  498 auto quick log
> > +999 auto quick dax
> 
> Why should this be in a "dax" group when the test explicitly turns
> off the the DAX mount option?

Right, sorry, this is a bit confusing.  We only turn off dax for the scratch
device, but we use the full mount options for the test device.  To reproduce
the bug I'm looking for we would like those mount options to include -o dax
(hence the membership in the dax group), but the test runs fine without this
so I didn't want to require the dax mount option for the test to run.

I'll add comments to this effect, and I'll address the rest of your feedback
in v2.

Thank you for the review.
