Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:44288 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752187AbcITXkw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2016 19:40:52 -0400
Date: Wed, 21 Sep 2016 09:40:48 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/3] move now-generic quota tests to generic
Message-ID: <20160920234048.GB10454@dastard>
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <06d804f2-646e-a586-bed1-416ffde8e0e9@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06d804f2-646e-a586-bed1-416ffde8e0e9@sandeen.net>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 20, 2016 at 05:24:59PM -0500, Eric Sandeen wrote:
> Now that these tests have been made generic, move them into
> the generic/ dir and update group files.
>=20
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

I wonder if this would be better done simply as a tools/mvtest
script for the maintainer to run. e.g.

#!/bin/sh

tools/mvtest xfs/054 generic/380
tools/mvtest xfs/118 generic/381
tools/mvtest xfs/138 generic/382
tools/mvtest xfs/260 generic/383

#EOF

Rather than ending up with patch that won't apply because we've
already applied another patch that added a new test that conflicts?
Reviewing the change is also heaps easier :)

> ---
>=20
> diff --git a/tests/generic/group b/tests/generic/group
> index a602b01..f5ebbb1 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -381,3 +381,8 @@
>  376 auto quick metadata
>  377 attr auto quick metadata
>  378 auto quick metadata
> +380 quota auto quick
> +381 quota auto quick
> +382 auto quick quota
> +383 auto quick quota
> +

No trailing blank line....

> @@ -257,7 +254,6 @@
>  257 auto quick clone
>  258 auto quick clone
>  259 auto quick
> -260 auto quick quota
>  261 auto quick quota
>  262 auto quick quota
>  263 auto quick quota
>=20
> N?????r??y????b?X??=C7=A7v?^?)=DE=BA{.n?+????=D7=AC?=C8=A7?=17??=DC=A8}=
???=C6=A0z?&j:+v???=07????zZ+??+zf???h???~????i???z?=1E?w?????????&?)=DF=A2=
=1Bf

Ummm, what? That looks like some kind of corruption occurred in
transit. There's no mailing list footer, and it's not at my end as
it's in the archive copies, too....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
