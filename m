Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:20950 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757656AbcHYF5S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 01:57:18 -0400
Date: Thu, 25 Aug 2016 15:57:13 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/337: add checks for listxattr call fails.
Message-ID: <20160825055713.GN22388@dastard>
References: <1472039753-29982-1-git-send-email-asavkov@redhat.com>
 <20160825040944.GV27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160825040944.GV27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Artem Savkov <asavkov@redhat.com>, fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 25, 2016 at 12:09:44PM +0800, Eryu Guan wrote:
> On Wed, Aug 24, 2016 at 01:55:53PM +0200, Artem Savkov wrote:
> > Add simple checks for failed calls to listxattr syscall. So far ERANGE, ENOENT
> > and EFAULT are checked.
> > 
> > Test is based on llistxattr02 test from LTP.
> 
> Any reason porting this from LTP? I think LTP is the right place for
> such syscall level tests, this test should stay there, or extend
> llistxattr02 test if you want to test new errnos.

It's pretty clear that nobody is actually using LTP in their
day-to-day development work-flow. It's a pain to build and
configure and it wants to write to places it shouldn't.

I asked that this test be added to xfstests, and that's especially
important because I can't reproduce the reported problem with LTP.
Hence we need to work out a reliable reproducer, and really that
belongs in xfstests along with all the other xattr tests we run.

> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > ---
> >  .gitignore            |  1 +
> >  src/Makefile          |  2 +-
> >  src/listxattr_fails.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/337     |  4 ++++
> >  tests/generic/337.out |  3 +++
> >  5 files changed, 60 insertions(+), 1 deletion(-)
> >  create mode 100644 src/listxattr_fails.c
> > 
> > diff --git a/.gitignore b/.gitignore
> > index d84f385..613d245 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -66,6 +66,7 @@
> >  /src/holes
> >  /src/holetest
> >  /src/itrash
> > +/src/listxattr_fails

Not the best name for a test program. Better is to write a simple
tool that runs listxattr with a buffer size specified on the command
line. That way it canbe used for more than just the specific test
case. e.g. we can test corner cases rather than jsut "is the buffer
too small?" by creating specific combinations of extended attributes
and then calling the listxattr tool with different buffer sizes...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
