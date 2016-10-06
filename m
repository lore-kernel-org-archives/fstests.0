Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:54631 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751448AbcJFV7Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Oct 2016 17:59:24 -0400
Date: Fri, 7 Oct 2016 08:59:20 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH V2 2/2] fs/super.c: don't fool lockdep in freeze_super()
 and thaw_super() paths
Message-ID: <20161006215920.GE9806@dastard>
References: <20160926165525.GA9338@redhat.com>
 <20160927065135.GA1139@quack2.suse.cz>
 <20160927172901.GA11879@redhat.com>
 <20160930171434.GA2373@redhat.com>
 <20161002214225.GS9806@dastard>
 <20161003164435.GB6634@redhat.com>
 <20161004114341.GA8572@redhat.com>
 <20161004194435.GW9806@dastard>
 <20161005164432.GB15121@redhat.com>
 <20161006171758.GA21707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161006171758.GA21707@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Nikolay Borisov <kernel@kyup.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 06, 2016 at 07:17:58PM +0200, Oleg Nesterov wrote:
> Probably false positive? Although when I look at the comment above xfs_sync_sb()
> I think that may be sometging like below makes sense, but I know absolutely nothing
> about fs/ and XFS in particular.
> 
> Oleg.
> 
> 
> --- x/fs/xfs/xfs_trans.c
> +++ x/fs/xfs/xfs_trans.c
> @@ -245,7 +245,8 @@ xfs_trans_alloc(
>  	atomic_inc(&mp->m_active_trans);
>  
>  	tp = kmem_zone_zalloc(xfs_trans_zone,
> -		(flags & XFS_TRANS_NOFS) ? KM_NOFS : KM_SLEEP);
> +		(flags & (XFS_TRANS_NOFS | XFS_TRANS_NO_WRITECOUNT))
> +			? KM_NOFS : KM_SLEEP);
>  	tp->t_magic = XFS_TRANS_HEADER_MAGIC;
>  	tp->t_flags = flags;
>  	tp->t_mountp = mp;

Brief examination says caller should set XFS_TRANS_NOFS, not change
the implementation to make XFS_TRANS_NO_WRITECOUNT flag to also mean
XFS_TRANS_NOFS.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
