Return-Path: <fstests-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:19908 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752007AbaGUDYO convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 20 Jul 2014 23:24:14 -0400
Message-ID: <53CC87A0.1060204@cn.fujitsu.com>
Date: Mon, 21 Jul 2014 11:23:12 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ext4: regression test for wrong assert in ext4_mb_normalize_request()
References: <1405503795-3198-1-git-send-email-wangxg.fnst@cn.fujitsu.com> <alpine.LFD.2.00.1407161401080.2400@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.1407161401080.2400@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: =?windows-1252?Q?Luk=E1=9A_Czerner?= <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Lukas,

On 07/16/2014 08:02 PM, Lukáš Czerner wrote:
> On Wed, 16 Jul 2014, Xiaoguang Wang wrote:
> 
>> Date: Wed, 16 Jul 2014 17:43:15 +0800
>> From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>> To: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
>> Cc: tytso@mit.edu, mlombard@redhat.com,
>>     Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>> Subject: [PATCH] ext4: regression test for wrong assert in
>>     ext4_mb_normalize_request()
>>
>> Regression test for:
>>     b5b6077 ext4: fix wrong assert in ext4_mb_normalize_request()
>>
>> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>  tests/ext4/003     | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/ext4/003.out |  2 ++
>>  tests/ext4/group   |  1 +
>>  3 files changed, 60 insertions(+)
>>  create mode 100755 tests/ext4/003
>>  create mode 100644 tests/ext4/003.out
>>
>> diff --git a/tests/ext4/003 b/tests/ext4/003
>> new file mode 100755
>> index 0000000..d5be9a7
>> --- /dev/null
>> +++ b/tests/ext4/003
>> @@ -0,0 +1,57 @@
>> +#! /bin/bash
>> +# FS QA Test No. ext4/003
>> +#
>> +# Regression test for commit:
>> +# b5b6077 ext4: fix wrong assert in ext4_mb_normalize_request()
>> +# This testcase checks whether this bug has been fixed.
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2014 Fujitsu.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +    _scratch_unmount
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +_supported_fs ext4
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +
>> +rm -f $seqres.full
>> +
>> +yes | mkfs.ext4 -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
>> +    >> $seqres.full 2>&1
> 
> If we want to have bigalloc specific tests we should probably add a
> helpers to check for bigalloc support in both kernel, and e2fsprogs
> so this test does not fail on older kernel/older e2fsprogs.
Sorry for the delay. New version will be sent soon, thanks!

Regards,
Xiaoguang Wang


> 
> Thanks!
> -Lukas
> 
>> +_scratch_mount || _fail "couldn't mount fs"
>> +
>> +dd if=/dev/zero of=$SCRATCH_MNT/testfile bs=1M count=256 2>&1 | _filter_dd
>> +
>> +echo "Slience is golden"
>> +
>> +status=0
>> +exit
>> diff --git a/tests/ext4/003.out b/tests/ext4/003.out
>> new file mode 100644
>> index 0000000..07f245d
>> --- /dev/null
>> +++ b/tests/ext4/003.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 003
>> +Slience is golden
>> diff --git a/tests/ext4/group b/tests/ext4/group
>> index 7e66035..152196c 100644
>> --- a/tests/ext4/group
>> +++ b/tests/ext4/group
>> @@ -5,6 +5,7 @@
>>  #
>>  001 auto prealloc quick
>>  002 auto quick prealloc
>> +003 auto quick
>>  271 auto rw quick
>>  301 aio dangerous ioctl rw stress
>>  302 aio dangerous ioctl rw stress
>>
> .
> 

