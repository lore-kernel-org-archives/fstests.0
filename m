Received: from mail.cn.fujitsu.com ([183.91.158.132]:25764 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730688AbeISPHe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Sep 2018 11:07:34 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 7304B4B41ED3
        for <fstests@vger.kernel.org>; Wed, 19 Sep 2018 17:30:23 +0800 (CST)
Message-ID: <5BA2172F.4030403@cn.fujitsu.com>
Date: Wed, 19 Sep 2018 17:30:23 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: The problem of generic/465 in xfs filesystem
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi all,
 
On RHEL7.5, running generic/465 with xfs should fail because the fix patch[1] is not merged.  But on my
environment[3], since the patch set[2] designed to fix generic/450 is ported into RHEL7.5, generic/465
turns into pass on my environment.
 
I discover that various combinations of cpu and memory can lead to different results of generic/465.
On environment[4], generic/465 fails.  
On environment[5], generic/465 passes.
On other environment[6], generic/465 always fails.
 
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee70daaba82d70766d0723b743d9fdeb3b06102a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74cedf9b6c603f2278a05bc91b140b32b434d0b5
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d4594acbf6d8f75a27f3578476b6a27d8b13ebb 
[3] OS Version: RHEL7.5(including Alpha, Beta, GA)
    CPU Info: Intel(R) Core(TM)2 Duo CPU E7500  @ 2.93GHz
    Number of Processor: 2
    Memory Info: 2048M/4096M
[4] OS Version: RHEL7.4GA
    CPU Info: Intel(R) Core(TM)2 Duo CPU E7500  @ 2.93GHz
    Number of Processor: 2
    Memory Info: 4096M
[5] OS Version: RHEL7.4GA
    CPU Info: Intel(R) Core(TM)2 Duo CPU E7500  @ 2.93GHz
    Number of Processor: 2
    Memory Info: 2048M
[6] OS Version: RHEL7.5(including Alpha, Beta, GA)
    CPU Info: Intel(R) Core(TM) i3-2120 CPU @ 3.30GHz/Intel(R) Core(TM) i5-3470 CPU @ 3.20GHz
    Number of Processor: 2
    Memory Info: 2048M/4096M
 
It seems that eithor various combinations of cpu and memory or the fix patch set [2] can lead to different
results of generic/465, I am not sure which is the real cause of this issue. 
 
The issue was reported by Yang Xu (xuyang.jy@cn.fujitsu.com)

Thanks,
Xiao Yang
