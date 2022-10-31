Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D624FA3740
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Oct 2022 06:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJaG6y (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 31 Oct 2022 02:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaG6y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Oct 2022 02:58:54 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0430A9590
        for <fstests@vger.kernel.org>; Sun, 30 Oct 2022 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667199528; i=@fujitsu.com;
        bh=rRTMLyC6HHKNkQKTDwmP3Ry+3M2Z5acCq5eJYJT7HxY=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Hmsr4jGWLKXW0GPUnDdMZ9GCqdWZdKB/QFj3J71R0P3S5FykjNGn1zACmNViURlLT
         4ttnmLuOLHf5WJTd0jeBLdMbi+JcomXJetlIZ3L8MymRFk5WdEc8ffgwd76eR5xm8T
         wKfbCgdpNUEYb1qDWJ1ewTicIbqPGU/jCC7j85vNCqXniSUpuMj+ad201hApIXf2Z/
         j0213h7c26Zn5tT+ozBlr4/MBKjUw98LsP9gilyNxcSeR/yBkjKKkh7ovFt27rfqeq
         n09z8M60JT0ODp2uv72e9AjuVUb1VGfUFlmTHbrJaPGHgINBty5Z3iswsX+KiwcXR/
         aeWOwn32vn58w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRWlGSWpSXmKPExsViZ8OxWVe9KD7
  Z4G6nosXplr3sFntP7mR1YPJ4v+8qm8fnTXIBTFGsmXlJ+RUJrBnrj9sUvNCt6D9i28DYptrF
  yMUhJLCRUeLzl2uMEM4SJontXV9ZIJxtjBJ/J+9l72Lk4OAVsJO41lPWxcjJwSKgKvFu/g1mE
  JtXQFDi5MwnLCC2qECSxNUNd1lBbGGBWInmWYfAbBEBRYk1Py+C1TMLyEo0tm4BiwsJFEtcPP
  0arJdNwFFi3qyNbCA2p4CNxMrNM9kh6i0kFr85CGXLS2x/OwdsjgTQzLYl/9gh7AqJWbPamCB
  sNYmr5zYxT2AUmoXkvFlIRs1CMmoBI/MqRrPi1KKy1CJdQ2O9pKLM9IyS3MTMHL3EKt1EvdRS
  3fLU4hJdI73E8mK91OJiveLK3OScFL281JJNjMDQTylWnLGD8d+yP3qHGCU5mJREecPz4pOF+
  JLyUyozEosz4otKc1KLDzHKcHAoSfB+ywfKCRalpqdWpGXmAOMQJi3BwaMkwusH0spbXJCYW5
  yZDpE6xWjMcX7n/r3MHB//XNzLLMSSl5+XKiXO+7gAqFQApDSjNA9uECw9XGKUlRLmZWRgYBD
  iKUgtys0sQZV/xSjOwagkzDsFZCFPZl4J3L5XQKcwAZ3C1h4HckpJIkJKqoFJaM/621fXuzWs
  0HvNIHWV/YiDO0OT0ArWIMUVNY0vuB137yo5vzRl5cV7ORPM25cfeGEhsSI18LVg4uR1XzKvG
  q06OYXt88tpbqnHDqde9RdRV7s7SfxDiJntoYMu254erdmf9FN++0t707Vnc8T3FOpc/ybzbF
  vw2gSt+xy/TyXmyp/xdcrclel0WPG7rfp11fSaxrqV6lveRL+Uf+zbIjnpiFv29rSwXTfm1nt
  +MI49++p84J6jU41LPtrODVy2sDQqcKJKzZcnDZYSTlLhLrVn5l7t4nl5fdo9r0x1/RPif5e0
  Pqg6GpTh5qEp+GhFyWNTxlvshWmrz788LH0p6dOD7lv1YivfsfSnfkmdq8RSnJFoqMVcVJwIA
  F/duEaKAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-8.tower-548.messagelabs.com!1667199527!162748!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8877 invoked from network); 31 Oct 2022 06:58:47 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-8.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Oct 2022 06:58:47 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 45268155;
        Mon, 31 Oct 2022 06:58:47 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 3816B151;
        Mon, 31 Oct 2022 06:58:47 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 31 Oct 2022 06:58:45 +0000
