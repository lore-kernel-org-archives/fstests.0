Received: from aserp2120.oracle.com ([141.146.126.78]:40784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZMsz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Sep 2018 08:48:55 -0400
Subject: Re: [PATCH v2 1/9] fstests: btrfs: _scratch_mkfs_sized fix min size
 without mixed option
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-2-git-send-email-anand.jain@oracle.com>
 <b054a402-0507-4990-6752-8d75b02a97ed@suse.com>
 <68c6443f-6d2b-ba3a-40e1-994fa5ee32e3@oracle.com>
 <b6a81bfa-66f6-89e3-3c1e-2d5396f8bbf4@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <2430cb59-fb64-11ef-5baa-ae20589d916e@oracle.com>
Date: Wed, 26 Sep 2018 14:37:20 +0800
MIME-Version: 1.0
In-Reply-To: <b6a81bfa-66f6-89e3-3c1e-2d5396f8bbf4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
List-ID: <fstests@vger.kernel.org>



On 09/26/2018 02:34 PM, Nikolay Borisov wrote:
>=20
>=20
> On 26.09.2018 07:07, Anand Jain wrote:
>>
>>
>> On 09/25/2018 06:51 PM, Nikolay Borisov wrote:
>>>
>>>
>>> On 25.09.2018 07:24, Anand Jain wrote:
>>>> As of now _scratch_mkfs_sized() checks if the requested size is belo=
w 1G
>>>> and forces the --mixed option for the mkfs.btrfs. Well the correct s=
ize
>>>> considering all possible group profiles at which we need to force th=
e
>>>> mixed option is roughly 256Mbytes. So fix that.
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>
>>> Have you considered the implications of this w.r.t commit
>>> d4da414a9a9d ("common/rc: raise btrfs mixed mode threshold to 1GB")
>>>
>>> Initially this threshold was 100mb then Omar changed it to 1g. Does t=
his
>>> change affect generic/427?
>>
>> d4da414a9a9d does not explain what was the problem that Omar wanted to
>> address, mainly what was the failure about.
>=20
> I just retested on upstream 4.19.0-rc3 with Omar's patch reverted (so
> anything above 100m for fs size is created with non-mixed block groups)
> and the test succeeded. So indeed your change seems to not make a
> difference for this test.

  Thanks for testing.
Anand

>>
>> And no it does not affect. I have verified generic/427 with kernel 4.1
>> and 4.19-rc5 with=C2=A0 btrfs-progs 4.1, 4.9 and latest from kdave the=
y all
>> run fine. Good to integrate.
>>
>> Thanks, Anand
>>
>>>
>>>> ---
>>>>  =C2=A0 common/rc | 5 ++++-
>>>>  =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/common/rc b/common/rc
>>>> index d5bb1feee2c3..90dc3002bc3d 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -969,7 +969,10 @@ _scratch_mkfs_sized()
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local mixed_opt=3D
>>>> -=C2=A0=C2=A0=C2=A0 (( fssize <=3D 1024 * 1024 * 1024 )) && mixed_op=
t=3D'--mixed'
>>>> +=C2=A0=C2=A0=C2=A0 # minimum size that's needed without the mixed o=
ption.
>>>> +=C2=A0=C2=A0=C2=A0 # Ref: btrfs-prog: btrfs_min_dev_size()
>>>> +=C2=A0=C2=A0=C2=A0 # Non mixed mode is also the default option.
>>>> +=C2=A0=C2=A0=C2=A0 (( fssize < $((256 * 1024 *1024)) )) && mixed_op=
t=3D'--mixed'
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixe=
d_opt -b $fssize $SCRATCH_DEV
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jfs)
>>>>
>>
