Received: from mail-yb1-f174.google.com ([209.85.219.174]:35376 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbeHaSgk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 31 Aug 2018 14:36:40 -0400
MIME-Version: 1.0
References: <1513324055-77618-1-git-send-email-cgxu519@icloud.com>
 <1513324055-77618-3-git-send-email-cgxu519@icloud.com> <CAOQ4uxgf=btK-MKed7-8_nmpfO-UnPyVJ4RyTtK1hMQuU8Y=-g@mail.gmail.com>
 <63598ea1-8fd3-1003-a5b1-cb177a9380d8@gmx.com> <6c2125c0-5a89-4a67-7a2c-2bebe8dd5b7e@gmx.com>
In-Reply-To: <6c2125c0-5a89-4a67-7a2c-2bebe8dd5b7e@gmx.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 Aug 2018 17:28:43 +0300
Message-ID: <CAOQ4uxhu9rNBByXwZifcf=mmDekGwu8H4s8GsMrFMcanp-7A5Q@mail.gmail.com>
Subject: Re: problem with tune2fs after ext4 godown
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Chengguang Xu <cgxu519@gmx.com>
Cc: Chengguang Xu <cgxu519@icloud.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

[switching over to ext4 list]

On Fri, Aug 31, 2018 at 5:19 PM cgxu519 <cgxu519@gmx.com> wrote:
>
>
> Hi Amir,
>
> It seems godown will cause side effect on ext4/tune2fs, mount an ext4
> filesystem after running godown,
> then tune2fs -l <dev> complains like below. so definitely it will not
> pass d_type check.
>
>
> [root@x201 xfstests-dev]# tune2fs -l /dev/mapper/test-test1
> tune2fs 1.44.2 (14-May-2018)
> tune2fs: Superblock checksum does not match superblock while trying to
> open /dev/mapper/test-test1
> Couldn't find valid filesystem superblock.
>
>

Chengguang,

Bringing this to the attention of ext4 developers,
can you please re-iterate the reproducer (without the mention of
overlayfs and genereic/474) to demonstrate the problem.

And please try to avoid "top posting".

Thanks,
Amir.
