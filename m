Received: from mail-pl0-f66.google.com ([209.85.160.66]:33860 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeCPEEy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Mar 2018 00:04:54 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so1525298plq.1
        for <fstests@vger.kernel.org>; Thu, 15 Mar 2018 21:04:54 -0700 (PDT)
Date: Fri, 16 Mar 2018 12:04:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: Reproducible hang in generic/430 test with latest mainline kernel
Message-ID: <20180316040423.GO30836@localhost.localdomain>
References: <CAMy_GT_VxnTVN=7VHGdPwWk7N44d7o9rqHNRrJLKHj3Z9dY7Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy_GT_VxnTVN=7VHGdPwWk7N44d7o9rqHNRrJLKHj3Z9dY7Pg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 16, 2018 at 11:21:20AM +0800, Po-Hsu Lin wrote:
> Hello,
> 
> I'm experiencing the test hang issue caused by test generic/430 with
> ext4/xfs/btrfs partition created on /dev/sdb

I didn't see the hang on my Fedora host with 4.16-rc5 kernel. I tested
ext4/xfs/btrfs too, all passed quickly.

Thanks,
Eryu
