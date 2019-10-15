Return-Path: <SRS0=6y5p=YI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DCECE58E
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 09:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31A220659
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 09:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfJOJzQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:55:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfJOJzQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Oct 2019 05:55:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4562C3B1048D65315235;
        Tue, 15 Oct 2019 17:55:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct
 2019 17:55:08 +0800
Subject: Re: [PATCH 1/2] common/defrag: support f2fs
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20190927100627.9086-1-yuchao0@huawei.com>
 <20191002105956.GZ2622@desktop>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c4a64d7b-de6a-1bb7-102c-4a6ea1a627d6@huawei.com>
Date:   Tue, 15 Oct 2019 17:55:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191002105956.GZ2622@desktop>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2019/10/2 18:59, Eryu Guan wrote:
> On Fri, Sep 27, 2019 at 06:06:26PM +0800, Chao Yu wrote:
>> F2FS supports defragment based on file granularity, adjust test suit
>> to support f2fs.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  common/config |  2 ++
>>  common/defrag | 11 ++++++++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/config b/common/config
>> index 4c86a492..c43be339 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -176,6 +176,7 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
>>  export FSTRIM_PROG="$(type -P fstrim)"
>>  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
>>  export RESIZE2FS_PROG="$(type -P resize2fs)"
>> +export F2FS_IO_PROG="$(type -P f2fs_io)"
>>  export FIO_PROG="$(type -P fio)"
>>  export FILEFRAG_PROG="$(type -P filefrag)"
>>  export E4DEFRAG_PROG="$(type -P e4defrag)"
>> @@ -240,6 +241,7 @@ case "$HOSTOS" in
>>  	export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
>>  	export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
>>  	export DUMP_F2FS_PROG=$(type -P dump.f2fs)
>> +	export F2FS_IO_PROG=$(type -P f2fs_io)
>>  	export BTRFS_UTIL_PROG=$(type -P btrfs)
>>  	export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
>>  	export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
>> diff --git a/common/defrag b/common/defrag
>> index 2bd739c0..9866d3da 100644
>> --- a/common/defrag
>> +++ b/common/defrag
>> @@ -27,6 +27,9 @@ _require_defrag()
>>  	rm -f $testfile $donorfile 2>&1 > /dev/null
>>  	DEFRAG_PROG="$E4DEFRAG_PROG"
>>  	;;
>> +    f2fs)
>> +	DEFRAG_PROG="$F2FS_IO_PROG defrag_file"
>> +	;;
>>      btrfs)
>>  	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
>>  	;;
>> @@ -140,7 +143,13 @@ _defrag()
>>  
>>  	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
>>  	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
>> -	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
>> +
>> +	if [ $FSTYP == "f2fs" ]; then
>> +		_filesize=`ls -l $1 | $AWK_PROG '{print $5}'`

Sorry for later reply.

> 
> Better to declare "filesize" as a local variable here.
> 
> 		local filesize=`stat -c %s $1`

Will update to use below code here:

local filesize=`ls -l $1 | $AWK_PROG '{print $5}'`

Thanks,

> 
> Otherwise looks fine to me.
> 
> But it'd be better to let other f2fs developers review this patchset as
> well.
> 
> Thanks,
> Eryu
> 
>> +		$DEFRAG_PROG 0 $_filesize $1 >> $seqres.full 2>&1
>> +	else
>> +		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
>> +	fi
>>  
>>  	_scratch_cycle_mount
>>  	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
>> -- 
>> 2.18.0.rc1
>>
> .
> 
