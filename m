Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0342C433DB
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 04:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B4261999
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 04:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC3E5l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Mar 2021 00:57:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:26900 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhC3E5P (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Mar 2021 00:57:15 -0400
IronPort-SDR: aT6KsJEOKIsnWiypA7wKvBVD/KzxVfDkNAMhsBaupszPWPzQqO4olkWyTVeHI+eBPXXODLS6kw
 qBNnEfWmgvYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="178821381"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="178821381"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 21:57:14 -0700
IronPort-SDR: 4LpWujFsvq2hs6VoHf7R2d8Tqv32p0d1o8HhCHml2GqUDNhXySVlhOgHr3n615iitPiUP29f/z
 YOtsJStdXtZQ==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="516284385"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 21:57:13 -0700
Date:   Mon, 29 Mar 2021 21:57:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        lihao2018.fnst@fujitsu.com, david@fromorbit.com, xifeng@redhat.com
Subject: Re: [PATCH v3 2/2] generic/608: Add new regression test
Message-ID: <20210330045713.GC3014244@iweiny-DESK2.sc.intel.com>
References: <20210330020655.7310-1-yangx.jy@fujitsu.com>
 <20210330020655.7310-2-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330020655.7310-2-yangx.jy@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 30, 2021 at 10:06:55AM +0800, Xiao Yang wrote:
> Write data into a file and then enable DAX on the file immediately,
> the written data which is still in the buffer should be synchronized
> to disk instead of discarded when the corresponding inode is evicted.
> 
> It's a regression test for commit 88149082bb8e.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

LGTM

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  tests/generic/608 | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tests/generic/608 b/tests/generic/608
> index 5ca2442f..c5bdac32 100755
> --- a/tests/generic/608
> +++ b/tests/generic/608
> @@ -7,6 +7,12 @@
>  # file change immediately when all applications close the file.
>  # It's a regression test for:
>  # 'commit 77573fa310d9 ("fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set")'
> +#
> +# Write data into a file and then enable DAX on the file immediately,
> +# the written data which is still in the buffer should be synchronized
> +# to disk instead of discarded when the corresponding inode is evicted.
> +# It's a regression test for:
> +# 'commit 88149082bb8e ("fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()"'
>  
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -87,6 +93,26 @@ test_disable_dax()
>  	_check_s_dax $t_file 0
>  }
>  
> +test_buffered_data_lost()
> +{
> +	local t_file=$SCRATCH_MNT/datafile
> +
> +	# Write data into a file
> +	echo "Buffered data" > $t_file
> +
> +	# Then enable DAX on the file immediately
> +	$XFS_IO_PROG -c 'chattr +x' $t_file
> +
> +	# Without commit 77573fa310d9, ensure inode can
> +	# be evicted by drop_caches
> +	echo 2 > /proc/sys/vm/drop_caches
> +
> +	# The written data which is still in the buffer should not be lost
> +	grep -q "Buffered data" $t_file || echo "Buffered data is lost"
> +
> +	rm -f $t_file
> +}
> +
>  do_tests()
>  {
>  	local mount_option=$1
> @@ -100,6 +126,9 @@ do_tests()
>  	test_enable_dax
>  	test_disable_dax
>  
> +	# Do test for commit 88149082bb8e
> +	test_buffered_data_lost
> +
>  	_scratch_unmount
>  }
>  
> -- 
> 2.21.0
> 
> 
> 
