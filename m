Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:63497 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbeLCIKm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Dec 2018 03:10:42 -0500
Date: Mon, 3 Dec 2018 19:10:34 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] generic/43[014]: copy_range beyond source EOF should
 fail
Message-ID: <20181203081034.GW19305@dastard>
References: <20181203064256.26768-1-david@fromorbit.com>
 <20181203064256.26768-3-david@fromorbit.com>
 <CAOQ4uxgqadtGXDU3UJAJeFGwNKOW1d4Ti8bmVZ3_ycMeK-CAow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgqadtGXDU3UJAJeFGwNKOW1d4Ti8bmVZ3_ycMeK-CAow@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, linux-api@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 03, 2018 at 09:30:58AM +0200, Amir Goldstein wrote:
> On Mon, Dec 3, 2018 at 8:43 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > As per the copy_file_range() man page:
> >
> > EINVAL
> >         Requested range extends beyond the end of the source file;
> > .....
> >
> > These tests actually attempt to copy beyond the end of the source
> > file and so should fail with EINVAL. The kernel does not check this
> > and so needs fixing. These operations should fail, so fix the tests.
> >
> 
> [cc: linux-api]
> 
> Probably better to discuss this on the kernel patch itself, but well...

I'm getting there - the problem is I need to refer to the tests in
the series description that these changes are made.

> How confident are you about this change not breaking existing programs?

My care factor is way below zero. The API implementation is so
broken right now that fixing it is almost guaranteed to break
something somewhere.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
