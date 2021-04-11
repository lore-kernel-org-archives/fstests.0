Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A918C43461
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC3B6120D
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Apr 2021 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhDKItP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Apr 2021 04:49:15 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:47560 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKItO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Apr 2021 04:49:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2789018|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.236535-0.00279829-0.760667;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JyFMcvj_1618130936;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JyFMcvj_1618130936)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 11 Apr 2021 16:48:57 +0800
Date:   Sun, 11 Apr 2021 16:48:56 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/591: tmpfs do not test with O_DIRECT flag
Message-ID: <YHK3+OTP20bjIx4A@desktop>
References: <20210409103800.2077384-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409103800.2077384-1-sunke32@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 09, 2021 at 06:38:00AM -0400, Sun Ke wrote:
> tmpfs does not support the O_DIRECT flag, so when FSTYP is tmpfs,
> do not test with O_DIRECT flag.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Seems we should add _require_odirect instead, otherwise we'll keep
adding new checks when new filesystems without dio support emerge.

Thanks,
Eryu

> ---
>  tests/generic/591 | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/591 b/tests/generic/591
> index d4020463..4b97a2fc 100755
> --- a/tests/generic/591
> +++ b/tests/generic/591
> @@ -31,10 +31,18 @@ _require_test_program "splice-test"
>  
>  rm -f $seqres.full
>  
> -$here/src/splice-test -r $TEST_DIR/a
> -$here/src/splice-test -rd $TEST_DIR/a
> -$here/src/splice-test $TEST_DIR/a
> -$here/src/splice-test -d $TEST_DIR/a
> +if [ $FSTYP == "tmpfs" ]; then
> +	echo "concurrent reader with O_DIRECT"
> +	echo "concurrent reader with O_DIRECT"
> +	$here/src/splice-test -rd $TEST_DIR/a
> +	echo "sequential reader with O_DIRECT"
> +	$here/src/splice-test -d $TEST_DIR/a
> +else
> +	$here/src/splice-test -r $TEST_DIR/a
> +	$here/src/splice-test -rd $TEST_DIR/a
> +	$here/src/splice-test $TEST_DIR/a
> +	$here/src/splice-test -d $TEST_DIR/a
> +fi
>  
>  # success, all done
>  status=0
> -- 
> 2.13.6
