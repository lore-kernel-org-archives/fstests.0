Received: from sandeen.net ([63.231.237.45]:34213 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbcE1SG7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 28 May 2016 14:06:59 -0400
Subject: Re: [PATCH 1/2] common/rc: add functions to check or write objects
 under /sys/fs
References: <1464362482-7704-1-git-send-email-zlang@redhat.com>
 <07e71f2f-229e-e8bf-3b73-546bef86f98b@sandeen.net>
 <20160528163605.GA5507@dhcp12-143.nay.redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <9e5233b8-3302-95e6-8300-0951a95bf56b@sandeen.net>
Date: Sat, 28 May 2016 13:06:57 -0500
MIME-Version: 1.0
In-Reply-To: <20160528163605.GA5507@dhcp12-143.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 5/28/16 11:36 AM, Zorro Lang wrote:
> Hi Eric,
> 
> Thanks for you can review this, as I know you're very busy recently:)
> 
> On Fri, May 27, 2016 at 01:05:15PM -0500, Eric Sandeen wrote:
>> On 5/27/16 10:21 AM, Zorro Lang wrote:
>>> XFS add more configurations in /sys/fs/xfs recently. For use
>>> them, this patch add some common functions for:
>>>   1. "require" a file/dir in /sys/fs.
>>>   2. write a file in /sys/fs.
>>
>> More specifically, in /sys/fs/${FSTYP}
> 
> Sure, I should specify this:)
> 
>>
>>> For common use, these functions can be used by other filesystems.
>>>
>>> Signed-off-by: Zorro Lang <zlang@redhat.com>
>>> ---
>>>  common/rc | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 81 insertions(+)
>>>
>>> diff --git a/common/rc b/common/rc
>>> index 51092a0..9935f08 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -3556,6 +3556,87 @@ run_fsx()
>>>  	fi
>>>  }
>>>  
>>> +_require_sys_fs()
>>> +{
>>> +        local dev=$1
>>> +        local target=$2
>>> +        local dname=""
>>> +
>>> +        if [ ! -b "$dev" -o -z "$target" ];then
>>> +	        echo "Usage: _require_sys_fs <device> <target_need_exist>"
>>> +                exit 1
>>> +        fi
>>> +
>>> +        dname=$(basename $(readlink -f $dev))
>>> +        _mkfs_dev $dev > /dev/null 2>&1
>>
>> we don't want to mkfs the test dev just for a _require test; that
>> device is supposed to age, and this could possibly take a very long
>> time, as well.  And in general a mkfs should not be required to test
>> the existence of a sysfs tunable, I think?
> 
> see below
> 
>>
>>> +        _mount -t $FSTYP `_common_dev_mount_options` $dev $SCRATCH_MNT
>>> +        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
>>> +                umount $SCRATCH_MNT
>>> +                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
>>> +        fi
>>> +        umount $SCRATCH_MNT
>>> +}
>>> +
>>> +_require_scratch_sys_fs()
>>> +{
>>> +        local target=$1
>>> +        local dname=""
>>> +
>>> +        if [ ! -b "$SCRATCH_DEV" -o -z "$target" ];then
>>> +	        echo "Usage: _require_scratch_sys_fs <target_need_exist>"
>>> +		exit 1
>>> +	fi
>>> +
>>> +        dname=$(basename $(readlink -f $SCRATCH_DEV))
>>> +	_scratch_mkfs > /dev/null 2>&1
>>> +        _scratch_mount
>>> +        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
>>> +                _scratch_unmount
>>> +                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
>>> +        fi
>>> +        _scratch_unmount
>>> +}
>>
>> This seems overly complex; do you need both of these functions?  We are only
>> testing one filesystem type at a time, and $TEST_DEV is always required.
>> What is the reason for the two differing functions?
>>
>> Isn't _require_sys_fs $SCRATCH_DEV exactly the same as
>> _require_scratch_sys_fs ?
>>
> 
> Sorry for the "complex", let me explain:
> 1. At first, I write a function _require_sys_fs(), which used to check
>    all kinds of device's /sys/fs/fstype configurations. Include dmerror,
>    dmthinp and what ever other devices(not only TEST_DEV, SCRATCH_DEV).

Right, that one is generic.

> 2. Then I want to add a _require_scratch_sys_fs() function, which only
>    used for SCRATCH_DEV. Because I feel generally if SCRATCH_DEV support
>    a /sys/fs/fstype configurations, that means the working kernel support
>    it. And _require_sys_fs() can be used by other devices write their
>    _require_XXX_sys_fs() function(if needed... Looks like I thought too
>    much....).

;)

> 3. When I wrote _require_scratch_sys_fs(), I want to use _require_sys_fs
>    $SCRATCH_DEV directly. But I saw _scratch_mkfs() use different options
>    with common mkfs_dev() function. So I use _scratch_mkfs and _scratch_mount
>    to write this _require_scratch_sys_fs().

If available sysfs options depens on mkfs options, that could be an issue.
But if we make the _require function check for a previous mkfs from the main
test itself, then the test can control the mkfs options too.

