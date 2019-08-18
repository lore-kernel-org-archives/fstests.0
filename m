Received: from mail-pl1-f194.google.com ([209.85.214.194]:43411 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRPWp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Aug 2019 11:22:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so4557473pld.10
        for <fstests@vger.kernel.org>; Sun, 18 Aug 2019 08:22:44 -0700 (PDT)
Date: Sun, 18 Aug 2019 23:22:36 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/322: remove bad xfs_io sync_range
Message-ID: <20190818152236.GA2845@desktop>
References: <20190805222738.21422-1-agruenba@redhat.com>
 <CAHc6FU6wt_GDPuhrp-z3ZwptrM9rOu5V2fH_7N8BfGNKNQUVag@mail.gmail.com>
 <20190815144957.tyfecxfgdhanaex7@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815144957.tyfecxfgdhanaex7@MacBook-Pro-91.local>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 15, 2019 at 10:49:58AM -0400, Josef Bacik wrote:
> On Tue, Aug 06, 2019 at 03:48:32PM +0200, Andreas Gruenbacher wrote:
> > On Tue, 6 Aug 2019 at 00:27, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > >
> > > The xfs_io sync_range command requires offset and length arguments.  Those are
> > > missing here, so the command fails with:
> > >
> > >   bad argument count 1 to sync_range, expected at least 2 arguments
> > >
> > > This went unnoticed because xfs_io still exits with status 0 in such cases,
> > > which looks like a separate bug.
> > >
> > > I'm assuming that the test did catch regressions as is and that the sync_range
> > > command isn't needed.  If this isn't the case, please fix the test.
> > 
> > Copying Josef who seems to be the author of this test case.
> 
> Looking back at it I think I added the sync_range because it was a little racey
> wether it would trip the problem or not.  The rename in btrfs would do the dirty
> writeout IIRC so that's probably why the problem still reproduced even though
> the sync file range was wrong.
> 
> That being said the sync_range needs to be there, so instead of deleting it we
> should have
> 
> sync_range -b 2M 1M

Hi Andreas, would you like to update the patch with the sync_range
fixed?

Thanks,
Eryu
