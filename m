Received: from aserp2130.oracle.com ([141.146.126.79]:50414 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfCYMmE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Mar 2019 08:42:04 -0400
Subject: Re: [PATCH] fstests: Verify that removed device has its superblocks
 deleted
From: Anand Jain <anand.jain@oracle.com>
References: <20190325094200.18687-1-nborisov@suse.com>
 <620fe973-9b9a-8915-8b41-bb1baccfee2b@oracle.com>
Message-ID: <b7d33a7f-9f38-11a5-aab0-eb4639b603a0@oracle.com>
Date: Mon, 25 Mar 2019 20:41:27 +0800
MIME-Version: 1.0
In-Reply-To: <620fe973-9b9a-8915-8b41-bb1baccfee2b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>
Cc: guaneryu@gmail.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 3/25/19 8:36 PM, Anand Jain wrote:
>=20
>=20
> On 3/25/19 5:42 PM, Nikolay Borisov wrote:
>> When a device is removed from a btrfs filesystem its superblock copies
>> must be deleted. This test ensures this is indeed the case.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>> =C2=A0 tests/btrfs/184=C2=A0=C2=A0=C2=A0=C2=A0 | 57=20
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/btrfs/184.out |=C2=A0 2 ++
>> =C2=A0 tests/btrfs/group=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 3 files changed, 60 insertions(+)
>> =C2=A0 create mode 100755 tests/btrfs/184
>> =C2=A0 create mode 100644 tests/btrfs/184.out
>>
>> diff --git a/tests/btrfs/184 b/tests/btrfs/184
>> new file mode 100755
>> index 000000000000..3bf7d201a145
>> --- /dev/null
>> +++ b/tests/btrfs/184
>> @@ -0,0 +1,57 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
>> +#
>> +# FS QA Test 184
>> +#
>> +# Verify that when a device is removed from a multi-device
>> +# filesystem its superblock copies are correctly deleted
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1=C2=A0=C2=A0=C2=A0 # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +=C2=A0=C2=A0=C2=A0 cd /
>> +=C2=A0=C2=A0=C2=A0 rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch
>> +_require_scratch_dev_pool 2
>> +_require_btrfs_command inspect-internal dump-super
>> +
>> +_scratch_pool_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>> +_scratch_mount
>> +
>> +# pick last dev in the list
>> +dev_del=3D`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
>=20
>> +$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs=20
>> device delete failed"
>=20
>  =C2=A0Device delete will fail with the raid1 mkfs option in the config=
 fail.

  Also needs

  _scratch_dev_pool_get 2
  _scratch_dev_pool_put


> Thanks, Anand
>=20
>=20
>> +for i in {0..2}; do
>> +=C2=A0=C2=A0=C2=A0 output=3D$($BTRFS_UTIL_PROG inspect-internal dump-=
super -s $i=20
>> $dev_del 2>&1)
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG inspect-internal dump-super -s $i=
 $dev_del 2>&1=20
>> | grep -q "bad magic"
>> +=C2=A0=C2=A0=C2=A0 ret=3D$?
>> +=C2=A0=C2=A0=C2=A0 if [[ "$output" !=3D "" && $ret -eq 1 ]]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _fail "Deleted dev superbl=
ocks not scratched"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +done
>> +_scratch_unmount
>> +
>> +# success, all done
>> +echo "Silence is golden"
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/184.out b/tests/btrfs/184.out
>> new file mode 100644
>> index 000000000000..b4ce96cfc047
>> --- /dev/null
>> +++ b/tests/btrfs/184.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 184
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index f3227c1708d9..c1d215bf5ff8 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -186,3 +186,4 @@
>> =C2=A0 181 auto quick balance
>> =C2=A0 182 auto quick balance
>> =C2=A0 183 auto quick clone compress punch
>> +184 auto quick volume
>>
