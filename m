Received: from mail-wr0-f170.google.com ([209.85.128.170]:35494 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdBEGpH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Feb 2017 01:45:07 -0500
Received: by mail-wr0-f170.google.com with SMTP id 89so7607314wrr.2
        for <fstests@vger.kernel.org>; Sat, 04 Feb 2017 22:45:07 -0800 (PST)
Subject: Re: [PATCH] generic/074: _cleanup potentially removes local FS files
References: <20170129135620.25464-1-omzg@plexistor.com>
 <20170204041848.GG1859@eguan.usersys.redhat.com>
From: Omer Zilberberg <omzg@plexistor.com>
Message-ID: <d428f2b8-5e3a-d9b8-955d-d5467c823b95@plexistor.com>
Date: Sun, 5 Feb 2017 08:45:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170204041848.GG1859@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 02/04/2017 06:18 AM, Eryu Guan wrote:
> On Sun, Jan 29, 2017 at 03:56:20PM +0200, Omer Zilberberg wrote:
>> fstest_dir is set after _cleanup() is defined and _require_test is
>> called. If _require_test fails (due to some unrelated bug in tested FS),
>> _cleanup will attempt to remove $fstest_dir.*, which expands to .*
>> This has the unfortunate effect of removing xfstests' .git and
>> .gitignore.
>>
>> Here is the 074.out.bad file for this case:
>> QA output created by 074
>> mount: permission denied
>> common/rc: retrying test device mount with external set
>> mount: permission denied
>> common/rc: could not mount /dev/pmem0 on /mnt
>> rm: refusing to remove '.' or '..' directory: skipping '.'
>> rm: refusing to remove '.' or '..' directory: skipping '..'
>> ----
>>
>> The only other test which could face the same problem is generic/285.
>> However, that test defines _cleanup after the _require* calls, and so on
>> _require_test failure, 285.out.bad contains the harmless:
>> ./common/rc: line 1: _cleanup: command not found
> 
> How about defining fstest_dir before _cleanup function? Along with
> "here" and "tmp", which looks clearer and makes more sense to me.
Sure, no problem. I'll send a new patch momentarily.
Thanks for the review
> 
> Thanks,
> Eryu
> 
>>
>> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
>> ---
>>  tests/generic/074 | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/074 b/tests/generic/074
>> index 55264bd..ef84263 100755
>> --- a/tests/generic/074
>> +++ b/tests/generic/074
>> @@ -33,7 +33,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  
>>  _cleanup()
>>  {
>> -    rm -rf $fstest_dir.* $tmp.*
>> +    [ -n "$fstest_dir" ] && rm -rf $fstest_dir.*
>> +    rm -rf $tmp.*
>>  }
>>  
>>  # get standard environment, filters and checks
>> -- 
>> 2.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
