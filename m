Received: from aserp1040.oracle.com ([141.146.126.69]:38546 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdHPPxQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Aug 2017 11:53:16 -0400
Date: Wed, 16 Aug 2017 08:53:07 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: Test infinite loop while searching for a free inode
 slot
Message-ID: <20170816155307.GA4794@magnolia>
References: <20170815125541.12243-1-cmaiolino@redhat.com>
 <20170816070214.GJ14807@eguan.usersys.redhat.com>
 <20170816073159.GL14807@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816073159.GL14807@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Carlos Maiolino <cmaiolino@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 16, 2017 at 03:31:59PM +0800, Eryu Guan wrote:
> On Wed, Aug 16, 2017 at 03:02:14PM +0800, Eryu Guan wrote:
> > > +
> > > +_scratch_unmount
> > > +
> > > +# agi->freecount is 0 here, corrupt it to show extra free inodes
> > > +$XFS_DB_PROG -x -c "agi 0" -c "write -d freecount 10" $SCRATCH_DEV >/dev/null 2>&1
> > 
> > redirect stdout and stderr to $seqres.full for debug purpose
> 
> And you can use _scratch_xfs_db wrapper instead of open coded xfs_db
> command.
> 
> And I found that "write -d" failed on a crc=0 XFS, though "write -c"
> allows corrupted data and bad CRC, but touch couldn't reproduce the hang
> in this case, because kernel detected bad crc first and aborted inode
> creation.

What error did you get, specifically?

Sounds more like a bug in write/fuzz -d to me. :)

--D

> 
> I think we can force a CRC enabled XFS by
> 
> _scratch_mkfs -m crc=1,finobt=0 >>$seqres.full 2>&1
> 
> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
