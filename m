Received: from cn.fujitsu.com ([222.73.24.84]:64715 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbdGaJd6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 31 Jul 2017 05:33:58 -0400
Message-ID: <597EF97E.9080305@cn.fujitsu.com>
Date: Mon, 31 Jul 2017 17:33:50 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] common/rc: add variable MOUNT_OPTIONS into _test_mount
References: <1501488393-25924-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170731085518.GI9167@eguan.usersys.redhat.com>
In-Reply-To: <20170731085518.GI9167@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/07/31 16:55, Eryu Guan wrote:
> On Mon, Jul 31, 2017 at 04:06:33PM +0800, Xiao Yang wrote:
>> On RHEL6.9GA, generic/097 fails for ext4 because _test_cycle_mount()
>> remount ext4 without the user_xattr option, so extended attributes
>> are not supported by ext4.
>>
>> On some old kernels, ext4 filesystem can not be mounted with acl and
>> user_xattr options by default.  The following patch has enabled these
>> options by default:
>> 'ea6633369458("ext4: enable acls and user_xattr by default")'
>>
>> We add variable MOUNT_OPTIONS into _test_mount, and it works normally
>> on all kernels.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> MOUNT_OPTIONS is for SCRATCH_DEV, TEST_FS_MOUNT_OPTS is for TEST_DEV, I
> think what you should update is _test_mount_opts in common/config, add
> something similar to _test_opts for ext series, to add acl and
> user_xattr support. Could you please verify if that works?
Hi Eryu,

Sorry, I am confused by MOUNT_OPTIONS and  TEST_FS_MOUNT_OPTS.
I have added acl and user_xattr support in _test_mount_opts(), and it 
worked normally.
I will send v2 patch as you suggested. :-)

Thanks,
Xiao Yang.
> Thanks,
> Eryu
>
>> ---
>>   common/rc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index c752979..c478eeb 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -519,7 +519,7 @@ _test_mount()
>>           return $?
>>       fi
>>       _test_options mount
>> -    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>> +    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS `_common_dev_mount_options $*` $TEST_DEV $TEST_DIR
>>   }
>>
>>   _test_unmount()
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
>



