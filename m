Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCF1C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 02:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141C320663
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 02:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGOCyF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:54:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:30139 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgGOCyF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 14 Jul 2020 22:54:05 -0400
IronPort-SDR: XZoDVFQE0iMd69Gbpglf01lbFfJzkdPmEt1P9vMRYXogUxvKDVNBf9yRR3byL981htb0rCyRo6
 kjQ2WHmlgESA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="136526567"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="136526567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 19:54:04 -0700
IronPort-SDR: Y0YlXc+ucGE2i09XG3CykxqSN3jRISu9SyCetmnsgtC+IYcL0Yvi5t+AvYI/wGAPj5018pa3/9
 CrbxGUWWwQtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="360572632"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2020 19:54:04 -0700
Date:   Tue, 14 Jul 2020 19:54:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH] common/dmlogwrites: Update _require_log_writes_dax()
Message-ID: <20200715025404.GJ3008823@iweiny-DESK2.sc.intel.com>
References: <20200714110150.11186-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714110150.11186-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 14, 2020 at 07:01:50PM +0800, Xiao Yang wrote:
> 1) Rename _require_log_writes_dax to _require_log_writes_dax_mountopt
> 2) Make _require_log_writes_dax_mountopt accept old and new dax option
> 3) generic/470 takes use of _require_log_writes_dax_mountopt
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Looks reasonable at this time.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

At some point I think we want to deprecate the '-o dax' option in favor of '-o
dax=always'.  I'm not sure when, how, or even if, that can be done so for now
this looks good.

Finally, I would really like to Thank you for doing these.  I had 1 big test
which I was trying to clean up to submit but I've not had time and my
understanding of xfstests is limited which made it slow going.  So I'd like to
offer a big Thank You!  :-D

Thanks,
Ira

> ---
>  common/dmlogwrites | 15 ++++++++++-----
>  tests/generic/470  |  2 +-
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 2a7ff612..2e9b2311 100644
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
> @@ -32,16 +35,18 @@ _require_log_writes_dax()
>  	_require_test_program "log-writes/replay-log"
>  
>  	local ret=0
> +	local mountopt=$1
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
> -- 
> 2.21.0
> 
> 
> 
