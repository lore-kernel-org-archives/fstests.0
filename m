Received: from mout.gmx.net ([212.227.15.18]:52055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfAWAvL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 22 Jan 2019 19:51:11 -0500
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
 <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
 <20190117022525.GC6173@dastard>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <89cc6e7d-f8d7-23c0-d7ce-8f873ae5c0bc@gmx.com>
Date: Wed, 23 Jan 2019 08:51:03 +0800
MIME-Version: 1.0
In-Reply-To: <20190117022525.GC6173@dastard>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lzyilBwMTqI0xpcd2RYHCoGOmtQ5DrkUr"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lzyilBwMTqI0xpcd2RYHCoGOmtQ5DrkUr
Content-Type: multipart/mixed; boundary="klPrJhFEMKWPFQZ0DIsvgoZPxbaw0rZtO";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
Message-ID: <89cc6e7d-f8d7-23c0-d7ce-8f873ae5c0bc@gmx.com>
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
 <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
 <20190117022525.GC6173@dastard>
In-Reply-To: <20190117022525.GC6173@dastard>

--klPrJhFEMKWPFQZ0DIsvgoZPxbaw0rZtO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/17 =E4=B8=8A=E5=8D=8810:25, Dave Chinner wrote:
> On Thu, Jan 17, 2019 at 09:30:19AM +0800, Qu Wenruo wrote:
>> On 2019/1/17 =E4=B8=8A=E5=8D=888:16, Dave Chinner wrote:
>>> On Wed, Jan 16, 2019 at 12:47:21PM +0800, Qu Wenruo wrote:
>>>> E.g. one operation should finish in 30s, but when it takes over 300s=
,
>>>> it's definitely a big regression.
>>>>
>>>> But considering how many different hardware/VM the test may be run o=
n,
>>>> I'm not really confident if this is possible.
>>>
>>> You can really only determine performance regressions by comparing
>>> test runtime on kernels with the same features set run on the same
>>> hardware. Hence you'll need to keep archives from all your test
>>> machiens and configs and only compare between matching
>>> configurations.
>>
>> Thanks, this matches my current understanding of how the testsuite wor=
ks.
>>
>> It looks like such regression detection can only be implemented outsid=
e
>> of fstests.
>=20
> That's pretty much by design. Analysis of multiple test run results
> and post-processing them is really not something that the test
> harness does. The test harness really just runs the tests and
> records the results....

What about using some other telemetry other than time to determine
regreesion?

In my particular case, the correct behavior, some reading like
generation would only increase by a somewhat predictable number.

While when the regression happens, the generation will go way higher
than expectation.

Is it acceptable to craft a test case using such measurement?

As I really hope to get an easy PASS/FAIL test case for QA guys to
notice such huge regression.

Thanks,
Qu

>=20
> Cheers,
>=20
> Dave.
>=20


--klPrJhFEMKWPFQZ0DIsvgoZPxbaw0rZtO--

--lzyilBwMTqI0xpcd2RYHCoGOmtQ5DrkUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlxHuncACgkQwj2R86El
/qjwaAf/eTcTqHZn8fyNJY8EMS13U0jiLpzxJXnjkLxeOdzeavznN4RdfIUZ59L8
MdmoiSxgb6wdDqSQZjRV01mnas9/uHCEcFVVZ48Kvpc5GcNfNxFkV68qXI88AiLx
JDB+qJDhRYpDb1Ocx5IQryqQXHSEiRsoGgMViNNhdMlL68TYCJjFfdnZIE7scGn4
N6gTy245z4OuhwRWVQcLtetPlBbM4V7K9O5j6v4sb+A1+IFQIHNPgC9Ie3bwoAKa
Hrd82bjPyHrJxKTy+PP/yvK/+FEfItjpT9d6tRNufSCPCV9E8yrlyso0YXKYCk/y
EJt+x63wda5USJWWK9U/Uy8JToNMCw==
=udw7
-----END PGP SIGNATURE-----

--lzyilBwMTqI0xpcd2RYHCoGOmtQ5DrkUr--
