Received: from mail-pg1-f194.google.com ([209.85.215.194]:45581 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1SwF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Sep 2018 14:52:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so4353998pgd.12
        for <fstests@vger.kernel.org>; Fri, 28 Sep 2018 05:28:32 -0700 (PDT)
Date: Fri, 28 Sep 2018 20:28:23 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: add a testcase to test uid/gid recovery
Message-ID: <20180928122823.GG17817@desktop>
References: <20180925084558.77190-1-yuchao0@huawei.com>
 <ab6235fd-ea62-59d4-246c-9b73bc3983f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6235fd-ea62-59d4-246c-9b73bc3983f3@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 25, 2018 at 05:16:31PM +0800, Chao Yu wrote:
> Hi Eryu,
> 
> There are several fields in inode rather than uid/gid didn't recover in
> f2fs, I'm not sure we need to cover all of them with one generic testcase,
> or with several testcases. Any suggestion?

Sorry for the late response!

Several targeted test cases would be fine.

Thanks,
Eryu
