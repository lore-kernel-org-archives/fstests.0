Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:15852 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728450AbfAQAQT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Jan 2019 19:16:19 -0500
Date: Thu, 17 Jan 2019 11:16:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Any way to detect performance in a test case?
Message-ID: <20190117001615.GB6173@dastard>
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 16, 2019 at 12:47:21PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/1/16 =E4=B8=8A=E5=8D=8811:57, Dave Chinner wrote:
> > On Wed, Jan 16, 2019 at 09:59:40AM +0800, Qu Wenruo wrote:
> >> Hi,
> >>
> >> Is there any way to detect (huge) performance regression in a test c=
ase?
> >>
> >> By huge performance regression, I mean some operation takes from les=
s
> >> than 10s to around 400s.
> >>
> >> There is existing runtime accounting, but we can't do it inside a te=
st
> >> case (or can we?)
> >>
> >> So is there any way to detect huge performance regression in a test =
case?
> >=20
> > Just run your normal performance monitoring tools while the test is
> > running to see what has changed. Is it IO, memory, CPU, lock
> > contention or somethign else that is the problem?  pcp, strace, top,
> > iostat, perf, etc all work just fine for finding perf regressions
> > reported by test cases...
>=20
> Sorry for the misunderstanding.
>=20
> I mean if it's possible for a test case to just fail when hitting some
> big performance regression.

This is part of the reported information in $RESULT_BASE/check.time.

If you want to keep a history of runtimes for later comparison, then
you just need to archive contents of that file with the test
results.

OR, alternatively, generate an XML test report which reports the
individual test runtime in each report:

.....
        <testcase classname=3D"xfstests.xfs" name=3D"generic/036" time=3D=
"12">
        </testcase>
        <testcase classname=3D"xfstests.xfs" name=3D"generic/112" time=3D=
"5">
        </testcase>
        <testcase classname=3D"xfstests.xfs" name=3D"generic/113" time=3D=
"4">
        </testcase>
        <testcase classname=3D"xfstests.xfs" name=3D"generic/114" time=3D=
"1">
.....

And then post-process these reports to determine runtime
differences.

> E.g. one operation should finish in 30s, but when it takes over 300s,
> it's definitely a big regression.
>=20
> But considering how many different hardware/VM the test may be run on,
> I'm not really confident if this is possible.

You can really only determine performance regressions by comparing
test runtime on kernels with the same features set run on the same
hardware. Hence you'll need to keep archives from all your test
machiens and configs and only compare between matching
configurations.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
