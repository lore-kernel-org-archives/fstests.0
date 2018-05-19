Received: from mail-pg0-f66.google.com ([74.125.83.66]:41647 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbeESLpw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 19 May 2018 07:45:52 -0400
Received: by mail-pg0-f66.google.com with SMTP id d14-v6so820137pgv.8
        for <fstests@vger.kernel.org>; Sat, 19 May 2018 04:45:52 -0700 (PDT)
Date: Sat, 19 May 2018 19:45:42 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 2/3] generic/382: Fix test when report uses /etc/passwd
Message-ID: <20180519114542.GH29080@desktop.hz.ali.com>
References: <20180514170351.13737-1-jack@suse.cz>
 <20180514170351.13737-3-jack@suse.cz>
 <20180517024250.GD29080@desktop.hz.ali.com>
 <20180517091836.ep4pydgqpg6cihgy@quack2.suse.cz>
 <20180517100611.4wzbvxsswqah4qsi@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517100611.4wzbvxsswqah4qsi@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 12:06:11PM +0200, Jan Kara wrote:
> On Thu 17-05-18 11:18:36, Jan Kara wrote:
> > On Thu 17-05-18 10:42:50, Eryu Guan wrote:
> > > On Mon, May 14, 2018 at 07:03:50PM +0200, Jan Kara wrote:
> > > > On older kernels xfs_quota uses /etc/passwd to report quota entries. In
> > > > such case all-zero lines disturb its output and the test fails. Fix the
> > > > problem by ignoring all-zero lines in quota report.
> > > 
> > > I notice that generic/381 does quota report in a similar way as in
> > > generic/382, is 381 affected by the same problem? If only generic/382 is
> > > affected, we could move the filter from common/filter to the test
> > > itself.
> > 
> > Yes, that test is affected as well. I just didn't notice because on my
> > system I don't have user 123456-fsgqa (SLE/openSUSE don't allow you to
> > create user with such name and I didn't bother to force-create it by
> > manually editting passwd). I'll send a patch to update that test to use the
> > filter as well if you're otherwise fine with this approach.
> 
> Attached is a patch for generic/381.
> 
> 								Honza

Thanks for the update! I probably will test the problem more in next
week (I'm traveling this weekend) and fold it into the generic/382 fix.
I'm taking the other two patches for this week's update.

Thanks,
Eryu

> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> From b3ee82ef8a81ed4ab41ad840ff55acd458654b58 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Thu, 17 May 2018 11:27:21 +0200
> Subject: [PATCH] generic/381: Fix test when report uses /etc/passwd
> 
> On older kernels xfs_quota uses /etc/passwd to report quota entries. In
> such case all-zero lines disturb its output and the test fails. Fix the
> problem by ignoring all-zero lines in quota report.
> 
> Reported-by: Eryu Guan <guaneryu@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/generic/381 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/381 b/tests/generic/381
> index 006f0d879638..72adbee66848 100755
> --- a/tests/generic/381
> +++ b/tests/generic/381
> @@ -67,7 +67,7 @@ $XFS_QUOTA_PROG -x -c "limit -u bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT
>  echo "=== quota command output ==="
>  $XFS_QUOTA_PROG -c "quota -u -b -N -v 123456-fsgqa" $SCRATCH_MNT | _filter_quota
>  echo "=== report command output ==="
> -$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota
> +$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota_report | _filter_quota
>  
>  # group test
>  echo "== group test =="
> @@ -75,7 +75,7 @@ $XFS_QUOTA_PROG -x -c "limit -g bsoft=100m bhard=200m 123456-fsgqa" $SCRATCH_MNT
>  echo "=== quota command output ==="
>  $XFS_QUOTA_PROG -c "quota -g -b -N -v 123456-fsgqa" $SCRATCH_MNT | _filter_quota
>  echo "=== report command output ==="
> -$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota
> +$XFS_QUOTA_PROG -x -c "report -u -b -N" $SCRATCH_MNT | grep -v "^root " | _filter_quota_report | _filter_quota
>  
>  # success, all done
>  status=0
> -- 
> 2.13.6
> 

