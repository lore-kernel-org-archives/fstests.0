Received: from mail-yw1-f66.google.com ([209.85.161.66]:41608 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPR5c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Oct 2018 13:57:32 -0400
Received: by mail-yw1-f66.google.com with SMTP id 135-v6so8667202ywo.8
        for <fstests@vger.kernel.org>; Tue, 16 Oct 2018 03:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181016074559.24728-1-yi.zhang@huawei.com> <20181016074559.24728-4-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-4-yi.zhang@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Oct 2018 13:07:39 +0300
Message-ID: <CAOQ4uxj_6CA1thOwwXOCtgZ3+oBW9g_sH=RY-Np5CmJkdH_+vA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] overlay: add fsck.overlay stress test
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 16, 2018 at 10:32 AM zhangyi (F) <yi.zhang@huawei.com> wrote:
>
> Introduce a test case for fsck.overlay which runs on the underlying
> directories created by fsstress (contain a lot of fs objects) to
> find potential stability issue.
>

Looks good.
Did it help you find any stability issues?

Thanks,
Amir.
