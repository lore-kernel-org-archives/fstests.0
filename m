Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29CFC433E1
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 03:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C191B2070E
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 03:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGODUG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:20:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44469 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726479AbgGODUG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jul 2020 23:20:06 -0400
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; 
   d="scan'208";a="96361043"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Jul 2020 11:20:03 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0E1F34CE505F;
        Wed, 15 Jul 2020 11:20:01 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 15 Jul 2020 11:20:01 +0800
Message-ID: <5F0E75DE.8050508@cn.fujitsu.com>
Date:   Wed, 15 Jul 2020 11:19:58 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>
Subject: Re: [PATCH v6 1/7] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com> <20200714094009.8654-2-yangx.jy@cn.fujitsu.com> <20200715015935.GG3008823@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200715015935.GG3008823@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 0E1F34CE505F.ADCFD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/7/15 9:59, Ira Weiny wrote:
> On Tue, Jul 14, 2020 at 05:40:03PM +0800, Xiao Yang wrote:
>> 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
>> 2) _require_dax_iflag() checks FS_XFLAG_DAX
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Reviewed-by: Ira Weiny<ira.weiny@intel.com>
Hi Ira,

Do you want to check if invalid parameter is passed to  
_require_scratch_dax_mountopt? Thought
I think it is not necessary(user should pass correct parament).
Like this:
[ "$mountopt" != "dax" ] && [ "$mountopt" != "dax=always" ] && _notrun 
"$mountopt is invalid"

Best Regards,
Xiao Yang
>> ---
>>
>> V5->V6:
>> Simplify _require_scratch_dax_mountopt because it is enough to only check
>> dax/dax=always mount option.  See the following reasons:
>> 1) we cannot detect if underlying device supports dax by mounting dax=inode
>>     or dax=never.
>> 2) dax=always, dax=inode, dax=never are always introduced together.
>>
>>   common/rc | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index f17b19f2..aeec1f11 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3188,6 +3188,28 @@ _require_scratch_dax()
>>   	_scratch_unmount
>>   }
>>
>> +# Only accept dax/dax=always mount option becasue dax=always, dax=inode
>> +# and dax=never are always introduced together.
>> +_require_scratch_dax_mountopt()
>> +{
>> +	local mountopt=$1
>> +
>> +	_require_scratch
>> +	_scratch_mkfs>  /dev/null 2>&1
>> +	_try_scratch_mount "-o $mountopt">  /dev/null 2>&1 || \
>> +		_notrun "mount $SCRATCH_DEV with $mountopt failed"
>> +
>> +	_fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)" || \
>> +		_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
>> +
>> +	_scratch_unmount
>> +}
>> +
>> +_require_dax_iflag()
>> +{
>> +	_require_xfs_io_command "chattr" "x"
>> +}
>> +
>>   # Does norecovery support by this fs?
>>   _require_norecovery()
>>   {
>> -- 
>> 2.21.0
>>
>>
>>
>
> .
>



