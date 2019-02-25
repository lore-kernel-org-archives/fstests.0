Received: from mail-yw1-f68.google.com ([209.85.161.68]:40695 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBYGqE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Feb 2019 01:46:04 -0500
Received: by mail-yw1-f68.google.com with SMTP id c67so3248346ywa.7
        for <fstests@vger.kernel.org>; Sun, 24 Feb 2019 22:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20190122032408.91336-1-zhengbin13@huawei.com> <20190224153954.GD2713@desktop>
 <ae68f006-3bf2-0b59-23cd-1a1f1e35fb18@huawei.com> <CAOQ4uxjvPUeEY=drBt=SoWPo7yK+yiYh3dbvMG+3YAWvTsJrfw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjvPUeEY=drBt=SoWPo7yK+yiYh3dbvMG+3YAWvTsJrfw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Feb 2019 08:45:53 +0200
Message-ID: <CAOQ4uxg2M6+QFGdgB9o2UKbRbYH_PixpcNwWoGHkkSXOnoEj6A@mail.gmail.com>
Subject: Re: [PATCH 0/6] squashfs: introduce squashfs support
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhengbin (A)" <zhengbin13@huawei.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>, Hou Tao <houtao1@huawei.com>, zhaohongjiang@huawei.com
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 25, 2019 at 7:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Feb 25, 2019 at 3:33 AM zhengbin (A) <zhengbin13@huawei.com> wrote:
> >
> > Thanks for your reply.
> >
> > > I don't quite like the idea of "forking" random tests from 'generic' to
> > > 'readonly'. The biggest benefit of adding new fs support to fstests is
> > > that it shares most of the 'generic' tests and gets good test coverage.
> > > But forking a very small subset of generic tests not only defeats the
> > > benefit but also adding extra maintain burden
> > --->I agree that, but if we want to add readonly filesystem support in fstests,
> > maybe it is the best way?I didn't find a better way
> >
> > On 2019/2/24 23:39, Eryu Guan wrote:
> > > [Sorry for being so long to review this squashfs support.]
> > >
> > > On Tue, Jan 22, 2019 at 11:24:02AM +0800, zhengbin wrote:
> > >> This patch add squashfs support in xfstests-dev. Add two directories
> > >> in tests directory, readonly can also be used for other readonly
> > >> filesystem, squashfs is just used for squashfs filesystem.
> > >> tests/readonly/001        mount test
> > >> tests/readonly/002--010   metadata test
> > >> tests/readonly/011--018   data test
> > >> tests/readonly/019--021   xattr test
> > >> tests/squashfs/001--005   mksquashfs options test
> > >
> > > I don't quite like the idea of "forking" random tests from 'generic' to
> > > 'readonly'. The biggest benefit of adding new fs support to fstests is
> > > that it shares most of the 'generic' tests and gets good test coverage.
> > > But forking a very small subset of generic tests not only defeats the
> > > benefit but also adding extra maintain burden.
> > >
> > > But the problem is that squashfs is a readonly filesystem and sharing
> > > the existing generic tests is not easy. (Actually I've been looking at
> > > this series several times, but couldn't come out with a good solution.)
> > > Because fstests harness assumes the filesystem being tested is writable
> > > by default, various _require rules also write/create files to check if a
> > > functionality is supported by the underlying filesystem. This leads me
> > > to wonder if fstests is suitable for such readonly filesystems?
> > >
> > > I'm glad to hear what do others think, any comments are welcomed!
> > >
>
> Maybe the problem is not the forking of readonly tests, but the fact that
> these tests cannot be shared as is with other filesystems.
> I know I once fixed a bug or two when ext4 was mounted on a readonly
> blockdev (i.e. with ext4 snapshots).
>
> readonly tests could be meaningful to other filesystems if constructed as:
> _require_scratch_readonly_blkdev
> _scratch_blkdev_setrw
> _scratch_mkfs
> _scratch_mount
> setup()
> _scratch_umount
> _scratch_blkdev_setro
> _scratch_mount_readonly_blkdev
> test()
>
> Of course for squashfs, _scratch_mount will be "mounting" a
> scratch tmpdir and only _scratch_mount_readonly_blkdev
> will really be mounting a squashfs.
>

Yet another option is to make these tests about filesystems
that require "_scratch_mkfs_from_tmpdir".
I know ext4 has this tool used for creating an Android read-only
and compact system image, not sure if e2fsprogs has a similar
functionality. I remember reading about similar functionality for
mkfs.xfs.

Some overlayfs tests might possibly be generalized with this
format, because preparing the lower layer can be replaced by
copying file from tmpdir to lower layer on _scratch_mkfs_from_tmpdir.
This could also be a direction towards supporting -overlay tests
with squashfs, which is a rather common combination in the wild
(OpenWRT AFAIK).

Thanks,
Amir.
