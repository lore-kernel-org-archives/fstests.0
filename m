Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:50729 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376AbbHTVIQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 20 Aug 2015 17:08:16 -0400
Date: Fri, 21 Aug 2015 07:08:12 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: link .out to correct output when we set
 USE_ATTR_SECURE=yes
Message-ID: <20150820210812.GO3902@dastard>
References: <55D52473.7050209@cn.fujitsu.com>
 <1440032464-17626-1-git-send-email-yangds.fnst@cn.fujitsu.com>
 <CAHpGcMLZT5xYx5EUBLTPyLQd0f+jQ-g+c_f-oErsHP33m7-ROg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHpGcMLZT5xYx5EUBLTPyLQd0f+jQ-g+c_f-oErsHP33m7-ROg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>, fstests@vger.kernel.org, linux-mtd@lists.infradead.org, richard.weinberger@gmail.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 20, 2015 at 08:18:28AM +0200, Andreas Gr=FCnbacher wrote:
> Dongsheng,
>=20
> 2015-08-20 3:01 GMT+02:00 Dongsheng Yang <yangds.fnst@cn.fujitsu.com>:
> >
> > When we set USE_ATTR_SECURE to yes or no, the expected outputs of gen=
eric/062
> > would be different. So we need to link the .out to different file.
>=20
> Can the tests for the different namespaces please be separated from
> each other here (see below)?

I certainly agree with this approach ;)

>=20
> diff --git a/tests/generic/062 b/tests/generic/062
> index 194b638..9dd4498 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -142,6 +142,7 @@ for nsp in $ATTR_MODES; do
>                 echo "*** final list (strings, type=3D$inode, nsp=3D$ns=
p)"
>                 getfattr -m '.' -e hex $SCRATCH_MNT/$inode
>=20
> +               # FIXME: Remove all remaining xattrs
>         done
>  done
>=20
> Next, can the security namespace tests be put in their own test case
> so that we don't need to switch between two different .out files? This
> could be done by setting ATTR_MODES and then invoking
> tests/generic/062 to avoid duplicating the entire test script.

Just not the suggested mechanism :)

We can't execute one test from another - that will lead to all sorts
of bad juju occurring with results and timing and so on because they
are all based on $0.  The correct way to do this is to factor the
test internals into a common file, then wrap the common functions
with a new test file.

e.g. see _test_generic_punch(), which started off as corner case
testing the XFS_IOC_ZERORANGE ioctl in a single test, Then got
extended to testing hole punching in a new test, then got factored
into common functions in common/punch, and it is now called by 14
different tests....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
