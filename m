Received: from mx1.redhat.com ([209.132.183.28]:46430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753283AbdGKLNn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Jul 2017 07:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 876F183F45
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2017 11:13:42 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-20.bos.redhat.com [10.18.41.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AFA15D964
        for <fstests@vger.kernel.org>; Tue, 11 Jul 2017 11:13:42 +0000 (UTC)
Date: Tue, 11 Jul 2017 07:13:41 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [WIP PATCH V2] Buffer resubmittion test
Message-ID: <20170711111341.GA24477@bfoster.bfoster>
References: <20170710133418.7083-1-cmaiolino@redhat.com>
 <20170710145522.GA17652@bfoster.bfoster>
 <20170710150612.ofjodvipik7wvpnu@eorzea.usersys.redhat.com>
 <20170710151343.GB17652@bfoster.bfoster>
 <20170710155223.xmco3qgecbffug56@eorzea.usersys.redhat.com>
 <20170711083955.zw6ksal76mh2fozl@eorzea.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711083955.zw6ksal76mh2fozl@eorzea.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 11, 2017 at 10:39:55AM +0200, Carlos Maiolino wrote:
> Hi Brian,
> 
> > > > > 
> > > > > The test is still under xfs (rather than generic).
> > > > > 
> 
> I'm still not really convinced this test should be added to generic, this tests
> a very specific behavior of XFS journal, the journal behavior on XFS and ext4
> for example, are very different,
> 

Sure, but this generally isn't how we determine whether a test is
generic or fs-specific. IME, a test is made specific iff it depends on
some fs-specific feature/option to run, regardless of whether the
underlying problem is generic or not.

Granted, if there is a major behavior discrepency between filesystems
such that making this test generic would complicate the test or require
a different implementation, I think that is reasonable enough for an
exception.

> either ext4 or btrfs for example, will remount the filesystem as RO during the
> xfs_io process to fill the filesystem, so, even though the filesystem can keep
> consistency, the test shows it as a failure.
> 
> What do you think? I honestly believe it would be better to keep this test as a
> XFS test, the behavior here is XFS specific.
> 

Ok, so to me the question here is: can we make this test function
normally on both XFS and other fs' that exhibit the behavior above
without major changes and disrupting the original intent? For example,
can the test be updated to accommodate the fact that some filesystems
may go inactive after the overprovisioned write?

It seems to me that it can with something as simple as the appended
diff. Of course, this probably should be enhanced further to verify that
the fs went read-only or to simply not ignore a freeze failure if [
$FSTYP == xfs ], etc.

Brian

--- 8< ---

diff --git a/tests/xfs/999 b/tests/xfs/999
old mode 100644
new mode 100755
index b46f1cc8..5ee7521b
--- a/tests/xfs/999
+++ b/tests/xfs/999
@@ -55,7 +55,6 @@ _cleanup()
 # real QA test starts here
 
 # Modify as appropriate.
-_supported_fs xfs
 _supported_os Linux
 _require_scratch_nocheck
 _require_dm_target thin-pool
@@ -102,7 +101,8 @@ xfs_io -f -d -c 'pwrite -b 1m 0 120m' $SCRATCH_MNT/f1 >>$seqres.full 2>&1
 
 # This freeze will never complete until the dm-thin POOL device is extended.
 # This is expected, it is only used so xfsaild is triggered to flush AIL items.
-fsfreeze -f $SCRATCH_MNT &
+fsfreeze -f $SCRATCH_MNT >>$seqres.full 2>&1 &
+freezepid=$!
 
 # Wait enough so xfsaild can run
 sleep 10
@@ -110,9 +110,12 @@ sleep 10
 # Make some extra space available so the freeze above can proceed
 lvextend -L $newpsize $vgname/$poolname >>$seqres.full 2>&1
 
+wait -n $freezepid
+ret=$?
+
 # Try to thaw the filesystem, and complete test if if succeed.
 # NOTE: This will hang on affected XFS filesystems.
-fsfreeze -u $SCRATCH_MNT
+[ $ret == 0 ] && fsfreeze -u $SCRATCH_MNT
 echo "Test OK"
 
 status=0
