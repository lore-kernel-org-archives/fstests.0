Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59542 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbbDBEKo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Apr 2015 00:10:44 -0400
Date: Thu, 2 Apr 2015 12:10:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 6/9] generic: test I/O error path by fully filling dm
 snapshot
Message-ID: <20150402041041.GF16808@dhcp-13-216.nay.redhat.com>
References: <1426846618-23413-7-git-send-email-eguan@redhat.com>
 <1427896455-12048-1-git-send-email-eguan@redhat.com>
 <20150401175710.GF4756@bfoster.bfoster>
 <20150401222954.GF28621@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150401222954.GF28621@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 02, 2015 at 09:29:54AM +1100, Dave Chinner wrote:
> On Wed, Apr 01, 2015 at 01:57:10PM -0400, Brian Foster wrote:
> > On Wed, Apr 01, 2015 at 09:54:15PM +0800, Eryu Guan wrote:
> > > xfs used to panic in this test, this xfs commit fix the bug
> > > 
> > > 8d6c121 xfs: fix buffer use after free on IO error
> > > 
> > > ext4 and btrfs trigger WARNING on current 4.0-rc3 kernel
> > > 
> > > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > > ---
> > > v2:
> > > - add _require_dm_snapshot() function to require dm snapshot target
> > > - make sure SCRATCH_DEV has enough space for the test
> > > - fail the test directly when failures detected in setup phase
> > > 
> > 
> > FYI, the mail subject header hasn't changed so Dave might not notice
> > this is a new patch.
> 
> Saw it.
> 
> > > +_mount /dev/mapper/$vgname-$snapname $mnt
> > > +
> > > +# write 5M data to the snapshot
> > > +$XFS_IO_PROG -fc "pwrite 0 5m" $mnt/testfile >>$seqres.full 2>&1
> > > +
> > 
> > I noticed there were no errors in $seqres.full when running this test.
> > E.g., the pwrite succeeds because nothing is written back to disk at
> > that point. The fs does shutdown due to the flush on umount, but it's
> > kind of hidden away up in the _cleanup() function.
> > 
> > Kind of a nit, but we could be a bit more explicit and do a '-c fsync'
> > after the pwrite here? That way it's clear that writeback to disk is
> > part of the core test and we have a little feedback in $seqres.full that
> > I/O errors occurred, as expected.
> 
> Added the -c fsync as I pulled it in.

I was thinking about adding fsync or sync at first, but it causes
problems in cleanup. For some reason(I don't know clearly) fsync
sometimes pins the snapshot in use and vgremove can't remove all lvs, so
SCRATCH_DEV is still used by the test vg when running next test

our local _scratch_mkfs routine ...                                                                                                                                              
mkfs.xfs: cannot open /dev/sda6: Device or resource busy                                                                                         
check: failed to mkfs $SCRATCH_DEV using specified options

>From 081.full I can see

Logical volume vg_081/snap_081 contains a filesystem in use.

The test vg/lv has to be removed manually after the test

vgremove -f vg_081

I don't find a proper way to fix it yet, but simply adding 'sleep 1'
before vgremove in _cleanup works for me

[root@hp-dl388eg8-01 xfstests]# git diff
diff --git a/tests/generic/081 b/tests/generic/081
index 3e17d34..29b0240 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -36,6 +36,7 @@ _cleanup()
        rm -f $tmp.*
        # lvm may have umounted it on I/O error, but in case it does not
        $UMOUNT_PROG $mnt >/dev/null 2>&1
+       sleep 1
        $LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
        $LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
 }

Thanks,
Eryu
