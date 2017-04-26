Received: from mga07.intel.com ([134.134.136.100]:16729 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932200AbdDZRus (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Apr 2017 13:50:48 -0400
Date: Wed, 26 Apr 2017 11:50:46 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v2 2/2] dax: add regression test for stale mmap reads
Message-ID: <20170426175046.GA15921@linux.intel.com>
References: <20170425205106.20576-1-ross.zwisler@linux.intel.com>
 <20170425205106.20576-2-ross.zwisler@linux.intel.com>
 <20170426074727.GG26397@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426074727.GG26397@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, fstests@vger.kernel.org, Xiong Zhou <xzhou@redhat.com>, jmoyer@redhat.com, Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@ml01.01.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 26, 2017 at 03:47:27PM +0800, Eryu Guan wrote:
> On Tue, Apr 25, 2017 at 02:51:06PM -0600, Ross Zwisler wrote:
<>
> > diff --git a/tests/generic/427 b/tests/generic/427
> > new file mode 100755
> > index 0000000..6e265a1
> > --- /dev/null
> > +++ b/tests/generic/427
> > @@ -0,0 +1,67 @@
> > +#! /bin/bash
> > +# FS QA Test 427
> > +#
> > +# This is a regression test for kernel patch:
> > +#  dax: fix data corruption due to stale mmap reads
> > +# created by Ross Zwisler <ross.zwisler@linux.intel.com>
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Intel Corporation.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
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
> > +_require_test_program "t_dax_stale_pmd"
> > +_require_xfs_io_command "falloc"
> 
> I'm wondering if falloc is really needed? If not, this test could be run
> with ext2/3 too. See below.
> 
> > +_require_user
> 
> This is not needed anymore.

Fixed in v3.

> > +
> > +# real QA test starts here
> > +
> > +# ensure we have no pre-existing block allocations, so we get a hole
> > +rm -f $TEST_DIR/testfile
> > +$XFS_IO_PROG -f -c "falloc 0 4M" $TEST_DIR/testfile >> $seqres.full 2>&1
> 
> I found that 'xfs_io -fc "truncate 4M" $TEST_DIR/testfile' works too,
> from the comments in test and kernel patch, if I understand correctly,
> we only need to mmap un-allocated blocks, right?
> 
> If truncate(2) works too, I think we can move truncate operation to the
> t_dax_stale_pmd program too, because the whole truncate && mmap && read
> sequence are logically together, this also avoids the confusion on why
> testfile is in 4M size.

Yep, that works.  In v3 I've moved to using only ftruncate so we can enable
ext2/3, and I've moved those calls into the C file with comments explaining
why we're doing things.
