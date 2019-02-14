Received: from mail-pg1-f194.google.com ([209.85.215.194]:42178 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfBNFsH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Feb 2019 00:48:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so2446803pga.9
        for <fstests@vger.kernel.org>; Wed, 13 Feb 2019 21:48:07 -0800 (PST)
Date: Thu, 14 Feb 2019 13:47:59 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: detect preallocation support for fsx tests 075
 and 112
Message-ID: <20190214054759.GW2713@desktop>
References: <20190205184713.20266-1-hch@lst.de>
 <20190210111142.GU2713@desktop>
 <20190211003741.GC20493@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211003741.GC20493@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 11, 2019 at 11:37:41AM +1100, Dave Chinner wrote:
> On Sun, Feb 10, 2019 at 07:11:42PM +0800, Eryu Guan wrote:
> > On Tue, Feb 05, 2019 at 07:47:13PM +0100, Christoph Hellwig wrote:
> > > Currently generic/075 and generic/112 have two extra fsx passes each that
> > > exercise fsx with preallocation, which are only enabled for XFS.
> > > 
> > > These tests can also be run with other file systems, given that the XFS
> > > prealloc ioctls are implemented in generic code since the addition of
> > > the fallocate system call.  This also means a version of XFS that does
> > > not support preallocation (e.g. because it always writes out of place)
> > > can skip the prealloc tests while still completing the normal fsx tests
> > > just fine.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  tests/generic/075 | 16 +++++++++++-----
> > >  tests/generic/112 | 20 +++++++++++++-------
> > >  2 files changed, 24 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/tests/generic/075 b/tests/generic/075
> > > index 2b957891..8981c560 100755
> > > --- a/tests/generic/075
> > > +++ b/tests/generic/075
> > > @@ -48,11 +48,12 @@ _do_test()
> > >      echo "fsx.$_n : $_filter_param"
> > >      echo "-----------------------------------------------"
> > >  
> > > -    if [ "$FSTYP" != "xfs" ]
> > > -    then
> > > -	if [ "$_n" = "1" -o "$_n" = "3" ]
> > > -	then
> > > -	    # HACK: only xfs handles preallocation (-x) so just skip this test
> > > +    if [ "$_n" = "1" -o "$_n" = "3" ]; then
> > > +        if echo $testio | grep -q "Operation not supported"; then
> > 
> > Hmm, I don't think checking ENOSUPP message is sufficient, old distros
> > may ship xfs_io without falloc support or there's no generic prealloc
> > ioctl support, these cases are rare but possible.
> > 
> > How about adding a new XFS_IOC_RESVSP ioctl check in src/feature.c and
> 
> xfs_io -c "resvsp 0 1g" ...

But we have to check for different error messages caused by different
errnos again, and xfs_io doesn't set non-zero return value on failure,
so there's no easy way to check if XFS_IOC_RESVSP ioctl is succeeded or
not. I think it would be easier to do it in feature.c and we can rely on
the return value of 'feature'.

Or can we assume 'xfs -c "resvsp 0 1"' prints nothing on success, then
we could check if it prints out some kind error messages?

Thanks,
Eryu
