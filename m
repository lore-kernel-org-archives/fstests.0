Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:24537 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfBKAhp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Feb 2019 19:37:45 -0500
Date: Mon, 11 Feb 2019 11:37:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: detect preallocation support for fsx tests 075
 and 112
Message-ID: <20190211003741.GC20493@dastard>
References: <20190205184713.20266-1-hch@lst.de>
 <20190210111142.GU2713@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210111142.GU2713@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 10, 2019 at 07:11:42PM +0800, Eryu Guan wrote:
> On Tue, Feb 05, 2019 at 07:47:13PM +0100, Christoph Hellwig wrote:
> > Currently generic/075 and generic/112 have two extra fsx passes each that
> > exercise fsx with preallocation, which are only enabled for XFS.
> > 
> > These tests can also be run with other file systems, given that the XFS
> > prealloc ioctls are implemented in generic code since the addition of
> > the fallocate system call.  This also means a version of XFS that does
> > not support preallocation (e.g. because it always writes out of place)
> > can skip the prealloc tests while still completing the normal fsx tests
> > just fine.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/generic/075 | 16 +++++++++++-----
> >  tests/generic/112 | 20 +++++++++++++-------
> >  2 files changed, 24 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tests/generic/075 b/tests/generic/075
> > index 2b957891..8981c560 100755
> > --- a/tests/generic/075
> > +++ b/tests/generic/075
> > @@ -48,11 +48,12 @@ _do_test()
> >      echo "fsx.$_n : $_filter_param"
> >      echo "-----------------------------------------------"
> >  
> > -    if [ "$FSTYP" != "xfs" ]
> > -    then
> > -	if [ "$_n" = "1" -o "$_n" = "3" ]
> > -	then
> > -	    # HACK: only xfs handles preallocation (-x) so just skip this test
> > +    if [ "$_n" = "1" -o "$_n" = "3" ]; then
> > +        if echo $testio | grep -q "Operation not supported"; then
> 
> Hmm, I don't think checking ENOSUPP message is sufficient, old distros
> may ship xfs_io without falloc support or there's no generic prealloc
> ioctl support, these cases are rare but possible.
> 
> How about adding a new XFS_IOC_RESVSP ioctl check in src/feature.c and

xfs_io -c "resvsp 0 1g" ...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
