Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6247AC433EF
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Dec 2021 14:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhLEPAp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Dec 2021 10:00:45 -0500
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:34173 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhLEPAm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Dec 2021 10:00:42 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2046408|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0139915-0.00073407-0.985274;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.M3NFaNU_1638716233;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M3NFaNU_1638716233)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 05 Dec 2021 22:57:13 +0800
Date:   Sun, 5 Dec 2021 22:57:13 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 00/16] generic: add some mmap CoW tests
Message-ID: <YazTSVgkmfnhkR9j@desktop>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211203073053.1421823-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203073053.1421823-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 03, 2021 at 03:30:53PM +0800, Shiyang Ruan wrote:
> Ping

The patchset is in my to-review queue, but just didn't get enough time
to review them.. Will try to find some time to review them next week.

Thanks,
Eryu

> 
> > This series is to add missing mmap CoW tests in some sets of testcases:
> > Set 1. CoW on shared blocks which are interleaving reflinked by two files.
> >   - P1:            add mmap test
> > Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
> >    the destination file.
> >   - P2 ~ P6:       add mmap test
> > Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
> >    the source file.
> >   - P11, P12:      add missing buffered-io and direct-io test for mixed blocks
> >   - P7 ~ P10, P13: add mmap test
> > Set 4. races tests
> >   - P14: race between reflink and mmap reading
> >   - P15: race between mmap writing to and reflink source file
> >   - P16: race between mmap writing to and reflink target file
> 
