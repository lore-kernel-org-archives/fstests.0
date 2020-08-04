Return-Path: <SRS0=m56w=BO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7327C433DF
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Aug 2020 01:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67A020781
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Aug 2020 01:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgHDB0b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:26:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15244 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbgHDB0b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2020 21:26:31 -0400
X-IronPort-AV: E=Sophos;i="5.75,432,1589212800"; 
   d="scan'208";a="97564328"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Aug 2020 09:26:28 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id CC8854CE5466;
        Tue,  4 Aug 2020 09:26:25 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 4 Aug 2020 09:26:25 +0800
Message-ID: <5F28B940.8000007@cn.fujitsu.com>
Date:   Tue, 4 Aug 2020 09:26:24 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <guaneryu@gmail.com>,
        <fstests@vger.kernel.org>
Subject: Re: [PATCH v8 1/7] common/rc: Introduce helpers for new dax mount
 options and FS_XFLAG_DAX
References: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com> <20200803083838.26222-2-yangx.jy@cn.fujitsu.com> <20200803194915.GF1573827@iweiny-DESK2.sc.intel.com> <20200803222645.GB1203354@magnolia>
In-Reply-To: <20200803222645.GB1203354@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: CC8854CE5466.AB7DA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/8/4 6:26, Darrick J. Wong wrote:
> On Mon, Aug 03, 2020 at 12:49:19PM -0700, Ira Weiny wrote:
>> On Mon, Aug 03, 2020 at 04:38:32PM +0800, Xiao Yang wrote:
>>> 1) _check_scratch_dax_mountopt() checks old/new dax mount option and
>>>     returns a value.
>>> 2) _require_scratch_dax_mountopt() throws notrun if _check_scratch_dax_mountopt()
>>>     returns a non-zero value.
>>> 3) _require_dax_iflag() checks FS_XFLAG_DAX.
>>>
>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> ---
>>>   common/rc | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 42 insertions(+)
>>>
>>> diff --git a/common/rc b/common/rc
>>> index 1b7b2575..d7926bc5 100644
>>> --- a/common/rc
>>> +++ b/common/rc
>>> @@ -3188,6 +3188,48 @@ _require_scratch_dax()
>>>   	_scratch_unmount
>>>   }
>>>
>>> +# Only accept dax/dax=always mount option becasue dax=always, dax=inode
>>> +# and dax=never are always introduced together.
>>> +# Return 0 if filesystem/device supports the specified dax option.
>>> +# Return 1 if mount fails with the specified dax option.
>>> +# Return 2 if /proc/mounts shows wrong dax option.
>>> +# Check new dax=inode, dax=always or dax=never option by passing "dax=always".
>>> +# Check old dax or new dax=always by passing "dax".
>>> +_check_scratch_dax_mountopt()
>> So I think I see what you are trying to say here but I'm not sure the
>> comment/doc is clear.  How about:
>>
>> # Check if dax mount options are supported
>> #
>> # $1 can be either 'dax=always' or 'dax'
>> #
>> # dax=always
>> #      Check for the new dax options (dax=inode, dax=always or dax=never) by
>> #      passing "dax=always".
>> # dax
>> #      Check for the old dax or new dax=always by passing "dax".
>> #
>> # This only accepts 'dax=always' because dax=always, dax=inode
>> # and dax=never are always supported together.  So if the other options are
>> # required checking for 'dax=always' indicates support for the other 2.
>> #
>> # Return 0 if filesystem/device supports the specified dax option.
>> # Return 1 if mount fails with the specified dax option.
>> # Return 2 if /proc/mounts shows wrong dax option.
> /me likes this better.
Hi Ira, Darrick

It is clearer and better, I will update the comment in v9 patch set. :-)
Besides,  could you help me review another new test which has been sent 
to mail list:
"generic: Verify how to change the S_DAX flag on an existing file"
I want to squash it into v9 patch set after you review it.

Thanks,
Xiao Yang
> --D
>
>> Ira
>>
>>> +{
>>> +	local option=$1
>>> +
>>> +	_require_scratch
>>> +	_scratch_mkfs>  /dev/null 2>&1
>>> +
>>> +	_try_scratch_mount "-o $option">  /dev/null 2>&1 || return 1
>>> +
>>> +	if _fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)"; then
>>> +		_scratch_unmount
>>> +		return 0
>>> +	else
>>> +		_scratch_unmount
>>> +		return 2
>>> +	fi
>>> +}
>>> +
>>> +# Throw notrun if _check_scratch_dax_mountopt() returns a non-zero value.
>>> +_require_scratch_dax_mountopt()
>>> +{
>>> +	local mountopt=$1
>>> +
>>> +	_check_scratch_dax_mountopt "$mountopt"
>>> +	local res=$?
>>> +
>>> +	[ $res -eq 1 ]&&  _notrun "mount $SCRATCH_DEV with $mountopt failed"
>>> +	[ $res -eq 2 ]&&  _notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
>>> +}
>>> +
>>> +_require_dax_iflag()
>>> +{
>>> +	_require_xfs_io_command "chattr" "x"
>>> +}
>>> +
>>>   # Does norecovery support by this fs?
>>>   _require_norecovery()
>>>   {
>>> -- 
>>> 2.21.0
>>>
>>>
>>>
>
> .
>



