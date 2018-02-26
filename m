Received: from szxga06-in.huawei.com ([45.249.212.32]:50153 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751945AbeBZCLR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 25 Feb 2018 21:11:17 -0500
Subject: Re: [PATCH] fsck.overlay: add ovl_check_origin helper
References: <20180223120106.32921-1-yangerkun@huawei.com>
 <CAOQ4uxj7Bg5vjoCtke=R1D3aG73rNRg_hKJofkJWk0vjfcxyMw@mail.gmail.com>
 <733feaf3-0885-b57d-674d-2ebcb963484a@huawei.com>
 <CAOQ4uxg3G=V7+eGMt8snHf0TFgfrYO2BLdyKPHUHqy=aQh=fKw@mail.gmail.com>
From: "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <7921d87b-daaa-e436-8464-9ab1203fd8f7@huawei.com>
Date: Mon, 26 Feb 2018 10:10:55 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg3G=V7+eGMt8snHf0TFgfrYO2BLdyKPHUHqy=aQh=fKw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>, yangerkun <yangerkun@huawei.com>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Eryu Guan <eguan@redhat.com>, Miao Xie <miaoxie@huawei.com>, zhaohongjiang@huawei.com
List-ID: <fstests@vger.kernel.org>

On 2018/2/25 2:46, Amir Goldstein wrote:
> On Sat, Feb 24, 2018 at 11:36 AM, yangerkun <yangerkun@huawei.com> wrot=
e:
>>
>>
>> On 2/24/2018 3:43 PM, Amir Goldstein wrote:
>>>
>>> On Fri, Feb 23, 2018 at 2:01 PM, yangerkun <yangerkun@huawei.com> wro=
te:
>>>>
>>>> For origin xattr, use fid in ovl_fh to consume file_handle, and use
>>>> open_by_handle_at to check validity of the origin ovl_fh. In auto mo=
de,
>>>> the invalid origin xattr will remove automatic.
>>>>
>>>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>>>> ---
> [...]
>>>> +
>>>> +/*
>>>> + * Check the validity of ovl_fh.
>>>> + */
>>>> +int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
>>>> +{
>>>> +       if (fh_len < sizeof(struct ovl_fh) || fh_len < fh->len)
>>>> +               return -EINVAL;
>>>> +
>>>> +       if (fh->magic !=3D OVL_FH_MAGIC)
>>>> +               return -EINVAL;
>>>> +
>>>> +       if (fh->version > OVL_FH_VERSION || fh->flags & ~OVL_FH_FLAG=
_ALL)
>>>> +               return -ENODATA;
>>>> +
>>>> +       if (!(fh->flags & OVL_FH_FLAG_ANY_ENDIAN) &&
>>>> +           (fh->flags & OVL_FH_FLAG_BIG_ENDIAN) !=3D
>>>> OVL_FH_FLAG_CPU_ENDIAN)
>>>> +               return -ENODATA;
>>>> +
>>>
>>>
>>> Overlayfs approach to unrecognized ovl_fh on-disk format is very
>>> naiive borderline buggy.
>>> When endian/flags/version check fails, origin is treated as "unknown"
>>> and that is fine as
>>> long as the only implication is change of inode number.
>>> But when checking that origin of upper root matches lower root for
>>> index feature, treating
>>> unrecognized ovl_fh format as unknown will result in overwriting the
>>> root origin and as
>>> far as I can tell, this is a bug.
>>>
>>> The situation with fsck.overlayfs is even worse IMO, because running
>>> an old fsck tools
>>> is even more easy to get wrong than mounting an overlayfs with an old
>>> kernel.
>>> In general fsck.* tools, like e2fsck, are more prudent about fixing a
>>> filesystem
>>> with unknown on-disk format than the kernel about mounting filesystem
>>> with unknown
>>> on-disk format features.
>>>
>>> This patch specifically does not seem to do any harm when encounterin=
g
>>> unknown
>>> on-disk format of ovl_fh, but I think fsck.overlay should take some
>>> extra steps for
>>> safety, before fixing overlayfs with features that fsck.overlay does
>>> not support.
>>>
>>> I suggest at least the following safely checks on start of fsck.overl=
ay:
>>> - Check if index dir exists in workdir
>>> - Check if upperdir root has an unrecognized origin xattr format
>>> - Check if index dir root has an unrecognized origin xattr format
>>>
>>> If any of the checks above is positive, fsck.overlay should issue a
>>> warning
>>> and refuse to fix fielsystem. Running with -n -f is allowed.
>>> See if index dir exists, then removing origin xattr can corrupt the i=
ndex.
>>> When fsck.overlay gains the knowledge about checking and fixing index=
,
>>> user would opt-in to checking an overlayfs with index by -o index=3Do=
n
>>
>>
>> When compile the kernel, we can choose the default config about overla=
y,
>> which user won't get. So, user may choose the fault arguments like
>> "fsck.overlay -olower..." while index xattr is on when there is really
>> overlayfs. Other filesystems can get xattr from superblock in disk, bu=
t we
>> cannot use this way in overlay. So, how to deal with this=EF=BC=9F
>>
>>
>=20
> The kernel default options for overlayfs mount really does not matter f=
or
> fsck.overlay. The only thing that matters is to detect whether the laye=
rs
> were *ever* mounted by a kernel which enabled features that fsck.overla=
y
> does not support.
>=20
> The current state of fsck.overlay is:
> - supports redirect feature
> - does not support any other feature including upstream features index =
and
> nfs_export and future features like metacopy.
>=20
> A filesystem repair tool should NOT fix the filesystem if it detects on=
-disk
> format that it does not recognize.
>=20
> That means among other things for overlayfs that if an xattr if found o=
n any
> file by the name of trusted.overlay.<something> and <something> is not =
a
> an expected name, then fsck.overlay should shout that it does not
> recognize the on-disk format (print out the unrecognized xattr name) an=
d
> refuse to continue.
>=20
> The problem with overlayfs compares to traditional filesystems is the l=
ack
> of "feature bits" in the "super block", so there is no O(1) test for un=
supported
> features, but they still can be detected.
>=20
> Contrary to the example above, there is a simple O(1) test to check if
> overlayfs was mounted with index feature enabled - the existence of a
> non empty $workdir/index dir is de-facto a "feature bit" and until fsck=
.overlay
> knows how to verify and fix overlayfs without corrupting the index it s=
hould
> refuse to fix an overlay filesystem with an index.
>=20

Maybe we can store "feature bit" in upper root xattr or somewhere else in=
 workdir
after we implement mkfs.overlay, and classify them into compat and incomp=
at
features, we can use old fsck.overlay to fix the filesystem if there is n=
o
unrecognized incompat feature.

Before this, the index dir can be treated as a kind of "unrecognized inco=
mpat
feature", so the "simple O(1) test" can works well, but how can we handle
another incompat feature tomorrow? Should we implement mkfs.overlay befor=
e the
first release version of fsck.overlay?

Thanks,
Yi.

> The options that will be passed to fsck.overlay (i.e.
> redirect_dir=3Doff, index-on)
> will not mean that  fsck.overlay should or should not check redirects/i=
ndex.
> They will mean something like:
> index=3Don - reconstruct index for copied up hardlinks
> redirect_dir=3Doff - remove all redirects and recursively "move" all
> copied up files.
>=20
> Thanks,
> Amir.
>=20
> .
>=20

