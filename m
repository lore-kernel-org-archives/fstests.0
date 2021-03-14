Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F500C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 11:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D363A64EBD
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 11:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhCNLmm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Mar 2021 07:42:42 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:41769 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhCNLmJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Mar 2021 07:42:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07983366|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.213983-0.00137258-0.784644;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JkulizJ_1615722126;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JkulizJ_1615722126)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 14 Mar 2021 19:42:06 +0800
Date:   Sun, 14 Mar 2021 19:42:06 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: specifically make new xfs in _test_mkfs
Message-ID: <YE32jkUjOxc0pc1Z@desktop>
References: <20210311121213.1348303-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311121213.1348303-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 11, 2021 at 08:12:13PM +0800, Zorro Lang wrote:
> When we test different filesystems with different sections in config
> file, always hit below failure:
>    ...
>    our local _test_mkfs routine ...
>    mkfs.xfs: /dev/vdb1 appears to contain an existing filesystem (xfs)
>    mkfs.xfs: Use the -f option to force overwrite.
>    check: failed to mkfs $TEST_DEV using specified options
>    ...
> 
> To fix this problem, change the _test_mkfs to deal with xfs creation
> properly. Due to xfstests uses _test_mkfs rarely, currently only in
> check program, so I don't intend to write a whole new series of
> _test_mkfs_xfs_* functions likes what _scratch_mkfs_xfs_* does.
> 
> Reported-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Zorro Lang <zlang@redhat.com>

I also have defined different test sections in config file to test
different filesysms, but I didn't hit this failure. And it turns out
that I have "-f" in MKFS_OPTIONS, e.g.

	[xfs_prjquota_crc]
	FSTYP=xfs
	MKFS_OPTIONS="-f -b size=4k -m crc=1"
	MOUNT_OPTIONS="-o prjquota"

	[xfs_allquota_reflink]
	FSTYP=xfs
	MKFS_OPTIONS="-f -b size=4k -m crc=1,reflink=1,rmapbt=1"
	MOUNT_OPTIONS="-o usrquota,grpquota,prjquota"

And I think that's the way to fix it.

Thanks,
Eryu

> ---
>  common/rc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 0ce3cb0d..c783def7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -258,6 +258,7 @@ _test_options()
>  
>      case $type in
>      mkfs)
> +	TEST_OPTIONS="$TEST_OPTIONS -f"
>  	rt_opt="-r"
>          log_opt="-l"
>  	;;
> @@ -633,6 +634,15 @@ _test_mkfs()
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> +    xfs)
> +	local mkfs_opts=$*
> +
> +	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
> +		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+\S\+//g"`
> +	fi
> +	_test_options mkfs
> +	$MKFS_XFS_PROG $TEST_OPTIONS $MKFS_OPTIONS $mkfs_opts $TEST_DEV
> +	;;
>      *)
>  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> -- 
> 2.29.2
