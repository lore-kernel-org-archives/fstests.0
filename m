Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:21282 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757149AbcHWGy4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Aug 2016 02:54:56 -0400
Date: Tue, 23 Aug 2016 16:54:47 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [GIT PULL] fstests: updates on 2016-08-20
Message-ID: <20160823065447.GY19025@dastard>
References: <201608201444.u7KEi22g015351@int-mx14.intmail.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201608201444.u7KEi22g015351@int-mx14.intmail.prod.int.phx2.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 20, 2016 at 10:44:01PM +0800, Eryu Guan wrote:
> Hi Dave,
> 
> Can you please pull the fstests update from the location below? This is a
> normal update, which contains new generic and XFS tests and other fixes.
> 
> Thanks,
> Eryu
> 
> The following changes since commit c760a54061d26890be3929e4c6659bf3dc9e0c6a:
> 
>   src/t_immutable: allow EPERM on immutable inode (2016-08-12 11:17:34 +0800)
> 
> are available in the git repository at:
> 
>   https://github.com/guaneryu/xfstests.git for-dave
> 
> for you to fetch changes up to 3c75489a57518745598e239ffeec2af64400f185:
> 
>   common/rc: improve _require_metadata_journaling() for ext4 (2016-08-20 00:54:28 +0800)
> 
> ----------------------------------------------------------------
> 
> fstests: update on 2016-08-20
> 
> This update contains:
> o New tests for generic and XFS
> o Miscellaneous small fixes
> 
> ----------------------------------------------------------------
> Brian Foster (1):
>       generic: shutdown fs after log recovery

Hi Eryu,

I just pulled this all in and got an unexpected surprise - this new
test killed all of my test machines. From your description ("normal
update") I didn't expect to see something like this occur - I pulled
it, confirmed commits match, then pushed it to my test machines
and started a test cycle. I expected to see it complete without any
significant problems.

The issue here is that this new test exercises a crash case and does
not have fixes that are upstream yet - we have review backlog that
has piled up while 4.8-rc1 regressions are being dealt with and
getting the xfsprogs rmap support reviewed and merged. Upstream can
only move as fast as review bandwidth will allow, and so sometimes
things don't get merged as quickly as we'd all like.

As such, can you try to hold off merging new tests that crash or
hang systems until the bug fixes have been committed in the upstream
repositories? This won't affect reviewers or testers (they grab
the test in themselves to exercise the problem), but for everyone
else merging it will just be a nuisance because there's nothing they
can do to make the test pass (excluding it is the only solution).

In future, maybe it would be a good idea to ask the patch submitter
to tell you when the fix for a dangerous test like this has been
merged? That way you can and use that to determine when you push it
out for everyone? If it's just a pass/fail test it really doesn't
matter, but dangerous tests need to be handled a bit more
carefully.

For now, I'm going to hold off pushing this update out so other
people don't have to work around this issue whilst we clear out the
upstream patch backlog. Hopefully that won't take too long.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
