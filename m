Return-Path: <SRS0=HfNX=A6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673AAC433E1
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jul 2020 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448E4207EA
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jul 2020 17:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgGSRXM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:23:12 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:34503 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRXM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jul 2020 13:23:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09399154|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00858591-0.000561715-0.990852;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10434;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.I4NHmlt_1595179388;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.I4NHmlt_1595179388)
          by smtp.aliyun-inc.com(10.147.41.187);
          Mon, 20 Jul 2020 01:23:08 +0800
Date:   Mon, 20 Jul 2020 01:23:08 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: clear WARN_ONCE state before each test
Message-ID: <20200719172308.GF2557159@desktop>
References: <20200715114219.18353-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715114219.18353-1-lczerner@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 15, 2020 at 01:42:19PM +0200, Lukas Czerner wrote:
> clear WARN_ONCE state before each test to allow a potential problem
> to be reported for each test
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  check | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/check b/check
> index 2e148e57..6ba64d5d 100755
> --- a/check
> +++ b/check
> @@ -756,6 +756,11 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			touch ${RESULT_DIR}/check_dmesg
>  		fi
>  		_try_wipe_scratch_devs > /dev/null 2>&1
> +
> +		# clear the WARN_ONCE state to allow a potential problem
> +		# to be reported for each test
> +		(echo 1 > /sys/kernel/debug/clear_warn_once) > /dev/null 2>&1

Thanks for the fix! I replaced "/sys/kernel/debug" with $DEBUGFS_MNT on commit.

Thanks,
Eryu

> +
>  		if [ "$DUMP_OUTPUT" = true ]; then
>  			_run_seq 2>&1 | tee $tmp.out
>  			# Because $? would get tee's return code
> -- 
> 2.21.3
