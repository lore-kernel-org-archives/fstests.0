Received: from smtpbg299.qq.com ([184.105.67.99]:44225 "EHLO smtpbg299.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753155AbdLDGMj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 4 Dec 2017 01:12:39 -0500
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
From: Chengguang Xu <cgxu@mykernel.net>
In-Reply-To: <CAOQ4uxj4kBygrqA44OPCoJ4qRFFF_hPSeY8DL=Y8DA_eTa=p4Q@mail.gmail.com>
Date: Mon, 4 Dec 2017 14:05:16 +0800
Message-Id: <226EEED1-8707-485D-BEE8-45DBB4D4F670@mykernel.net>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
 <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net>
 <20171201041301.GB2749@eguan.usersys.redhat.com>
 <DF0589AC-18BE-495E-8DFD-54F0690CC8E7@mykernel.net>
 <CAOQ4uxgOyPy9w96_HaUtM1thHcajn1LuHkiFSOtMZw0f-=HR8g@mail.gmail.com>
 <20171201214320.GU4094@dastard>
 <CAOQ4uxg5RfRXATfcBK3CRouioEDwu_RpqxPLry2fyp8Qq0RdjQ@mail.gmail.com>
 <20171202214030.GW4094@dastard>
 <CAOQ4uxj4kBygrqA44OPCoJ4qRFFF_hPSeY8DL=Y8DA_eTa=p4Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>


>=20
> =D4=DA 2017=C4=EA12=D4=C23=C8=D5=A3=AC=CF=C2=CE=E72:45=A3=ACAmir Goldst=
ein <amir73il@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Sat, Dec 2, 2017 at 11:40 PM, Dave Chinner <david@fromorbit.com> wro=
te:
>> On Sat, Dec 02, 2017 at 12:43:18PM +0200, Amir Goldstein wrote:
>>> On Fri, Dec 1, 2017 at 11:43 PM, Dave Chinner <david@fromorbit.com> w=
rote:
> [...]
>=20
>>=20
>> Implement FS_IOC_SHUTDOWN on overlay, then you can test it via
>> software controlled shutdown. i.e. make overlay return true for
>> _require_scratch_shutdown() and implement what is needed to shut it
>> all down and prevent further writes of dirty inodes. Thens do
>> data/metadata checks after a shutdown/unmount/mount cycle. Then
>> what you have on disk after the mount cycle is what was written by
>> sync/fsync/syncfs...
>>=20
>> We've only been using this shutdown mechanism to test fsync/sync
>> mechanisms on XFS for ~20 years.
>>=20
>=20
> All right.
> We don't need to implement FS_IOC_SHUTDOWN on overlay, we
> only need to shutdown upper fs if upper fs supports shutdown.
> Doing that would be the equivalent of a dm-flakey test for a blokdev fs=
,
> because upper fs is the only persistent storage of overlayfs.
> Thanks for the advice.
>=20
> Chengguang,
>=20
> I propose that you teach _require_scratch_shutdown about
> OVL_BASE_SCRATCH_MNT and write and overlay/* test
> that tests syncfs by shutting down upper fs if upper fs supports shutdo=
wn.

OK, let me try this way, for data correctness I=A1=AFll use stat & md5_ch=
ecksum.
Is there anything else should I add for checking?

>=20
> It doesn't matter much that the test won't run on all underlying fs as =
long
> as a regression will be caught by someone running overlay tests over
> xfs/ext4.
>=20
> Cheers,
> Amir.
>=20

