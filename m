Received: from mail-yb1-f193.google.com ([209.85.219.193]:41029 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfBYFVs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Feb 2019 00:21:48 -0500
Received: by mail-yb1-f193.google.com with SMTP id w74so2881621ybg.8
        for <fstests@vger.kernel.org>; Sun, 24 Feb 2019 21:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20190122032408.91336-1-zhengbin13@huawei.com> <20190224153954.GD2713@desktop>
 <ae68f006-3bf2-0b59-23cd-1a1f1e35fb18@huawei.com>
In-Reply-To: <ae68f006-3bf2-0b59-23cd-1a1f1e35fb18@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Feb 2019 07:21:36 +0200
Message-ID: <CAOQ4uxjvPUeEY=drBt=SoWPo7yK+yiYh3dbvMG+3YAWvTsJrfw@mail.gmail.com>
Subject: Re: [PATCH 0/6] squashfs: introduce squashfs support
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhengbin (A)" <zhengbin13@huawei.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>, Hou Tao <houtao1@huawei.com>, zhaohongjiang@huawei.com
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 25, 2019 at 3:33 AM zhengbin (A) <zhengbin13@huawei.com> wrote:
>
> Thanks for your reply.
>
> > I don't quite like the idea of "forking" random tests from 'generic' to
> > 'readonly'. The biggest benefit of adding new fs support to fstests is
> > that it shares most of the 'generic' tests and gets good test coverage.
> > But forking a very small subset of generic tests not only defeats the
> > benefit but also adding extra maintain burden
> --->I agree that, but if we want to add readonly filesystem support in fstests,
> maybe it is the best way?I didn't find a better way
>
> On 2019/2/24 23:39, Eryu Guan wrote:
> > [Sorry for being so long to review this squashfs support.]
> >
> > On Tue, Jan 22, 2019 at 11:24:02AM +0800, zhengbin wrote:
> >> This patch add squashfs support in xfstests-dev. Add two directories
> >> in tests directory, readonly can also be used for other readonly
> >> filesystem, squashfs is just used for squashfs filesystem.
> >> tests/readonly/001        mount test
> >> tests/readonly/002--010   metadata test
> >> tests/readonly/011--018   data test
> >> tests/readonly/019--021   xattr test
> >> tests/squashfs/001--005   mksquashfs options test
> >
> > I don't quite like the idea of "forking" random tests from 'generic' to
> > 'readonly'. The biggest benefit of adding new fs support to fstests is
> > that it shares most of the 'generic' tests and gets good test coverage.
> > But forking a very small subset of generic tests not only defeats the
> > benefit but also adding extra maintain burden.
> >
> > But the problem is that squashfs is a readonly filesystem and sharing
> > the existing generic tests is not easy. (Actually I've been looking at
> > this series several times, but couldn't come out with a good solution.)
> > Because fstests harness assumes the filesystem being tested is writable
> > by default, various _require rules also write/create files to check if a
> > functionality is supported by the underlying filesystem. This leads me
> > to wonder if fstests is suitable for such readonly filesystems?
> >
> > I'm glad to hear what do others think, any comments are welcomed!
> >

Maybe the problem is not the forking of readonly tests, but the fact that
these tests cannot be shared as is with other filesystems.
I know I once fixed a bug or two when ext4 was mounted on a readonly
blockdev (i.e. with ext4 snapshots).

readonly tests could be meaningful to other filesystems if constructed as:
_require_scratch_readonly_blkdev
_scratch_blkdev_setrw
_scratch_mkfs
_scratch_mount
setup()
_scratch_umount
_scratch_blkdev_setro
_scratch_mount_readonly_blkdev
test()

Of course for squashfs, _scratch_mount will be "mounting" a
scratch tmpdir and only _scratch_mount_readonly_blkdev
will really be mounting a squashfs.

Thanks,
Amir.
