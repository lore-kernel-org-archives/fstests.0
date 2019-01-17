Received: from mout.gmx.net ([212.227.15.15]:58167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfAQBa0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Jan 2019 20:30:26 -0500
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
Date: Thu, 17 Jan 2019 09:30:19 +0800
MIME-Version: 1.0
In-Reply-To: <20190117001615.GB6173@dastard>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O02kPlmq1Y5Slj8FwaMOdWNlfYsjlOUOT"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O02kPlmq1Y5Slj8FwaMOdWNlfYsjlOUOT
Content-Type: multipart/mixed; boundary="liUeghrSil6bOFH9oBqQTPI01c8sNwZ0q";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
Message-ID: <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
In-Reply-To: <20190117001615.GB6173@dastard>

--liUeghrSil6bOFH9oBqQTPI01c8sNwZ0q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/17 =E4=B8=8A=E5=8D=888:16, Dave Chinner wrote:
> On Wed, Jan 16, 2019 at 12:47:21PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/1/16 =E4=B8=8A=E5=8D=8811:57, Dave Chinner wrote:
>>> On Wed, Jan 16, 2019 at 09:59:40AM +0800, Qu Wenruo wrote:
>>>> Hi,
>>>>
>>>> Is there any way to detect (huge) performance regression in a test c=
ase?
>>>>
>>>> By huge performance regression, I mean some operation takes from les=
s
>>>> than 10s to around 400s.
>>>>
>>>> There is existing runtime accounting, but we can't do it inside a te=
st
>>>> case (or can we?)
>>>>
>>>> So is there any way to detect huge performance regression in a test =
case?
>>>
>>> Just run your normal performance monitoring tools while the test is
>>> running to see what has changed. Is it IO, memory, CPU, lock
>>> contention or somethign else that is the problem?  pcp, strace, top,
>>> iostat, perf, etc all work just fine for finding perf regressions
>>> reported by test cases...
>>
>> Sorry for the misunderstanding.
>>
>> I mean if it's possible for a test case to just fail when hitting some=

>> big performance regression.
>=20
> This is part of the reported information in $RESULT_BASE/check.time.
>=20
> If you want to keep a history of runtimes for later comparison, then
> you just need to archive contents of that file with the test
> results.
>=20
> OR, alternatively, generate an XML test report which reports the
> individual test runtime in each report:
>=20
> .....
>         <testcase classname=3D"xfstests.xfs" name=3D"generic/036" time=3D=
"12">
>         </testcase>
>         <testcase classname=3D"xfstests.xfs" name=3D"generic/112" time=3D=
"5">
>         </testcase>
>         <testcase classname=3D"xfstests.xfs" name=3D"generic/113" time=3D=
"4">
>         </testcase>
>         <testcase classname=3D"xfstests.xfs" name=3D"generic/114" time=3D=
"1">
> .....
>=20
> And then post-process these reports to determine runtime
> differences.
>=20
>> E.g. one operation should finish in 30s, but when it takes over 300s,
>> it's definitely a big regression.
>>
>> But considering how many different hardware/VM the test may be run on,=

>> I'm not really confident if this is possible.
>=20
> You can really only determine performance regressions by comparing
> test runtime on kernels with the same features set run on the same
> hardware. Hence you'll need to keep archives from all your test
> machiens and configs and only compare between matching
> configurations.

Thanks, this matches my current understanding of how the testsuite works.=


It looks like such regression detection can only be implemented outside
of fstests.

Thanks for all the suggestions!
Qu

>=20
> Cheers,
>=20
> Dave.
>=20


--liUeghrSil6bOFH9oBqQTPI01c8sNwZ0q--

--O02kPlmq1Y5Slj8FwaMOdWNlfYsjlOUOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlw/2qsACgkQwj2R86El
/qj3rgf5ASHMZ2uEJJkWl7IgXfDtgQr6SVA41T4xnU6WR30J7VvY/xfhG7Yd9Ie3
jhIWi0qjfpEb4tIEuQ8WFFFKpFpB+juHqI5fd3U4c0BMWEyeuCz4GiADEB7V3lHy
jteJY3zOlY1l2gavfaCmfa6HWuChsaSJXNld4Lz6evTprDbM/l158aFeBQiAQgPP
jt82Ir6p7TqQH2FzDmPkjlbpGVuDRJnYPnNGhM17q/2v5KLXe01bn0ofB/cgUeZm
1VJus+3LsSbKvjl6/hCj7z1M3vDmCkTEmgGl+IqwV/69tw4hhPDt9RLeGPYGnfgH
rO5cN9uNx99UimL5bGH0tO46/yUT7Q==
=zZL0
-----END PGP SIGNATURE-----

--O02kPlmq1Y5Slj8FwaMOdWNlfYsjlOUOT--
