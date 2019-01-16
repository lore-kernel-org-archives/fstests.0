Received: from mout.gmx.net ([212.227.17.21]:49813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732003AbfAPEr2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Jan 2019 23:47:28 -0500
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
Date: Wed, 16 Jan 2019 12:47:21 +0800
MIME-Version: 1.0
In-Reply-To: <20190116035745.GO4205@dastard>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AfyQeGeXtT51bNcVUWTnBHWaeL9d8u7yf"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AfyQeGeXtT51bNcVUWTnBHWaeL9d8u7yf
Content-Type: multipart/mixed; boundary="8M24MvevtqswUzL7XoeLd2kQ98fbtAa66";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
Message-ID: <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
In-Reply-To: <20190116035745.GO4205@dastard>

--8M24MvevtqswUzL7XoeLd2kQ98fbtAa66
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/16 =E4=B8=8A=E5=8D=8811:57, Dave Chinner wrote:
> On Wed, Jan 16, 2019 at 09:59:40AM +0800, Qu Wenruo wrote:
>> Hi,
>>
>> Is there any way to detect (huge) performance regression in a test cas=
e?
>>
>> By huge performance regression, I mean some operation takes from less
>> than 10s to around 400s.
>>
>> There is existing runtime accounting, but we can't do it inside a test=

>> case (or can we?)
>>
>> So is there any way to detect huge performance regression in a test ca=
se?
>=20
> Just run your normal performance monitoring tools while the test is
> running to see what has changed. Is it IO, memory, CPU, lock
> contention or somethign else that is the problem?  pcp, strace, top,
> iostat, perf, etc all work just fine for finding perf regressions
> reported by test cases...

Sorry for the misunderstanding.

I mean if it's possible for a test case to just fail when hitting some
big performance regression.

E.g. one operation should finish in 30s, but when it takes over 300s,
it's definitely a big regression.

But considering how many different hardware/VM the test may be run on,
I'm not really confident if this is possible.

Thanks,
Qu

>=20
> Cheers,
>=20
> Dave.
>=20


--8M24MvevtqswUzL7XoeLd2kQ98fbtAa66--

--AfyQeGeXtT51bNcVUWTnBHWaeL9d8u7yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlw+t1kACgkQwj2R86El
/qgxTAf/TDMYi8Z31s0GfC0qSgMJlLQBbOYQT90BGNqrBF1y+saIMlxYCe8Nk5ZV
tvLdYUBQkFbn3UGsOUj/QRWxIWGjHeCWGediVY2MldtT3K1G5AL5IKkHgRibE9fH
xjOgDu9e2PU9KtBwbodBp1JLKS4iweF40QGof6HK4Zze53TxZaRBLzPZVUHbTgtL
bspKRsjXzNU9p3UUdTbHwhNXo/Kg4czBWdE4Xz5JRvu+SEN8RnVWmXzDpX3GpXK3
vTZ9uPsQtHZ60oBLTJmBnblCalX7OHVWwuLksJFlqmLZf8YF8ysMrG6gzhPAuWnt
WIJS/IwB+jOiUnVgQK0Mqu5i98toFw==
=Hy+f
-----END PGP SIGNATURE-----

--AfyQeGeXtT51bNcVUWTnBHWaeL9d8u7yf--
