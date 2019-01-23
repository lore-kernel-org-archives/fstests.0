Received: from mout.gmx.net ([212.227.17.22]:36081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfAWFIi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 23 Jan 2019 00:08:38 -0500
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
 <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
 <20190117022525.GC6173@dastard>
 <89cc6e7d-f8d7-23c0-d7ce-8f873ae5c0bc@gmx.com>
 <20190123041830.GQ6173@dastard>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <903e8afa-413a-b0c9-5c91-682691107fbe@gmx.com>
Date: Wed, 23 Jan 2019 13:08:30 +0800
MIME-Version: 1.0
In-Reply-To: <20190123041830.GQ6173@dastard>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s22EZYvTy7VNvyNFjtVQhibErNitA8vVW"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s22EZYvTy7VNvyNFjtVQhibErNitA8vVW
Content-Type: multipart/mixed; boundary="GVT73Z60iLajZWOzjg9sWYKYBbLRJuex3";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
Message-ID: <903e8afa-413a-b0c9-5c91-682691107fbe@gmx.com>
Subject: Re: Any way to detect performance in a test case?
References: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
 <20190116035745.GO4205@dastard>
 <643f7899-e010-2694-4af6-960f0fc6e5cc@gmx.com>
 <20190117001615.GB6173@dastard>
 <21520e24-bfa6-ba1e-c19c-b0e0e803f4b7@gmx.com>
 <20190117022525.GC6173@dastard>
 <89cc6e7d-f8d7-23c0-d7ce-8f873ae5c0bc@gmx.com>
 <20190123041830.GQ6173@dastard>
In-Reply-To: <20190123041830.GQ6173@dastard>

--GVT73Z60iLajZWOzjg9sWYKYBbLRJuex3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/23 =E4=B8=8B=E5=8D=8812:18, Dave Chinner wrote:
> On Wed, Jan 23, 2019 at 08:51:03AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2019/1/17 =E4=B8=8A=E5=8D=8810:25, Dave Chinner wrote:
>>> On Thu, Jan 17, 2019 at 09:30:19AM +0800, Qu Wenruo wrote:
>>>> On 2019/1/17 =E4=B8=8A=E5=8D=888:16, Dave Chinner wrote:
>>>>> On Wed, Jan 16, 2019 at 12:47:21PM +0800, Qu Wenruo wrote:
>>>>>> E.g. one operation should finish in 30s, but when it takes over 30=
0s,
>>>>>> it's definitely a big regression.
>>>>>>
>>>>>> But considering how many different hardware/VM the test may be run=
 on,
>>>>>> I'm not really confident if this is possible.
>>>>>
>>>>> You can really only determine performance regressions by comparing
>>>>> test runtime on kernels with the same features set run on the same
>>>>> hardware. Hence you'll need to keep archives from all your test
>>>>> machiens and configs and only compare between matching
>>>>> configurations.
>>>>
>>>> Thanks, this matches my current understanding of how the testsuite w=
orks.
>>>>
>>>> It looks like such regression detection can only be implemented outs=
ide
>>>> of fstests.
>>>
>>> That's pretty much by design. Analysis of multiple test run results
>>> and post-processing them is really not something that the test
>>> harness does. The test harness really just runs the tests and
>>> records the results....
>>
>> What about using some other telemetry other than time to determine
>> regreesion?
>>
>> In my particular case, the correct behavior, some reading like
>> generation would only increase by a somewhat predictable number.
>>
>> While when the regression happens, the generation will go way higher
>> than expectation.
>=20
> That's something that would be done inside the test, right? i.e.
> this has nothing to do with the test harness itself, but is a
> failure criteria for the specific test?

Yep, a failure criteria for that specific test.

>=20
>> Is it acceptable to craft a test case using such measurement?
>=20
> If it's reliable and not prone to false positives from future code
> changes, yes.

Glad to know that.

Thanks,
Qu
>=20
> Cheers,
>=20
> Dave.
>=20


--GVT73Z60iLajZWOzjg9sWYKYBbLRJuex3--

--s22EZYvTy7VNvyNFjtVQhibErNitA8vVW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlxH9s4ACgkQwj2R86El
/qiurAf/b0mxs6XZidTCr2gfIFPghO54zNzQ8oF0QRmwzTFv8ZwVd0kaaltvnOxJ
lwZ/nPKEFRXj7vqkb7gqL8vGKUKMTv10wWgptiIJbuJkoOOEjzJ6LVbOl9n3ozjj
BMzu4ENhgXHBMO2VbsIhYDqeV42arLTstwzrNgrLtwlXXv35LJpzfRMz1SDVCUlf
FUHD2QGCd2LcTClWB77u+ddhdjPBX2iuOgZPMk8Gmkv0TsJa5lq+EA5U8k/71sA/
T0LHH2URLydg1wlNY5sjXuA0bsIBLRydOPYVZo+y58LvXq7T2jsIeNExp9McrEHW
qQrXY0es6Zqxq1rODIRLK+eLBN8+5w==
=Cr3a
-----END PGP SIGNATURE-----

--s22EZYvTy7VNvyNFjtVQhibErNitA8vVW--
