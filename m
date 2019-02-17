Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:58769 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbfBQV4M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Feb 2019 16:56:12 -0500
Date: Mon, 18 Feb 2019 08:56:06 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: new EOF fragmentation tests
Message-ID: <20190217215606.GX20493@dastard>
References: <20190211013647.22580-1-david@fromorbit.com>
 <20190216100454.GY2713@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216100454.GY2713@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 16, 2019 at 06:04:54PM +0800, Eryu Guan wrote:
> On Mon, Feb 11, 2019 at 12:36:47PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > These tests create substantial file fragmentation as a result of
> > application actions that defeat post-EOF preallocation
> > optimisations. They are intended to replicate known vectors for
> > these problems, and provide a check that the fragmentation levels
> > have been controlled. The mitigations we make may not completely
> > remove fragmentation (e.g. they may demonstrate speculative delalloc
> > related extent size growth) so the checks don't assume we'll end up
> > with perfect layouts and hence check for an exceptable level of
> > fragmentation rather than none.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/xfs/500     | 79 +++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/500.out |  9 +++++
> >  tests/xfs/501     | 81 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/501.out |  9 +++++
> >  tests/xfs/502     | 81 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/502.out |  9 +++++
> >  tests/xfs/503     | 89 +++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/503.out | 33 ++++++++++++++++++
> >  tests/xfs/group   |  4 +++
> >  9 files changed, 394 insertions(+)
> >  create mode 100755 tests/xfs/500
> >  create mode 100644 tests/xfs/500.out
> >  create mode 100755 tests/xfs/501
> >  create mode 100644 tests/xfs/501.out
> >  create mode 100755 tests/xfs/502
> >  create mode 100644 tests/xfs/502.out
> >  create mode 100755 tests/xfs/503
> >  create mode 100644 tests/xfs/503.out
> > 
> > diff --git a/tests/xfs/500 b/tests/xfs/500
> > new file mode 100755
> > index 00000000..d0802e86
> > --- /dev/null
> > +++ b/tests/xfs/500
> > @@ -0,0 +1,79 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test xfs/500
> > +#
> > +# Post-EOF preallocation defeat test
> 
> The test description of the four tests are all the same, I know there're
> detailed descriptions later in each test, but it's better to write high
> level descriptions here.

Not really. lsqa.pl gets drowned by detailed test decsriptions in
the header rather than just the one line description it was
originally supposed to be. i.e. if I'm looking for preallocation
defeat tests, then './lsqa.pl |grep -B 2 -i preallocation' should
get me the description of all the tests that exercise preallocation
in some way.

e.g.

$ ./lsqa.pl |grep -B 2 -i prealloc |grep "FS QA"
FS QA Test No. btrfs/013
FS QA Test 153
FS QA Test No. 094
FS QA Test No. 226
FS QA Test No. 274
FS QA Test No. 009
FS QA Test No. xfs/014
FS QA Test 118
FS QA Test No. 165
FS QA Test xfs/500
FS QA Test xfs/501
FS QA Test xfs/502
FS QA Test xfs/503

(you can also see why I put "FS QA Test <testdir>/<number>" in the
identifier line, too)

IOWs, the rest of the test description is irrelevant to lsqa - like
git commits, it's mostly the one-line description that matters for
finding relevant tests....

AFAIC, if you're describing how/why the test code does what it does,
then it should be with the code that does those operations, not 50
lines away where it will bitrot as the code gets changed over time.
That's pretty much the rule we use for writing kernel/application
code - the test code should be no different...

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
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> 
> _supported_fs xfs
> 
> The four tests all have the same issue.

The contents of the test is generic and has no XFS specific code in
them. I just placed it in tests/xfs because I don't care about
what the other filesystems do in these situations.

Whatever, I'll change it.

> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +
> > +_scratch_mkfs 2>&1 >> $seqres.full
> > +_scratch_mount
> > +
> > +# Write multiple files in parallel using synchronous buffered writes. Aim is to
> 
> This should be "using open/read/close loops" not "synchronous buffered
> writes"?

No. write_file() uses synchronous buffered writes and they are
written in parallel. And three lines later:

> > +# interleave allocations to fragment the files. Assuming we've fixed the
> > +# sycnhronous write defeat, we can still trigger the same issue with a
> > +# open/read/close on O_RDONLY files.

is the description of using open/read/close loops to trigger
fragmentation.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
