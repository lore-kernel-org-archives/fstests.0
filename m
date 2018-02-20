Received: from userp2120.oracle.com ([156.151.31.85]:38362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeBTRUZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Feb 2018 12:20:25 -0500
Date: Tue, 20 Feb 2018 09:20:21 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fstests: _fail test by default when _scratch_mount fails
Message-ID: <20180220172021.GB14582@magnolia>
References: <20180218124457.28597-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218124457.28597-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Sun, Feb 18, 2018 at 08:44:57PM +0800, Eryu Guan wrote:
> Previously _scratch_mount didn't check the mount status and most
> tests continue to run even if the mount failed (unless test checks
> for the mount status explicitly). This would result in running tests
> on the underlying filesystem (usually rootfs) and implicit test
> failures, and such failures can be annoying and are usually hard to
> debug.
> 
> Now _fail test by default if _scratch_mount failed and introduce
> _try_scratch_mount for tests that need to check mount results
> themselves. Also introduce a new _try_scratch_mount helper that does
> scratch mount without checking mount status for tests that do the
> check themselves.
> 
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Eryu Guan <eguan@redhat.com>

The common/generic/shared/xfs parts look ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(The ext4/btrfs parts seemed ok at a quick glance, but I'm not as
familiar with them.)

--D
