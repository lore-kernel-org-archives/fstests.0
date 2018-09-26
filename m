Received: from mx2.suse.de ([195.135.220.15]:32960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeIZMpv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Sep 2018 08:45:51 -0400
Subject: Re: [PATCH v2 1/9] fstests: btrfs: _scratch_mkfs_sized fix min size
 without mixed option
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-2-git-send-email-anand.jain@oracle.com>
 <b054a402-0507-4990-6752-8d75b02a97ed@suse.com>
 <68c6443f-6d2b-ba3a-40e1-994fa5ee32e3@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <b6a81bfa-66f6-89e3-3c1e-2d5396f8bbf4@suse.com>
Date: Wed, 26 Sep 2018 09:34:27 +0300
MIME-Version: 1.0
In-Reply-To: <68c6443f-6d2b-ba3a-40e1-994fa5ee32e3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
List-ID: <fstests@vger.kernel.org>



On 26.09.2018 07:07, Anand Jain wrote:
>=20
>=20
> On 09/25/2018 06:51 PM, Nikolay Borisov wrote:
>>
>>
>> On 25.09.2018 07:24, Anand Jain wrote:
>>> As of now _scratch_mkfs_sized() checks if the requested size is below=
 1G
>>> and forces the --mixed option for the mkfs.btrfs. Well the correct si=
ze
>>> considering all possible group profiles at which we need to force the
>>> mixed option is roughly 256Mbytes. So fix that.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Have you considered the implications of this w.r.t commit
>> d4da414a9a9d ("common/rc: raise btrfs mixed mode threshold to 1GB")
>>
>> Initially this threshold was 100mb then Omar changed it to 1g. Does th=
is
>> change affect generic/427?
>=20
> d4da414a9a9d does not explain what was the problem that Omar wanted to
> address, mainly what was the failure about.

I just retested on upstream 4.19.0-rc3 with Omar's patch reverted (so
anything above 100m for fs size is created with non-mixed block groups)
and the test succeeded. So indeed your change seems to not make a
difference for this test.

>=20
> And no it does not affect. I have verified generic/427 with kernel 4.1
> and 4.19-rc5 with=C2=A0 btrfs-progs 4.1, 4.9 and latest from kdave they=
 all
> run fine. Good to integrate.
>=20
> Thanks, Anand
>=20
>>
>>> ---
>>> =C2=A0 common/rc | 5 ++++-
>>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/common/rc b/common/rc
>>> index d5bb1feee2c3..90dc3002bc3d 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -969,7 +969,10 @@ _scratch_mkfs_sized()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local mixed_opt=3D
>>> -=C2=A0=C2=A0=C2=A0 (( fssize <=3D 1024 * 1024 * 1024 )) && mixed_opt=
=3D'--mixed'
>>> +=C2=A0=C2=A0=C2=A0 # minimum size that's needed without the mixed op=
tion.
>>> +=C2=A0=C2=A0=C2=A0 # Ref: btrfs-prog: btrfs_min_dev_size()
>>> +=C2=A0=C2=A0=C2=A0 # Non mixed mode is also the default option.
>>> +=C2=A0=C2=A0=C2=A0 (( fssize < $((256 * 1024 *1024)) )) && mixed_opt=
=3D'--mixed'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_=
opt -b $fssize $SCRATCH_DEV
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jfs)
>>>
>=20
