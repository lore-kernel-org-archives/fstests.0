Received: from aserp2120.oracle.com ([141.146.126.78]:49886 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDMXhP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Apr 2018 19:37:15 -0400
Date: Fri, 13 Apr 2018 16:37:11 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/187: fix ftype brokenness
Message-ID: <20180413233711.GB13697@magnolia>
References: <20180411160809.GA13697@magnolia>
 <20180413061408.GH2932@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413061408.GH2932@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 13, 2018 at 02:14:08PM +0800, Eryu Guan wrote:
> On Wed, Apr 11, 2018 at 09:08:09AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > This test requires XFS_SB_VERSION_MOREBITSBIT to be zero.  ftype (which
> > is now enabled by default) causes this to be set, so detect it in mkfs
> > and disable it.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  tests/xfs/187 |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/xfs/187 b/tests/xfs/187
> > index 07ef3ae..e1a8ce9 100755
> > --- a/tests/xfs/187
> > +++ b/tests/xfs/187
> > @@ -70,8 +70,14 @@ export MOUNT_OPTIONS=""
> >  # lazysb, attr2 and other feature bits are held in features2 and will require
> >  # morebitsbit on So test with lazysb and without it to see if the morebitsbit is
> >  # okay etc. If the mkfs defaults change, these need to change as well.
> > -export MKFS_NO_LAZY="-m crc=0 -l lazy-count=0 -i projid32bit=0"
> > -export MKFS_LAZY="-m crc=0 -l lazy-count=1 -i projid32bit=0"
> > +MKFS_NO_LAZY="-m crc=0 -l lazy-count=0 -i projid32bit=0"
> > +MKFS_LAZY="-m crc=0 -l lazy-count=1 -i projid32bit=0"
> > +
> > +# Detect ftype
> 
> I'd put the reason of detecting ftype support in comments here. I can
> fix it on commit.

Ok.

# ftype is also stored in features2, so we have to detect its presence in
# mkfs and disable it here too.

?

--D

> Thanks,
> Eryu
> 
> > +if _scratch_mkfs --help 2>&1 | grep -q "ftype="; then
> > +	MKFS_NO_LAZY="$MKFS_NO_LAZY -n ftype=0"
> > +	MKFS_LAZY="$MKFS_LAZY -n ftype=0"
> > +fi
> >  
> >  # Make sure that when we think we are testing with morebits off
> >  # that we really are.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
