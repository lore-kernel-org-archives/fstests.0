Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:64396 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751303AbeBLFJR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Feb 2018 00:09:17 -0500
Date: Mon, 12 Feb 2018 16:08:40 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3] generic: add stress test for fanotify and inotify
Message-ID: <20180212050840.GC7000@dastard>
References: <CCAOQ4uxh2ZmEJi8gbiDRsYefV+XC20TNLjW9OFOZM0=j0_0yf+Q@mail.gmail.com>
 <1518332344-4772-1-git-send-email-xzhou@redhat.com>
 <CAOQ4uxj7AWbDm78k23bnekcSTZm17RkWh44aE0mhAQ7wyguixg@mail.gmail.com>
 <20180212004126.w6tg2ohcrbt7qhdv@XZHOUW.usersys.redhat.com>
 <CAOQ4uxht-TkTiH+=9gp29XtCPv9=QR0v5FGFFvL+Ag9Nvshaww@mail.gmail.com>
 <20180212043357.x6dhq67wghzgafrw@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212043357.x6dhq67wghzgafrw@XZHOUW.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 12, 2018 at 12:33:57PM +0800, Xiong Zhou wrote:
> On Mon, Feb 12, 2018 at 05:50:21AM +0200, Amir Goldstein wrote:
> > Patchset is for a reason - the reason is that all patches should be
> > reviewed and merged together. But that's got nothing to do with the
> > reason you should list the fix commit in test description.
> > The reason for that is that testers needs to know if test is expected to
> > fail or pass on the kernel they are using.
> 
> AFAIK, known issue tracking is not handled by fstests.

And by that reasoning, commit IDs for bug fixes should not be in
fstests at all.

However, it is useful to many people to have a reference to the fix
associated with the test (or at least it's initial commit). That can
either be a commit ID or a url that points to the patch on the
mailing list that will be committed to fix it.

> > Listing the cleanup patches does not serve this purpose.
> > In fact, it may confuse people testing stable kernels, because stable
> > kernel could have fix patches applied but not all cleanup patches.
> 
> Interesting, I'm listing all of them and I'm saying "fixed by this series"
> not "fixed by this commit".

That's way too much irrelevant information, especially as "issue
tracking is not handled by fstests".

Please listen to Amir and follow the convention that everyone has
agreed on for referencing the fix a regression test relates to.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
