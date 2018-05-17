Received: from mx2.suse.de ([195.135.220.15]:47191 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeEQKGM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 17 May 2018 06:06:12 -0400
Date: Thu, 17 May 2018 12:06:11 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] generic/382: Fix test when report uses /etc/passwd
Message-ID: <20180517100611.4wzbvxsswqah4qsi@quack2.suse.cz>
References: <20180514170351.13737-1-jack@suse.cz>
 <20180514170351.13737-3-jack@suse.cz>
 <20180517024250.GD29080@desktop.hz.ali.com>
 <20180517091836.ep4pydgqpg6cihgy@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mgavp3rnvnsapbdn"
Content-Disposition: inline
In-Reply-To: <20180517091836.ep4pydgqpg6cihgy@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--mgavp3rnvnsapbdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 17-05-18 11:18:36, Jan Kara wrote:
> On Thu 17-05-18 10:42:50, Eryu Guan wrote:
> > On Mon, May 14, 2018 at 07:03:50PM +0200, Jan Kara wrote:
> > > On older kernels xfs_quota uses /etc/passwd to report quota entries. In
> > > such case all-zero lines disturb its output and the test fails. Fix the
> > > problem by ignoring all-zero lines in quota report.
> > 
> > I notice that generic/381 does quota report in a similar way as in
> > generic/382, is 381 affected by the same problem? If only generic/382 is
> > affected, we could move the filter from common/filter to the test
> > itself.
> 
> Yes, that test is affected as well. I just didn't notice because on my
> system I don't have user 123456-fsgqa (SLE/openSUSE don't allow you to
> create user with such name and I didn't bother to force-create it by
> manually editting passwd). I'll send a patch to update that test to use the
> filter as well if you're otherwise fine with this approach.

Attached is a patch for generic/381.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--mgavp3rnvnsapbdn
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-generic-381-Fix-test-when-report-uses-etc-passwd.patch"

>From b3ee82ef8a81ed4ab41ad840ff55acd458654b58 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 17 May 2018 11:27:21 +0200
Subject: [PATCH] generic/381: Fix test when report uses /etc/passwd

On older kernels xfs_quota uses /etc/passwd to report quota entries. In
such case all-zero lines disturb its output and the test fails. Fix the
problem by ignoring all-zero lines in quota report.

Reported-by: Eryu Guan <guaneryu@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/381 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/381 b/tests/generic/381
index 006f0d879638..72adbee66848 100755
--- a/tests/generic/381
+++ b/tests/generic/381
@@ -67,7 +67,7 @@ $XFS_QUOTA_PROG -x -c "limit -u bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT
 echo "=== quota command output ==="
 $XFS_QUOTA_PROG -c "quota -u -b -N -v 123456-fsgqa" $SCRATCH_MNT | _filter_quota
 echo "=== report command output ==="
-$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota
+$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota_report | _filter_quota
 
 # group test
 echo "== group test =="
@@ -75,7 +75,7 @@ $XFS_QUOTA_PROG -x -c "limit -g bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT
 echo "=== quota command output ==="
 $XFS_QUOTA_PROG -c "quota -g -b -N -v 123456-fsgqa" $SCRATCH_MNT | _filter_quota
 echo "=== report command output ==="
-$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota
+$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota_report | _filter_quota
 
 # success, all done
 status=0
-- 
2.13.6


--mgavp3rnvnsapbdn--
