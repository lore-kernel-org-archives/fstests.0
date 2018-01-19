Received: from mail.cn.fujitsu.com ([183.91.158.132]:61851 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750718AbeASEEN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Jan 2018 23:04:13 -0500
Message-ID: <5A616E38.9070302@cn.fujitsu.com>
Date: Fri, 19 Jan 2018 12:04:08 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] common/filter: Factor out expected XFS warnings
 for assert
References: <20180118084645.GT3102@eguan.usersys.redhat.com> <1516272595-3678-1-git-send-email-yangx.jy@cn.fujitsu.com> <1516272595-3678-2-git-send-email-yangx.jy@cn.fujitsu.com> <20180118182915.GI5606@magnolia>
In-Reply-To: <20180118182915.GI5606@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: eguan@redhat.com, david@fromorbit.com, bfoster@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/01/19 2:29, Darrick J. Wong wrote:
> On Thu, Jan 18, 2018 at 06:49:54PM +0800, xiao yang wrote:
>> 1) Introduce _require_no_xfs_bug_on_assert helper to check if XFS is built
>>     with CONFIG_XFS_ASSERT_FATAL, and just call _require_no_xfs_debug if
>>     /sys/fs/xfs/debug/bug_on_assert is not available.
>>
>> 2) Apply _require_no_xfs_bug_on_assert in xfs/098 and xfs/115.
>>
>> 3) Move filter_xfs_dmesg from xfs/098 to common/filter, and rename
>>     it as _filter_assert_dmesg.
>>
>> Signed-off-by: xiao yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/filter | 11 +++++++++++
>>   common/xfs    | 12 ++++++++++++
>>   tests/xfs/098 | 20 ++++++++------------
>>   tests/xfs/115 |  7 ++++---
>>   4 files changed, 35 insertions(+), 15 deletions(-)
>>
>> diff --git a/common/filter b/common/filter
>> index 8e1fdb4..53874a0 100644
>> --- a/common/filter
>> +++ b/common/filter
>> @@ -570,5 +570,16 @@ _filter_aiodio_dmesg()
>>   	    -e "s#$warn9#Intentional warnings in dio_complete#"
>>   }
>>
>> +# We generate assert related WARNINGs on purpose and make sure test doesn't fail
>> +# because of these warnings. This is a helper for _check_dmesg() to filter out
>> +# them.
>> +_filter_assert_dmesg()
>> +{
>> +	local warn1="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
>> +	local warn2="WARNING:.*fs/xfs/xfs_message\.c:.*assfail.*"
>> +	sed -e "s#$warn1#Intentional warnings in asswarn#" \
>> +	    -e "s#$warn2#Intentional warnings in assfail#"
>> +}
>> +
>>   # make sure this script returns success
>>   /bin/true
>> diff --git a/common/xfs b/common/xfs
>> index ab58364..a0e03b6 100644
>> --- a/common/xfs
>> +++ b/common/xfs
>> @@ -625,6 +625,18 @@ _require_no_xfs_debug()
>>   	fi
>>   }
>>
>> +# Check if XFS is built with CONFIG_XFS_ASSERT_FATAL
>> +_require_no_xfs_bug_on_assert()
>> +{
>> +	if [ -f /sys/fs/xfs/debug/bug_on_assert ]; then
>> +		grep -q "1" /sys/fs/xfs/debug/bug_on_assert&&  \
>> +		   _notrun "Require XFS built without CONFIG_XFS_ASSERT_FATAL"
> This knob can be written, so perhaps we'd rather just set it to zero
> instead of _notrun?
Hi Darrick,

I think we can keep it and update the _notrun message as Eryu suggested.

>> +	else
>> +	# Call _require_no_xfs_debug if bug_on_assert is not available
> That much is obvious from the code, but the comment doesn't say much
> about why we shift to _require_no_xfs_debug.  How about:
>
> # Require that assertions will not hang the system.
> #
> # Note: Prior to the creation of CONFIG_XFS_ASSERT_FATAL (and the sysfs
> # knob bug_on_assert), assertions would always crash the system if XFS
> # debug was enabled (CONFIG_XFS_DEBUG=y).  If a test is designed to
> # trigger an assertion and the test designer does not want to hang
> # fstests, skip the test.
This comment looks better to me.

Thanks,
Xiao Yang
> --D
>
>> +		_require_no_xfs_debug
>> +	fi
>> +}
>> +
>>   # Get a metadata field
>>   # The first arg is the field name
>>   # The rest of the arguments are xfs_db commands to find the metadata.
>> diff --git a/tests/xfs/098 b/tests/xfs/098
>> index 9bcd94b..ebb7ca7 100755
>> --- a/tests/xfs/098
>> +++ b/tests/xfs/098
>> @@ -47,6 +47,10 @@ _cleanup()
>>   _supported_fs xfs
>>   _supported_os Linux
>>
>> +# We corrupt XFS on purpose, and CONFIG_XFS_ASSERT_FATAL built XFS
>> +# would crash due to assert failure, so skip if we're testing on a
>> +# CONFIG_XFS_ASSERT_FATAL built XFS.
>> +_require_no_xfs_bug_on_assert
>>   _require_scratch
>>   test -n "${FORCE_FUZZ}" || _require_scratch_xfs_crc
>>   _require_attrs
>> @@ -56,16 +60,6 @@ test -z "${FUZZ_ARGS}"&&  FUZZ_ARGS="-n 8 -3"
>>
>>   rm -f $seqres.full
>>
>> -# If we corrupt log on a CONFIG_XFS_WARN build, there will be mount related
>> -# WARNINGs in dmesg as expected.  We don't want to simply _disable_dmesg_check
>> -# which could miss other potential bugs, so filter out the intentional WARNINGs,
>> -# make sure test doesn't fail because of this warning and fails on other WARNINGs.
>> -filter_xfs_dmesg()
>> -{
>> -	local warn="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
>> -	sed -e "s#$warn#Intentional warnings in asswarn#"
>> -}
>> -
>>   TESTDIR="${SCRATCH_MNT}/scratchdir"
>>   TESTFILE="${TESTDIR}/testfile"
>>
>> @@ -107,8 +101,10 @@ _scratch_mount 2>/dev/null&&  _fail "mount should not succeed"
>>   echo "+ repair fs"
>>   _repair_scratch_fs>>  $seqres.full 2>&1
>>
>> -# mount may trigger related WARNINGs, so filter them.
>> -_check_dmesg filter_xfs_dmesg
>> +# We may trigger assert related WARNINGs if we corrupt log on a
>> +# CONFIG_XFS_WARN or CONFIG_XFS_DEBUG(without CONFIG_XFS_ASSERT_FATAL)
>> +# build, so filter them.
>> +_check_dmesg _filter_assert_dmesg
>>
>>   echo "+ mount image (2)"
>>   _scratch_mount
>> diff --git a/tests/xfs/115 b/tests/xfs/115
>> index 0e62628..5fe1fd5 100755
>> --- a/tests/xfs/115
>> +++ b/tests/xfs/115
>> @@ -52,9 +52,10 @@ rm -f $seqres.full
>>   _supported_fs generic
>>   _supported_os Linux
>>   _require_scratch_nocheck
>> -# we corrupt XFS on purpose, and debug built XFS would crash due to assert
>> -# failure, so skip if we're testing on a debug built XFS
>> -_require_no_xfs_debug
>> +# We corrupt XFS on purpose, and CONFIG_XFS_ASSERT_FATAL built XFS
>> +# would crash due to assert failure, so skip if we're testing on a
>> +# CONFIG_XFS_ASSERT_FATAL built XFS.
>> +_require_no_xfs_bug_on_assert
>>   _disable_dmesg_check
>>
>>   # Make sure we disable finobt if the filesystem supports it, otherwise, just
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



