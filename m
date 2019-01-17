Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:5566 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfAQCZ2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Jan 2019 21:25:28 -0500
Date: Thu, 17 Jan 2019 13:25:25 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Any way to detect performance in a test case?
Message-ID: <20190117022525.GC6173@dastard>
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
 <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 17, 2019 at 09:30:19AM +0800, Qu Wenruo wrote:
> On 2019/1/17 =E4=B8=8A=E5=8D=888:16, Dave Chinner wrote:
> > On Wed, Jan 16, 2019 at 12:47:21PM +0800, Qu Wenruo wrote:
> >> E.g. one operation should finish in 30s, but when it takes over 300s=
,
> >> it's definitely a big regression.
> >>
> >> But considering how many different hardware/VM the test may be run o=
n,
> >> I'm not really confident if this is possible.
> >=20
> > You can really only determine performance regressions by comparing
> > test runtime on kernels with the same features set run on the same
> > hardware. Hence you'll need to keep archives from all your test
> > machiens and configs and only compare between matching
> > configurations.
>=20
> Thanks, this matches my current understanding of how the testsuite work=
s.
>=20
> It looks like such regression detection can only be implemented outside
> of fstests.

That's pretty much by design. Analysis of multiple test run results
and post-processing them is really not something that the test
harness does. The test harness really just runs the tests and
records the results....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
