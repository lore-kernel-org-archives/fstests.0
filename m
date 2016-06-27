Received: from mail-wm0-f41.google.com ([74.125.82.41]:36419 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbcF0G6M (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2016 02:58:12 -0400
Received: by mail-wm0-f41.google.com with SMTP id f126so87022944wma.1
        for <fstests@vger.kernel.org>; Sun, 26 Jun 2016 23:58:11 -0700 (PDT)
Subject: Re: [PATCH] generic/294: filter quotes from mknod
References: <1466938044-23916-1-git-send-email-omzg@plexistor.com>
 <20160627031524.GI23649@eguan.usersys.redhat.com>
From: Omer Zilberberg <omzg@plexistor.com>
Message-ID: <b4958141-efdd-8825-14f9-fd014f7117e9@plexistor.com>
Date: Mon, 27 Jun 2016 09:57:58 +0300
MIME-Version: 1.0
In-Reply-To: <20160627031524.GI23649@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 06/27/2016 06:15 AM, Eryu Guan wrote:
> On Sun, Jun 26, 2016 at 01:47:24PM +0300, Omer Zilberberg wrote:
>> Since coreutils v8.25, mknod errors omit quotes around filenames, and
>> this breaks generic/294's golden image.
>>
>> Checked on Ubuntu 16.04.
>>
>> See coreutils: 08e8fd7 all: avoid quoting file names when possible
>> https://github.com/coreutils/coreutils/commit/08e8fd7e38f2dae7c69c54eb22d508b6517e66e5
>>
>> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
> 
> It looks good to me. But I took a look at the above coreutils commit and
> noticed that many other commands are affected as well, like touch, cp,
> mv etc.
> 
> Did you see other failures caused by other commands? If so, I'm
> thinking about a more generic way to fix it, rather than adding filters
> to each command. Something like fstests commit 774f4dd77534 ("xfstests:
> unify apostrophes in output files").
Surprisingly no, even though I was expecting more failures..
However, I usually run only the 'generic' tests.
I'll try running xfs and btrfs tests on that system, see whether something comes up.
> 
>> ---
>>  common/filter         | 5 +++++
>>  tests/generic/294     | 2 +-
>>  tests/generic/294.out | 2 +-
>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/filter b/common/filter
>> index 244621a..a16ef70 100644
>> --- a/common/filter
>> +++ b/common/filter
>> @@ -385,5 +385,10 @@ _filter_od()
>>  	'
>>  }
>>  
> 
> Comment on why this filter is needed, like most other filters do, e.g.
> _filter_fstrim, _filter_ro_mount
Agreed, I will send v2 if nothing else comes up in xfs and btrfs reruns.
> 
> Thanks,
> Eryu
> 
>> +_filter_mknod()
>> +{
>> +	sed -e "s/mknod: '\(.*\)': File exists/mknod: \1: File exists/"
>> +}
>> +
>>  # make sure this script returns success
>>  /bin/true
>> diff --git a/tests/generic/294 b/tests/generic/294
>> index 3fa6ba2..fb5d9aa 100755
>> --- a/tests/generic/294
>> +++ b/tests/generic/294
>> @@ -55,7 +55,7 @@ THIS_TEST_DIR=$SCRATCH_MNT/$seq.test
>>  
>>  _create_files()
>>  {
>> -	mknod $THIS_TEST_DIR/testnode c 1 3
>> +	mknod $THIS_TEST_DIR/testnode c 1 3 2>&1 | _filter_mknod
>>  	mkdir $THIS_TEST_DIR/testdir
>>  	touch $THIS_TEST_DIR/testtarget
>>  	ln -s $THIS_TEST_DIR/testtarget $THIS_TEST_DIR/testlink 2>&1 | _filter_ln
>> diff --git a/tests/generic/294.out b/tests/generic/294.out
>> index 1ac1c67..7802472 100644
>> --- a/tests/generic/294.out
>> +++ b/tests/generic/294.out
>> @@ -1,5 +1,5 @@
>>  QA output created by 294
>> -mknod: 'SCRATCH_MNT/294.test/testnode': File exists
>> +mknod: SCRATCH_MNT/294.test/testnode: File exists
>>  mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
>>  touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
>>  ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
>> -- 
>> 2.5.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
