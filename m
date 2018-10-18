Received: from szxga05-in.huawei.com ([45.249.212.191]:13670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbeJRLmF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Oct 2018 07:42:05 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 936D02C0453DF
        for <fstests@vger.kernel.org>; Thu, 18 Oct 2018 11:42:57 +0800 (CST)
Subject: Re: [PATCH v2 2/4] overlay: fix exit code for some fsck.overlay valid
 cases
References: <20181016074559.24728-1-yi.zhang@huawei.com>
 <20181016074559.24728-3-yi.zhang@huawei.com>
 <CAOQ4uxhJRxMqMzMn_zm+1LyaAUuRmMmr=YNPshX7U2MAUTtmYw@mail.gmail.com>
From: "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <c3b4ba3b-001d-ad70-445f-f0c1ce5d17f0@huawei.com>
Date: Thu, 18 Oct 2018 11:42:52 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhJRxMqMzMn_zm+1LyaAUuRmMmr=YNPshX7U2MAUTtmYw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On 2018/10/16 17:26, Amir Goldstein Wrote:
> On Tue, Oct 16, 2018 at 10:32 AM zhangyi (F) <yi.zhang@huawei.com> wrot=
e:
>>
>> Some valid test cases about fsck.overlay may be not valid enough now,
>> they lose the impure xattr on the parent directory of the simluated
>> redirect directory, and lose the whiteout which use to cover the origi=
n
>> lower object. Then fsck.overlay will fix these two inconsistency which
>> are not those test cases want to cover, thus it will lead to
>> fsck.overlay return FSCK_NONDESTRUCT instead of FSCK_OK. Fix these by
>> complement the missing overlay related features.
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> ---
>=20
> Ok. I think it's fine if we merge this fix now, but this way it is goin=
g
> to be quite hard to maintain this test.
>=20
> Imagine every time that you add another feature to fsck.overlay,
> say "add overlay features xattr", fsck will start returning FSCK_NONDES=
TRUCT
> and break this test.
>=20
> Perhaps it would have been better to construct the test cases by:
> - mount overlay
> - create some copied up/ redirected  dirs and whiteouts
> - umount overlay
> - make minor modifications to upper/lower layer
> - run fsck
>=20
> Then you wouldn't need to worry about things like impure parent dir
> and future overlay features.
>=20
> I will leave it to you to decide if you want to fix this now or the
> next time around...
>=20

Indeed, I thought about this choice. If we create overlay on-disk feature=
s
(xattrs=EF=BC=8Cwhiteouts...) through overlayfs, the fsck tests results b=
ecomes
non-independent. It will depends on the kernel (overlayfs module) user ar=
e
running the test. Imaging if user want to test the latest fsck.overlay
on the old kernel which contains a compatible feature xattr fsck.overlay
know but the kernel don't, we will get the unexpected result. Or maybe
we can add some _require_xxx_feature() helper to enforce user doing test
on the kernel which supports the specified feature?

Thanks,
Yi.
