Received: from cn.fujitsu.com ([59.151.112.132]:62746 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750862AbdAPIEP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Jan 2017 03:04:15 -0500
Message-ID: <587C7E75.80008@cn.fujitsu.com>
Date: Mon, 16 Jan 2017 16:04:05 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] common/rc: use $FSTYP and $SCRATCH_DEV in _supports_filetype
 function
References: <1484548819-4295-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170116072352.GE1859@eguan.usersys.redhat.com>
In-Reply-To: <20170116072352.GE1859@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/01/16 15:23, Eryu Guan wrote:
> On Mon, Jan 16, 2017 at 02:40:19PM +0800, Xiao Yang wrote:
>> generic/401 failed on RHEL6.8GA because output option is not
>> supported by df.  So we use $FSTYP and $SCRATCH_DEV instead of
>> df --output to fix it.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 892c46e..90ad496 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -268,14 +268,12 @@ _supports_filetype()
>>   {
>>   	local dir=$1
>>
>> -	local fstyp=$(df --output=fstype $dir | tail -1)
>> -	case "$fstyp" in
>> +	case $FSTYP in
> $FSTYP can't be used directly in this function, because it's also used
> to detect the fstype of upperfs of overlayfs in overlay testing, in
> which case FSTYP is overlay. See _overlay_mount().
>
> Just remove "--output=xxx" option and parse the output, e.g.
>
> local fstyp=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`
>
> Note that $DF_PROG is defined as "df -T -P", which prints the fstyp
> field.
>
>
Hi Eryu

Thanks for your explanations, i will rewrite this patch.

Best Regards,
Xiao Yang

>>   	xfs)
>>   		xfs_info $dir | grep -q "ftype=1"
>>   		;;
>>   	ext2|ext3|ext4)
>> -		tune2fs -l $(df --output=source $dir | tail -1) | \
>> -		   grep -q filetype
>> +		tune2fs -l $SCRATCH_DEV | grep -q filetype
> Same here, $SCRATCH_DEV doesn't fit.
>
> Thanks,
> Eryu
>
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
>
> .
>