> 4. About why I need mkfs before in this _require function, at first those
>    /sys/fs/fstype configurations only can be used after mount. The second
>    is I hope _require_sys_fs() can be used by other devices, which maybe
>    not mkfs... So....
> 
>> Also, because $SCRATCH_DEV is not required, $SCRATCH_MNT
>> isn't either, so I don't think you can use $SCRATCH_MNT.
> 
> I did this according to _require_scratch_xfs_crc() function.

right, but that is specific to "scratch."  My point was that
you were using $SCRATCH_MNT in the first generic function, which
is not specific to scratch, and can operate on any device.

>>
>> Also :)  We may one day want to require sysfs files which
>> are not in the fs/ namespace, so it should probably
>> be named according to the namespace.
>>
>> So maybe something like this (not tested)
>>
>> + /* Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ENTRY */
>> +_require_fs_sys_fs()
>> +{
>> +        local dev=$1
>> +        local target=$2
>> +        local dname=""
>> +        local tmp_mnt=`mktemp -d`
>> +
>> +        if [ ! -b "$dev" -o -z "$target" ];then
>> +	        echo "Usage: _require_fs_sys_fs <device> <sysfs_path>"
>> +                exit 1
>> +        fi
>> +
>> +        dname=$(basename $(readlink -f $dev))
>> +        _mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
>> +        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
>> +                umount $tmp_mnt
>> +                rm -f $tmp_mnt
>> +                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
>> +        fi
>> +        umount $SCRATCH_MNT
> 
> I think you mean "umount $tmp_mnt" at here

yep!

> 
>> +        rm -f $tmp_mnt
>> +}
>>
>> and it would work for either SCRATCH or TEST?
> 
> hmm.. That's OK. I can't sure if mkfs before mount is better or not. If we
> don't mkfs in this function, we ask the caller keep sure the $dev has been
> mkfs. I think both are OK for me, I will follow your idea:)

It does seem a little strange to require the mkfs I guess, but it seems better
than performing mkfs twice in the test.

I suppose one other way to do it might e to make a tiny loopback filesystem
image in a tempfile, and test that.  That way you could control the
mkfs time?  But I guess it's possible that sysfs options *could* even depend
on the size of the fs, though I can't think of any today that do.
 
>>
>>> +_set_sys_fs_param()
>>> +{
>>> +        local dev=$1
>>> +        shift
>>> +        local target=$1
>>> +        shift
>>> +        local content="$*"
>>> +
>>> +        if [ ! -b "$dev" -o -z "$target" -o -z "$content" ];then
>>> +                echo "Usage: _set_sys_fs_param <mounted_device> <target> <content>"
>>> +                exit 1
>>> +        fi
>>> +        local dname=$(basename $(readlink -f $dev))
>>> +        echo "$content" > /sys/fs/${FSTYP}/${dname}/$target
>>> +}
>>
>> This seems fine.  Normally I'd say this could just be open coded
>> in the test, but the dname=$(basename $(readlink -f $dev)) is worth
>> encapsulating in the helper.
> 
> Do you mean I should do?:
> local dname=$(readlink -f $dev)
> dname=`basename $dname`

No ... I mean, what you have is just fine, no change needed.

>>
>>> +_enable_xfs_fail_at_unmount()
>>> +{
>>> +        local dev=$1
>>> +
>>> +        if [ ! -b "$dev" -o "$FSTYP" != "xfs" ];then
>>> +                echo "Usage: _enable_xfs_fail_at_unmount <mounted_XFS_device>"
>>> +                exit 1
>>> +        fi
>>> +
>>> +        _set_sys_fs_param $dev error/fail_at_unmount 1
>>> +}
>>> +
>>> +_disable_xfs_fail_at_unmount()
>>> +{
>>> +        local dev=$1
>>> +
>>> +        if [ ! -b "$dev" -o "$FSTYP" != "xfs" ];then
>>> +                echo "Usage: _enable_xfs_fail_at_unmount <mounted_XFS_device>"
>>> +                exit 1
>>> +        fi
>>> +
>>> +        _set_sys_fs_param $dev error/fail_at_unmount 0
>>> +}
>>
>> I don't think this is needed; it's easy enough to just call:
>>
>> _set_fs_sys_fs_param $dev error/fail_at_unmount 0
>> _set_fs_sys_fs_param $dev error/fail_at_unmount 1
>>
>> directly from tests.  There are a lot of sysfs tunables, writing wrappers
>> for each one isn't really that helpful.
> 
> Yeah, except they can check if "$FSTYP" = "xfs", they don't do
> more than use _set_fs_sys_fs_param directly.

Well, it would be strange to call an xfs sysfs interface on a
non-xfs test, but ... I guess it could happen.

You could add something to _set_fs_sys_fs_param to also
_fail with a warning if /sys/fs/${FSTYP}/${dname}/$target does not exist. 

-Eric
 
> Thanks,
> Zorro
> 
>>
>> Thanks,
>> -Eric
>>
>>>  init_rc
>>
>>>  
>>>  ################################################################################
>>>
> 
