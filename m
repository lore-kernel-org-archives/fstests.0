Received: from mx1.redhat.com ([209.132.183.28]:55225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbcFQQuD (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 17 Jun 2016 12:50:03 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76D69C0B64DF
	for <fstests@vger.kernel.org>; Fri, 17 Jun 2016 16:50:03 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5HGo1fL020781
	for <fstests@vger.kernel.org>; Fri, 17 Jun 2016 12:50:02 -0400
Date: Sat, 18 Jun 2016 00:50:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/rc: ignore MKFS_OPTIONS in
 _scratch_mkfs_xfs_supported()
Message-ID: <20160617165001.GL5140@eguan.usersys.redhat.com>
References: <1465718229-19485-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465718229-19485-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 12, 2016 at 03:57:09PM +0800, Eryu Guan wrote:
> In recent mkfs updates in xfsprogs, commit 9090e187bc3e ("mkfs: add
> respecification detection to generic parsing") added re-specification
> detection to "-m" option, it causes several tests _notrun if
> MKFS_OPTIONS has the same options as those being tested in
> _scratch_mkfs_xfs_supported(), because they're specified multiple times.
> 
> 	MKFS_OPTIONS="-m crc=0" ./check xfs/001
> 	xfs/001 3s ... [not run] mkfs.xfs doesn't have crc feature
> 
> Fix it by removing MKFS_OPTIONS when testing mkfs features in
> _scratch_mkfs_xfs_supported(), only $mkfs_opts matters.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Self-NAK, this breaks other tests like xfs/186. Currently xfs/186 only
runs with MKFS_OPTIONS="-m crc=0" set, and depends on MKFS_OPTIONS in
_scratch_mkfs_xfs_supported(). Not sure what's the best fix yet.

Thanks,
Eryu

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 51092a0..c7a7667 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -477,7 +477,7 @@ _scratch_mkfs_xfs_supported()
>  
>  	_scratch_options mkfs
>  
> -	$MKFS_XFS_PROG -N $MKFS_OPTIONS $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
> +	$MKFS_XFS_PROG -N $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
>  }
>  
>  _scratch_mkfs_xfs()
> -- 
> 2.5.5
> 
