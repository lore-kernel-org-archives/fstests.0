Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E651C636C8
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 13:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7AB61182
	for <linux-fstests@archiver.kernel.org>; Sun, 18 Jul 2021 13:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhGRNyO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 18 Jul 2021 09:54:14 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:40484 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhGRNyN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Jul 2021 09:54:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07843886|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00463065-0.000736642-0.994633;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Kkr11rn_1626616273;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Kkr11rn_1626616273)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sun, 18 Jul 2021 21:51:14 +0800
Date:   Sun, 18 Jul 2021 21:51:13 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     darrick.wong@oracle.com, fstests@vger.kernel.org
Subject: Re: [RFC PATCH] misc: skip fsx tests when op length not congruent
 with file allocation unit
Message-ID: <YPQx0cXESGzJyu0U@desktop>
References: <20210706181452.GB11571@locust>
 <20210707104745.98822-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707104745.98822-1-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 07, 2021 at 06:47:45PM +0800, Jeffle Xu wrote:
> 
> Yes it works. For example in this RFC patch, generic/075 could be
> skipped once 'bigalloc' is detected for ext4.
> 
> I could fix all related test cases in this way, if it is acceptable to
> the community.

Looks fine to me.

> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  common/rc         | 20 ++++++++++++++++++++
>  tests/generic/075 |  3 +++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index f58a542..92245e0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4041,6 +4041,23 @@ _sysfs_dev()
>  	min=$(echo "ibase=16; $min" | bc)
>  	echo /sys/dev/block/$maj:$min
>  }
> +		
> +_ext4_get_file_block_size()

Another ext4 specific helper in common/rc, perhaps it's time to create
its own file for ext4, i.e. common/ext4, and move all ext4 specific
helpers in common/rc there.

> +{
> +	local path="$1"
> +	path="$(readlink -m "$path")"
> +	local dev=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $1}'`

$dir is not defined, you mean $path here?

> +	
> +	# The alloc unit size equals block size for ext4 without 'bigalloc'.
> +	if ! (tune2fs -l $dev | grep -q 'Cluster size'); then

$TUNE2FS_PROG

Perhaps you could call tune2fs only once and save its "Cluster size"
line for later use.

Thanks,
Eryu

> +		_get_block_size "$path"
> +		return
> +	fi
> +
> +	# Otherwise, call tune2fs acquiring cluster size.
> +	tune2fs -l $dev | sed -n -e 's/^.*Cluster size:\s*\([0-9]*\).*$/\1/p'
> +
> +}
>  
>  # Get the minimum block size of a file.  Usually this is the
>  # minimum fs block size, but some filesystems (ocfs2) do block
> @@ -4059,6 +4076,9 @@ _get_file_block_size()
>  	"xfs")
>  		_xfs_get_file_block_size $1
>  		;;
> +	"ext4")
> +		_ext4_get_file_block_size $1
> +		;;
>  	*)
>  		_get_block_size $1
>  		;;
> diff --git a/tests/generic/075 b/tests/generic/075
> index 7467bb7..d269a7c 100755
> --- a/tests/generic/075
> +++ b/tests/generic/075
> @@ -109,6 +109,9 @@ _process_args()
>  _supported_fs generic
>  _require_test
>  
> +blksz=$(_get_block_size $TEST_DIR)
> +_require_congruent_file_oplen $TEST_DIR $blksz
> +
>  size10=`expr 10 \* 1024 \* 1024`	# 10 megabytes
>  filelen=$size10
>  numops1=1000
> -- 
> 1.8.3.1
