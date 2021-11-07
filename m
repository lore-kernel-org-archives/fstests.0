Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD8C433EF
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Nov 2021 13:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4636135F
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Nov 2021 13:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhKGNe3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Nov 2021 08:34:29 -0500
Received: from out20-109.mail.aliyun.com ([115.124.20.109]:51751 "EHLO
        out20-109.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhKGNe2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Nov 2021 08:34:28 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3396402|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0539591-0.00124263-0.944798;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Lose5zv_1636291903;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lose5zv_1636291903)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sun, 07 Nov 2021 21:31:44 +0800
Date:   Sun, 7 Nov 2021 21:31:43 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/5] generic: add a couple of MMAP CoW tests
Message-ID: <YYfVP7HJDNGwo8p5@desktop>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 12:52:17PM +0800, Shiyang Ruan wrote:
> There is a set of CoW tests which is to 
>   > Check what happens if we BufferedIO/DIO CoW blocks 2-4 of a page's worth
>   > of blocks when the second block is a regular/unwritten/hole/delalloc/all
>   > block.
> I think a test of MMAP CoW is also needed for these kind of testsets.  So,
> add MMAP CoW for each case.
> 
> Shiyang Ruan (5):
>   generic/xxx: Add MMAP CoW test for 'regular' case
>   generic/xxx: Add MMAP CoW test for 'unwritten' case
>   generic/xxx: Add MMAP CoW test for 'hole' case
>   generic/xxx: Add MMAP CoW test for 'delalloc' case
>   generic/xxx: Add MMAP CoW test for 'all' case

Thanks for all these tests!

You could remove the 'xxx' part from patch summary, and for new tests
you don't have to write the specific test seq number in summary,
something like below is fine

   generic: add mmap CoW test for 'regular' case

As test seq number will always change on commit, there's no need to keep
such a place holder.

Thanks,
Eryu

> 
>  tests/generic/900     |  75 +++++++++++++++++++++++
>  tests/generic/900.out |   6 ++
>  tests/generic/901     |  76 ++++++++++++++++++++++++
>  tests/generic/901.out |   6 ++
>  tests/generic/902     |  70 ++++++++++++++++++++++
>  tests/generic/902.out |   6 ++
>  tests/generic/903     |  76 ++++++++++++++++++++++++
>  tests/generic/903.out |   6 ++
>  tests/generic/904     | 135 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/904.out |  82 +++++++++++++++++++++++++
>  10 files changed, 538 insertions(+)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
>  create mode 100755 tests/generic/901
>  create mode 100644 tests/generic/901.out
>  create mode 100755 tests/generic/902
>  create mode 100644 tests/generic/902.out
>  create mode 100755 tests/generic/903
>  create mode 100644 tests/generic/903.out
>  create mode 100755 tests/generic/904
>  create mode 100644 tests/generic/904.out
> 
> -- 
> 2.33.0
> 
> 
