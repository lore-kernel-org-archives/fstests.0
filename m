Received: from mail-qk1-f193.google.com ([209.85.222.193]:41966 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbfHOOuB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Aug 2019 10:50:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so2002695qkk.8
        for <fstests@vger.kernel.org>; Thu, 15 Aug 2019 07:50:00 -0700 (PDT)
Date: Thu, 15 Aug 2019 10:49:58 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] generic/322: remove bad xfs_io sync_range
Message-ID: <20190815144957.tyfecxfgdhanaex7@MacBook-Pro-91.local>
References: <20190805222738.21422-1-agruenba@redhat.com>
 <CAHc6FU6wt_GDPuhrp-z3ZwptrM9rOu5V2fH_7N8BfGNKNQUVag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6wt_GDPuhrp-z3ZwptrM9rOu5V2fH_7N8BfGNKNQUVag@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 06, 2019 at 03:48:32PM +0200, Andreas Gruenbacher wrote:
> On Tue, 6 Aug 2019 at 00:27, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > The xfs_io sync_range command requires offset and length arguments.  Those are
> > missing here, so the command fails with:
> >
> >   bad argument count 1 to sync_range, expected at least 2 arguments
> >
> > This went unnoticed because xfs_io still exits with status 0 in such cases,
> > which looks like a separate bug.
> >
> > I'm assuming that the test did catch regressions as is and that the sync_range
> > command isn't needed.  If this isn't the case, please fix the test.
> 
> Copying Josef who seems to be the author of this test case.

Looking back at it I think I added the sync_range because it was a little racey
wether it would trip the problem or not.  The rename in btrfs would do the dirty
writeout IIRC so that's probably why the problem still reproduced even though
the sync file range was wrong.

That being said the sync_range needs to be there, so instead of deleting it we
should have

sync_range -b 2M 1M

Thanks,

Josef
