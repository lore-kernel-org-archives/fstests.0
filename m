Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B55CC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 15:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349749AbiCUPCg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiCUPCf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 11:02:35 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E051517EB
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 08:01:05 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AXJYgwajyWfZPQvMZ83P4OHm5X161fBIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUHymAbXmHVOf2MamH8eN1xPovkoUtS7ZLTm4cxQAdlqXw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl65zPkhCYIhMAxN0rVinaJ7Yw9P1rDHp?=
 =?us-ascii?q?S7tQGJz0XKBOOneS7xPS8UOYEuyiJBKEHJ6tG4jc5k26fVq1gHPj+r2zxzYcw9?=
 =?us-ascii?q?F8NagpmRJ4yv/YkVAc=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGub0d65j/BotHTKoiQPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122845569"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Mar 2022 23:01:04 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id DD4B44D169E7
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 23:00:59 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 21 Mar 2022 23:01:01 +0800
Received: from [10.167.201.3] (10.167.201.3) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 21 Mar 2022 23:00:58 +0800
Message-ID: <4abf66f4-2101-db09-f1c1-4c70668038d3@fujitsu.com>
Date:   Mon, 21 Mar 2022 23:00:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 0/3] xfs: add memory failure tests for dax mode
To:     <fstests@vger.kernel.org>
References: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: DD4B44D169E7.A2B2D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

ping...  any comments?

在 2022/3/11 23:18, Shiyang Ruan 写道:
> This patchset is to verify whether memory failure mechanism still works
> with the dax-rmap feature[1].  With this feature, dax and reflink can be
> used together[2].  So, we also test it for reflinked files in filesystem
> mounted with dax option.
> 
> [1] https://lore.kernel.org/linux-xfs/20220227120747.711169-1-ruansy.fnst@fujitsu.com/
> [2] https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/
> 
> Shiyang Ruan (3):
>    xfs: add memory failure test for dax mode
>    xfs: add memory failure test for dax&reflink mode
>    xfs: add memory failure test for partly-reflinked&dax file
> 
>   .gitignore                      |   1 +
>   src/Makefile                    |   3 +-
>   src/t_mmap_cow_memory_failure.c | 154 ++++++++++++++++++++++++++++++++
>   tests/xfs/900                   |  48 ++++++++++
>   tests/xfs/900.out               |   9 ++
>   tests/xfs/901                   |  49 ++++++++++
>   tests/xfs/901.out               |   9 ++
>   tests/xfs/902                   |  52 +++++++++++
>   tests/xfs/902.out               |   9 ++
>   9 files changed, 333 insertions(+), 1 deletion(-)
>   create mode 100644 src/t_mmap_cow_memory_failure.c
>   create mode 100755 tests/xfs/900
>   create mode 100644 tests/xfs/900.out
>   create mode 100755 tests/xfs/901
>   create mode 100644 tests/xfs/901.out
>   create mode 100755 tests/xfs/902
>   create mode 100644 tests/xfs/902.out
> 


