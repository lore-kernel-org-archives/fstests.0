Received: from mx1.redhat.com ([209.132.183.28]:55344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755065AbcHCHzf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 3 Aug 2016 03:55:35 -0400
Date: Wed, 3 Aug 2016 15:55:32 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/095: update warning whitelist
Message-ID: <20160803075531.GI27776@eguan.usersys.redhat.com>
References: <1470042176-31447-1-git-send-email-hch@lst.de>
 <20160802232305.GQ12670@dastard>
 <20160803073918.GE16413@zlang.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160803073918.GE16413@zlang.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 03, 2016 at 03:39:18PM +0800, Zorro Lang wrote:
> On Wed, Aug 03, 2016 at 09:23:05AM +1000, Dave Chinner wrote:
> > On Mon, Aug 01, 2016 at 11:02:56AM +0200, Christoph Hellwig wrote:
> > > The recent direct I/O path refactor changed the function name in the
> > > racing read case.  Update the test case to handle the new name in
> > > addition to the old one.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  tests/generic/095 | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/095 b/tests/generic/095
> > > index c656ef1..4754992 100755
> > > --- a/tests/generic/095
> > > +++ b/tests/generic/095
> > > @@ -125,9 +125,11 @@ $FIO_PROG $fio_config >>$seqres.full 2>&1
> > >  filter_xfs_dmesg()
> > >  {
> > >  	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
> > > -	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
> > > +	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
> > > +	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
> > >  	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
> > > -	    -e "s#$warn2#Intentional warnings in xfs_file_read_iter#"
> > > +	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
> > > +	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#"
> 
> Hi,
> 
> 1) xfs_file_dio_aio_read() was splited from xfs_file_read_iter() by
> below commit:
> 
>   bbc5a74 xfs: split xfs_file_read_iter into buffered and direct I/O helpers
> 
> 2) xfs_file_read_iter() came from xfs_file_aio_read() as below commit:
> 
>   b4f5d2c xfs: switch to ->read_iter()
> 
> Some Linux distro (e.g: RHEL-7) still use the old kernel with old function
> xfs_file_aio_read(), generic/095 always fails on it. So how about filter
> xfs_file_aio_read too?

I think you can just send another (follow-up) patch for review.

Eryu
