Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CBC433E1
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 03:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C3F2070E
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 03:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGODMm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:12:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64540 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726624AbgGODMm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jul 2020 23:12:42 -0400
X-IronPort-AV: E=Sophos;i="5.75,353,1589212800"; 
   d="scan'208";a="96360630"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Jul 2020 11:12:39 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 7AC1A4CE5CEF;
        Wed, 15 Jul 2020 11:12:39 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 15 Jul 2020 11:12:40 +0800
Message-ID: <5F0E7424.2090709@cn.fujitsu.com>
Date:   Wed, 15 Jul 2020 11:12:36 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>
Subject: Re: [PATCH v6 3/7] generic/223: Don't clear all mkfs options for
 _scratch_mkfs_geom() roughly
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com> <20200714094009.8654-4-yangx.jy@cn.fujitsu.com> <20200715023117.GH3008823@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200715023117.GH3008823@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 7AC1A4CE5CEF.AE88A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/7/15 10:31, Ira Weiny wrote:
> On Tue, Jul 14, 2020 at 05:40:05PM +0800, Xiao Yang wrote:
>> ext4 can accept the last one if the same mkfs options are passed but xfs cannot
> I'm having trouble parsing this commit message.  What does 'last one' refer to?
>
>> accept the same mkfs options and reports "xxx option is respecified" error.
> Ok I think I understand now.  Some FS's (XFS) do not accept an option more than
> once.  So we can't just blindly add options to the end of the MKFS_OPTIONS.  Is
> that correct?
Hi Ira,

Correct.
>> I
>> prefer to override the same mkfs option which is defined in MKFS_OPTION so that
>> we can have a chance to pass other mkfs options to _scratch_mkfs_geom().
> Instead the patch parses the current option string and replaces the value if
> the option is already there.  This allows us to specify MKFS_OPTIONS to
> generic/223.
Right. :-)

XFS_MKFS_OPTIONS/MKFS_OPTIONS can be used to specify some custom options by user,
so I don't want to clear it blindly.

Thanks,
Xiao Yang
> I think the code is reasonable although my sed skills are not good enough to
> tell for sure...  ;-)
>
> Ira
>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc         | 14 +++++++++++++-
>>   tests/generic/223 |  1 -
>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 6c908f2e..567cf83b 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1051,7 +1051,19 @@ _scratch_mkfs_geom()
>>
>>       case $FSTYP in
>>       xfs)
>> -	MKFS_OPTIONS+=" -b size=$blocksize, -d su=$sunit_bytes,sw=$swidth_mult"
>> +	if echo "$MKFS_OPTIONS" | egrep -q "b?size="; then
>> +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b?size=)[0-9]+/\1$blocksize/")
>> +	else
>> +		MKFS_OPTIONS+=" -b size=$blocksize"
>> +	fi
>> +
>> +	if echo "$MKFS_OPTIONS" | egrep -q "(su|sunit|sw|swidth)="; then
>> +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r \
>> +			-e "s/(su|sunit)=[0-9kmg]+/su=$sunit_bytes/" \
>> +			-e "s/(sw|swidth)=[0-9kmg]+/sw=$swidth_mult/")
>> +	else
>> +		MKFS_OPTIONS+=" -d su=$sunit_bytes,sw=$swidth_mult"
>> +	fi
>>   	;;
>>       ext4|ext4dev)
>>   	MKFS_OPTIONS+=" -b $blocksize -E stride=$sunit_blocks,stripe_width=$swidth_blocks"
>> diff --git a/tests/generic/223 b/tests/generic/223
>> index 6cfd00dd..ba7c9a44 100755
>> --- a/tests/generic/223
>> +++ b/tests/generic/223
>> @@ -41,7 +41,6 @@ for SUNIT_K in 8 16 32 64 128; do
>>   	let SUNIT_BLOCKS=$SUNIT_BYTES/$BLOCKSIZE
>>
>>   	echo "=== mkfs with su $SUNIT_BLOCKS blocks x 4 ==="
>> -	export MKFS_OPTIONS=""
>>   	_scratch_mkfs_geom $SUNIT_BYTES 4 $BLOCKSIZE>>  $seqres.full 2>&1
>>   	_scratch_mount
>>
>> -- 
>> 2.21.0
>>
>>
>>
>
> .
>



