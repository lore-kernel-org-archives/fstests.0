Return-Path: <SRS0=dVie=YJ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F4C4360C
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 06:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5038D2082C
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 06:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfJPG3J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Oct 2019 02:29:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728228AbfJPG3I (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Oct 2019 02:29:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D33CE7C5E9284E577120;
        Wed, 16 Oct 2019 14:29:06 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 16 Oct
 2019 14:29:02 +0800
Subject: Re: [PATCH v3] common/rc: generalize _get_filesize()
To:     Dave Chinner <david@fromorbit.com>
CC:     <guaneryu@gmail.com>, <darrick.wong@oracle.com>,
        <fstests@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20191016024803.12028-1-yuchao0@huawei.com>
 <20191016034325.GI15134@dread.disaster.area>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9774df2c-aa9d-df86-7d14-d67a41ae2e87@huawei.com>
Date:   Wed, 16 Oct 2019 14:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191016034325.GI15134@dread.disaster.area>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2019/10/16 11:43, Dave Chinner wrote:
> On Wed, Oct 16, 2019 at 10:48:03AM +0800, Chao Yu wrote:
>> There are some testcases use below command to get file size, generalize
>> it as global function _get_filesize()
>>
>> ls -l $1 | $AWK_PROG '{print $5}'
>>
>> And in addition, using more simple command "stat -c %s" instead.
>>
>> - adjust common/defrag, generic/275 and generic/315 to use it
>> - remove unused _filesize in generic/013
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v3:
>> - avoid unneeded echo command in _get_filesize() pointed out by Darrick.
>>  common/defrag     | 2 +-
>>  common/rc         | 5 +++++
>>  tests/generic/013 | 5 -----
>>  tests/generic/275 | 2 +-
>>  tests/generic/315 | 2 +-
>>  5 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/common/defrag b/common/defrag
>> index 1381a4dd..1769013b 100644
>> --- a/common/defrag
>> +++ b/common/defrag
>> @@ -145,7 +145,7 @@ _defrag()
>>  	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
>>  
>>  	if [ $FSTYP == "f2fs" ]; then
>> -		local filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
>> +		local filesize=`_get_filesize $1`
>>  		$DEFRAG_PROG 0 $filesize $1 >> $seqres.full 2>&1
>>  	else
>>  		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
>> diff --git a/common/rc b/common/rc
>> index cfaabf10..8cdb7a9b 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -165,6 +165,11 @@ if [ ! -z "$REPORT_LIST" ]; then
>>  	_assert_report_list
>>  fi
>>  
>> +_get_filesize()
>> +{
>> +    stat -c %s "$1"
>> +}
> 
> Also, all these should use _get_filesize():

Oh, correct, I forgot to research with the new command... let me send v4 to
cover below lines.

Thanks for your reminder.

Thanks,

> 
> $ git grep 'stat -c %s'
> tests/btrfs/086:echo "bar file size after clone operation: $(stat -c %s $SCRATCH_MNT/bar)"
> tests/generic/399:                      total_file_size=$((total_file_size + $(stat -c %s $file)))
> tests/generic/399:      total_file_size=$((total_file_size + $(stat -c %s $file)))
> tests/xfs/306:size=`stat -c %s $SCRATCH_MNT/file`
> $ git grep 'stat -c "%s"'
> tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
> tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
> tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
> tests/generic/286:      test $(stat -c "%s" $src) = $(stat -c "%s" $dest) ||
> tests/overlay/060:      actual_size=$(stat -c "%s" $target)
> tests/xfs/014:  size=`stat -c "%s" $file`
> tests/xfs/076:offset=`stat -c "%s" $SCRATCH_MNT/spc`
> 
> 
> Cheers,
> 
> Dave.
> 
