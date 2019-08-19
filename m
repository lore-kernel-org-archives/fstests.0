Received: from mx1.redhat.com ([209.132.183.28]:37336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSJAE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Aug 2019 05:00:04 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EEBA7E425
        for <fstests@vger.kernel.org>; Mon, 19 Aug 2019 09:00:04 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id k22so1948218otn.12
        for <fstests@vger.kernel.org>; Mon, 19 Aug 2019 02:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190805222738.21422-1-agruenba@redhat.com> <CAHc6FU6wt_GDPuhrp-z3ZwptrM9rOu5V2fH_7N8BfGNKNQUVag@mail.gmail.com>
 <20190815144957.tyfecxfgdhanaex7@MacBook-Pro-91.local> <20190818152236.GA2845@desktop>
In-Reply-To: <20190818152236.GA2845@desktop>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 19 Aug 2019 10:59:52 +0200
Message-ID: <CAHc6FU60uQLYL2daU-5-cB9mA7vqMjqK9VEQ8u5JOxH=Rx5QnQ@mail.gmail.com>
Subject: Re: [PATCH] generic/322: remove bad xfs_io sync_range
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Aug 18, 2019 at 5:22 PM Eryu Guan <guaneryu@gmail.com> wrote:
> On Thu, Aug 15, 2019 at 10:49:58AM -0400, Josef Bacik wrote:
> > On Tue, Aug 06, 2019 at 03:48:32PM +0200, Andreas Gruenbacher wrote:
> > > On Tue, 6 Aug 2019 at 00:27, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > >
> > > > The xfs_io sync_range command requires offset and length arguments.  Those are
> > > > missing here, so the command fails with:
> > > >
> > > >   bad argument count 1 to sync_range, expected at least 2 arguments
> > > >
> > > > This went unnoticed because xfs_io still exits with status 0 in such cases,
> > > > which looks like a separate bug.
> > > >
> > > > I'm assuming that the test did catch regressions as is and that the sync_range
> > > > command isn't needed.  If this isn't the case, please fix the test.
> > >
> > > Copying Josef who seems to be the author of this test case.
> >
> > Looking back at it I think I added the sync_range because it was a little racey
> > wether it would trip the problem or not.  The rename in btrfs would do the dirty
> > writeout IIRC so that's probably why the problem still reproduced even though
> > the sync file range was wrong.
> >
> > That being said the sync_range needs to be there, so instead of deleting it we
> > should have
> >
> > sync_range -b 2M 1M
>
> Hi Andreas, would you like to update the patch with the sync_range
> fixed?

Done, if that helps.

Andreas
