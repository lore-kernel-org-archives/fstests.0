Received: from szxga04-in.huawei.com ([45.249.212.190]:2714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406280AbfIYD1t (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 24 Sep 2019 23:27:49 -0400
Subject: Re: [PATCH xfstests v2] overlay: Enable character device to be the
 base fs partition
References: <1569376448-53998-1-git-send-email-chengzhihao1@huawei.com>
 <20190925030550.GA9913@magnolia> <20190925031733.GB9913@magnolia>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <46aa2daf-4c4a-ea74-2300-bb32fdfbdbcc@huawei.com>
Date: Wed, 25 Sep 2019 11:27:32 +0800
MIME-Version: 1.0
In-Reply-To: <20190925031733.GB9913@magnolia>
Content-Type: text/plain; charset="gbk"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: guaneryu@gmail.com, amir73il@gmail.com, david.oberhollenzer@sigma-star.at, ebiggers@google.com, yi.zhang@huawei.com, fstests@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

There are indeed many '-b' options in xfstests. I only confirmed the line=
 of overlay test. Other -b test options I need to reconfirm later.

=D4=DA 2019/9/25 11:17, Darrick J. Wong =D0=B4=B5=C0:
> On Tue, Sep 24, 2019 at 08:05:50PM -0700, Darrick J. Wong wrote:
>> On Wed, Sep 25, 2019 at 09:54:08AM +0800, Zhihao Cheng wrote:
>>> There is a message in _supported_fs():
>>>     _notrun "not suitable for this filesystem type: $FSTYP"
>>> for when overlay usecases are executed on a chararcter device based b=
ase
>>
>> You can do that?
>>
>> What does that even look like?
>=20
> OH, ubifs.  Ok.
>=20
> /me wonders if there are more places in xfstests with test -b that need=
s
> fixing...
>=20
> --D
>=20
>> --D
>>
>>> fs. _overay_config_override() detects that the current base fs partit=
ion
>>> is not a block device, and FSTYP won't be overwritten as 'overlay' be=
fore
>>> executing usecases which results in all overlay usecases become 'notr=
un'.
>>> In addition, all generic usecases are based on base fs rather than ov=
erlay.
>>>
>>> We want to rewrite FSTYP to 'overlay' before running the usecases. To=
 do
>>> this, we need to add additional character device judgments for TEST_D=
EV
>>> and SCRATCH_DEV in _overay_config_override().
>>>
>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>> ---
>>>  common/config | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/config b/common/config
>>> index 4c86a49..a22acdb 100644
>>> --- a/common/config
>>> +++ b/common/config
>>> @@ -550,7 +550,7 @@ _overlay_config_override()
>>>  	#    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the valu=
es
>>>  	#    of the configured base fs and SCRATCH/TEST_DEV vars are set to=
 the
>>>  	#    overlayfs base and mount dirs inside base fs mount.
>>> -	[ -b "$TEST_DEV" ] || return 0
>>> +	[ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>>> =20
>>>  	# Config file may specify base fs type, but we obay -overlay flag
>>>  	[ "$FSTYP" =3D=3D overlay ] || export OVL_BASE_FSTYP=3D"$FSTYP"
>>> @@ -570,7 +570,7 @@ _overlay_config_override()
>>>  	export TEST_DIR=3D"$OVL_BASE_TEST_DIR/$OVL_MNT"
>>>  	export MOUNT_OPTIONS=3D"$OVERLAY_MOUNT_OPTIONS"
>>> =20
>>> -	[ -b "$SCRATCH_DEV" ] || return 0
>>> +	[ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>>> =20
>>>  	# Store original base fs vars
>>>  	export OVL_BASE_SCRATCH_DEV=3D"$SCRATCH_DEV"
>>> --=20
>>> 2.7.4
>>>
>=20
> .
>=20
