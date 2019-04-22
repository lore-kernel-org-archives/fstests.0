Received: from mx1.redhat.com ([209.132.183.28]:39076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVNWw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Apr 2019 09:22:52 -0400
Subject: Re: [PATCH] xfs/033: don't use repair output in golden output
References: <8b214be1-6f7e-f668-39ef-2e188f44d352@redhat.com>
 <20190420085332.GC22372@desktop>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <1766bfa9-4dd0-1dec-1a0d-f46211f323df@redhat.com>
Date: Mon, 22 Apr 2019 08:22:51 -0500
MIME-Version: 1.0
In-Reply-To: <20190420085332.GC22372@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 4/20/19 3:53 AM, Eryu Guan wrote:
> On Thu, Apr 18, 2019 at 12:01:31PM -0500, Eric Sandeen wrote:
>> With the xfs_repair fixes for how the link count on root inodes
>> are handled, xfs/033 started failing because we didn't have to
>> re-fix the link count at the end of the repair run.
>>
>> Capturing and comparing all of the xfs_repair output seems somewhat
>> fragile in general.  It should suffice to just run repair, then
>> check that it succeeded with _scratch_xfs_repair, rather than
>> comparing against all the detailed output.  So, this patch does that.
>> Full repair output is still saved to the $seqres.full file.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/.gitignore b/.gitignore
>> index c13fb713..2482dd61 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -251,7 +251,6 @@
>>  /dmapi/src/suite2/src/test_rights
>>  
>>  # Symlinked files
>> -/tests/xfs/033.out
>>  /tests/xfs/071.out
>>  /tests/xfs/096.out
>>  
>> diff --git a/common/repair b/common/repair
>> index c94939c9..5e53f5f2 100644
>> --- a/common/repair
>> +++ b/common/repair
>> @@ -114,7 +114,7 @@ _check_repair()
>>  	_scratch_unmount
>>  
>>  	_zero_position $value "$structure"
>> -	_scratch_xfs_repair 2>&1 | _filter_repair
>> +	_scratch_xfs_repair 2>&1 | _filter_repair >> $seqres.full
> 
> Looks like this will break ohter tests that depend on the output of
> _check_repair, e.g. xfs/030 and xfs/148 (xfs/031 and xfs/149 also call
> _check_repair, but they have their local definition of _check_repair)

Whoops sorry, I should have caught that.

Thanks,
-Eric
