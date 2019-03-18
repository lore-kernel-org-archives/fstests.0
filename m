Received: from szxga06-in.huawei.com ([45.249.212.32]:44122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbfCRMaw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 18 Mar 2019 08:30:52 -0400
Subject: Re: [PATCH 0/6] squashfs: introduce squashfs support
References: <20190122032408.91336-1-zhengbin13@huawei.com>
 <20190224153954.GD2713@desktop>
 <ae68f006-3bf2-0b59-23cd-1a1f1e35fb18@huawei.com>
 <CAOQ4uxjvPUeEY=drBt=SoWPo7yK+yiYh3dbvMG+3YAWvTsJrfw@mail.gmail.com>
From: "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <9462dff2-cecc-6656-600e-3d969ce68320@huawei.com>
Date: Mon, 18 Mar 2019 20:30:27 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjvPUeEY=drBt=SoWPo7yK+yiYh3dbvMG+3YAWvTsJrfw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>, Hou Tao <houtao1@huawei.com>, zhaohongjiang@huawei.com, gaoxiang25@huawei.com
List-ID: <fstests@vger.kernel.org>

Hi Eryu, What is the conclusion=EF=BC=9F
May be we could use Goldstein's advice, but If we use this, all of the te=
stcases need to be rewritten.

On 2019/2/25 13:21, Amir Goldstein wrote:
> On Mon, Feb 25, 2019 at 3:33 AM zhengbin (A) <zhengbin13@huawei.com> wr=
ote:
>>
>> Thanks for your reply.
>>
>>> I don't quite like the idea of "forking" random tests from 'generic' =
to
>>> 'readonly'. The biggest benefit of adding new fs support to fstests i=
s
>>> that it shares most of the 'generic' tests and gets good test coverag=
e.
>>> But forking a very small subset of generic tests not only defeats the
>>> benefit but also adding extra maintain burden
>> --->I agree that, but if we want to add readonly filesystem support in=
 fstests,
>> maybe it is the best way?I didn't find a better way
>>
>> On 2019/2/24 23:39, Eryu Guan wrote:
>>> [Sorry for being so long to review this squashfs support.]
>>>
>>> On Tue, Jan 22, 2019 at 11:24:02AM +0800, zhengbin wrote:
>>>> This patch add squashfs support in xfstests-dev. Add two directories
>>>> in tests directory, readonly can also be used for other readonly
>>>> filesystem, squashfs is just used for squashfs filesystem.
>>>> tests/readonly/001        mount test
>>>> tests/readonly/002--010   metadata test
>>>> tests/readonly/011--018   data test
>>>> tests/readonly/019--021   xattr test
>>>> tests/squashfs/001--005   mksquashfs options test
>>>
>>> I don't quite like the idea of "forking" random tests from 'generic' =
to
>>> 'readonly'. The biggest benefit of adding new fs support to fstests i=
s
>>> that it shares most of the 'generic' tests and gets good test coverag=
e.
>>> But forking a very small subset of generic tests not only defeats the
>>> benefit but also adding extra maintain burden.
>>>
>>> But the problem is that squashfs is a readonly filesystem and sharing
>>> the existing generic tests is not easy. (Actually I've been looking a=
t
>>> this series several times, but couldn't come out with a good solution=
.)
>>> Because fstests harness assumes the filesystem being tested is writab=
le
>>> by default, various _require rules also write/create files to check i=
f a
>>> functionality is supported by the underlying filesystem. This leads m=
e
>>> to wonder if fstests is suitable for such readonly filesystems?
>>>
>>> I'm glad to hear what do others think, any comments are welcomed!
>>>
>=20
> Maybe the problem is not the forking of readonly tests, but the fact th=
at
> these tests cannot be shared as is with other filesystems.
> I know I once fixed a bug or two when ext4 was mounted on a readonly
> blockdev (i.e. with ext4 snapshots).
>=20
> readonly tests could be meaningful to other filesystems if constructed =
as:
> _require_scratch_readonly_blkdev
> _scratch_blkdev_setrw
> _scratch_mkfs
> _scratch_mount
> setup()
> _scratch_umount
> _scratch_blkdev_setro
> _scratch_mount_readonly_blkdev
> test()
>=20
> Of course for squashfs, _scratch_mount will be "mounting" a
> scratch tmpdir and only _scratch_mount_readonly_blkdev
> will really be mounting a squashfs.
>=20
> Thanks,
> Amir.
>=20
> .
>=20
