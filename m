Received: from mx2.suse.de ([195.135.220.15]:42936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfDLH1j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 12 Apr 2019 03:27:39 -0400
Subject: Re: [PATCH RFC] fstests: generic/077: fix populate fs use _fill_fs()
References: <20190412052418.22206-1-anand.jain@oracle.com>
 <91949b01-d016-f732-265b-77a397a1efbe@gmx.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <dd0e5f46-09b0-8be2-d909-2e011d72ff5e@suse.com>
Date: Fri, 12 Apr 2019 10:27:35 +0300
MIME-Version: 1.0
In-Reply-To: <91949b01-d016-f732-265b-77a397a1efbe@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 12.04.19 =D0=B3. 10:15 =D1=87., Qu Wenruo wrote:
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

I've had the same issue, the problem is that once the fs is full cp will
continue happily trying to copy stuff and will just be failing with ENOSP=
C

>=20
>>
>> This patch propose to use the common/populate function _fill_fs() to
>> write files into the target directory instead. However I am not too
>> sure about the motivation of this test case in the first place, and
>> why does it wanted to cp /usr or /lib,
>=20
> To my eyes, it's using /usr or /lib just for it's mostly full/contains =
a
> lot of files for most systems.
>=20
>> and why fs should become full?
>=20
> Maybe to hit certain ENOSPC corner case for ACL/xattr, just my guess.

nod, I've used that test to test certain patches (latest this test was
useful is when testing Anad's xattr/acl patches)

>=20
>> Any idea? Thanks.
>=20
> Use populate_fs is definitely the right move.
>=20
> However I have some concern below.
>=20
> [snip]
>>  echo "*** set default ACL"
>>  setfacl -R -dm u:fsgqa:rwx,g::rwx,o::r-x,m::rwx $SCRATCH_MNT/subdir
>> =20
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

Looking at the test shouldn't the "set default acl" be done after the fs
is completely full?

>=20
> Thanks,
> Qu
>=20
>> =20
>>  _check_scratch_fs
>> =20
>> diff --git a/tests/generic/077.out b/tests/generic/077.out
>> index eae7226ab29c..9c143c902a2c 100644
>> --- a/tests/generic/077.out
>> +++ b/tests/generic/077.out
>> @@ -1,7 +1,6 @@
>>  QA output created by 077
>>  *** create filesystem
>>  *** set default ACL
>> -*** populate filesystem, pass #1
>> -*** populate filesystem, pass #2
>> +*** populate filesystem
>>  *** all done
>>  *** unmount
>>
>=20
