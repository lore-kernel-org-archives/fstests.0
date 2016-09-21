Received: from mx1.redhat.com ([209.132.183.28]:54352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753389AbcIUGoo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Sep 2016 02:44:44 -0400
Date: Wed, 21 Sep 2016 14:44:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 3/3] move now-generic quota tests to generic
Message-ID: <20160921064441.GJ27776@eguan.usersys.redhat.com>
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <06d804f2-646e-a586-bed1-416ffde8e0e9@sandeen.net>
 <20160920234048.GB10454@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160920234048.GB10454@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 21, 2016 at 09:40:48AM +1000, Dave Chinner wrote:
> On Tue, Sep 20, 2016 at 05:24:59PM -0500, Eric Sandeen wrote:
> > Now that these tests have been made generic, move them into
> > the generic/ dir and update group files.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> 
> I wonder if this would be better done simply as a tools/mvtest
> script for the maintainer to run. e.g.
> 
> #!/bin/sh
> 
> tools/mvtest xfs/054 generic/380
> tools/mvtest xfs/118 generic/381
> tools/mvtest xfs/138 generic/382
> tools/mvtest xfs/260 generic/383
> 
> #EOF
> 
> Rather than ending up with patch that won't apply because we've
> already applied another patch that added a new test that conflicts?
> Reviewing the change is also heaps easier :)

Either way is OK for me. Usually it's not a big problem, I always have
to renumber tests and resolve the conflicts. And as this patch doesn't
apply due to the patch corruption at the end, I re-did the patch by
running mvtest script.

> 
> > ---
> > 
> > diff --git a/tests/generic/group b/tests/generic/group
> > index a602b01..f5ebbb1 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -381,3 +381,8 @@
> >  376 auto quick metadata
> >  377 attr auto quick metadata
> >  378 auto quick metadata
> > +380 quota auto quick

I re-numbered them starting from 379.

> > +381 quota auto quick
> > +382 auto quick quota
> > +383 auto quick quota
> > +
> 
> No trailing blank line....

Fixed at commit time. And start testing them now.

Thanks,
Eryu
