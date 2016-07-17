Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:41822 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751295AbcGQXa6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 17 Jul 2016 19:30:58 -0400
Date: Mon, 18 Jul 2016 09:30:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] common/rc: avoid mkfs option conflicts in
 _scratch_mkfs_xfs_supported
Message-ID: <20160717233056.GY1922@dastard>
References: <1468556451-19817-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468556451-19817-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 15, 2016 at 12:20:51PM +0800, Eryu Guan wrote:
> In recent mkfs.xfs updates in xfsprogs, commit 9090e187bc3e ("mkfs:
> add respecification detection to generic parsing") added
> re-specification detection to "-m" option, it causes several tests
> _notrun if MKFS_OPTIONS has the same options as those being tested
> in _scratch_mkfs_xfs_supported(), because they're specified multiple
> times.
> 
> 	MKFS_OPTIONS="-m crc=0" ./check xfs/001
> 	xfs/001 3s ... [not run] mkfs.xfs doesn't have crc feature
> 
> Fix it by creating XFS again without MKFS_OPTIONS in
> _scratch_mkfs_xfs_supported(), in case there's conflict between
> MKFS_OPTIONS and mkfs_opts, like what we do in _scratch_mkfs_xfs().
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
