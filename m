Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5234AC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Dec 2021 07:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243592AbhLCHeV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:34:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53828 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1378867AbhLCHeU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Dec 2021 02:34:20 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AUIOZEq+UzlZm+Xopsf7bDrUDnHyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUoq1WYOzjAcCG7QOquCazekKNh1Otmyp04O75TQztNmQFdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4EfyWlTdhSMkj/jRHOKmULW?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OaecSPh65XPkSUqdFOpmZ2CFnoeM5YE9/1rGkl?=
 =?us-ascii?q?Q+vECbjMAdBaOg6Sx2r3TdwXGrqzPN+GyZMVG5C4mlmqfUJ4brVn4a/2izbdlM?=
 =?us-ascii?q?P0Y36iixcrjWvc=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4AcRdqAqiCOfJEPlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,283,1631548800"; 
   d="scan'208";a="118362146"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Dec 2021 15:30:55 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 762574D13A1D
        for <fstests@vger.kernel.org>; Fri,  3 Dec 2021 15:30:53 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Dec 2021 15:30:54 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Dec 2021 15:30:51 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <ruansy.fnst@fujitsu.com>
CC:     <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 00/16] generic: add some mmap CoW tests
Date:   Fri, 3 Dec 2021 15:30:53 +0800
Message-ID: <20211203073053.1421823-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 762574D13A1D.AEAF4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ping

> This series is to add missing mmap CoW tests in some sets of testcases:
> Set 1. CoW on shared blocks which are interleaving reflinked by two files.
>   - P1:            add mmap test
> Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
>    the destination file.
>   - P2 ~ P6:       add mmap test
> Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
>    the source file.
>   - P11, P12:      add missing buffered-io and direct-io test for mixed blocks
>   - P7 ~ P10, P13: add mmap test
> Set 4. races tests
>   - P14: race between reflink and mmap reading
>   - P15: race between mmap writing to and reflink source file
>   - P16: race between mmap writing to and reflink target file


