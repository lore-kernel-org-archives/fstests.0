Received: from aserp2120.oracle.com ([141.146.126.78]:57320 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeIXTmf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Sep 2018 15:42:35 -0400
Subject: Re: [PATCH 1/9] fstests: btrfs: _scratch_mkfs_sized fix min size
 without mixed option
References: <1537784193-24431-1-git-send-email-anand.jain@oracle.com>
 <1537784193-24431-2-git-send-email-anand.jain@oracle.com>
 <c770f3ed-a813-74c9-0b9d-04a3ce740185@gmx.com>
 <bdd780f8-8c50-c859-30ba-53c68d81bb72@oracle.com>
 <80c6fc3d-4c30-34b7-ecc1-31eddb12fe59@gmx.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <5d791c2f-35ee-8e37-056c-d9089483d5af@oracle.com>
Date: Mon, 24 Sep 2018 21:40:00 +0800
MIME-Version: 1.0
In-Reply-To: <80c6fc3d-4c30-34b7-ecc1-31eddb12fe59@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 09/24/2018 08:02 PM, Qu Wenruo wrote:
>=20
>=20
> On 2018/9/24 =E4=B8=8B=E5=8D=887:53, Anand Jain wrote:
>>
>>
>> On 09/24/2018 06:58 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2018/9/24 =E4=B8=8B=E5=8D=886:16, Anand Jain wrote:
>>>> As of now _scratch_mkfs_sized check if the requested size is below 1=
G
>>>> and forces the --mixed option for the mkfs.btrfs. Well the correct s=
ize
>>>> at which we need to force the mixed option is 114294784bytes. Fix th=
at.
>>>
>>> How this size is get from?
>>> If it's from btrfs_min_dev_size(), I strongly recommend to add refere=
nce
>>> here, and don't use the ugly intermediate number.
>>>
>>>
>>> BTW, this number is related to mkfs profile.
>>> If you really want to use some maximum number, please follow the max
>>> possible value in btrfs_min_dev_size(), which should be 229M other th=
an
>>> 106M.
>>
>>  =C2=A0Thanks for the comments. I completely missed out the point of o=
ther
>>  =C2=A0group profile requiring more than ~115 bytes. Will fix.
>=20
> I'd go a rounded number, like 256M.
>=20
> Non of the number from btrfs_min_dev_size() is really easy to remember
> nor makes sense out of btrfs realm.
>=20
> And this also leaves a little more headroom for later modification
> (although I hope such modification never happen)

  I agree. Actually I was thinking it should be like that when I was=20
writing this patch, then my logical mind didn't provide any strong=20
reason to back that up. As ideas match, Will fix it at 256M.

Thanks, Anand


> Thanks,
> Qu
>=20
>>  =C2=A0Yep the ref for the size is btrfs_min_dev_size().
>>
>> -Anand
>>
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>  =C2=A0 common/rc | 4 +++-
>>>>  =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/common/rc b/common/rc
>>>> index d5bb1feee2c3..bcdbf03e1bf0 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -969,7 +969,9 @@ _scratch_mkfs_sized()
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local mixed_opt=3D
>>>> -=C2=A0=C2=A0=C2=A0 (( fssize <=3D 1024 * 1024 * 1024 )) && mixed_op=
t=3D'--mixed'
>>>> +=C2=A0=C2=A0=C2=A0 # minimum size that's needed without the mixed o=
ption.
>>>> +=C2=A0=C2=A0=C2=A0 # Non mixed mode is also the default option.
>>>> +=C2=A0=C2=A0=C2=A0 (( fssize < 114294784 )) && mixed_opt=3D'--mixed=
'
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixe=
d_opt -b $fssize $SCRATCH_DEV
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jfs)
>>>>
>>>
>=20
