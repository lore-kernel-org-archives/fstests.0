Received: from mail-yb0-f196.google.com ([209.85.213.196]:36072 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeG3H3p (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jul 2018 03:29:45 -0400
MIME-Version: 1.0
In-Reply-To: <20180728084242.33918-1-yi.zhang@huawei.com>
References: <20180728084242.33918-1-yi.zhang@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Jul 2018 08:56:25 +0300
Message-ID: <CAOQ4uxjoDK2Pm53gCv-g1h1RHDfWSeQpR4aFCs2ZgAMJX1M+cw@mail.gmail.com>
Subject: Re: [xfstests PATCH 0/3] overlay: enhance fsck.overlay test cases
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>, yangerkun <yangerkun@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Jul 28, 2018 at 11:42 AM, zhangyi (F) <yi.zhang@huawei.com> wrote:
> Hi All,
>
> These are fsck.overlay program related patch set. The first patch correct
> the exit code of fsck.overlay in the existing 3 test cases, the second
> patch introduce a stress case to test stability, and the final patch add
> some exception cases to test exception handling process of fsck.overlay.
>
> The fsck.overlay program also was undate at:
>
> https://github.com/hisilicon/overlayfs-progs/tree/next
>
> All these three patches have been tested with the new fsck.overlay,
> please review.
>

So if Eryu tests your changes without updating to new fsck.overlay,
tests will start to fail. Is that the expected behavior?

Right now it may not be a big nuisance, but you should declare which
is "the official" version of fsck.overlay to test with xfstest -
is it next? master?
Probably best if you ask Eryu to hold back on merging changes not
compatible with current fsck.overlay master, until the master branch
is updated and would be useful to ANNOUNCE the overlayfs-progs
updates to the list with the gist of changes.

Thanks,
Amir.
