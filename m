Received: from mx1.mpynet.fi ([82.197.21.84]:32485 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752433AbdLURkZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Dec 2017 12:40:25 -0500
Subject: Re: [PATCH] common/encrypt: Create an encrypted equivalent of
 _scratch_mkfs_sized
From: Ari Sundholm <ari@tuxera.com>
References: <1513792000-25462-1-git-send-email-ari@tuxera.com>
 <20171221013802.GP5858@dastard>
 <1a058cb8-b2c0-39b5-e65d-d77264c37a54@tuxera.com>
Message-ID: <b1651c48-4be5-fc7a-e6ea-c099c6913642@tuxera.com>
Date: Thu, 21 Dec 2017 19:40:23 +0200
MIME-Version: 1.0
In-Reply-To: <1a058cb8-b2c0-39b5-e65d-d77264c37a54@tuxera.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 12/21/2017 03:52 PM, Ari Sundholm wrote:
> Hi!
>=20
> Thank you for your comments. Please see below.
>=20
> On 12/21/2017 03:38 AM, Dave Chinner wrote:
>> On Wed, Dec 20, 2017 at 07:46:40PM +0200, Ari Sundholm wrote:
>>> Test case generic/399 hardcodes "-O encrypt" in MKFS_OPTIONS when
>>> calling _scratch_mkfs_sized, which only works with the mkfs of certai=
n
>>> filesystems. Create a new helper, _scratch_mkfs_sized_encrypted, for
>>> handling the differences between the mkfs tools of different
>>> filesystems. It also allows those filesystems whose mkfs doesn't acce=
pt
>>> "-O encrypt" to skip the test gracefully until proper support is adde=
d
>>> for them in the helper.
>>>
>>> Signed-off-by: Ari Sundholm <ari@tuxera.com>
>>> ---
>>> =C2=A0 common/encrypt=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
>>> =C2=A0 tests/generic/399 |=C2=A0 3 +--
>>> =C2=A0 2 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/encrypt b/common/encrypt
>>> index a6fd89d..189c59e 100644
>>> --- a/common/encrypt
>>> +++ b/common/encrypt
>>> @@ -81,6 +81,18 @@ _scratch_mkfs_encrypted()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>> =C2=A0 }
>>> +_scratch_mkfs_sized_encrypted()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 case $FSTYP in
>>> +=C2=A0=C2=A0=C2=A0 ext4|f2fs)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MKFS_OPTIONS=3D"$MKFS_OPT=
IONS -O encrypt" _scratch_mkfs_sized $*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>
>> This does not need to screw around with MKFS_OPTIONS. This:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _scratch_mkfs_sized -O encr=
ypt $*
>>
>> Will do just fine.
>=20
> Hmm, I don't see how that could work. At the moment, _scratch_mkfs_size=
d=20
> only takes and uses two arguments, one of which is optional. AFAICS, al=
l=20
> additional mkfs options need to be passed using MKFS_OPTIONS to=20
> _scratch_mkfs_sized.
>=20
> As for using $* instead of $1 $2, I am hoping that will avoid having to=
=20
> change this new function even if the usage of _scratch_mkfs_sized chang=
es.
>=20
>> Also, _scratch_mkfs_encrypted() supports UBIFS, and this new
>> function doesn't. Seems like it should to me...
>=20
> _scratch_mkfs_sized does not support ubifs, though, so the operation=20
> would _notrun anyway. I'm not familiar with ubifs or its tools, but I'l=
l=20
> see if I can find out how to implement support for ubifs in=20
> _scratch_mkfs_sized.
>=20

I looked into implementing ubifs support for _scratch_mkfs_sized and=20
_scratch_mkfs_sized_encrypted. It doesn't seem there is a very good way=20
of doing this, apart from removing the existing volume and recreating=20
it, something like this:
	ubirmvol $SCRATCH_DEV -n 0
	ubimkvol $SCRATCH_DEV -n 0 -N foobar -s SIZE

This has the problem that we may not really know what the volume ID=20
should be. Can we trust it to be 0? The other issue is that $SCRATCH_DEV=20
probably points to a UBI volume instead of a UBI device. I guess ubinfo=20
(or just sed'ing out the volume suffix) could be used to get the=20
underlying UBI device.

I think supporting this should be in a separate patch.

Best regards,
Ari Sundholm
ari@tuxera.com

>> Cheers,
>>
>> Dave.
>>
>=20
> Thanks,
> Ari Sundholm
> ari@tuxera.com
> --=20
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html