Message-ID: <3f70813c-14b0-d8c7-b1e1-e8f670555bd1@fujitsu.com>
Date:   Mon, 31 Oct 2022 14:58:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] common/config: Make test and scratch devices use the same
 mount options
To:     Zorro Lang <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>
References: <1666867852-134-1-git-send-email-yangx.jy@fujitsu.com>
 <20221030032626.i6hv5m6rlor6fxbc@zlang-mailbox>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <20221030032626.i6hv5m6rlor6fxbc@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/10/30 11:26, Zorro Lang wrote:
> On Thu, Oct 27, 2022 at 10:50:52AM +0000, Xiao Yang wrote:
>> Some cases(e.g. generic/519) check commands/features on test device but
>> do tests on scratch device.  If some mount options can impact the check
>> result, these cases may throw error instead if not run when we use
>> different mount options for test and scratch devices.
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
> 
> This patch makes sense to me.

Hi Zorro,

Thanks for your review.
Sorry for a typo (s/instead if/instead of/).

> 
> Actually I'm a little curious about the history of _test_mount_opts() function,
> so I tried to check the commit log of fstests, then I found this function was
> brought in by 0e9141e49d4a ("common: add cifs support").
> 
> This commit set MOUNT_OPTIONS and TEST_FS_MOUNT_OPTS same, then later patches
> (which trys to support a new fs) update mount_opts() but sometimes don't
> update _test_mount_opts(). I don't know if they're intended. From my narrow
> knowledge I think TEST_FS_MOUNT_OPTS and MOUNT_OPTS should keep consistent, if
> no specific setup. And the log history shows that we've tried to fix their
> inconsistent problems by some patches. E.g.
>    adf56068 ("common/config: add acl and user_xattr support for TEST_DEV")
>    643c6850 ("common/config: honor NFS_MOUNT_OPTIONS in _test_mount_opts")
> 

Yes, I think they should keep consistent usually. We can use the same 
TEST_FS_MOUNT_OPTS and MOUNT_OPTIONS by seting $FSTYP_MOUNT_OPTIONS in 
local.config. For example:
export XFS_MOUNT_OPTIONS="-o dax"

> I think even if someone fs really need a different default TEST_FS_MOUNT_OPTS,
> we can change it in _test_mount_opts, or let them same.

