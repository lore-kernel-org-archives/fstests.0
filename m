Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62817C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 06:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463006125F
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 06:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhKHG1z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 01:27:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25568 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237710AbhKHG1z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Nov 2021 01:27:55 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AK/PITKuevmYJkTnIRHZ+sMufjOfnVHRcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3mmNLCjvQOvzYNzH1Ko8kO42/oRsD7JbXmNAwQQpurSpgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cZXgrLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JPLkxOaLCGEL/JGSRte0Zcj0ulqCGd?=
 =?us-ascii?q?m+OYJNXYIY3irifmqzamnUcFyick5asrmJoUSvjdn1z6xMBqMafgvWI2TvZkBg?=
 =?us-ascii?q?mh23ZsIQJ7jiwMiQWIHRHz9j9dnYz/70K4Dodo=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3APhDDu6+zCdvxg1PCOqxuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,217,1631548800"; 
   d="scan'208";a="117046472"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Nov 2021 14:25:10 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 870E649F19C5;
        Mon,  8 Nov 2021 14:25:03 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 8 Nov 2021 14:25:06 +0800
Received: from [10.167.216.64] (10.167.216.64) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 8 Nov 2021 14:25:05 +0800
Message-ID: <4e4c9789-0e1b-04e1-2a26-c1cccd509b66@fujitsu.com>
Date:   Mon, 8 Nov 2021 14:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/5] generic: add a couple of MMAP CoW tests
To:     Eryu Guan <guan@eryu.me>
CC:     <fstests@vger.kernel.org>
References: <20211105045222.157826-1-ruansy.fnst@fujitsu.com>
 <YYfVP7HJDNGwo8p5@desktop>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YYfVP7HJDNGwo8p5@desktop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 870E649F19C5.ACB81
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



在 2021/11/7 21:31, Eryu Guan 写道:
> On Fri, Nov 05, 2021 at 12:52:17PM +0800, Shiyang Ruan wrote:
>> There is a set of CoW tests which is to
>>    > Check what happens if we BufferedIO/DIO CoW blocks 2-4 of a page's worth
>>    > of blocks when the second block is a regular/unwritten/hole/delalloc/all
>>    > block.
>> I think a test of MMAP CoW is also needed for these kind of testsets.  So,
>> add MMAP CoW for each case.
>>
>> Shiyang Ruan (5):
>>    generic/xxx: Add MMAP CoW test for 'regular' case
>>    generic/xxx: Add MMAP CoW test for 'unwritten' case
>>    generic/xxx: Add MMAP CoW test for 'hole' case
>>    generic/xxx: Add MMAP CoW test for 'delalloc' case
>>    generic/xxx: Add MMAP CoW test for 'all' case
> 
> Thanks for all these tests!
> 
> You could remove the 'xxx' part from patch summary, and for new tests
> you don't have to write the specific test seq number in summary,
> something like below is fine
> 
>     generic: add mmap CoW test for 'regular' case
> 
> As test seq number will always change on commit, there's no need to keep
> such a place holder.

Got it.  Thanks.

--
Ruan
> 
> Thanks,
> Eryu
> 
>>
>>   tests/generic/900     |  75 +++++++++++++++++++++++
>>   tests/generic/900.out |   6 ++
>>   tests/generic/901     |  76 ++++++++++++++++++++++++
>>   tests/generic/901.out |   6 ++
>>   tests/generic/902     |  70 ++++++++++++++++++++++
>>   tests/generic/902.out |   6 ++
>>   tests/generic/903     |  76 ++++++++++++++++++++++++
>>   tests/generic/903.out |   6 ++
>>   tests/generic/904     | 135 ++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/904.out |  82 +++++++++++++++++++++++++
>>   10 files changed, 538 insertions(+)
>>   create mode 100755 tests/generic/900
>>   create mode 100644 tests/generic/900.out
>>   create mode 100755 tests/generic/901
>>   create mode 100644 tests/generic/901.out
>>   create mode 100755 tests/generic/902
>>   create mode 100644 tests/generic/902.out
>>   create mode 100755 tests/generic/903
>>   create mode 100644 tests/generic/903.out
>>   create mode 100755 tests/generic/904
>>   create mode 100644 tests/generic/904.out
>>
>> -- 
>> 2.33.0
>>
>>


