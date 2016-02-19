Received: from sandeen.net ([63.231.237.45]:37967 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947047AbcBSP7A (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 19 Feb 2016 10:59:00 -0500
Subject: Re: [PATCH] xfs: change return value check to golden image check
References: <1455208656-16637-1-git-send-email-zlang@redhat.com>
 <20160219013316.GW14668@dastard>
 <254524291.19728857.1455896123254.JavaMail.zimbra@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <56C73BC2.7090506@sandeen.net>
Date: Fri, 19 Feb 2016 09:58:58 -0600
MIME-Version: 1.0
In-Reply-To: <254524291.19728857.1455896123254.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Zirong Lang <zlang@redhat.com>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>



On 2/19/16 9:35 AM, Zirong Lang wrote:
>=20
>=20
> ----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
>> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, eguan@redhat.com
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=BA=94, 201=
6=E5=B9=B4 2 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 9:33:16
>> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs: change return value check to gold=
en image check
>>
>> On Fri, Feb 12, 2016 at 12:37:36AM +0800, Zorro Lang wrote:
>>> xfs/133 and xfs/138 use too much code to do "return value" check,
>>> it's not necessary. For the code can be more readable and clear,
>>> I change "return value" check to golden image check.
>>>
>>> Signed-off-by: Zorro Lang <zlang@redhat.com>
>>> ---
>>>  tests/xfs/133     | 20 +++++++-------------
>>>  tests/xfs/133.out |  7 +++++++
>>>  tests/xfs/138     | 26 ++++++++++++--------------
>>>  tests/xfs/138.out | 12 ++++++++++++
>>>  4 files changed, 38 insertions(+), 27 deletions(-)
>>
>> This cause a xfs/133 failure like this on my systems:
>>
>> --- tests/xfs/133.out   2016-02-19 10:40:57.043131919 +1100
>> +++ /home/dave/src/xfstests-dev/results//xfs/xfs/133.out.bad    2016-0=
2-19
>> 12:24:53.173589432 +1100
>> @@ -4,5 +4,6 @@
>>  Filesystem Blocks Quota Limit Warn/Time Mounted on
>>  SCRATCH_DEV 0 102400 204800 00 [--------] SCRATCH_MNT
>>  =3D=3D=3D report command output =3D=3D=3D
>> +(null) 0 0 0 00 [--------]

I need to dig, but this may be a result of GETNEXTQUOTA additions to
xfs_quota.

We can now find IDs on disk that don't exist in the user database, and
we would not have reported them before.

Perhaps change the test to report ids not names, to debug it and see
which one it is finding?

I'm guessing it's ID 0, but I have to think about whether that's correct
to show or not...

Thanks,
-Eric

>>  123456-project 0 102400 204800 00 [--------]
>=20
> Wow, I reproduce this problem after I updated my xfsprogs-dev from:
>=20
> 12dd365 xfs_quota: modify commands which can't handle multiple types
>=20
> to:
>=20
> 1abecda xfsprogs: Release v4.5.0-rc1
>=20
> That's your newest Release recently. I need more check for this new fai=
lure.
>=20
> Thanks,
> Zorro
>=20
>> =20
>>
>> Can you see if you can reproduce it?
>>
>> Cheers,
>>
>> Dave.
>> --
>> Dave Chinner
>> david@fromorbit.com
>>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
