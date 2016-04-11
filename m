Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:13522 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750912AbcDKAE4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 10 Apr 2016 20:04:56 -0400
Date: Mon, 11 Apr 2016 10:02:38 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/259: handle minimum block size more precisely
Message-ID: <20160411000238.GB9088@dastard>
References: <1460027155-4222-1-git-send-email-eguan@redhat.com>
 <20160407213231.GD761@dastard>
 <20160407234837.GA1439@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160407234837.GA1439@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 07, 2016 at 04:48:37PM -0700, Christoph Hellwig wrote:
> On Fri, Apr 08, 2016 at 07:32:31AM +1000, Dave Chinner wrote:
> > > diff --git a/tests/xfs/259 b/tests/xfs/259
> > > index 16c1935..3150ff3 100755
> > > --- a/tests/xfs/259
> > > +++ b/tests/xfs/259
> > > @@ -51,9 +51,7 @@ testfile=$TEST_DIR/259.image
> > >  # Test various sizes slightly less than 4 TB. Need to handle different
> > >  # minimum block sizes for CRC enabled filesystems, but use a small log so we
> > >  # don't write lots of zeros unnecessarily.
> > > -xfs_info $TEST_DIR | _filter_mkfs 2> $tmp.mkfs > /dev/null
> > > -. $tmp.mkfs
> > 
> > This tests the configuration of the test device, which is not
> > controlled by the test harness, so can be different to the
> > configuration being used for the scratch device.
> > 
> > > -if [ $_fs_has_crcs -eq 1 ]; then
> > > +if [ $XFS_MKFS_CRC_DEFAULT -eq 1 ]; then
> > 
> > IOWs, this is not an not equivalent test.
> 
> And I think that's the whole point of this change :)
> 
> Previously it tested what the TEST_DIR did, which was wrong for this
> test.  Now it tests what mkfs does by default (including for the scratch
> dev), which is what we really want here.

Which is not at all clear from the patch description.

Seriously, though, this does not belong in common/config. We already
have a helper function to check what mkfs supports (i.e.
 _scratch_mkfs_xfs_supported()), and if we just want a bare check
then factor this into a _mkfs_xfs_supported() and supply the
parameters specific to the test.

Indeed, this is basically what we do with _require_xfs_mkfs_crc();
the same thing should be done, but without the "notrun" if -m crc
s not supported...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
