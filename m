Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB4C433FE
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Dec 2020 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E8223121
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Dec 2020 13:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgLFNze (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Dec 2020 08:55:34 -0500
Received: from out20-63.mail.aliyun.com ([115.124.20.63]:40973 "EHLO
        out20-63.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgLFNze (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Dec 2020 08:55:34 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1682637|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.639514-0.00181835-0.358668;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.J3e3DP._1607262876;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J3e3DP._1607262876)
          by smtp.aliyun-inc.com(10.147.42.16);
          Sun, 06 Dec 2020 21:54:36 +0800
Date:   Sun, 6 Dec 2020 21:54:36 +0800
From:   Eryu Guan <guan@eryu.me>
To:     XiaoLi Feng <xifeng@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1] generic/275: use free block counts to check if fs is
 filled sufficiently.
Message-ID: <20201206135436.GW3853@desktop>
References: <20201202102731.22350-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202102731.22350-1-xifeng@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 02, 2020 at 06:27:31PM +0800, Xiaoli Feng wrote:
> From: Xiaoli Feng <xifeng@redhat.com>
> 
> For large block size, such as 64k, there're maybe leave more than 768k
> space when disk is full. I met one. When I test 64k for dax. It leaves
> about 800k space when disk is full. So change to jude the free block
> for >4k fs.

I'm not sure if that's a bug in the filesystem, and the test is designed
to find such bugs. Would you please make sure if that's a bug or not
first? Maybe by asking in proper mailing list.

Thanks,
Eryu

> ---
>  tests/generic/275 | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/275 b/tests/generic/275
> index 3a016037..2c5a807f 100755
> --- a/tests/generic/275
> +++ b/tests/generic/275
> @@ -62,9 +62,16 @@ rm -f $SCRATCH_MNT/tmp1
>  sync
>  echo "Post rm space:" >> $seqres.full
>  $DF_PROG $SCRATCH_MNT >>$seqres.full 2>&1
> -_freespace=`$DF_PROG -k $SCRATCH_MNT | tail -n 1 | awk '{print $5}'`
> -[ $_freespace -gt 1024 ] && _fail "could not sufficiently fill filesystem"
> -
> +bsize=$(_get_file_block_size $SCRATCH_MNT)
> +bsize=$((bsize / 1024))
> +_freespace=`$DF_PROG -k  $SCRATCH_MNT | tail -n 1 | awk '{print $5}'`
> +# When block size is >4k, use the free counts of block to judge
> +if [ "$bsize" -gt 4 ]; then
> +	_freeblock=$((_freespace / bsize))
> +	[ "$_freeblock" -gt 256 ] && _fail "could not sufficiently fill filesystem"
> +else
> +	[ "$_freespace" -gt 1024 ] && _fail "could not sufficiently fill filesystem"
> +fi
>  # Try to write more than available space in chunks that will allow at least one
>  # full write to succeed.
>  dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=128k count=8 >>$seqres.full 2>&1
> -- 
> 2.18.1
