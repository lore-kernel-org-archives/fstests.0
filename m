Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:32405 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbfAWESj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jan 2019 23:18:39 -0500
Date: Wed, 23 Jan 2019 15:18:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Any way to detect performance in a test case?
Message-ID: <20190123041830.GQ6173@dastard>
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
 <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
 <20190117022525.GC6173@dastard>
 <89cc6e7d-f8d7-23c0-d7ce-8f873ae5c0bc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89cc6e7d-f8d7-23c0-d7ce-8f873ae5c0bc@gmx.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 23, 2019 at 08:51:03AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/1/17 =E4=B8=8A=E5=8D=8810:25, Dave Chinner wrote:
> > On Thu, Jan 17, 2019 at 09:30:19AM +0800, Qu Wenruo wrote:
> >> On 2019/1/17 =E4=B8=8A=E5=8D=888:16, Dave Chinner wrote:
> >>> On Wed, Jan 16, 2019 at 12:47:21PM +0800, Qu Wenruo wrote:
> >>>> E.g. one operation should finish in 30s, but when it takes over 30=
0s,
> >>>> it's definitely a big regression.
> >>>>
> >>>> But considering how many different hardware/VM the test may be run=
 on,
> >>>> I'm not really confident if this is possible.
> >>>
> >>> You can really only determine performance regressions by comparing
> >>> test runtime on kernels with the same features set run on the same
> >>> hardware. Hence you'll need to keep archives from all your test
> >>> machiens and configs and only compare between matching
> >>> configurations.
> >>
> >> Thanks, this matches my current understanding of how the testsuite w=
orks.
> >>
> >> It looks like such regression detection can only be implemented outs=
ide
> >> of fstests.
> >=20
> > That's pretty much by design. Analysis of multiple test run results
> > and post-processing them is really not something that the test
> > harness does. The test harness really just runs the tests and
> > records the results....
>=20
> What about using some other telemetry other than time to determine
> regreesion?
>=20
> In my particular case, the correct behavior, some reading like
> generation would only increase by a somewhat predictable number.
>
> While when the regression happens, the generation will go way higher
> than expectation.

That's something that would be done inside the test, right? i.e.
this has nothing to do with the test harness itself, but is a
failure criteria for the specific test?

> Is it acceptable to craft a test case using such measurement?

If it's reliable and not prone to false positives from future code
changes, yes.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
