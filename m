Received: from userp2120.oracle.com ([156.151.31.85]:53350 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1TsV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Sep 2018 15:48:21 -0400
Subject: Re: [PATCH v2 1/9] fstests: btrfs: _scratch_mkfs_sized fix min size
 without mixed option
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-2-git-send-email-anand.jain@oracle.com>
 <b054a402-0507-4990-6752-8d75b02a97ed@suse.com>
 <68c6443f-6d2b-ba3a-40e1-994fa5ee32e3@oracle.com>
 <b6a81bfa-66f6-89e3-3c1e-2d5396f8bbf4@suse.com>
 <20180927200755.GC29754@vader>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <24327738-3749-e838-5b38-5e8b64f2bd3b@oracle.com>
Date: Fri, 28 Sep 2018 21:23:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180927200755.GC29754@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Omar Sandoval <osandov@osandov.com>, Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 09/28/2018 04:07 AM, Omar Sandoval wrote:
> On Wed, Sep 26, 2018 at 09:34:27AM +0300, Nikolay Borisov wrote:
>>
>>
>> On 26.09.2018 07:07, Anand Jain wrote:
>>>
>>>
>>> On 09/25/2018 06:51 PM, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 25.09.2018 07:24, Anand Jain wrote:
>>>>> As of now _scratch_mkfs_sized() checks if the requested size is bel=
ow 1G
>>>>> and forces the --mixed option for the mkfs.btrfs. Well the correct =
size
>>>>> considering all possible group profiles at which we need to force t=
he
>>>>> mixed option is roughly 256Mbytes. So fix that.
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>
>>>> Have you considered the implications of this w.r.t commit
>>>> d4da414a9a9d ("common/rc: raise btrfs mixed mode threshold to 1GB")
>>>>
>>>> Initially this threshold was 100mb then Omar changed it to 1g. Does =
this
>>>> change affect generic/427?
>>>
>>> d4da414a9a9d does not explain what was the problem that Omar wanted t=
o
>>> address, mainly what was the failure about.
>>
>> I just retested on upstream 4.19.0-rc3 with Omar's patch reverted (so
>> anything above 100m for fs size is created with non-mixed block groups=
)
>> and the test succeeded. So indeed your change seems to not make a
>> difference for this test.
>>
>>>
>>> And no it does not affect. I have verified generic/427 with kernel 4.=
1
>>> and 4.19-rc5 with=C2=A0 btrfs-progs 4.1, 4.9 and latest from kdave th=
ey all
>>> run fine. Good to integrate.
>=20
> I had to double check, but it only happens with -m dup. If I apply the
> following patch:
>=20
> diff --git a/common/rc b/common/rc
> index d5bb1fe..989b846 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -969,7 +969,7 @@ _scratch_mkfs_sized()
>   	;;
>       btrfs)
>   	local mixed_opt=3D
> -	(( fssize <=3D 1024 * 1024 * 1024 )) && mixed_opt=3D'--mixed'
> +	(( fssize <=3D 100 * 1024 * 1024 )) && mixed_opt=3D'--mixed'
>   	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>   	;;
>       jfs)
> diff --git a/tests/generic/427 b/tests/generic/427
> index e8ebffe..206cf08 100755
> --- a/tests/generic/427
> +++ b/tests/generic/427
> @@ -65,6 +65,7 @@ fi
>   # start a background aio writer, which does several extending loops
>   # internally and check data integrality
>   $AIO_TEST -s $fsize -b 65536 $SCRATCH_MNT/tst-aio-dio-eof-race.$seq
> +btrfs fi usage $SCRATCH_MNT
>   status=3D$?
>  =20
>   kill $open_close_pid
>=20
> And run with MKFS_OPTIONS=3D"-m dup", then we don't have enough data sp=
ace
> for the test:
>=20
> --- /root/linux/xfstests/tests/generic/427.out	2017-11-28 16:05:46.8114=
35644 -0800
> +++ /root/linux/xfstests/results/generic/427.out.bad	2018-09-27 13:01:0=
0.540510385 -0700
> @@ -1,2 +1,24 @@
>   QA output created by 427
> -Success, all done.
> +pwrite: No space left on device

Thanks Omar. Unfortunately I can't reproduce with the diff as above +=20
MKFS_OPTIONS=3D"-m dup".

In any case the objective of this patch is to ensure=20
_scratch_mkfs_sized() provides default group profile with the minimum=20
disk size that's actually be required. And related to that there isn't=20
any issue in this patch.

Thanks, Anand

> +Overall:
> +    Device size:		 256.00MiB
> +    Device allocated:		 255.00MiB
> +    Device unallocated:		   1.00MiB
> +    Device missing:		     0.00B
> +    Used:			 179.03MiB
> +    Free (estimated):		     0.00B	(min: 0.00B)
> +    Data ratio:			      1.00
> +    Metadata ratio:		      2.00
> +    Global reserve:		  16.00MiB	(used: 0.00B)
> +
> +Data,single: Size:175.00MiB, Used:175.00MiB
> +   /dev/nvme0n1p2	 175.00MiB
> +
> +Metadata,DUP: Size:32.00MiB, Used:2.00MiB
> +   /dev/nvme0n1p2	  64.00MiB
> +
> +System,DUP: Size:8.00MiB, Used:16.00KiB
> +   /dev/nvme0n1p2	  16.00MiB
> +
> +Unallocated:
> +   /dev/nvme0n1p2	   1.00MiB
>=20
