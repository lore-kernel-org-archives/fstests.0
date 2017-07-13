Received: from mx1.redhat.com ([209.132.183.28]:58406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdGMMM6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 13 Jul 2017 08:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2682E7A176
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2017 12:12:58 +0000 (UTC)
Date: Thu, 13 Jul 2017 14:12:54 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] xfstests: Test filesystem lockup on full overprovisioned
 dm-thin
Message-ID: <20170713121254.pftijci5aflidil2@eorzea.usersys.redhat.com>
References: <20170712080527.826-1-cmaiolino@redhat.com>
 <20170712091438.GA7015@eguan.usersys.redhat.com>
 <20170712121338.gtkhowgny2syjdvu@eorzea.usersys.redhat.com>
 <20170713104210.GF2478@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713104210.GF2478@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 13, 2017 at 06:42:10PM +0800, Eryu Guan wrote:
> On Wed, Jul 12, 2017 at 02:13:38PM +0200, Carlos Maiolino wrote:
> > Ugh, sorry, I missed these comments during my past reply
> > 
> > > > +
> > > > +_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> > > 
> > > Sorry, I should've asked earlier in your RFC patch.. can all these setup
> > > work be done with helpers in common/dmthin? e.g. _dmthin_init,
> > > _dmthin_grow, the backing dev size, virtual size etc. are handled
> > > properly in dmthin helpers. You could take generic/347 as an example.
> > > 
> > 
> > I could do that if strictly required, but I'll also need to add a new dmthin
> > helper to create snapshots, once this tests requires a snapshot. IIRC, LVM uses
> > some 'tricks' to create snapshots (see device-mapper doc in kernel source), so
> > this might add unneeded complexity to the test.
> > 
> > I can use the helpers in common/dmthin for sure, but if this is not strictly
> > required, I'd just stay with LVM instead of using device-mapper directly.
> 
> I don't think it's strictly required, if there're some good reasons. But
> I really like to see the reasons are explained in the test as comments.
> Otherwise it just makes me wondering why snapshot is needed, because
> it's not mentioned in the commit log nor in the test description.
> 
> Thanks,
> Eryu
> 
> P.S.
> 
> I played with this test a bit today and tried to get rid of snapshot but
> failed. The difference I can see between using snapshot or not is that,
> snapshot somehow makes metadata I/O error happens on block 0x0, while
> without it the error happens on other blocks, e.g. block 0xc100.
> 

Yup, the problem isn't easily reproducible without the snapshot here, but the
difference on the block being written 0x0 vs 0xc100 isn't the only difference, but
really don't remember now. Triggering the situation where we don't have space to
writeback the AIL items being flushed isn't quite trivial.

But I can certainly for sure add the snapshot requirement in the test
description here.

> XFS (dm-4): metadata I/O error: block 0x0 ("xfs_buf_iodone_callback_error") error 28 numblks 1
> vs
> XFS (dm-4): metadata I/O error: block 0xc100 ("xfs_buf_iodone_callback_error") error 28 numblks 32
> --

-- 
Carlos
