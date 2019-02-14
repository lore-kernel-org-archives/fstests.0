Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:64959 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732343AbfBNW1M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Feb 2019 17:27:12 -0500
Date: Fri, 15 Feb 2019 09:27:08 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: detect preallocation support for fsx tests 075
 and 112
Message-ID: <20190214222708.GR20493@dastard>
References: <20190205184713.20266-1-hch@lst.de>
 <20190210111142.GU2713@desktop>
 <20190211003741.GC20493@dastard>
 <20190214054759.GW2713@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214054759.GW2713@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 14, 2019 at 01:47:59PM +0800, Eryu Guan wrote:
> On Mon, Feb 11, 2019 at 11:37:41AM +1100, Dave Chinner wrote:
> > On Sun, Feb 10, 2019 at 07:11:42PM +0800, Eryu Guan wrote:
> > > On Tue, Feb 05, 2019 at 07:47:13PM +0100, Christoph Hellwig wrote:
> > > > Currently generic/075 and generic/112 have two extra fsx passes each that
> > > > exercise fsx with preallocation, which are only enabled for XFS.
> > > > 
> > > > These tests can also be run with other file systems, given that the XFS
> > > > prealloc ioctls are implemented in generic code since the addition of
> > > > the fallocate system call.  This also means a version of XFS that does
> > > > not support preallocation (e.g. because it always writes out of place)
> > > > can skip the prealloc tests while still completing the normal fsx tests
> > > > just fine.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  tests/generic/075 | 16 +++++++++++-----
> > > >  tests/generic/112 | 20 +++++++++++++-------
> > > >  2 files changed, 24 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/tests/generic/075 b/tests/generic/075
> > > > index 2b957891..8981c560 100755
> > > > --- a/tests/generic/075
> > > > +++ b/tests/generic/075
> > > > @@ -48,11 +48,12 @@ _do_test()
> > > >      echo "fsx.$_n : $_filter_param"
> > > >      echo "-----------------------------------------------"
> > > >  
> > > > -    if [ "$FSTYP" != "xfs" ]
> > > > -    then
> > > > -	if [ "$_n" = "1" -o "$_n" = "3" ]
> > > > -	then
> > > > -	    # HACK: only xfs handles preallocation (-x) so just skip this test
> > > > +    if [ "$_n" = "1" -o "$_n" = "3" ]; then
> > > > +        if echo $testio | grep -q "Operation not supported"; then
> > > 
> > > Hmm, I don't think checking ENOSUPP message is sufficient, old distros
> > > may ship xfs_io without falloc support or there's no generic prealloc
> > > ioctl support, these cases are rare but possible.
> > > 
> > > How about adding a new XFS_IOC_RESVSP ioctl check in src/feature.c and
> > 
> > xfs_io -c "resvsp 0 1g" ...
> 
> But we have to check for different error messages caused by different
> errnos again, and xfs_io doesn't set non-zero return value on failure,
> so there's no easy way to check if XFS_IOC_RESVSP ioctl is succeeded or
> not. I think it would be easier to do it in feature.c and we can rely on
> the return value of 'feature'.
> 
> Or can we assume 'xfs -c "resvsp 0 1"' prints nothing on success, then
> we could check if it prints out some kind error messages?

Ummm, look at the code or run the command I quoted?

io/prealloc.c::resvsp_f()

        if (xfsctl(file->name, file->fd, XFS_IOC_RESVSP64, &segment) < 0) {
                perror("XFS_IOC_RESVSP64");
                return 0;
        }

On XFS (success):

$ xfs_io -f -c "resvsp 0 1" /mnt/scratch/testfile
$

On ext3 (failure):

$ sudo xfs_io -f -c "resvsp 0 1" /testfile
XFS_IOC_RESVSP64: Operation not supported
$

-Dave.
-- 
Dave Chinner
david@fromorbit.com
