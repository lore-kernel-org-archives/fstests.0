Received: from mail.cn.fujitsu.com ([183.91.158.132]:59724 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750707AbeEVEGq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 May 2018 00:06:46 -0400
Message-ID: <5B039746.1000309@cn.fujitsu.com>
Date: Tue, 22 May 2018 12:06:30 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/132: umount scratch device after finishing test
References: <1526704344-19615-1-git-send-email-yangx.jy@cn.fujitsu.com> <20180521023631.GN10363@dastard> <5B027930.4050203@cn.fujitsu.com> <20180521224641.GR23861@dastard>
In-Reply-To: <20180521224641.GR23861@dastard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On 2018/05/22 6:46, Dave Chinner wrote:
> On Mon, May 21, 2018 at 03:45:52PM +0800, Xiao Yang wrote:
>> On 2018/05/21 10:36, Dave Chinner wrote:
>>> On Sat, May 19, 2018 at 12:32:24PM +0800, Xiao Yang wrote:
>>>> xfs/132 and xfs/133 running together got the following error:
>>>> ------------------------------------------------------------
>>>> ...
>>>> xfs/132 1s ... 1s
>>>> xfs/133 1s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//xfs/133.out.bad)
>>>> ...
>>>> QA output created by 133
>>>> -Format and mount
>>>> -Corrupt filesystem
>>>> -Remount, try to append
>>>> -Write did not succeed (ok).
>>>> +SCRATCH_DEV=/dev/sda11 is mounted but not on SCRATCH_MNT=common/config: - aborting
>>>> +Already mounted result:
>>>> +/dev/sda11 /mnt/xfstests/scratch
>>>> ...
>>>> ------------------------------------------------------------
>>>>
>>>> xfs/132 led to XFS shutdown due to the corrupted inode, but it didn't rectify XFS
>>>> by umount scratch device.
>>> AFAIK, we don't have to unmount the scratch device when a test
>>> finishes - the test harness is supposed to do that and make sure
>>> that it is in the correct state for the next test to run.
>>>
>>> It seems that somewhere along the line this got broken. - I'm
>>> guessing the fact that this test also says "don't check the scratch
>>> device" the test harness is failing to unmount it because it's not
>>> running _check_scratch_device. I'm guessing that it should at least
>>> run _scratch_unmount....
>> Hi Dave,
>>
>> Could we just make the test harness call _scratch_unmount after running every test, as below:
>> --------------------------------------------------------------
>> diff --git a/check b/check
>> index 96198ac..63ece67 100755
>> --- a/check
>> +++ b/check
>> @@ -815,6 +815,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>                  _make_testcase_report "$tc_status"
>>              fi
>>              seq="after_$seqnum"
>> +           _scratch_unmount 2>   /dev/null
>>          done
>>          sect_stop=`_wallclock`
>>          interrupt=false
> Sort of. The problem is in _check_filesystem, though, where it does
> nothing when _require_scratch_nocheck() is used. It needs to cycle
> the mount in this case, and then the main loop doesn't need to be
> touched...
Hi Dave,

What about cycling the mount when _require_scratch_nocheck() or _notrun is called?
--------------------------------------------------------------------
diff --git a/check b/check
index 96198ac..ea94524 100755
--- a/check
+++ b/check
@@ -489,10 +489,14 @@ _check_filesystems()
         if [ -f ${RESULT_DIR}/require_test ]; then
                 _check_test_fs || err=true
                 rm -f ${RESULT_DIR}/require_test*
+       else
+               _test_cycle_mount
         fi
         if [ -f ${RESULT_DIR}/require_scratch ]; then
                 _check_scratch_fs || err=true
                 rm -f ${RESULT_DIR}/require_scratch*
+       else
+               _scratch_cycle_mount
         fi
  }
--------------------------------------------------------------------

>> @@ -823,7 +824,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
>>          echo
>>
>>          _test_unmount 2>   /dev/null
>> -       _scratch_unmount 2>   /dev/null
>>   done
> This needs to remain - this is the final unmount of the devices
> after all tests run.
Agreed.  remain it.

Thanks,
Xiao Yang

> Cheers,
>
> Dave.



