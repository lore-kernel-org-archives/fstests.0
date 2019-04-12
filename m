Received: from userp2120.oracle.com ([156.151.31.85]:38674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfDLHjk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Apr 2019 03:39:40 -0400
Subject: Re: [PATCH RFC] fstests: generic/077: fix populate fs use _fill_fs()
References: <20190412052418.22206-1-anand.jain@oracle.com>
 <91949b01-d016-f732-265b-77a397a1efbe@gmx.com>
 <dd0e5f46-09b0-8be2-d909-2e011d72ff5e@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <1586b0c1-c973-8ace-ca8b-e3f52298dd25@oracle.com>
Date: Fri, 12 Apr 2019 15:39:26 +0800
MIME-Version: 1.0
In-Reply-To: <dd0e5f46-09b0-8be2-d909-2e011d72ff5e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 12/4/19 3:27 PM, Nikolay Borisov wrote:
>=20
>=20
> On 12.04.19 =D0=B3. 10:15 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/4/12 =E4=B8=8B=E5=8D=881:24, Anand Jain wrote:
>>> Test case generic/077 uses files under /lib or /usr to fill SCRATCH_M=
NT.
>>> If /usr or /lib is below 256mb then test fails to run, or if these di=
rs
>>> are too large it takes a long time for the cp to finish. On my machin=
e
>>> it takes 645sec.
>>
>> Wait for a minute, ths fs is only 256M sized, if it takes you over 10
>> minutes, there must be something else wrong.
>=20
> I've had the same issue, the problem is that once the fs is full cp wil=
l
> continue happily trying to copy stuff and will just be failing with ENO=
SPC
>=20
>>
>>>
>>> This patch propose to use the common/populate function _fill_fs() to
>>> write files into the target directory instead. However I am not too
>>> sure about the motivation of this test case in the first place, and
>>> why does it wanted to cp /usr or /lib,
>>
>> To my eyes, it's using /usr or /lib just for it's mostly full/contains=
 a
>> lot of files for most systems.
>>
>>> and why fs should become full?
>>
>> Maybe to hit certain ENOSPC corner case for ACL/xattr, just my guess.
>=20
> nod, I've used that test to test certain patches (latest this test was
> useful is when testing Anad's xattr/acl patches)
>=20
>>
>>> Any idea? Thanks.
>>
>> Use populate_fs is definitely the right move.
>>
>> However I have some concern below.
>>
>> [snip]
>>>   echo "*** set default ACL"
>>>   setfacl -R -dm u:fsgqa:rwx,g::rwx,o::r-x,m::rwx $SCRATCH_MNT/subdir
>>>  =20
>>> -echo "*** populate filesystem, pass #1" | tee -a $seqres.full
>>> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
>>> -
>>> -echo "*** populate filesystem, pass #2" | tee -a $seqres.full
>>> -cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
>>> +blksz=3D"$(_get_block_size $SCRATCH_MNT/subdir)"
>>> +echo "*** populate filesystem" | tee -a $seqres.full
>>> +echo "*** fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0" >> $seqres.=
full
>>> +_fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0 >> $seqres.full 2>&1
>>
>> Unlike the original behavior, which do 2 passes and the 2nd pass will
>> overwrite previous files.
>>
>> While after your modification, it's no longer the case.
>>
>> At least we should try to replay the 1st run to mimic the original beh=
avior.
>=20
> Looking at the test shouldn't the "set default acl" be done after the f=
s
> is completely full?

  Even by using a large /usr, the cp (2 iterations) was never been able
  to make the metadata full, (same with __full_fs() as well).

  After cp -r /usr <256mb fs> reported ENOSPC.
  stat -f -c "%f" /btrfs
   16488

Thanks, Anand

>>
>> Thanks,
>> Qu
>>
>>>  =20
>>>   _check_scratch_fs
>>>  =20
>>> diff --git a/tests/generic/077.out b/tests/generic/077.out
>>> index eae7226ab29c..9c143c902a2c 100644
>>> --- a/tests/generic/077.out
>>> +++ b/tests/generic/077.out
>>> @@ -1,7 +1,6 @@
>>>   QA output created by 077
>>>   *** create filesystem
>>>   *** set default ACL
>>> -*** populate filesystem, pass #1
>>> -*** populate filesystem, pass #2
>>> +*** populate filesystem
>>>   *** all done
>>>   *** unmount
>>>
>>
