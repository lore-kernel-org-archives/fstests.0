Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3D1C433E1
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 18:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DBC6193A
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhC2SXt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:23:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:58083 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhC2SXe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Mar 2021 14:23:34 -0400
IronPort-SDR: m0v2+rkE9nN2EIlId8jGtDnJ2b8NC/d3fRiO7HScpIV6OmyRzYTty5Aq3HFWNGiJCh90uVRFNo
 8bJC2JaJB/kA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="178733846"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="178733846"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 11:23:33 -0700
IronPort-SDR: agSzgW5AD3swNeipiKONIzuthFQE95WX6mN22nVgc/BXZCaR1wywYOlAt2/DmtJP9PZzK06Qk2
 qFGhBOASDSfA==
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="417789032"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 11:23:33 -0700
Date:   Mon, 29 Mar 2021 11:23:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        lihao2018.fnst@fujitsu.com, david@fromorbit.com, xifeng@redhat.com
Subject: Re: [PATCH v2 2/2] generic/608: Add new regression test
Message-ID: <20210329182333.GZ3014244@iweiny-DESK2.sc.intel.com>
References: <20210329092054.5278-1-yangx.jy@fujitsu.com>
 <20210329092054.5278-2-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329092054.5278-2-yangx.jy@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 29, 2021 at 05:20:54PM +0800, Xiao Yang wrote:
> Write data into a file and then enable DAX on the file immediately,
> the written data which is still in the buffer will be lost when
> the corresponding inode is evicted.

This and the comment below are confusing.  Doesn't the buffered data get
written?  Which means the data is not lost?

IOW the test is checking to make sure the data does not get lost, not that it
does.  What am I missing?

Ira

> 
> It's a regression test for commit 26b15a042b8a.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  tests/generic/608 | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tests/generic/608 b/tests/generic/608
> index d81a2488..674bd2cf 100755
> --- a/tests/generic/608
> +++ b/tests/generic/608
> @@ -7,6 +7,12 @@
>  # file change immediately when all applications close the file.
>  # It's a regression test for:
>  # 'commit e7bed0b5bc4b ("fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set")'
> +#
> +# Write data into a file and then enable DAX on the file immediately,
> +# the written data which is still in the buffer will be lost when the
> +# corresponding inode is evicted.
> +# It's a regression test for:
> +# 'commit 26b15a042b8a ("fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()"'
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
> +	# Without commit e7bed0b5bc4b, ensure inode can
> +	# be evicted by drop_caches
> +	echo 2 > /proc/sys/vm/drop_caches
> +
> +	# The written data which is still in the buffer will be lost
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
> +	# Do test for commit 26b15a042b8a
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
