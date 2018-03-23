Received: from userp2130.oracle.com ([156.151.31.86]:46074 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbeCWQt5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Mar 2018 12:49:57 -0400
Date: Fri, 23 Mar 2018 09:49:51 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/278: mkfs with v4 format
Message-ID: <20180323164951.GF4810@magnolia>
References: <bde6f5a1-1107-9c03-402d-486bfbdcbd35@redhat.com>
 <20180323021600.GW30836@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323021600.GW30836@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 23, 2018 at 10:16:00AM +0800, Eryu Guan wrote:
> On Thu, Mar 22, 2018 at 03:09:53PM -0500, Eric Sandeen wrote:
> > This test had silently stopped working when mkfs.xfs switched
> > to v5 supers by default, and changed inode sizes:
> > 
> > > field u not found
> > > parsing error
> > > field u not found
> > > parsing error
> > 
> > ...
> > 
> > Switch back to the original behavior by turning off crcs,
> > and catch such failures if they crop up again by looking
> > for xfs_db errors in $seqres.full.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > ---
> > 
> > (is it horrific to grep $seqres.full?  xfs_db doesn't exit
> > with failure in this case :( )
> 
> I think that's fine, at least xfs/083 and ext4/006 do grep it :)
> 
> Or we can redirect xfs_db output to a $tmp.xfs_db file and grep it, and
> append the file content to $seqres.full if necessary, so that we just
> grep what we care about, not the full $seqres.full file.
> 
> > 
> > and now this causes repair to fail on a verifier error, but
> > I just sent an xfsprogs patch to fix that as well.
> > 
> > diff --git a/tests/xfs/278 b/tests/xfs/278
> > index b94ee9c..c0e09c7 100755
> > --- a/tests/xfs/278
> > +++ b/tests/xfs/278
> > @@ -48,7 +48,7 @@ _supported_os Linux
> >  _require_scratch
> >  
> >  rm -f $seqres.full
> > -_scratch_mkfs >$seqres.full 2>&1
> > +_scratch_mkfs -m crc=0 -n ftype=0 >$seqres.full 2>&1
> 
> At first I thought this might lose test coverage with v5 filesystem, but
> after looking at the xfsprogs commit that fixed the original bug (commit
> 198b747f2553 ("repair: properly mark lost+found inode as used")), it
> seems like that both v4 and v5 go to the same code path, and we won't
> lose test coverage.

I don't like the idea of losing test coverage on v5 filesystems just to
avoid having to rewrite this test to detect the xfs_db inode field name
prefix.  At some point in the near(ish) future we're going to start
landing the parent pointer code at which point the v5 code paths in
repair /will/ start to diverge.

Anyway, I have my autodetect patch ready so I'll send that shortly.

--D

> If this is the case, I think it's worth mentioning it in commit log too.
> Otherwise looks fine to me.
> 
> Thanks,
> Eryu
> 
> >  _scratch_mount
> >  
> >  mkdir -p $SCRATCH_MNT/dir/subdir
> > @@ -73,6 +73,8 @@ _scratch_xfs_db -x -c "inode $DIR_INO" -c "write core.nlinkv2 0"  >> $seqres.ful
> >  _scratch_xfs_db -x -c "inode $SUBDIR_INO" -c "write u.sfdir2.hdr.parent.i4 0"  >> $seqres.full
> >  _scratch_xfs_db -x -c "inode $SUBDIR_INO" -c "write core.nlinkv2 0"  >> $seqres.full
> >  
> > +grep -q "not found\|parsing error" $seqres.full && _fail "xfs_db commands failed"
> > +
> >  echo "===== BEGIN of xfs_repair =====" >> $seqres.full
> >  echo "" >>$seqres.full
> >  
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
