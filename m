Received: from cn.fujitsu.com ([59.151.112.132]:12196 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbcHZFoW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Aug 2016 01:44:22 -0400
Message-ID: <57BFD726.6080105@cn.fujitsu.com>
Date: Fri, 26 Aug 2016 13:44:06 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] xfs/098: fix xfs_repair on newer xfsprogs
References: <20160825154052.GD20705@birch.djwong.org> <1472182612-10218-1-git-send-email-yangx.jy@cn.fujitsu.com> <20160826044225.GY27776@eguan.usersys.redhat.com>
In-Reply-To: <20160826044225.GY27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: darrick.wong@oracle.com, fstests@vger.kernel.org, zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

On 2016/08/26 12:42, Eryu Guan wrote:
> On Fri, Aug 26, 2016 at 11:36:52AM +0800, Xiao Yang wrote:
>> Make sure xfs_repair can't clear the log by default when it is corrupted.
>> xfs_repair always and only clear the log when the -L parameter is specified.
>> This has updated by:
>> Commit f2053bc ("xfs_repair: don't clear the log by default")
> Can you please put more details in commit log? e.g. what's the problem
> you want to fix, what's the symptom, etc. I had a hard time
> understanding the problems without running the test.
>
Hi Eryu
xfs_repair without -L option succeeded to repair filesystem at xfs/098 
if log is corrupted.  However,
this feature has been changed by following patch since 
xfsprogs-dev(4.3.0),  we have to use -L option to
repair filesystem if log is corrupted.
Commit f2053bc ("xfs_repair: don't clear the log by default")

xfs/098 will fail to repair filesystem if log is corrupted since 
xfsprogs-dev(4.3.0), so fix it.

Thanks
Xiao Yang.
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc     | 4 ++--
>>   tests/xfs/098 | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 3fb0600..c693a31 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1143,9 +1143,9 @@ _repair_scratch_fs()
>>       xfs)
>>           _scratch_xfs_repair "$@" 2>&1
>>   	res=$?
>> -	if [ "$res" -eq 2 ]; then
>> +	if [ "$res" -ne 0 ]; then
>>   		echo "xfs_repair returns $res; replay log?"
>> -		_scratch_mount
>> +		_scratch_mount 2>&1
>>   		res=$?
>>   		if [ "$res" -gt 0 ]; then
>>   			echo "mount returns $res; zap log?"
>> diff --git a/tests/xfs/098 b/tests/xfs/098
>> index d91d617..eb33bb1 100755
>> --- a/tests/xfs/098
>> +++ b/tests/xfs/098
>> @@ -93,7 +93,7 @@ echo "+ mount image"
>>   _scratch_mount 2>/dev/null&&  _fail "mount should not succeed"
>>
>>   echo "+ repair fs"
>> -_scratch_xfs_repair>>  $seqres.full 2>&1
>> +_repair_scratch_fs>>  $seqres.full
> The above two redirection updates seem not necessary to me, mount
> failure message got redirected to $seqres.full in both cases. Any reason
> doing so?
>
> Thanks,
> Eryu
>
Hi Eryu
if xfs_repair without -L option can succeed to repair filesystem, the 
second mount will skip.

Thanks
Xiao Yang.
>>
>>   echo "+ mount image (2)"
>>   _scratch_mount
>> -- 
>> 1.8.3.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>



