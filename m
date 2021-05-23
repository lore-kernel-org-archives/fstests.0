Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1692C47080
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 09:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AF86128A
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 09:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhEWJHR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 May 2021 05:07:17 -0400
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:43068 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhEWJHR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 May 2021 05:07:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09231891|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0244744-0.000565306-0.97496;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KHWS5C1_1621760749;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KHWS5C1_1621760749)
          by smtp.aliyun-inc.com(10.147.42.197);
          Sun, 23 May 2021 17:05:49 +0800
Date:   Sun, 23 May 2021 17:05:49 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Jakob Unterwurzacher <jakobunt@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/286: fix integer underflow on block sizes != 4096
Message-ID: <YKoa7dtkdmu8hp+/@desktop>
References: <20210522184814.95802-1-jakobunt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522184814.95802-1-jakobunt@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 22, 2021 at 08:48:14PM +0200, Jakob Unterwurzacher wrote:
> The read loop always requested 4096 bytes, which only works
> when the total read length is a multiple of 4096 bytes.

The total read length should be

"The length of this extent is (hole_off - data_off)"

according to the comments above do_extent_copy(). Total read length
being not a multiple of 4k means 'data_off' or 'hole_off' is not 4k
aligned.

> 
> This is not neccessarily true, and when it's not, len wraps

But generic/286 creates source files with lenght of all data extents and
hole extents being multiple of 4k. So I still don't understand why this
is valid for gocryptfs. Shouldn't that be a bug in seek_data/seek_hole
in gocryptfs? Could you please elaborate?

Thanks,
Eryu

> around to UINT64_MAX and you get a lot of these:
> 
> 	ERROR: [error:38] reached EOF:Success
> 
> This was caught when running xfstests against gocryptfs,
> an encrypted overlay file system.
> 
> On ext4, the test still passes after this change.
> 
> Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
> ---
>  src/seek_copy_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/seek_copy_test.c b/src/seek_copy_test.c
> index 0c2c6a3d..28c021e2 100644
> --- a/src/seek_copy_test.c
> +++ b/src/seek_copy_test.c
> @@ -98,7 +98,7 @@ do_extent_copy(int src_fd, int dest_fd, off_t data_off, off_t hole_off)
>  	}
>  
>  	while (len > 0) {
> -		ssize_t nr_read = read(src_fd, buf, BUF_SIZE);
> +		ssize_t nr_read = read(src_fd, buf, MIN(len, BUF_SIZE));
>  		if (nr_read < 0) {
>  			if (errno == EINTR)
>  				continue;
> -- 
> 2.31.1
