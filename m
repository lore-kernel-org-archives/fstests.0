Received: from userp2130.oracle.com ([156.151.31.86]:47922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLHaS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Apr 2019 03:30:18 -0400
Subject: Re: [PATCH RFC] fstests: generic/077: fix populate fs use _fill_fs()
References: <20190412052418.22206-1-anand.jain@oracle.com>
 <91949b01-d016-f732-265b-77a397a1efbe@gmx.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <b92da32a-d991-f86d-7b85-b1dd33f92b61@oracle.com>
Date: Fri, 12 Apr 2019 15:30:08 +0800
MIME-Version: 1.0
In-Reply-To: <91949b01-d016-f732-265b-77a397a1efbe@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 12/4/19 3:15 PM, Qu Wenruo wrote:
>=20
>=20
> On 2019/4/12 =E4=B8=8B=E5=8D=881:24, Anand Jain wrote:
>> Test case generic/077 uses files under /lib or /usr to fill SCRATCH_MN=
T.
>> If /usr or /lib is below 256mb then test fails to run, or if these dir=
s
>> are too large it takes a long time for the cp to finish. On my machine
>> it takes 645sec.
>=20
> Wait for a minute, ths fs is only 256M sized, if it takes you over 10
> minutes, there must be something else wrong.

  What's happening is cp -r fails (ENOSPC) for each file, so the
  cp -r runs for a long time.

>>
>> This patch propose to use the common/populate function _fill_fs() to
>> write files into the target directory instead. However I am not too
>> sure about the motivation of this test case in the first place, and
>> why does it wanted to cp /usr or /lib,
>=20
> To my eyes, it's using /usr or /lib just for it's mostly full/contains =
a
> lot of files for most systems.

  A lot of files. At the same time its not consistent across systems.

>> and why fs should become full?
>=20
> Maybe to hit certain ENOSPC corner case for ACL/xattr, just my guess.

ok.

>> Any idea? Thanks.
>=20
> Use populate_fs is definitely the right move.
>=20
> However I have some concern below.
>=20
> [snip]
>>   echo "*** set default ACL"
>>   setfacl -R -dm u:fsgqa:rwx,g::rwx,o::r-x,m::rwx $SCRATCH_MNT/subdir
>>  =20
>> -echo "*** populate filesystem, pass #1" | tee -a $seqres.full
>> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
>> -
>> -echo "*** populate filesystem, pass #2" | tee -a $seqres.full
>> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
>> +blksz=3D"$(_get_block_size $SCRATCH_MNT/subdir)"
>> +echo "*** populate filesystem" | tee -a $seqres.full
>> +echo "*** fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0" >> $seqres.f=
ull
>> +_fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0 >> $seqres.full 2>&1
>=20
> Unlike the original behavior, which do 2 passes and the 2nd pass will
> overwrite previous files.
>=20
> While after your modification, it's no longer the case.
>=20
> At least we should try to replay the 1st run to mimic the original beha=
vior.

  yep.

Thanks, Anand

> Thanks,
> Qu
>=20
>>  =20
>>   _check_scratch_fs
>>  =20
>> diff --git a/tests/generic/077.out b/tests/generic/077.out
>> index eae7226ab29c..9c143c902a2c 100644
>> --- a/tests/generic/077.out
>> +++ b/tests/generic/077.out
>> @@ -1,7 +1,6 @@
>>   QA output created by 077
>>   *** create filesystem
>>   *** set default ACL
>> -*** populate filesystem, pass #1
>> -*** populate filesystem, pass #2
>> +*** populate filesystem
>>   *** all done
>>   *** unmount
>>
>=20
