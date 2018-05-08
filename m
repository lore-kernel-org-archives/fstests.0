Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754995AbeEHMqa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 8 May 2018 08:46:30 -0400
Message-ID: <26f3c1c78d4ee94af5ef51af5c88fa25247efb90.camel@kernel.org>
Subject: Re: [PATCH v3] generic: test for seeing unseen fsync errors on
 newly open files
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 08 May 2018 08:46:27 -0400
In-Reply-To: <20180502055051.GA29084@desktop>
References: <20180428145937.6804-1-jlayton@kernel.org>
         <20180428230627.16791-1-jlayton@kernel.org>
         <20180502055051.GA29084@desktop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, willy@infradead.org, andres@anarazel.de, david@fromorbit.com, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

On Wed, 2018-05-02 at 13:50 +0800, Eryu Guan wrote:
> On Sat, Apr 28, 2018 at 07:06:27PM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > This adds a regression test for the following kernel patch:
> > 
> >     errseq: Always report a writeback error once
> > 
> > This is motivated by some rather odd behavior done by the PostgreSQL
> > project. The main database writers will offload the fsync calls to a
> > separate process, which can open files after a writeback error has
> > already occurred.
> > 
> > This used to work with older kernels that reported the error to only
> > one fd, but with the errseq_t changes we lost the ability to see
> > errors that occurred before the open. The above patch restores that
> > behavior.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  tests/generic/999     | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/999.out |  5 +++
> >  tests/generic/group   |  1 +
> >  3 files changed, 101 insertions(+)
> >  create mode 100755 tests/generic/999
> >  create mode 100644 tests/generic/999.out
> > 
> > diff --git a/tests/generic/999 b/tests/generic/999
> > new file mode 100755
> > index 000000000000..b816fd3bb423
> > --- /dev/null
> > +++ b/tests/generic/999
> > @@ -0,0 +1,95 @@
> > +#! /bin/bash
> > +# FS QA Test No. XXX
> 
>                     ^^^ Need a test number here :)
> > +#
> > +# Open a file several times, write to it, fsync on all fds and make sure that
> > +# they all return 0. Change the device to start throwing errors. Write again
> > +# on all fds and fsync on all fds. Ensure that we get errors on all of them.
> > +# Then fsync on all one last time and verify that all return 0.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2018, Jeff Layton <jlayton@redhat.com>
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
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -rf $tmp.* $testdir
> > +	_dmerror_cleanup
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/dmerror
> > +
> > +# real QA test starts here
> > +_supported_os Linux
> > +_require_scratch_nocheck
> > +# This test uses "dm" without taking into account the data could be on
> > +# realtime subvolume, thus the test will fail with rtinherit=1
> > +_require_no_rtinherit
> > +
> > +_require_dm_target error
> > +
> > +rm -f $seqres.full
> > +
> > +echo "Format and mount"
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_dmerror_init
> > +_dmerror_mount
> > +
> > +datalen=65536
> > +_require_fs_space $SCRATCH_MNT $datalen
> > +
> > +# use fd 5 to hold file open
> > +testfile=$SCRATCH_MNT/fsync-open-after-err
> > +exec 5>$testfile
> > +
> > +# write some data to file and fsync it out
> > +$XFS_IO_PROG -c "pwrite -q 0 $datalen" -c fsync $testfile
> > +
> > +# flip device to non-working mode
> > +_dmerror_load_error_table
> > +
> > +# rewrite the data, call sync to ensure it's written back w/o scraping error
> > +$XFS_IO_PROG -c "pwrite -q 0 $datalen" -c sync $testfile
> > +
> > +# heal the device error
> > +_dmerror_load_working_table
> > +
> > +# open again and call fsync
> > +echo "The following fsync should fail with EIO:"
> > +$XFS_IO_PROG -c fsync $testfile
> > +echo "done"
> 
>                                                                                                                                                                                                
> I built latest Linus tree, which should contain the mentioned fix, and I                                                                                                                       
> saw different results on xfs, ext4 and btrfs.                                                                                                                                                  
>                                                                                                                                                                                                
> XFS fails the test as:                                                                                                                                                                         
>     -fsync: Input/output error                                                                                                                                                                 
>     +/mnt/scratch/fsync-open-after-err: Input/output error

I think I see the problem. I was testing this with a logdev. I think
we'll need a _require_logdev directive in the test. I'll send a v4 in a
bit with that and some other corrections.

>                                                                                                                                      
>                                                                                                                                                                                                
> While btrfs fails as:                                                                                                                                                                          
>     -fsync: Input/output error                                                                                                                                                                 
>     +/mnt/scratch/fsync-open-after-err: Read-only file system
>                                                              

I think btrfs will require a specialized testcase (like we did for some
of the earlier tests in this area). I'll send a separate patch for that
one.

>                                                                      
>                                                                                                                                                                                                
> And both XFS and btrfs behave in the same way no matter I have the fix                                                                                                                         
> applied or not (tested on v4.16 kernel and v4.17-rc3+ kernel).                                                                                                                                 
>                                                                                                                                                                                                
> Only ext4 passes the test with v4.17-rc3+ kernel, and fails on v4.16                                                                                                                           
> kernel as expected:                                                                                                                                                                            
>     -fsync: Input/output error                                                                                                                                                                 
>                                                                                                                                                                                                
> Could you please take a look?                                                                                                                                                                  
>                                                                                                                                                                                                
> Thanks,                                                                                                                                                                                        
> Eryu
> 
> > +
> > +# close file
> > +exec 5>&-
> > +
> > +# success, all done
> > +_dmerror_unmount
> > +_dmerror_cleanup
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/999.out b/tests/generic/999.out
> > new file mode 100644
> > index 000000000000..38d2d7f6495f
> > --- /dev/null
> > +++ b/tests/generic/999.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 999
> > +Format and mount
> > +The following fsync should fail with EIO:
> > +fsync: Input/output error
> > +done
> > diff --git a/tests/generic/group b/tests/generic/group
> > index ea8e51b35e79..48f491a5c32b 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -486,3 +486,4 @@
> >  481 auto quick log metadata
> >  482 auto metadata replay
> >  483 auto quick log metadata
> > +999 auto quick
> > -- 
> > 2.14.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jeff Layton <jlayton@kernel.org>
