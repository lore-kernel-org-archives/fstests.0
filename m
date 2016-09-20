Received: from cn.fujitsu.com ([59.151.112.132]:36870 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750708AbcITEk7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2016 00:40:59 -0400
Message-ID: <57E0BDD3.5060907@cn.fujitsu.com>
Date: Tue, 20 Sep 2016 12:40:51 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] common/rc: fix fsmap check
References: <20160920030332.GD10172@birch.djwong.org> <1474341339-22956-1-git-send-email-yangx.jy@cn.fujitsu.com> <20160920035930.GD27776@eguan.usersys.redhat.com>
In-Reply-To: <20160920035930.GD27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, david@fromorbit.com, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On 2016/09/20 11:59, Eryu Guan wrote:
> On Tue, Sep 20, 2016 at 11:15:39AM +0800, Xiao Yang wrote:
>> I got an error about $TEST_DIR being a directory when running xfs/273,
>> because xfs_io tried to open the directory first before it parsed the -T
> I think the problem here is your xfs_io binary doesn't have -T support
> (O_TMPFILE). So the commit log doesn't seem correct to me.
>
> Just curious, what's your xfsprogs version and what's the distrobution
> you're running on? xfsprogs shipped with RHEL6 and RHEL7 both have
> O_TMPFILE support.
>
Hi Eryu
I ran this case with xfsprogs-4.5.0 on RHEL7.3Beta, I think that -T 
option has been supported.
Is there another reason lead to this issue?

Thanks
Xiao Yang
>> options.  I get rid of -T to fix it because getfsmap doesn't care if it's
>> run against a file or a directory.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 13afc6a..ec5d73e 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2049,7 +2049,7 @@ _require_xfs_io_command()
>>   			_notrun "xfs_io $command support is missing"
>>   		;;
>>   	"fsmap" )
>> -		testio=`$XFS_IO_PROG -T -F -c "fsmap" \
>> +		testio=`$XFS_IO_PROG -F -c "fsmap" \
>>   			$TEST_DIR 2>&1`
> I think it's better to operate on a file in $TEST_DIR not $TEST_DIR
> itself. Previously xfs_io creates a tmpfile under $TEST_DIR (-T does
> this) and runs fsmap on it. Now without -T option, we have to create the
> file ourselves. And the "-F" option is not needed. So it ends up with:
>
> 		testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
>
> Thanks,
> Eryu
>
>>   		echo $testio | egrep -q "Inappropriate ioctl"&&  \
>>   			_notrun "xfs_io $command support is missing"
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



