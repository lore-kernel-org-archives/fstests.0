Received: from mail-pg1-f196.google.com ([209.85.215.196]:42022 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfIYJ3U (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 05:29:20 -0400
Date: Wed, 25 Sep 2019 17:29:13 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH xfstests v3] overlay: Enable character device to be the
 base fs partition
Message-ID: <20190925092913.GR2622@desktop>
References: <1569393333-128141-1-git-send-email-chengzhihao1@huawei.com>
 <CAOQ4uxjfko0+G_BUOt=fL1iTXdnWA=-=Kn-bgszF08g7yj4zqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjfko0+G_BUOt=fL1iTXdnWA=-=Kn-bgszF08g7yj4zqQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>, "zhangyi (F)" <yi.zhang@huawei.com>, fstests <fstests@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 25, 2019 at 10:18:39AM +0300, Amir Goldstein wrote:
> On Wed, Sep 25, 2019 at 9:29 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> >
> > When running overlay tests using character devices as base fs partitions,
> > all overlay usecase results become 'notrun'. Function
> > '_overay_config_override' (common/config) detects that the current base
> > fs partition is not a block device and will set FSTYP to base fs. The
> > overlay usecase will check the current FSTYP, and if it is not 'overlay'
> > or 'generic', it will skip the execution.
> >
> > For example, using UBIFS as base fs skips all overlay usecases:
> >
> >   FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
> >   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
> >   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
> >
> >   overlay/001   [not run] not suitable for this filesystem type: ubifs
> >   overlay/002   [not run] not suitable for this filesystem type: ubifs
> >   overlay/003   [not run] not suitable for this filesystem type: ubifs
> >
> > When checking that the base fs partition is a block/character device,
> > FSTYP is overwritten as 'overlay'. This patch allows the base fs
> > partition to be a character device that can also execute overlay
> > usecases (such as ubifs).
> >
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> Looks fine.
> Eryu, you may change this to Reviewed-by

Sure, thanks for the review!

Eryu
