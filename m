Received: from userp2120.oracle.com ([156.151.31.85]:39536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfHSQZz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Aug 2019 12:25:55 -0400
Date: Mon, 19 Aug 2019 09:25:46 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fstests: generic/500 doesn't work for btrfs
Message-ID: <20190819162546.GH15198@magnolia>
References: <20190815182659.27875-1-josef@toxicpanda.com>
 <20190818154016.GB2845@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818154016.GB2845@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Sun, Aug 18, 2019 at 11:44:28PM +0800, Eryu Guan wrote:
> On Thu, Aug 15, 2019 at 02:26:59PM -0400, Josef Bacik wrote:
> > Btrfs does COW, so when we unlink the file we need to update metadata
> > and write it to a new location, which we can't do because the thinp is
> > full.  This results in an EIO during a metadata write, which makes us
> > flip read only, thus making it impossible to fstrim the fs.  Just make
> > it so we skip this test for btrfs.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  tests/generic/500 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/generic/500 b/tests/generic/500
> > index 201d8b9f..5cd7126f 100755
> > --- a/tests/generic/500
> > +++ b/tests/generic/500
> > @@ -49,6 +49,12 @@ _supported_os Linux
> >  _require_scratch_nocheck
> >  _require_dm_target thin-pool
> >  
> > +# The unlink below will result in new metadata blocks for btrfs because of CoW,
> > +# and since we've filled the thinp device it'll return EIO, which will make
> > +# btrfs flip read only, making it fail this test when it just won't work right
> > +# for us in the first place.
> > +test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"
> 
> I'm wondering if we could introduce a proper _require rule to cover this
> case? e.g. require the fs doesn't allocate new blocks on unlink? or
> something like that. But I'm not sure what's the proper fs feature to
> require here, any suggestions?

I'd be careful with this -- xfs can allocate new metadata blocks on
unlink too -- changes in the free space btrees, expansion of the free
inode btree, etc.  For the 20 inodes in play in g/500 this won't be the
case, but if you had a test that created 20,000 inodes, then that could
happen.

--D

> Thanks,
> Eryu
> 
> > +
> >  # Require underlying device support discard
> >  _scratch_mkfs >>$seqres.full 2>&1
> >  _scratch_mount
> > -- 
> > 2.21.0
> > 
