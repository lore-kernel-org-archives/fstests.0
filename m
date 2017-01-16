Received: from cn.fujitsu.com ([59.151.112.132]:12729 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750831AbdAPIYH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Jan 2017 03:24:07 -0500
Message-ID: <587C8322.80303@cn.fujitsu.com>
Date: Mon, 16 Jan 2017 16:24:02 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] common/rc: Fix _supports_filetype function
References: <20170116072352.GE1859@eguan.usersys.redhat.com> <1484554040-4231-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170116082047.GF1859@eguan.usersys.redhat.com>
In-Reply-To: <20170116082047.GF1859@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/01/16 16:20, Eryu Guan wrote:
> On Mon, Jan 16, 2017 at 04:07:20PM +0800, Xiao Yang wrote:
>> generic/401 failed on RHEL6.8GA because "--output=xxx"
>> option is not supported by df.  So we remove it.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 892c46e..87ef849 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -268,14 +268,14 @@ _supports_filetype()
>>   {
>>   	local dir=$1
>>
>> -	local fstyp=$(df --output=fstype $dir | tail -1)
>> +	local fstyp=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`
>>   	case "$fstyp" in
>>   	xfs)
>>   		xfs_info $dir | grep -q "ftype=1"
>>   		;;
>>   	ext2|ext3|ext4)
>> -		tune2fs -l $(df --output=source $dir | tail -1) | \
>> -		   grep -q filetype
>> +		local mntdir=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $1}'`
>                        ^^^^^^ this actually is the underlying device
>
> I'll rename it to "dev" on commit.
Hi Eryu

Agree it. :-)

Best Regards,
Xiao Yang
> Thanks,
> Eryu
>
>> +		tune2fs -l $mntdir | grep -q filetype
>>   		;;
>>   	*)
>>   		local testfile=$dir/$$.ftype
>> -- 
>> 1.8.3.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>



