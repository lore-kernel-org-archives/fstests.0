Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:50053 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751149AbbDAWaP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 1 Apr 2015 18:30:15 -0400
Date: Thu, 2 Apr 2015 09:29:54 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/9] generic: test I/O error path by fully filling dm
 snapshot
Message-ID: <20150401222954.GF28621@dastard>
References: <1426846618-23413-7-git-send-email-eguan@redhat.com>
 <1427896455-12048-1-git-send-email-eguan@redhat.com>
 <20150401175710.GF4756@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150401175710.GF4756@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 01, 2015 at 01:57:10PM -0400, Brian Foster wrote:
> On Wed, Apr 01, 2015 at 09:54:15PM +0800, Eryu Guan wrote:
> > xfs used to panic in this test, this xfs commit fix the bug
> > 
> > 8d6c121 xfs: fix buffer use after free on IO error
> > 
> > ext4 and btrfs trigger WARNING on current 4.0-rc3 kernel
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> > v2:
> > - add _require_dm_snapshot() function to require dm snapshot target
> > - make sure SCRATCH_DEV has enough space for the test
> > - fail the test directly when failures detected in setup phase
> > 
> 
> FYI, the mail subject header hasn't changed so Dave might not notice
> this is a new patch.

Saw it.

> > +_mount /dev/mapper/$vgname-$snapname $mnt
> > +
> > +# write 5M data to the snapshot
> > +$XFS_IO_PROG -fc "pwrite 0 5m" $mnt/testfile >>$seqres.full 2>&1
> > +
> 
> I noticed there were no errors in $seqres.full when running this test.
> E.g., the pwrite succeeds because nothing is written back to disk at
> that point. The fs does shutdown due to the flush on umount, but it's
> kind of hidden away up in the _cleanup() function.
> 
> Kind of a nit, but we could be a bit more explicit and do a '-c fsync'
> after the pwrite here? That way it's clear that writeback to disk is
> part of the core test and we have a little feedback in $seqres.full that
> I/O errors occurred, as expected.

Added the -c fsync as I pulled it in.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
