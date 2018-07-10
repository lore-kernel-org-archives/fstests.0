Received: from mga11.intel.com ([192.55.52.93]:39077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732344AbeGJVQn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Jul 2018 17:16:43 -0400
Date: Tue, 10 Jul 2018 15:15:19 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [fstests PATCH 2/2] generic/999: test DAX DMA vs
 truncate/hole-punch
Message-ID: <20180710211519.GA25279@linux.intel.com>
References: <20180620225147.12151-1-ross.zwisler@linux.intel.com>
 <20180620225147.12151-2-ross.zwisler@linux.intel.com>
 <20180621024033.GK2780@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621024033.GK2780@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org, Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 21, 2018 at 10:40:33AM +0800, Eryu Guan wrote:
> On Wed, Jun 20, 2018 at 04:51:47PM -0600, Ross Zwisler wrote:
<>

> > diff --git a/tests/generic/999 b/tests/generic/999
> > new file mode 100755
> > index 00000000..8f488cb5
> > --- /dev/null
> > +++ b/tests/generic/999
> > @@ -0,0 +1,50 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2018 Intel Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test generic/999
> > +#
> > +# This is a regression test for kernel patch:
> > +#   ext4: handle layout changes to pinned DAX mapping
> > +# created by Ross Zwisler <ross.zwisler@linux.intel.com>
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test
> > +_require_test_program "t_mmap_collision"
> 
> _require_xfs_io_command "fpunch"
> _require_xfs_io_command "fcollapse"
> _require_xfs_io_command "fzero"

I don't think I need these because I don't actually require this functionality
from xfs_io.  I did try and use xfs_io for this test, but the way the
threading needs to work I ended up having to write my own C program.  So,
even if xfs_io happens to be old and without fpunch, for example, as long as
fallocate can use FALLC_FL_PUNCH_HOLE I think the test should do the right
thing.

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
> Also need "punch collapse zero" groups.

I'm assuming I should still add my test to these 3 groups, even though I'm not
getting this functionality via xfs_io?

Thank you for the review, I'll address the rest of your comments in v2.
