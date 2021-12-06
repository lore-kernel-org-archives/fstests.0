Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6031CC433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Dec 2021 01:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhLFBWL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Dec 2021 20:22:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22910 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230037AbhLFBWL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Dec 2021 20:22:11 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A36A5NaArLH6hcRVW/wvhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBAC53TkjhWRVmmQZX2+AP/+JYWXwe9onaomwoRsAvpCAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkERcwmj/3auK49CMkiPnSLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZP0apOSbcSfXXcu7iheun2HX6/pzBUceMJcJ56ByDAl?=
 =?us-ascii?q?m++cEJSsRdTidiO+shrG2UO9hgoIkNsaDAW+1khmM1hmAVbB/H8+FGP6MuLdlM?=
 =?us-ascii?q?P4LrpgmNZ7jiwAxMFKDtCj9XiA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGcAXLKB2sa5RJZzlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,290,1631548800"; 
   d="scan'208";a="118443487"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Dec 2021 09:18:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9A8864D13A1F;
        Mon,  6 Dec 2021 09:18:38 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 6 Dec 2021 09:18:40 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 6 Dec 2021 09:18:19 +0800
Message-ID: <b1aacb7f-719d-0624-2186-dfb9755d74a0@fujitsu.com>
Date:   Mon, 6 Dec 2021 09:18:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 00/16] generic: add some mmap CoW tests
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211203073053.1421823-1-ruansy.fnst@fujitsu.com> <YazTSVgkmfnhkR9j@desktop>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YazTSVgkmfnhkR9j@desktop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 9A8864D13A1F.AF02A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


在 2021/12/5 22:57, Eryu Guan 写道:
> On Fri, Dec 03, 2021 at 03:30:53PM +0800, Shiyang Ruan wrote:
>> Ping
> 
> The patchset is in my to-review queue, but just didn't get enough time
> to review them.. Will try to find some time to review them next week.

OK, Thanks~


--
Ruan

> 
> Thanks,
> Eryu
> 
>>
>>> This series is to add missing mmap CoW tests in some sets of testcases:
>>> Set 1. CoW on shared blocks which are interleaving reflinked by two files.
>>>    - P1:            add mmap test
>>> Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
>>>     the destination file.
>>>    - P2 ~ P6:       add mmap test
>>> Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
>>>     the source file.
>>>    - P11, P12:      add missing buffered-io and direct-io test for mixed blocks
>>>    - P7 ~ P10, P13: add mmap test
>>> Set 4. races tests
>>>    - P14: race between reflink and mmap reading
>>>    - P15: race between mmap writing to and reflink source file
>>>    - P16: race between mmap writing to and reflink target file
>>


