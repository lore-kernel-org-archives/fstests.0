Received: from mx1.redhat.com ([209.132.183.28]:39940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbdHPHcE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Aug 2017 03:32:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 500EA7974E
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2017 07:32:04 +0000 (UTC)
Date: Wed, 16 Aug 2017 15:31:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: Test infinite loop while searching for a free inode
 slot
Message-ID: <20170816073159.GL14807@eguan.usersys.redhat.com>
References: <20170815125541.12243-1-cmaiolino@redhat.com>
 <20170816070214.GJ14807@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170816070214.GJ14807@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Carlos Maiolino <cmaiolino@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 16, 2017 at 03:02:14PM +0800, Eryu Guan wrote:
> > +
> > +_scratch_unmount
> > +
> > +# agi->freecount is 0 here, corrupt it to show extra free inodes
> > +$XFS_DB_PROG -x -c "agi 0" -c "write -d freecount 10" $SCRATCH_DEV >/dev/null 2>&1
> 
> redirect stdout and stderr to $seqres.full for debug purpose

And you can use _scratch_xfs_db wrapper instead of open coded xfs_db
command.

And I found that "write -d" failed on a crc=0 XFS, though "write -c"
allows corrupted data and bad CRC, but touch couldn't reproduce the hang
in this case, because kernel detected bad crc first and aborted inode
creation.

I think we can force a CRC enabled XFS by

_scratch_mkfs -m crc=1,finobt=0 >>$seqres.full 2>&1

Thanks,
Eryu
