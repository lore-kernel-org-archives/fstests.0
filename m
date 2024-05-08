Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F6481C4
	for <fstests@vger.kernel.org>; Wed,  8 May 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165941; cv=none; b=tPK1X2VzFfp4OlZMQ5cNkpSL4VVRXat2EwzIzVjeK1xSqKYk6LypxnY1MRZJBksTgoCBwNqXdsc+aBXLqmRu9UmMx4xuBU9bvjS44XMkwF8oGw9jy2AZMVqkk8BHxU5sUZQuBP669i8Cs8x60MHlh9sEtMa9uevC2dFJQC0+zEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165941; c=relaxed/simple;
	bh=fjb3ln2B2kg8QFrtp4fKOyC1rRPKcI6UJgRp5kMvNH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeqomlpRNi0/DG42R07GflLg3GBXpnLfNrWtwzsFs6by4DR0EIIq3+46LXLDhS7QEkKWF4TPcDYMmWZOnWVVArNf9CazlCJNLoNn//RbIUPjkUXyc0c0P44TJUPWLMUZqpHNrCm3fqsWFZxfcYtoFX7A2AXGnx+WwnF7RdkO1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=AA9cEWC4; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="AA9cEWC4"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VZBwJ08gjz9svD;
	Wed,  8 May 2024 12:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715165936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=is++b1I6wpy8s49a2ERvlDm+ULbqG8gloDExQ5tk6NY=;
	b=AA9cEWC4mPbgVwhORWHRBo5DTu2OcfDuLNagN7jNoX4yWuWTuXJwKYqoYghFE8DcUeBWbT
	Z0cGRNWMrnbtRR2Dg+xKSgHdTVG9LNgEwq1eWvtjiRRctaMJlgtPsXlM2/0dH+WX+X9gDB
	tgpMxzw1Zk7D8QmIHfuVgFAULhh2/hJmg03Fbo7jE8uqDDbqoklZDKuG+SJuKcj3nec7uN
	c0iNHAxtKT0E1TcfzGt+RNMhrLTNqYZr6M79qzy4+x7CJ8TY+O0U1c4dUtu87pFAL9wIvJ
	miQnc/9VTlXMGCNqMEUFNj72xrH69Oru7smoJ+/r2IPB+rw+qfm/iEox9/pHgg==
Date: Wed, 8 May 2024 10:58:52 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
Message-ID: <20240508105852.nfjtlp53v24xb3tw@quentin>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-2-kernel@pankajraghav.com>
 <20240507222323.GC2049409@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507222323.GC2049409@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4VZBwJ08gjz9svD

On Tue, May 07, 2024 at 03:23:23PM -0700, Darrick J. Wong wrote:
> On Mon, May 06, 2024 at 05:01:17PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > This test fails when xfs is formatted with 64k filesystem block size*.
> > It fails because the soft quota is not exceeded with the hardcoded 64k
> > pwrite, thereby, the grace time is not set. Even though soft quota is
> > set to 12k for uid1, it is rounded up to the nearest blocksize.
> > 
> > *** Report for user quotas on device /dev/sdb3
> > Block grace time: 7days; Inode grace time: 7days
> >                         Block limits                File limits
> > User            used    soft    hard  grace    used  soft  hard  grace
> > ----------------------------------------------------------------------
> > 0        --       0       0       0      0       3     0     0      0
> > 1        --      64      64    1024      0       1     0     0      0
> > 2        --      64       0       0      0       1     0     0      0
> > 
> > Adapt the pwrite to do more than 64k write when the FS blocksize is 64k.
> > 
> > Cap the blksz to be at least 64k to retain the same behaviour as before
> > for smaller filesystem blocksizes.
> > 
> > * This happens even on a 64k pagesize system and it is not related to
> >   LBS effort.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  tests/xfs/161 | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/xfs/161 b/tests/xfs/161
> > index 486fa6ca..94290f18 100755
> > --- a/tests/xfs/161
> > +++ b/tests/xfs/161
> > @@ -38,9 +38,15 @@ _qmount_option "usrquota"
> >  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
> >  _scratch_mount >> $seqres.full
> >  
> > +min_blksz=65536
> > +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> > +# Write more than one block to exceed the soft block quota limit.
> > +blksz=$(( 2 * $file_blksz))
> > +
> > +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
> 
> If we don't set $min_blksize and always write (2 * $file_blksz) does the
> test still work?

I think something like this is more clean where we don't have anymore
hardcoded variables:

Author: Pankaj Raghav <p.raghav@samsung.com>
Date:   Thu Jan 18 18:40:39 2024 +0100

    xfs/161: adapt the test case for 64k FS blocksize
    
    This test fails when xfs is formatted with 64k filesystem block size*.
    It fails because the soft quota is not exceeded with the hardcoded 64k
    pwrite, thereby, the grace time is not set. Even though soft quota is
    set to 12k for uid1, it is rounded up to the nearest blocksize.
    
    *** Report for user quotas on device /dev/sdb3
    Block grace time: 7days; Inode grace time: 7days
                            Block limits                File limits
    User            used    soft    hard  grace    used  soft  hard  grace
    ----------------------------------------------------------------------
    0        --       0       0       0      0       3     0     0      0
    1        --      64      64    1024      0       1     0     0      0
    2        --      64       0       0      0       1     0     0      0
    
    Adapt the pwrite to do twice the FS block size and set the soft limit
    to be 1 FS block.
    
    * This happens even on a 64k pagesize system and it is not related to
      LBS effort.
    
    Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

diff --git a/tests/xfs/161 b/tests/xfs/161
index 486fa6ca..074acddc 100755
--- a/tests/xfs/161
+++ b/tests/xfs/161
@@ -38,15 +38,21 @@ _qmount_option "usrquota"
 _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
 _scratch_mount >> $seqres.full
 
+
+pgsize=`$here/src/feature -s`
+file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
+# Write more than one block to exceed the soft block quota limit.
+blksz=$(( 2 * $file_blksz))
+
 # Force the block counters for uid 1 and 2 above zero
-_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
-_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
+_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/a >> $seqres.full
+_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/b >> $seqres.full
 sync
 chown 1 $SCRATCH_MNT/a
 chown 2 $SCRATCH_MNT/b
 
 # Set quota limits on uid 1 before upgrading
-$XFS_QUOTA_PROG -x -c 'limit -u bsoft=12k bhard=1m 1' $SCRATCH_MNT
+$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$file_blksz"' bhard=1m 1' $SCRATCH_MNT
 
 # Make sure the grace period is at /some/ point in the future.  We have to
 # use bc because not all bashes can handle integer comparisons with 64-bit
@@ -71,7 +77,7 @@ _scratch_mount
 
 # Set a very generous grace period and quota limits on uid 2 after upgrading
 $XFS_QUOTA_PROG -x -c 'timer -u -b -d 2147483647' $SCRATCH_MNT
-$XFS_QUOTA_PROG -x -c 'limit -u bsoft=10000 bhard=150000 2' $SCRATCH_MNT
+$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$file_blksz"' bhard=150000 2' $SCRATCH_MNT
 
 # Query the grace periods to see if they got set properly after the upgrade.
 repquota -upn $SCRATCH_MNT > $tmp.repquota

> 
> --D
> 
> >  # Force the block counters for uid 1 and 2 above zero
> > -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
> > -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
> > +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/a >> $seqres.full
> > +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/b >> $seqres.full
> >  sync
> >  chown 1 $SCRATCH_MNT/a
> >  chown 2 $SCRATCH_MNT/b
> > -- 
> > 2.34.1
> > 

-- 
Pankaj Raghav
