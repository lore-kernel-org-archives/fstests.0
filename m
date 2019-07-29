Received: from szxga07-in.huawei.com ([45.249.212.35]:58140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387483AbfG2Lnk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Jul 2019 07:43:40 -0400
Subject: Re: [PATCH 1/3] generic/38[3456]: adjust to check prjquota before
 mount
References: <20190723092529.112426-1-yuchao0@huawei.com>
 <20190728095141.GM7943@desktop>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <b010ba0e-e4e3-215b-5e6f-c18b2a873942@huawei.com>
Date: Mon, 29 Jul 2019 19:43:39 +0800
MIME-Version: 1.0
In-Reply-To: <20190728095141.GM7943@desktop>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.orga
List-ID: <fstests@vger.kernel.org>

On 2019/7/28 17:51, Eryu Guan wrote:
> On Tue, Jul 23, 2019 at 05:25:27PM +0800, Chao Yu wrote:
>> Move _require_prjquota() to front of _qmount() since we do the
>> check on device directly instead of mountpoint, it can avoid
>> potential failure if filesystem utils needs exclusive open on
>> device.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> We've done similar changes before
> 
> 23f60ef304d6 ("generic/38[3-6]: require project quota to be enabled on
> SCRATCH_DEV")
> 
> but later it was reverted by
> 
> f722c48d4cd5 ("Revert "generic/38[3-6]: require project quota to be
> enabled on SCRATCH_DEV"")
> 
> Because we use quotactl(2) to check if prjquota is enabled on the given
> device (src/feature -P $dev in _require_prjquota), and quotactl(2)
> requires the given device is a mounted device.

You're right, let's ignore this patch. BTW, in order to fix f2fs failure on
these testcases, I'm trying to let dump.f2fs be able to check superblock on a
mounted device.

Thanks,

> 
> Thanks,
> Eryu
> 
>> ---
>>  tests/generic/383 | 2 +-
>>  tests/generic/384 | 2 +-
>>  tests/generic/385 | 2 +-
>>  tests/generic/386 | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/generic/383 b/tests/generic/383
>> index 2c8c5923..cf5ac255 100755
>> --- a/tests/generic/383
>> +++ b/tests/generic/383
>> @@ -39,6 +39,7 @@ _require_xfs_quota_foreign
>>  
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_enable_pquota
>> +_require_prjquota $SCRATCH_DEV
>>  
>>  do_project_test()
>>  {
>> @@ -76,7 +77,6 @@ EOF
>>  # Test project
>>  _qmount_option "usrquota,prjquota"
>>  _qmount
>> -_require_prjquota $SCRATCH_DEV
>>  do_project_test
>>  
>>  # success, all done
>> diff --git a/tests/generic/384 b/tests/generic/384
>> index b7c940d7..2c0cd00b 100755
>> --- a/tests/generic/384
>> +++ b/tests/generic/384
>> @@ -57,10 +57,10 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
>>  _require_scratch
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_enable_pquota
>> +_require_prjquota $SCRATCH_DEV
>>  
>>  _qmount_option "prjquota"
>>  _qmount
>> -_require_prjquota $SCRATCH_DEV
>>  
>>  report_quota()
>>  {
>> diff --git a/tests/generic/385 b/tests/generic/385
>> index 937131a9..56ce6eb0 100755
>> --- a/tests/generic/385
>> +++ b/tests/generic/385
>> @@ -56,9 +56,9 @@ quota_cmd="$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid"
>>  
>>  _scratch_mkfs >/dev/null 2>&1
>>  _scratch_enable_pquota
>> +_require_prjquota $SCRATCH_DEV
>>  _qmount_option "prjquota"
>>  _qmount
>> -_require_prjquota $SCRATCH_DEV
>>  
>>  #
>>  # Create the project root
>> diff --git a/tests/generic/386 b/tests/generic/386
>> index 462c5869..e4f7d23b 100755
>> --- a/tests/generic/386
>> +++ b/tests/generic/386
>> @@ -112,10 +112,10 @@ echo $proj_num:$proj_dir > "$my_projects"
>>  
>>  _scratch_mkfs					>> "$seqres.full" 2>&1
>>  _scratch_enable_pquota
>> +_require_prjquota $SCRATCH_DEV
>>  
>>  _qmount_option "prjquota"
>>  _qmount
>> -_require_prjquota $SCRATCH_DEV
>>  
>>  mkdir -p "${proj_dir}"
>>  
>> -- 
>> 2.18.0.rc1
>>
> .
> 
