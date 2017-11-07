Received: from mail.kernel.org ([198.145.29.99]:56742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965341AbdKGP3d (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Nov 2017 10:29:33 -0500
Subject: Re: [PATCH] generic/392: support to test fallocate
References: <20171105123935.14702-1-chao@kernel.org>
 <20171107044817.GH17339@eguan.usersys.redhat.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <ceb7b2ed-a054-bee0-b2e6-713c8d58afeb@kernel.org>
Date: Tue, 7 Nov 2017 23:29:22 +0800
MIME-Version: 1.0
In-Reply-To: <20171107044817.GH17339@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

On 2017/11/7 12:48, Eryu Guan wrote:
> On Sun, Nov 05, 2017 at 08:39:35PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> f2fs can skip isize updating in fsync(), since during mount, f2fs tries
>> to recovery isize according to valid block address or preallocated flag
>> in last fsynced dnode block.
>>
>> However, fallocate() breaks our rule with setting FALLOC_FL_KEEP_SIZE
>> flag, since it can preallocated block cross EOF, once the file is fsynced,
>> in POR, we will recover isize incorrectly based on these fallocated
>> blocks.
>>
>> This patch enables generic/392 to test fallocate case, in order to verify
>> whether filesystem will do incorrect recovery on isize.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Usually we don't add new sub-tests to existing tests, so new failures
> introduced by the new sub-tests won't be treated as false regressions.
> Please add a new test instead. (I notice the new falloc test fails on
> ext4 too, the allocated block counts changed after power cycle).

Ah, make sense to me, I will prepare patch to add a new test.

> 
>> ---
>>  tests/generic/392     | 14 ++++++++++++++
>>  tests/generic/392.out |  6 ++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/tests/generic/392 b/tests/generic/392
>> index 6922f7d2..f4ebeb2f 100755
>> --- a/tests/generic/392
>> +++ b/tests/generic/392
>> @@ -125,12 +125,26 @@ test_punch()
>>  	check_inode_metadata $1
>>  }
>>  
>> +test_falloc()
>> +{
>> +	echo "==== falloc $2 test with $1 ====" | tee -a $seqres.full
>> +	$XFS_IO_PROG -f -c "truncate 4202496"	\
>> +			-c "pwrite 0 4202496"	\
>> +			-c "fsync"		\
>> +			-c "falloc -k 4202496 $2"\
> 
> Need to require falloc -k support by
> 
> _require_xfs_io_command "falloc" "-k"

Got it, thanks for the reminder.

> 
> And maybe test falloc without keep_size too?

Agreed, will add. :)

Thanks,

> 
> Thanks,
> Eryu
> 
>> +			$testfile >/dev/null
>> +	check_inode_metadata $1
>> +}
>> +
>>  for i in fsync fdatasync; do
>>  	test_i_size $i 1024
>>  	test_i_size $i 4096
>>  	test_i_time $i
>>  	test_punch $i 1024
>>  	test_punch $i 4096
>> +	test_falloc $i 1024
>> +	test_falloc $i 4096
>> +	test_falloc $i 104857600
>>  done
>>  
>>  exit
>> diff --git a/tests/generic/392.out b/tests/generic/392.out
>> index 5d3330a6..d278bdf9 100644
>> --- a/tests/generic/392.out
>> +++ b/tests/generic/392.out
>> @@ -4,8 +4,14 @@ QA output created by 392
>>  ==== i_time test with fsync ====
>>  ==== fpunch 1024 test with fsync ====
>>  ==== fpunch 4096 test with fsync ====
>> +==== falloc 1024 test with fsync ====
>> +==== falloc 4096 test with fsync ====
>> +==== falloc 104857600 test with fsync ====
>>  ==== i_size 1024 test with fdatasync ====
>>  ==== i_size 4096 test with fdatasync ====
>>  ==== i_time test with fdatasync ====
>>  ==== fpunch 1024 test with fdatasync ====
>>  ==== fpunch 4096 test with fdatasync ====
>> +==== falloc 1024 test with fdatasync ====
>> +==== falloc 4096 test with fdatasync ====
>> +==== falloc 104857600 test with fdatasync ====
>> -- 
>> 2.14.1.145.gb3622a4ee
>>
