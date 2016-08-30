Received: from cn.fujitsu.com ([59.151.112.132]:29601 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750697AbcH3EEw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2016 00:04:52 -0400
Subject: Re: [PATCH] generic/159: record error value correctly
References: <20160830035114.13876-1-wangxg.fnst@cn.fujitsu.com>
 <20160830035940.GJ27776@eguan.usersys.redhat.com>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <57C504EC.5070303@cn.fujitsu.com>
Date: Tue, 30 Aug 2016 12:00:44 +0800
MIME-Version: 1.0
In-Reply-To: <20160830035940.GJ27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

On 08/30/2016 11:59 AM, Eryu Guan wrote:
> On Tue, Aug 30, 2016 at 11:51:14AM +0800, Wang Xiaoguang wrote:
>> This case failed in btrfs, it's because when trying to open an immutable
>> file, vfs returns EPERM, not EACCESS, fix this.
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>   tests/generic/159.out | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/159.out b/tests/generic/159.out
>> index 92fe33a..3e5e47f 100755
>> --- a/tests/generic/159.out
>> +++ b/tests/generic/159.out
>> @@ -2,4 +2,4 @@ QA output created by 159
>>   Format and mount
>>   Create the original files
>>   Try reflink on immutable files
>> -TEST_DIR/test-159/file2: Permission denied
>> +TEST_DIR/test-159/file2: Operation not permitted
> I think you need to do a filter in the test not change the golden image,
> so older kernels won't fail because they still return EACCES on
> immutable inodes.
I just checked the upstream kernel, found that it retuns EPERM.
OK, I'll send a new version.

Regards,
Xiaoguang Wang

>
> Thanks,
> Eryu
>
>



