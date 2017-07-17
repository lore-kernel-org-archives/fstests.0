Received: from mx1.redhat.com ([209.132.183.28]:52198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdGQKv6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Jul 2017 06:51:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7783980F97
        for <fstests@vger.kernel.org>; Mon, 17 Jul 2017 10:51:58 +0000 (UTC)
Date: Mon, 17 Jul 2017 12:51:55 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH V2] xfstests: Test filesystem lockup on full
 overprovisioned dm-thin
Message-ID: <20170717084130.dparhukikbbykac5@eorzea.usersys.redhat.com>
References: <20170713131208.28671-1-cmaiolino@redhat.com>
 <20170713154258.GA38668@bfoster.bfoster>
 <20170714034640.GJ2478@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714034640.GJ2478@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 14, 2017 at 11:46:40AM +0800, Eryu Guan wrote:
> On Thu, Jul 13, 2017 at 11:42:59AM -0400, Brian Foster wrote:
> > On Thu, Jul 13, 2017 at 03:12:08PM +0200, Carlos Maiolino wrote:
> > > With thin devices, it's possible to have a virtual device larger than
> > > the physical device itself, and such situation can cause problems to
> > > filesystems, once the filesystem 'believe' to have more space than it
> > > actually has.
> > > 
> > > This can lead the filesystem to several weird behaviors. The one tested
> > > here is filesystem lockup.
> > > 
> > > In case of XFS, it locks up when trying to writeback AIL metadata back
> > > to the filesystem, but, once there is no physical space available, XFS
> > > locks up and do not gracefuly handle this case.
> > > 
> > > Other filesystems usually are remounted as read-only, so they already
> > > have this situation covered.
> > > 
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> 

Somehow these messages were marked as read on my MUA.

Thanks for the review folks.

Time to finish the kernel fix for this test

Cheers

-- 
Carlos
