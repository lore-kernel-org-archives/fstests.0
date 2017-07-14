Received: from mx1.redhat.com ([209.132.183.28]:50888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753182AbdGNDqp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 13 Jul 2017 23:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B38FC0587D4
        for <fstests@vger.kernel.org>; Fri, 14 Jul 2017 03:46:44 +0000 (UTC)
Date: Fri, 14 Jul 2017 11:46:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH V2] xfstests: Test filesystem lockup on full
 overprovisioned dm-thin
Message-ID: <20170714034640.GJ2478@eguan.usersys.redhat.com>
References: <20170713131208.28671-1-cmaiolino@redhat.com>
 <20170713154258.GA38668@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713154258.GA38668@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: Carlos Maiolino <cmaiolino@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 13, 2017 at 11:42:59AM -0400, Brian Foster wrote:
> On Thu, Jul 13, 2017 at 03:12:08PM +0200, Carlos Maiolino wrote:
> > With thin devices, it's possible to have a virtual device larger than
> > the physical device itself, and such situation can cause problems to
> > filesystems, once the filesystem 'believe' to have more space than it
> > actually has.
> > 
> > This can lead the filesystem to several weird behaviors. The one tested
> > here is filesystem lockup.
> > 
> > In case of XFS, it locks up when trying to writeback AIL metadata back
> > to the filesystem, but, once there is no physical space available, XFS
> > locks up and do not gracefuly handle this case.
> > 
> > Other filesystems usually are remounted as read-only, so they already
> > have this situation covered.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Thanks for the update!

> > ---
> 
> Looks good to me. Any lingering concerns from Eryu aside:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

Looks good to me too, thanks for the review!

Eryu
