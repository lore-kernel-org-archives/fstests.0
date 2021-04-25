Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D1C433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 05:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB23661285
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 05:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhDYFGQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 01:06:16 -0400
Received: from out20-109.mail.aliyun.com ([115.124.20.109]:52610 "EHLO
        out20-109.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDYFGQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 01:06:16 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0896225|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0463449-0.00740637-0.946249;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.K3gQFTD_1619327135;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K3gQFTD_1619327135)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 25 Apr 2021 13:05:35 +0800
Date:   Sun, 25 Apr 2021 13:05:35 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: generic/095 and generic/300 failures
Message-ID: <YIT4n/154e/vOm9H@desktop>
References: <YH5siAMU+6p7iD01@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH5siAMU+6p7iD01@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 20, 2021 at 07:54:16AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> generic/095 and generic/300 have been failing for me with every config
> on every file system for a while with the following messages:
> 
> --- tests/generic/095.out	2016-03-29 13:59:30.405053956 +0000
> +++ results/generic/095.out.bad	2021-04-20 05:44:54.432081845 +0000
> @@ -1,2 +1,7 @@
>  QA output created by 095
> +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
>  Silence is golden           
> 
> --- tests/generic/300.out	2016-03-29 13:59:30.431720622 +0000
> +++ results/generic/300.out.bad	2021-04-20 05:45:06.324708699 +0000
> @@ -2,3 +2,4 @@
>  
>  Run fio with random aio-dio pattern
>    
> +falloc_raicer: No I/O performed by falloc, perhaps try --debug=io option for details?
> 
> 
> ----- End forwarded message -----

Yeah, I've noticed these failures as well, and it seems that it's caused
by fio behavior change, as Zorro said he never hit such failures[1].

I'm using fio-3.7

# fio --version
fio-3.7-66-gedfc

Thanks,
Eryu

[1] https://www.spinics.net/lists/fstests/msg15871.html
