Return-Path: <SRS0=TGcZ=A3=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF543C433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jul 2020 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C294A2067D
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jul 2020 05:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgGPFcS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:32:18 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10293 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725844AbgGPFcS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jul 2020 01:32:18 -0400
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="96422605"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jul 2020 13:32:13 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id DED4A4CE5075;
        Thu, 16 Jul 2020 13:32:07 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 16 Jul 2020 13:32:08 +0800
Message-ID: <5F0FE656.7050903@cn.fujitsu.com>
Date:   Thu, 16 Jul 2020 13:32:06 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     <fstests@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: Update _require_log_writes_dax()
 for new dax option
References: <20200715162342.15192-1-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200715162342.15192-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: DED4A4CE5075.AD696
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2020/7/16 0:23, Xiao Yang wrote:
> 1) Rename _require_log_writes_dax to _require_log_writes_dax_mountopt.
> 2) Make _require_log_writes_dax_mountopt check if old or new dax option
>    is supported.
> 3) generic/470 takes use of _require_log_writes_dax_mountopt.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Add missing Reviewed-by:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  common/dmlogwrites | 16 +++++++++++-----
>  tests/generic/470  |  2 +-
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 2a7ff612..66c2c939 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -23,7 +23,10 @@ _require_log_writes()
>  # explicitly. But this is considered as a temporary workaround, we want to move
>  # all the DAX check back to _require_log_writes when dm-log-writes gains full
>  # DAX support and remove this helper.
> -_require_log_writes_dax()
> +#
> +# Only accept dax/dax=always mount option becasue dax=always, dax=inode
> +# and dax=never are always introduced together.
> +_require_log_writes_dax_mountopt()
>  {
>  	[ -z "$LOGWRITES_DEV" -o ! -b "$LOGWRITES_DEV" ] && \
>  		_notrun "This test requires a valid \$LOGWRITES_DEV"
> @@ -32,16 +35,19 @@ _require_log_writes_dax()
>  	_require_test_program "log-writes/replay-log"
>  
>  	local ret=0
> +	local mountopt=$1
> +
>  	_log_writes_init $SCRATCH_DEV
>  	_log_writes_mkfs > /dev/null 2>&1
> -	_log_writes_mount -o dax > /dev/null 2>&1
> -	# Check options to be sure. XFS ignores dax option
> +	_log_writes_mount "-o $mountopt" > /dev/null 2>&1
> +	# Check options to be sure.
> +	# XFS ignores dax option(or changes it to dax=never)
>  	# and goes on if dev underneath does not support dax.
> -	_fs_options $LOGWRITES_DMDEV | grep -qw "dax"
> +	_fs_options $LOGWRITES_DMDEV | egrep -q "dax(=always|,|$)"
>  	ret=$?
>  	_log_writes_cleanup
>  	if [ $ret -ne 0 ]; then
> -		_notrun "$LOGWRITES_DMDEV $FSTYP does not support -o dax"
> +		_notrun "$LOGWRITES_DMDEV $FSTYP does not support -o $mountopt"
>  	fi
>  }
>  
> diff --git a/tests/generic/470 b/tests/generic/470
> index 93691f4a..fd6da563 100755
> --- a/tests/generic/470
> +++ b/tests/generic/470
> @@ -35,7 +35,7 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> -_require_log_writes_dax
> +_require_log_writes_dax_mountopt "dax"
>  _require_xfs_io_command "mmap" "-S"
>  _require_xfs_io_command "log_writes"
>  



