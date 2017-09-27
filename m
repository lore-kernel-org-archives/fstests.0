Received: from mx1.redhat.com ([209.132.183.28]:42278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbdI0PBY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Sep 2017 11:01:24 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 2/3] generic/413: skip dax to nondax dio test if needed
References: <1492413255-11146-1-git-send-email-xzhou@redhat.com>
        <1506328847-1669-1-git-send-email-xzhou@redhat.com>
        <1506328847-1669-3-git-send-email-xzhou@redhat.com>
        <20170927095004.GP8034@eguan.usersys.redhat.com>
Date: Wed, 27 Sep 2017 11:01:22 -0400
In-Reply-To: <20170927095004.GP8034@eguan.usersys.redhat.com> (Eryu Guan's
        message of "Wed, 27 Sep 2017 17:50:04 +0800")
Message-ID: <x49r2usnq2l.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

Eryu Guan <eguan@redhat.com> writes:

> On Mon, Sep 25, 2017 at 04:40:46PM +0800, Xiong Zhou wrote:
>> Since not all devices support dax has struct page backend,
>> which will not support this test.
>> 
>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>> ---
>>  tests/generic/413 | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/tests/generic/413 b/tests/generic/413
>> index a1cc514..b86c10f 100755
>> --- a/tests/generic/413
>> +++ b/tests/generic/413
>> @@ -88,6 +88,14 @@ t_nondax_to_dax()
>>  t_dax_to_nondax()
>>  {
>>  	prep_files
>> +	# dax to nondax dio needs struct page backend, which is
>> +	# not always avaiable among various devices. Skip this
>> +	# subtest if not compatible.
>> +	if ! src/t_mmap_dio $SCRATCH_MNT/tf_s \
>> +	   $TEST_DIR/tf_d $1 "test" > /dev/null 2>&1 ; then
>> +		return
>> +	fi
>> +
>
> Then we will never get a failure from this case, even if it's a real
> bug.. We need better way to tell if there's struct page present :)

ndctl list will tell you the mode of the namespace.  If it's 'raw', then
it doesn't have struct page backing.  If it's 'memory', it should work
fine.

-Jeff
