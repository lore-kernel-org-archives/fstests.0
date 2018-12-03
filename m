Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:21550 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbeLCIRr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 03:17:47 -0500
Date: Mon, 3 Dec 2018 19:17:43 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/3] generic: copy_file_range bounds test
Message-ID: <20181203081743.GX19305@dastard>
References: <20181203064256.26768-1-david@fromorbit.com>
 <20181203064256.26768-4-david@fromorbit.com>
 <CAOQ4uxgddSnVGC6+JmpiseAGKcKVjSq6nYOD4tAMUx5y8Yx3XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgddSnVGC6+JmpiseAGKcKVjSq6nYOD4tAMUx5y8Yx3XA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Olga Kornievskaia <kolga@netapp.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 03, 2018 at 09:25:19AM +0200, Amir Goldstein wrote:
> On Mon, Dec 3, 2018 at 8:43 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Test that copy_file_range will return the correct errors for various
> > error conditions and boundary constraints.
....
> 
> All the test cases above check for bugs, which I presume your kernel patch
> series is aimed at fixing(?)

Yes. Document the API (I have a man page patch) write the tests to
exercise correct API behaviour (these patches), fix the API
implementation until the tests start passing (still to be posted as
I wait for these to hit mailing list archives so I can point at
them).

> This one last test case tests for new functionality that is not
> currently available
> for any filesystem in upstream kernel.

Yup.

> Does your kernel patch set also add this functionality to xfs? to generic?

Yes and yes. overlay works, too, but I gave up caring about it
because it doesn't support the ioctls xfs_io uses in this test to
change open file state....

> IMO, it would be better to split this test case for new functionality to a new
> test, so that this one can pass on stable kernels once all the bug
> fixes have been
> applied.

Whatever. I'm tired, I've already put in 13 hours on this today and
I'm on the back of four 100+ hour weeks working on nothing but this
broken heap of crap.

Take it or leave it, because I'm just about burnt out on this
right now...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
