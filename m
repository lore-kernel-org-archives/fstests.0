Received: from userp2120.oracle.com ([156.151.31.85]:57254 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJ0ALr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Oct 2018 20:11:47 -0400
Subject: Re: [PATCH v2 rev log added] fstests: btrfs verify hardening agaist
 duplicate fsid
References: <1538383475-2532-1-git-send-email-anand.jain@oracle.com>
 <1539023301-4583-1-git-send-email-anand.jain@oracle.com>
 <c2e09b66-6c15-9bbe-c340-0a6015ea4a0e@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <6b58c095-d0a1-6330-0385-b06aa9c99483@oracle.com>
Date: Fri, 26 Oct 2018 23:34:04 +0800
MIME-Version: 1.0
In-Reply-To: <c2e09b66-6c15-9bbe-c340-0a6015ea4a0e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 10/26/2018 11:02 PM, Nikolay Borisov wrote:
>=20
>=20
> On 8.10.18 =D0=B3. 21:28 =D1=87., Anand Jain wrote:
>> We have a known bug in btrfs, that we let the device path be changed
>> after the device has been mounted. So using this loop hole the new
>> copied device would appears as if its mounted immediately after its
>> been copied. So this test case reproduces this issue.
>>
>> For example:
>>
>> Initially.. /dev/mmcblk0p4 is mounted as /
>>
>> lsblk
>> NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>> mmcblk0     179:0    0 29.2G  0 disk
>> |-mmcblk0p4 179:4    0    4G  0 part /
>> |-mmcblk0p2 179:2    0  500M  0 part /boot
>> |-mmcblk0p3 179:3    0  256M  0 part [SWAP]
>> `-mmcblk0p1 179:1    0  256M  0 part /boot/efi
>>
>> btrfs fi show
>> Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
>>      Total devices 1 FS bytes used 1.40GiB
>>      devid    1 size 4.00GiB used 3.00GiB path /dev/mmcblk0p4
>>
>> Copy mmcblk0 to sda
>> dd if=3D/dev/mmcblk0 of=3D/dev/sda
>>
>> And immediately after the copy completes the change in the device
>> superblock is notified which the automount scans using
>> btrfs device scan and the new device sda becomes the mounted root
>> device.
>>
>> lsblk
>> NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>> sda           8:0    1 14.9G  0 disk
>> |-sda4        8:4    1    4G  0 part /
>> |-sda2        8:2    1  500M  0 part
>> |-sda3        8:3    1  256M  0 part
>> `-sda1        8:1    1  256M  0 part
>> mmcblk0     179:0    0 29.2G  0 disk
>> |-mmcblk0p4 179:4    0    4G  0 part
>> |-mmcblk0p2 179:2    0  500M  0 part /boot
>> |-mmcblk0p3 179:3    0  256M  0 part [SWAP]
>> `-mmcblk0p1 179:1    0  256M  0 part /boot/efi
>> btrfs fi show /
>> Label: none  uuid: 07892354-ddaa-4443-90ea-f76a06accaba
>>      Total devices 1 FS bytes used 1.40GiB
>>      devid    1 size 4.00GiB used 3.00GiB path /dev/sda4
>>
>> The bug is quite nasty that you can't either unmount /dev/sda4 or
>> /dev/mmcblk0p4. And the problem does not get solved until you take
>> the sda out of the system on to another system to change its fsid usin=
g
>> the 'btrfstune -u' command.
>=20
> Is there a pending fix for this?

Yes.
https://patchwork.kernel.org/patch/10641041/

Test case header mentioned it.

>=20
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v1->v2:
>>    dont play around with dev patch use it as it is.
>>    do not use SCRATCH_MNT instead create it at the TEST_DIR and its re=
lated
>>     changes.
>>    golden out changes
>>    =20
>>   tests/btrfs/173     | 88 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>   tests/btrfs/173.out |  6 ++++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 95 insertions(+)
>>   create mode 100755 tests/btrfs/173
>>   create mode 100644 tests/btrfs/173.out
>>
>> diff --git a/tests/btrfs/173 b/tests/btrfs/173
>> new file mode 100755
>> index 000000000000..b466ae921e19
>> --- /dev/null
>> +++ b/tests/btrfs/173
>> @@ -0,0 +1,88 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2018 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 173
>> +#
>> +# Fuzzy test for FS image duplication.
>> +#  Could be fixed by
>> +#    [patch] btrfs: harden agaist duplicate fsid
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +mnt=3D$TEST_DIR/$seq.mnt
>> +_cleanup()
>> +{
>> +	rm -rf $mnt > /dev/null 2>&1
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch_dev_pool 2
>> +_scratch_dev_pool_get 2
>> +
>> +dev_foo=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>> +dev_bar=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>=20
> Naming devices _foo and _bar just shows you could not care less about
> the test.

   Hmm. Will make it device_1 and device_2.

> Either use sane names - primary_dev/secondary dev or device_1
> and device_2.

>> +
>> +echo dev_foo=3D$dev_foo >> $seqres.full
>> +echo dev_bar=3D$dev_bar >> $seqres.full
>> +echo | tee -a $seqres.full
>> +
>> +rm -rf $mnt > /dev/null 2>&1
>=20
> So what is $mnt? I can see it's used by very few tests and it's not
> obvious? Generally you should either define it as a local variable or
> use one of the SCRATCH_MNT/TEST_MNT global variables. Also I checked
> with Eric re. the use of $mnt in tests and his conclusion is :
>=20
> "<sandeen> looks like a bug"

  No its not. As few lines above, I have assigned it as..
     mnt=3D$TEST_DIR/$seq.mnt


>> +mkdir $mnt
>> +_mkfs_dev $dev_foo
>> +_mount $dev_foo $mnt
>> +
>> +check_btrfs_mount()
>> +{
>> +	local x=3D$(findmnt $mnt | grep -v TARGET | awk '{print $2}')
>> +	[[ $x =3D=3D $dev_foo ]] && echo DEV_FOO
>> +	[[ $x =3D=3D $dev_bar ]] && echo DEV_BAR
>> +}
>=20
> Same thing here re. DEV_(FOO|BAR).
>=20
>> +
>> +echo MNT $(check_btrfs_mount)
>> +
>> +for sb_bytenr in 65536 67108864
>> +do
>> +	echo -n "dd status=3Dnone if=3D$dev_foo of=3D$dev_bar bs=3D1 "\
>> +		"seek=3D$sb_bytenr skip=3D$sb_bytenr count=3D4096" >> $seqres.full
>> +	dd status=3Dnone if=3D$dev_foo of=3D$dev_bar bs=3D1 seek=3D$sb_byten=
r \
>> +				skip=3D$sb_bytenr count=3D4096 >> $seqres.full 2>&1
>> +	echo ..:$? >> $seqres.full
>=20
> This is an overkill, just use dd ... >/dev/null 2>&1, no one cares abou=
t
> the output of that. Also use DIO so that sb's are directly written to
> the devices.

  Yeah right will fix.

>> +done
>> +
>> +#Original device is mounted, scan of its clone should fail
>> +$BTRFS_UTIL_PROG device scan $dev_bar >> $seqres.full 2>&1
>> +echo btrfs device scan dev_bar ...:$?| tee -a $seqres.full
>> +
>> +echo MNT $(check_btrfs_mount)
>> +
>> +#Original device scan should be successful
>> +$BTRFS_UTIL_PROG device scan $dev_foo >> $seqres.full 2>&1
>> +echo btrfs device scan dev_foo ...:$?| tee -a $seqres.full
>> +
>> +umount $mnt > /dev/null 2>&1
>> +_scratch_dev_pool_put
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/173.out b/tests/btrfs/173.out
>> new file mode 100644
>> index 000000000000..3c7e3fb4e3f7
>> --- /dev/null
>> +++ b/tests/btrfs/173.out
>> @@ -0,0 +1,6 @@
>> +QA output created by 173
>> +
>> +MNT DEV_FOO
>> +btrfs device scan dev_bar ...:1
>> +MNT DEV_FOO
>> +btrfs device scan dev_foo ...:0
>=20
> It seems the output is really pointless it should just be "Silence is
> golden". Then in the test you would do all your run-time checks of
> what's the source of the mount etc etc and if your expectations don't
> match you fail the test and don't output "Silence is golden" which woul=
d
> signal success. Check for example

  I could do that. Will fix.

Thanks, Anand

>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 45782565c3b7..b2f1393f3e97 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -175,3 +175,4 @@
>>   170 auto quick snapshot
>>   171 auto quick qgroup
>>   172 auto quick punch
>> +173 volume
>>
