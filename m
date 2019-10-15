Return-Path: <SRS0=6y5p=YI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936FDECE588
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 10:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9CF217F9
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 10:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfJOKQE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:16:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfJOKQD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Oct 2019 06:16:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91664438C1179D91CE27;
        Tue, 15 Oct 2019 18:16:02 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct
 2019 18:15:58 +0800
Subject: Re: [PATCH v2 1/2] common/defrag: support f2fs
CC:     <guaneryu@gmail.com>, <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191015100938.123519-1-yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <22384b38-7334-ec2c-0bfc-5af14436b374@huawei.com>
Date:   Tue, 15 Oct 2019 18:15:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191015100938.123519-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Jaegeuk, do you have time to check these two patches which are trying to adjust
defrag/casefold testcase for f2fs?

On 2019/10/15 18:09, Chao Yu wrote:
> F2FS supports defragment based on file granularity, adjust test suit
> to support f2fs.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - use local variable in function
>  common/config |  2 ++
>  common/defrag | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index a0d58bde..22592cec 100644
> --- a/common/config
> +++ b/common/config
> @@ -176,6 +176,7 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
>  export FSTRIM_PROG="$(type -P fstrim)"
>  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
>  export RESIZE2FS_PROG="$(type -P resize2fs)"
> +export F2FS_IO_PROG="$(type -P f2fs_io)"
>  export FIO_PROG="$(type -P fio)"
>  export FILEFRAG_PROG="$(type -P filefrag)"
>  export E4DEFRAG_PROG="$(type -P e4defrag)"
> @@ -242,6 +243,7 @@ case "$HOSTOS" in
>  	export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
>  	export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
>  	export DUMP_F2FS_PROG=$(type -P dump.f2fs)
> +	export F2FS_IO_PROG=$(type -P f2fs_io)
>  	export BTRFS_UTIL_PROG=$(type -P btrfs)
>  	export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
>  	export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
> diff --git a/common/defrag b/common/defrag
> index 2bd739c0..1381a4dd 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -27,6 +27,9 @@ _require_defrag()
>  	rm -f $testfile $donorfile 2>&1 > /dev/null
>  	DEFRAG_PROG="$E4DEFRAG_PROG"
>  	;;
> +    f2fs)
> +	DEFRAG_PROG="$F2FS_IO_PROG defrag_file"
> +	;;
>      btrfs)
>  	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
>  	;;
> @@ -140,7 +143,13 @@ _defrag()
>  
>  	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
>  	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
> -	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
> +
> +	if [ $FSTYP == "f2fs" ]; then
> +		local filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
> +		$DEFRAG_PROG 0 $filesize $1 >> $seqres.full 2>&1
> +	else
> +		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
> +	fi
>  
>  	_scratch_cycle_mount
>  	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
> 
