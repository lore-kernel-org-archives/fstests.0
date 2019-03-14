Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48294 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbfCNIrF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Mar 2019 04:47:05 -0400
From: Yihao Wu <wuyihao@linux.alibaba.com>
Subject: Why generic/089 fails for NFSv4
Message-ID: <385c37ee-c0b9-2c87-0132-891726033b6a@linux.alibaba.com>
Date: Thu, 14 Mar 2019 16:46:43 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

Hi, all

Sorry to bother you.

lock_mtab in xfstests/src/t_mtab.c waits only for LOCK_TIMEOUT, which is 10.
After that it emits an error message. However when NFSv4 client fails to
lock a file in nfs4_retry_setlk (eg. locking conflict), it backs off for 30s
before retrying. So generic/089 frequently fails for NFSv4.

I'm wondering if there's a workaround to this problem. My kernel version is
4.19.24

Thanks,
Yihao Wu
