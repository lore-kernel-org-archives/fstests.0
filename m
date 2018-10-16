Received: from mail-yw1-f65.google.com ([209.85.161.65]:33884 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPRQE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Oct 2018 13:16:04 -0400
Received: by mail-yw1-f65.google.com with SMTP id m129-v6so8652284ywc.1
        for <fstests@vger.kernel.org>; Tue, 16 Oct 2018 02:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181016074559.24728-1-yi.zhang@huawei.com> <20181016074559.24728-3-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-3-yi.zhang@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Oct 2018 12:26:20 +0300
Message-ID: <CAOQ4uxhJRxMqMzMn_zm+1LyaAUuRmMmr=YNPshX7U2MAUTtmYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] overlay: fix exit code for some fsck.overlay valid cases
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 16, 2018 at 10:32 AM zhangyi (F) <yi.zhang@huawei.com> wrote:
>
> Some valid test cases about fsck.overlay may be not valid enough now,
> they lose the impure xattr on the parent directory of the simluated
> redirect directory, and lose the whiteout which use to cover the origin
> lower object. Then fsck.overlay will fix these two inconsistency which
> are not those test cases want to cover, thus it will lead to
> fsck.overlay return FSCK_NONDESTRUCT instead of FSCK_OK. Fix these by
> complement the missing overlay related features.
>
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---

Ok. I think it's fine if we merge this fix now, but this way it is going
to be quite hard to maintain this test.

Imagine every time that you add another feature to fsck.overlay,
say "add overlay features xattr", fsck will start returning FSCK_NONDESTRUCT
and break this test.

Perhaps it would have been better to construct the test cases by:
- mount overlay
- create some copied up/ redirected  dirs and whiteouts
- umount overlay
- make minor modifications to upper/lower layer
- run fsck

Then you wouldn't need to worry about things like impure parent dir
and future overlay features.

I will leave it to you to decide if you want to fix this now or the
next time around...

Thanks,
Amir.