If someone wants to use the different TEST_FS_MOUNT_OPTS and MOUNT_OPTS, 
he can set TEST_FS_MOUNT_OPTS and MOUNT_OPTIONS directly in local.config.
The logic is defined in get_next_config()
------------------------------------------------
[ -z "$MOUNT_OPTIONS" ] && _mount_opts
[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
------------------------------------------------

> 
> I gave this patch a little testing, but I can't test it on all fs we support.
> So I'll keep this patch a week, if anyone has any review points, please feel
> free to reply this email. If no, I'd like to give it my RVB at first.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks a lot.

Best Regards,
Xiao Yang
> 
> Thanks,
> Zorro
> 
>>   common/config | 65 +++++++++++++++++++--------------------------------
>>   1 file changed, 24 insertions(+), 41 deletions(-)
>>
>> diff --git a/common/config b/common/config
>> index 5eaae447..6f428eae 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -334,89 +334,72 @@ if [ "$FSTYP" == "xfs" ]; then
>>   	export XFS_MKFS_HAS_NO_META_SUPPORT
>>   fi
>>   
>> -_mount_opts()
>> +_common_mount_opts()
>>   {
>>   	case $FSTYP in
>>   	9p)
>> -		export MOUNT_OPTIONS=$PLAN9_MOUNT_OPTIONS
>> +		echo $PLAN9_MOUNT_OPTIONS
>>   		;;
>>   	xfs)
>> -		export MOUNT_OPTIONS=$XFS_MOUNT_OPTIONS
>> +		echo $XFS_MOUNT_OPTIONS
>>   		;;
>>   	udf)
>> -		export MOUNT_OPTIONS=$UDF_MOUNT_OPTIONS
>> +		echo $UDF_MOUNT_OPTIONS
>>   		;;
>>   	nfs)
>> -		export MOUNT_OPTIONS=$NFS_MOUNT_OPTIONS
>> +		echo $NFS_MOUNT_OPTIONS
>>   		;;
>>   	cifs)
>> -		export MOUNT_OPTIONS=$CIFS_MOUNT_OPTIONS
>> +		echo $CIFS_MOUNT_OPTIONS
>>   		;;
>>   	ceph)
>> -		export MOUNT_OPTIONS=$CEPHFS_MOUNT_OPTIONS
>> +		echo $CEPHFS_MOUNT_OPTIONS
>>   		;;
>>   	glusterfs)
>> -		export MOUNT_OPTIONS=$GLUSTERFS_MOUNT_OPTIONS
>> +		echo $GLUSTERFS_MOUNT_OPTIONS
>>   		;;
>>   	overlay)
>> -		export MOUNT_OPTIONS=$OVERLAY_MOUNT_OPTIONS
>> +		echo $OVERLAY_MOUNT_OPTIONS
>>   		;;
>>   	ext2|ext3|ext4|ext4dev)
>>   		# acls & xattrs aren't turned on by default on ext$FOO
>> -		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
>> +		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
>>   		;;
>>   	f2fs)
>> -		export MOUNT_OPTIONS="-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
>> +		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
>>   		;;
>>   	reiserfs)
>>   		# acls & xattrs aren't turned on by default on reiserfs
>> -		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
>> +		echo "-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
>>   		;;
>>          reiser4)
>> -               # acls & xattrs aren't supported by reiser4
>> -               export MOUNT_OPTIONS=$REISER4_MOUNT_OPTIONS
>> -               ;;
>> +		# acls & xattrs aren't supported by reiser4
>> +		echo $REISER4_MOUNT_OPTIONS
>> +		;;
>>   	gfs2)
>>   		# acls aren't turned on by default on gfs2
>> -		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
>> +		echo "-o acl $GFS2_MOUNT_OPTIONS"
>>   		;;
>>   	tmpfs)
>>   		# We need to specify the size at mount, use 1G by default
>> -		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
>> +		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
>>   		;;
>>   	ubifs)
>> -		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
>> +		echo $UBIFS_MOUNT_OPTIONS
>>   		;;
>>   	*)
>>   		;;
>>   	esac
>>   }
>>   
>> +_mount_opts()
>> +{
>> +	export MOUNT_OPTIONS=$(_common_mount_opts)
>> +}
>> +
>>   _test_mount_opts()
>>   {
>> -	case $FSTYP in
>> -	9p)
>> -		export TEST_FS_MOUNT_OPTS=$PLAN9_MOUNT_OPTIONS
>> -		;;
>> -	cifs)
>> -		export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
>> -		;;
>> -	ceph)
>> -		export TEST_FS_MOUNT_OPTS=$CEPHFS_MOUNT_OPTIONS
>> -		;;
>> -	nfs)
>> -		export TEST_FS_MOUNT_OPTS=$NFS_MOUNT_OPTIONS
>> -		;;
>> -	glusterfs)
>> -		export TEST_FS_MOUNT_OPTS=$GLUSTERFS_MOUNT_OPTIONS
>> -		;;
>> -	ext2|ext3|ext4|ext4dev)
>> -		# acls & xattrs aren't turned on by default on older ext$FOO
>> -		export TEST_FS_MOUNT_OPTS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
>> -		;;
>> -	*)
>> -		;;
>> -	esac
>> +	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
>>   }
>>   
>>   _mkfs_opts()
>> -- 
>> 2.34.1
>>
> 
