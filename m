Received: from cn.fujitsu.com ([59.151.112.132]:25488 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751104AbdEPINn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2017 04:13:43 -0400
Message-ID: <591AB4B2.6090303@cn.fujitsu.com>
Date: Tue, 16 May 2017 16:13:38 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] common: cleanup _require_xfs_io_command
References: <1494832679-13246-1-git-send-email-yangx.jy@cn.fujitsu.com> <1494832679-13246-2-git-send-email-yangx.jy@cn.fujitsu.com> <20170516080455.GX7250@eguan.usersys.redhat.com>
In-Reply-To: <20170516080455.GX7250@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/05/16 16:04, Eryu Guan wrote:
> On Mon, May 15, 2017 at 03:17:59PM +0800, Xiao Yang wrote:
>> We don't need to check specific flags at the end of this function
>> if we have checked them before. e.g, generic/071 and generic/422
>> are marked as notrun unexpectedly because xfs_io doesn't support
>> long-format help for falloc before xfsprogs v4.9.  Actually, xfs_io
>> has supported falloc, so these case should not be marked as notrun.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Thanks for the fix!
>
>> ---
>>   common/rc | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 539f153..2c893c0 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2041,6 +2041,7 @@ _require_xfs_io_command()
>>   	command=$1
>>   	shift
>>   	param="$*"
>> +	param_check=0
>>
>>   	testfile=$TEST_DIR/$$.xfs_io
>>   	case $command in
>> @@ -2055,6 +2056,7 @@ _require_xfs_io_command()
>>   		;;
>>   	"falloc" )
>>   		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
>> +		param_check=1
>>   		;;
>>   	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
>>   		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
>> @@ -2063,6 +2065,7 @@ _require_xfs_io_command()
>>   	"fiemap")
>>   		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
>>   			-c "fiemap -v $param" $testfile 2>&1`
>> +		param_check=1
>>   		;;
>>   	"flink" )
>>   		testio=`$XFS_IO_PROG -T -F -c "flink $testfile" \
>> @@ -2087,7 +2090,7 @@ _require_xfs_io_command()
>>   		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
>>   		;;
>>   	*)
>> -		testio=`$XFS_IO_PROG -c "$command help" 2>&1`
>> +		testio=`$XFS_IO_PROG -c "help $command" 2>&1`
>>   	esac
>>
>>   	rm -f $testfile 2>&1>  /dev/null
>> @@ -2100,9 +2103,10 @@ _require_xfs_io_command()
>>   	echo $testio | grep -q "foreign file active"&&  \
>>   		_notrun "xfs_io $command not supported on $FSTYP"
>>
>> -	test -z "$param"&&  return
>> -	$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
>> -		_notrun "xfs_io $command doesn't support $param"
>> +	if [ -n $param -a $param_check -eq 0 ]; then
> $param needs quotes here, otherwise if no param is specified [ -n ]
> still reports pass, e.g.
>
> $ unset empty_var
> $ if [ -n $empty_var ]; then echo "should not see this"; fi
> should not see this
> $ if [ -n "$empty_var" ]; then echo "should not see this"; fi
> <nothing printed>
>
> I can fix it at commit time.
Hi Eryu

Agreed.  Thanks for your explanation. :-)

Thanks,
Xiao Yang.
> Thanks,
> Eryu
>
>> +		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
>> +			_notrun "xfs_io $command doesn't support $param"
>> +	fi
>>   }
>>
>>   # check that kernel and filesystem support direct I/O
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



