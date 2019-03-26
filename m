Received: from mx2.suse.de ([195.135.220.15]:40154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfCZOLO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Mar 2019 10:11:14 -0400
Subject: Re: [PATCH v2] fstests: Verify that removed device has its
 superblocks deleted
References: <20190325094200.18687-1-nborisov@suse.com>
 <20190325140713.9509-1-nborisov@suse.com>
 <b50e36d4-b65a-3b9e-e776-3b11d90a32e2@oracle.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <f6512798-1e7a-37fd-6309-cfa1de1f7ac1@suse.com>
Date: Tue, 26 Mar 2019 16:11:10 +0200
MIME-Version: 1.0
In-Reply-To: <b50e36d4-b65a-3b9e-e776-3b11d90a32e2@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Anand Jain <anand.jain@oracle.com>
Cc: guaneryu@gmail.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 25.03.19 =D0=B3. 23:55 =D1=87., Anand Jain wrote:
>=20
>=20
> On 3/25/19 10:07 PM, Nikolay Borisov wrote:
>> When a device is removed from a btrfs filesystem its superblock copies
>> must be deleted.=20
>=20
> AFAIK this bug was fixed a long time back in the kernel. Is there any
> newer fix in the kernel?

No there isn't but we currently don't have a test that covers that
functionality and I have some changes in progress that touch superblock
writing code so I'd rather be safe than sorry.

>=20
>> This test ensures this is indeed the case.
>=20
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>=20
> Looks good.
>=20
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>=20
>> ---
>>
>> Changes since v1:
>> =C2=A0 * Use _scratch_dev_pool_(get|put) to ensure the test uses exact=
ly 2
>> devices.
>> =C2=A0 =C2=A0 * Explicitly use -draid0 -mraid0 mkfs options for the sc=
ratch
>> devices to
>> =C2=A0 ensure at least one of the device could be removed. Also add a
>> comment about
>> =C2=A0 that.
>>
>> =C2=A0 tests/btrfs/184=C2=A0=C2=A0=C2=A0=C2=A0 | 63
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/btrfs/184.out |=C2=A0 2 ++
>> =C2=A0 tests/btrfs/group=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 3 files changed, 66 insertions(+)
>> =C2=A0 create mode 100755 tests/btrfs/184
>> =C2=A0 create mode 100644 tests/btrfs/184.out
>>
>> diff --git a/tests/btrfs/184 b/tests/btrfs/184
>> new file mode 100755
>> index 000000000000..49fe5c9c27bb
>> --- /dev/null
>> +++ b/tests/btrfs/184
>> @@ -0,0 +1,63 @@
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
>> +_scratch_dev_pool_get 2
>> +
>> +# Explicitly use raid0 mode to ensure at least one of the devices can=
 be
>> +# removed.
>> +_scratch_pool_mkfs "-d raid0 -m raid0" >> $seqres.full 2>&1 || _fail
>> "mkfs failed"
>> +_scratch_mount
>> +
>> +# pick last dev in the list
>> +dev_del=3D`echo ${SCRATCH_DEV_POOL} | awk '{print $NF}'`
>> +$BTRFS_UTIL_PROG device delete $dev_del $SCRATCH_MNT || _fail "btrfs
>> device delete failed"
>> +for i in {0..2}; do
>> +=C2=A0=C2=A0=C2=A0 output=3D$($BTRFS_UTIL_PROG inspect-internal dump-=
super -s $i
>> $dev_del 2>&1)
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG inspect-internal dump-super -s $i=
 $dev_del 2>&1
>> | grep -q "bad magic"
>> +=C2=A0=C2=A0=C2=A0 ret=3D$?
>> +=C2=A0=C2=A0=C2=A0 if [[ "$output" !=3D "" && $ret -eq 1 ]]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _fail "Deleted dev superbl=
ocks not scratched"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +done
>> +_scratch_unmount
>> +
>> +_scratch_dev_pool_put
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
>=20
