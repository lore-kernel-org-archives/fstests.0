Received: from aserp2120.oracle.com ([141.146.126.78]:58486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJ0Afc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Oct 2018 20:35:32 -0400
Subject: Re: [PATCH v2 rev log added] fstests: btrfs verify hardening agaist
 duplicate fsid
References: <1538383475-2532-1-git-send-email-anand.jain@oracle.com>
 <1539023301-4583-1-git-send-email-anand.jain@oracle.com>
 <c2e09b66-6c15-9bbe-c340-0a6015ea4a0e@suse.com>
 <6b58c095-d0a1-6330-0385-b06aa9c99483@oracle.com>
 <8003c16e-1eef-1e7e-d697-11d8d32c2e91@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <cbdb0ebb-0bd4-561e-4509-096a72c4e710@oracle.com>
Date: Fri, 26 Oct 2018 23:57:45 +0800
MIME-Version: 1.0
In-Reply-To: <8003c16e-1eef-1e7e-d697-11d8d32c2e91@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 10/26/2018 11:52 PM, Nikolay Borisov wrote:
>=20
>=20
> On 26.10.18 =D0=B3. 18:34 =D1=87., Anand Jain wrote:
>>
>>
>> On 10/26/2018 11:02 PM, Nikolay Borisov wrote:
>>>
>>>
>>> On 8.10.18 =D0=B3. 21:28 =D1=87., Anand Jain wrote:
>>>> We have a known bug in btrfs, that we let the device path be changed
>>>> after the device has been mounted. So using this loop hole the new
>>>> copied device would appears as if its mounted immediately after its
>>>> been copied. So this test case reproduces this issue.
>>>>
>>>> For example:
>>>>
>>>> Initially.. /dev/mmcblk0p4 is mounted as /
>>>>
>>>> lsblk
>>>> NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJ:MIN RM=C2=A0 SIZE=
 RO TYPE MOUNTPOINT
>>>> mmcblk0=C2=A0=C2=A0=C2=A0=C2=A0 179:0=C2=A0=C2=A0=C2=A0 0 29.2G=C2=A0=
 0 disk
>>>> |-mmcblk0p4 179:4=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 4G=C2=A0 0 p=
art /
>>>> |-mmcblk0p2 179:2=C2=A0=C2=A0=C2=A0 0=C2=A0 500M=C2=A0 0 part /boot
>>>> |-mmcblk0p3 179:3=C2=A0=C2=A0=C2=A0 0=C2=A0 256M=C2=A0 0 part [SWAP]
>>>> `-mmcblk0p1 179:1=C2=A0=C2=A0=C2=A0 0=C2=A0 256M=C2=A0 0 part /boot/=
efi
>>>>
>>>> btrfs fi show
>>>> Label: none=C2=A0 uuid: 07892354-ddaa-4443-90ea-f76a06accaba
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 1.40GiB
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 4.00GiB use=
d 3.00GiB path /dev/mmcblk0p4
>>>>
>>>> Copy mmcblk0 to sda
>>>> dd if=3D/dev/mmcblk0 of=3D/dev/sda
>>>>
>>>> And immediately after the copy completes the change in the device
>>>> superblock is notified which the automount scans using
>>>> btrfs device scan and the new device sda becomes the mounted root
>>>> device.
>>>>
>>>> lsblk
>>>> NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJ:MIN RM=C2=A0 SIZE=
 RO TYPE MOUNTPOINT
>>>> sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:0=C2=
=A0=C2=A0=C2=A0 1 14.9G=C2=A0 0 disk
>>>> |-sda4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0=
 1=C2=A0=C2=A0=C2=A0 4G=C2=A0 0 part /
>>>> |-sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0=
 1=C2=A0 500M=C2=A0 0 part
>>>> |-sda3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0=
 1=C2=A0 256M=C2=A0 0 part
>>>> `-sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0=
 1=C2=A0 256M=C2=A0 0 part
>>>> mmcblk0=C2=A0=C2=A0=C2=A0=C2=A0 179:0=C2=A0=C2=A0=C2=A0 0 29.2G=C2=A0=
 0 disk
>>>> |-mmcblk0p4 179:4=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 4G=C2=A0 0 p=
art
>>>> |-mmcblk0p2 179:2=C2=A0=C2=A0=C2=A0 0=C2=A0 500M=C2=A0 0 part /boot
>>>> |-mmcblk0p3 179:3=C2=A0=C2=A0=C2=A0 0=C2=A0 256M=C2=A0 0 part [SWAP]
>>>> `-mmcblk0p1 179:1=C2=A0=C2=A0=C2=A0 0=C2=A0 256M=C2=A0 0 part /boot/=
efi
>>>> btrfs fi show /
>>>> Label: none=C2=A0 uuid: 07892354-ddaa-4443-90ea-f76a06accaba
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 1.40GiB
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 4.00GiB use=
d 3.00GiB path /dev/sda4
>>>>
>>>> The bug is quite nasty that you can't either unmount /dev/sda4 or
>>>> /dev/mmcblk0p4. And the problem does not get solved until you take
>>>> the sda out of the system on to another system to change its fsid us=
ing
>>>> the 'btrfstune -u' command.
>>>
>>> Is there a pending fix for this?
>>
>> Yes.
>> https://patchwork.kernel.org/patch/10641041/
>>
>> Test case header mentioned it.
>>
>>>
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>> v1->v2:
>>>>  =C2=A0=C2=A0 dont play around with dev patch use it as it is.
>>>>  =C2=A0=C2=A0 do not use SCRATCH_MNT instead create it at the TEST_D=
IR and its
>>>> related
>>>>  =C2=A0=C2=A0=C2=A0 changes.
>>>>  =C2=A0=C2=A0 golden out changes
>>>>  =C2=A0=C2=A0=C2=A0 =C2=A0 tests/btrfs/173=C2=A0=C2=A0=C2=A0=C2=A0 |=
 88
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  =C2=A0 tests/btrfs/173.out |=C2=A0 6 ++++
>>>>  =C2=A0 tests/btrfs/group=C2=A0=C2=A0 |=C2=A0 1 +
>>>>  =C2=A0 3 files changed, 95 insertions(+)
>>>>  =C2=A0 create mode 100755 tests/btrfs/173
>>>>  =C2=A0 create mode 100644 tests/btrfs/173.out
>>>>
>>>> diff --git a/tests/btrfs/173 b/tests/btrfs/173
>>>> new file mode 100755
>>>> index 000000000000..b466ae921e19
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/173
>>>> @@ -0,0 +1,88 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2018 Oracle. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 173
>>>> +#
>>>> +# Fuzzy test for FS image duplication.
>>>> +#=C2=A0 Could be fixed by
>>>> +#=C2=A0=C2=A0=C2=A0 [patch] btrfs: harden agaist duplicate fsid
>>>> +#
>>>> +seq=3D`basename $0`
>>>> +seqres=3D$RESULT_DIR/$seq
>>>> +echo "QA output created by $seq"
>>>> +
>>>> +here=3D`pwd`
>>>> +tmp=3D/tmp/$$
>>>> +status=3D1=C2=A0=C2=A0=C2=A0 # failure is the default!
>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> +
>>>> +mnt=3D$TEST_DIR/$seq.mnt
>>>> +_cleanup()
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 rm -rf $mnt > /dev/null 2>&1
>>>> +=C2=A0=C2=A0=C2=A0 cd /
>>>> +=C2=A0=C2=A0=C2=A0 rm -f $tmp.*
>>>> +}
>>>> +
>>>> +# get standard environment, filters and checks
>>>> +. ./common/rc
>>>> +. ./common/filter
>>>> +
>>>> +# remove previous $seqres.full before test
>>>> +rm -f $seqres.full
>>>> +
>>>> +# real QA test starts here
>>>> +
>>>> +# Modify as appropriate.
>>>> +_supported_fs btrfs
>>>> +_supported_os Linux
>>>> +_require_scratch_dev_pool 2
>>>> +_scratch_dev_pool_get 2
>>>> +
>>>> +dev_foo=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>>>> +dev_bar=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>>>
>>> Naming devices _foo and _bar just shows you could not care less about
>>> the test.
>>
>>  =C2=A0 Hmm. Will make it device_1 and device_2.
>>
>>> Either use sane names - primary_dev/secondary dev or device_1
>>> and device_2.
>>
>>>> +
>>>> +echo dev_foo=3D$dev_foo >> $seqres.full
>>>> +echo dev_bar=3D$dev_bar >> $seqres.full
>>>> +echo | tee -a $seqres.full
>>>> +
>>>> +rm -rf $mnt > /dev/null 2>&1
>>>
>>> So what is $mnt? I can see it's used by very few tests and it's not
>>> obvious? Generally you should either define it as a local variable or
>>> use one of the SCRATCH_MNT/TEST_MNT global variables. Also I checked
>>> with Eric re. the use of $mnt in tests and his conclusion is :
>>>
>>> "<sandeen> looks like a bug"
>>
>>  =C2=A0No its not. As few lines above, I have assigned it as..
>>  =C2=A0=C2=A0=C2=A0 mnt=3D$TEST_DIR/$seq.mnt
>=20
> I missed that, I will recommend moving the assignment near where you se=
t
> the devices

  cleanup() is using $mnt. cleanup() may get called for any trap before=20
the actual test.

Thanks, Anand


>>
>>
>>>> +mkdir $mnt
>>>> +_mkfs_dev $dev_foo
>>>> +_mount $dev_foo $mnt
>>>> +
>>>> +check_btrfs_mount()
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 local x=3D$(findmnt $mnt | grep -v TARGET | awk =
'{print $2}')
>>>> +=C2=A0=C2=A0=C2=A0 [[ $x =3D=3D $dev_foo ]] && echo DEV_FOO
>>>> +=C2=A0=C2=A0=C2=A0 [[ $x =3D=3D $dev_bar ]] && echo DEV_BAR
>>>> +}
>>>
>>> Same thing here re. DEV_(FOO|BAR).
>>>
>>>> +
>>>> +echo MNT $(check_btrfs_mount)
>>>> +
>>>> +for sb_bytenr in 65536 67108864
>>>> +do
>>>> +=C2=A0=C2=A0=C2=A0 echo -n "dd status=3Dnone if=3D$dev_foo of=3D$de=
v_bar bs=3D1 "\
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "seek=3D$sb_bytenr skip=3D=
$sb_bytenr count=3D4096" >> $seqres.full
>>>> +=C2=A0=C2=A0=C2=A0 dd status=3Dnone if=3D$dev_foo of=3D$dev_bar bs=3D=
1 seek=3D$sb_bytenr \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 skip=3D$sb_bytenr count=3D4096 >> $seqres.full 2>&1
>>>> +=C2=A0=C2=A0=C2=A0 echo ..:$? >> $seqres.full
>>>
>>> This is an overkill, just use dd ... >/dev/null 2>&1, no one cares ab=
out
>>> the output of that. Also use DIO so that sb's are directly written to
>>> the devices.
>>
>>  =C2=A0Yeah right will fix.
>>
>>>> +done
>>>> +
>>>> +#Original device is mounted, scan of its clone should fail
>>>> +$BTRFS_UTIL_PROG device scan $dev_bar >> $seqres.full 2>&1
>>>> +echo btrfs device scan dev_bar ...:$?| tee -a $seqres.full
>>>> +
>>>> +echo MNT $(check_btrfs_mount)
>>>> +
>>>> +#Original device scan should be successful
>>>> +$BTRFS_UTIL_PROG device scan $dev_foo >> $seqres.full 2>&1
>>>> +echo btrfs device scan dev_foo ...:$?| tee -a $seqres.full
>>>> +
>>>> +umount $mnt > /dev/null 2>&1
>>>> +_scratch_dev_pool_put
>>>> +
>>>> +# success, all done
>>>> +status=3D0
>>>> +exit
>>>> diff --git a/tests/btrfs/173.out b/tests/btrfs/173.out
>>>> new file mode 100644
>>>> index 000000000000..3c7e3fb4e3f7
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/173.out
>>>> @@ -0,0 +1,6 @@
>>>> +QA output created by 173
>>>> +
>>>> +MNT DEV_FOO
>>>> +btrfs device scan dev_bar ...:1
>>>> +MNT DEV_FOO
>>>> +btrfs device scan dev_foo ...:0
>>>
>>> It seems the output is really pointless it should just be "Silence is
>>> golden". Then in the test you would do all your run-time checks of
>>> what's the source of the mount etc etc and if your expectations don't
>>> match you fail the test and don't output "Silence is golden" which wo=
uld
>>> signal success. Check for example
>>
>>  =C2=A0I could do that. Will fix.
>>
>> Thanks, Anand
>>
>>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>>> index 45782565c3b7..b2f1393f3e97 100644
>>>> --- a/tests/btrfs/group
>>>> +++ b/tests/btrfs/group
>>>> @@ -175,3 +175,4 @@
>>>>  =C2=A0 170 auto quick snapshot
>>>>  =C2=A0 171 auto quick qgroup
>>>>  =C2=A0 172 auto quick punch
>>>> +173 volume
>>>>
>>
