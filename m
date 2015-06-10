Received: from mx1.redhat.com ([209.132.183.28]:48616 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbbFJHHr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Jun 2015 03:07:47 -0400
Date: Wed, 10 Jun 2015 15:07:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic: concurrent IO test with mixed IO types
Message-ID: <20150610070744.GZ3672@dhcp-13-216.nay.redhat.com>
References: <1433760101-25540-1-git-send-email-eguan@redhat.com>
 <1433767271-30562-1-git-send-email-eguan@redhat.com>
 <20150609222933.GC24666@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150609222933.GC24666@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 10, 2015 at 08:29:33AM +1000, Dave Chinner wrote:
> On Mon, Jun 08, 2015 at 08:41:11PM +0800, Eryu Guan wrote:
> > Test concurrent buffered I/O, DIO, AIO, mmap I/O and splice I/O on the
> > same files.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> > 
> > This fio job file has been proven to be potent, it triggers WARNINGs on ext4
> > and xfs with 4.1-rc6 kernel.
> > 
> > ext4: WARNING: at fs/ext4/inode.c:1328
> > xfs: WARNING: CPU: 7 PID: 3090 at fs/xfs/xfs_file.c:726 xfs_file_dio_aio_write+0x176/0x2a8 [xfs]()
> > 
> > The ext4 issue should be fixed by Lukas's patch
> > ext4: fix reservation release on invalidatepage for delalloc fs
> > 
> > And it ever paniced kernel in mm code and hung xfs.
> > 
> > I reduced the numjobs and iodepth to reduce the test time(~25s on my test host)
> > and scale them by $LOAD_FACTOR. And it still could trigger the warning on ext4
> > and xfs with reduced workload.
> > 
> > v2:
> > - use mktemp to create tmp fio job file
> ....
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +fio_config=`mktemp`
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> 
> By removing the definition of $tmp, you are now dumping all
> the temporary files the test harnes creates in /.

You're right, I see /fsck.log on my test host.

I checked 'check' and common/rc and chech has its "tmp=/tmp/$$"
definition and I thought I didn't use any functions from common/rc in my
test directly that depends on $tmp definition. I must have missed
something.

Should I send a v3 and roll back to v1? or you can just take v1?

Thanks,
Eryu
