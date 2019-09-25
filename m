Received: from mail-yw1-f68.google.com ([209.85.161.68]:44612 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411744AbfIYFWD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 01:22:03 -0400
MIME-Version: 1.0
References: <1569376448-53998-1-git-send-email-chengzhihao1@huawei.com>
 <20190925030550.GA9913@magnolia> <20190925031733.GB9913@magnolia> <46aa2daf-4c4a-ea74-2300-bb32fdfbdbcc@huawei.com>
In-Reply-To: <46aa2daf-4c4a-ea74-2300-bb32fdfbdbcc@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2019 08:21:50 +0300
Message-ID: <CAOQ4uxgmCy+VyNr28UczWR3wCLdD3HN5qDk6XwBdsB_2sn0WAQ@mail.gmail.com>
Subject: Re: [PATCH xfstests v2] overlay: Enable character device to be the
 base fs partition
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, Eryu Guan <guaneryu@gmail.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>, "zhangyi (F)" <yi.zhang@huawei.com>, fstests <fstests@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 25, 2019 at 6:27 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> There are indeed many '-b' options in xfstests. I only confirmed the line of overlay test. Other -b test options I need to reconfirm later.
>

FWIW, I eyeballed blockdev related overlayfs common code bits
and all I found out of order was:

@@ -3100,7 +3100,7 @@ _require_scratch_shutdown()
                        # SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
                        # will be null, so check OVL_BASE_SCRATCH_DEV before
                        # running shutdown to avoid shutting down base
fs accidently.
-                       _notrun "$SCRATCH_DEV is not a block device"
+                       _notrun "this test requires a valid
\$OVL_BASE_SCRATCH_DEV as ovl base fs"
                else
                        src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
                        || _notrun "Underlying filesystem does not
support shutdown"


Zhihaho,

That's all I meant in the nit.
The v1 commit message was perfectly fine, there was no need to change it at all.

Thanks,
Amir.
