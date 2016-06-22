Received: from mx4-phx2.redhat.com ([209.132.183.25]:42777 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcFVCVd convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 22:21:33 -0400
Date: Tue, 21 Jun 2016 21:42:53 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <241381551.489652.1466559773511.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160622000040.GF27480@dastard>
References: <1466429073-10124-1-git-send-email-zlang@redhat.com> <1466429073-10124-2-git-send-email-zlang@redhat.com> <20160621070818.GT5140@eguan.usersys.redhat.com> <20160622000040.GF27480@dastard>
Subject: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fail_at_unmount
 error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, sandeen@redhat.com, cem@redhat.com
List-ID: <fstests@vger.kernel.org>

Hi Dave

----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Eryu Guan" <eguan@redhat.com>
> =E6=8A=84=E9=80=81: "Zorro Lang" <zlang@redhat.com>, fstests@vger.kerne=
l.org, sandeen@redhat.com, cem@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 2016=
=E5=B9=B4 6 =E6=9C=88 22=E6=97=A5 =E4=B8=8A=E5=8D=88 8:00:40
> =E4=B8=BB=E9=A2=98: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fa=
il_at_unmount error handling
>=20
> On Tue, Jun 21, 2016 at 03:08:18PM +0800, Eryu Guan wrote:
> > On Mon, Jun 20, 2016 at 09:24:33PM +0800, Zorro Lang wrote:
> > > +# real QA test starts here
> > > +_supported_fs xfs
> > > +_supported_os Linux
> > > +_require_dm_target error
> > > +_require_scratch
> > > +
> > > +_scratch_mkfs > $seqres.full 2>&1
> > > +_require_fs_sysfs $SCRATCH_DEV error/fail_at_unmount
> >=20
> > Usually we call _require_xxx before mkfs and do the real test, a comm=
ent
> > to explain why we need to mkfs first would be good.
>=20
> Ok, so why do we need to test the scratch device for this
> sysfs file check? We've already got the test device mounted, and
> filesystems tend to present identical sysfs control files for all
> mounted filesystems.
>=20
> i.e. this _require_fs_sysfs() function could just drop the device
> and check the test device for whether the sysfs entry exists. If it
> doesn't, then the scratch device isn't going to have it, either.

Hmm... at first I thought about if I should use TEST_DEV to do _require_f=
s_sysfs
checking. But I'm not sure if different devices maybe bring different sys=
fs
attributes in, if someone make a special device in one case? So I give on=
e more
argument about device name.

>=20
> > > +# umount will cause XFS try to writeback something to root inode.
> > > +# So after load error table, it can trigger umount fail.
> > > +_dmerror_load_error_table
> > > +_dmerror_unmount
> >=20
> > Unmount still doesn't hang for me when I set fail_at_unmount to 0. Ma=
ybe
> > it's hard to hit the correct timing everytime.
>=20
> I wouldn't expect unmount to hang if you just "mount/pull
> device/unmount" like this test appears to be doing. The filesystem
> has to have dirty metadata for it to reliably hang. run a short
> fsstress load, pull the device while it is running, then unmount.

The umount doesn't hang because in _dmerror_load_error_table(), it use
"--nolockfs" option for dmsetup suspend operation. If drop this option,
umount will hang.

As I test, mount/pull device/unmount can cause a hang, because unmount wi=
ll
try to writeback something to root inode? But yes, do more fsstress load
can help to trigger the hang easier:)

I haven't known why "--nolockfs" will cause this situation. "--nolockfs" =
will
make suspend don't attempt to synchronize filesystem when suspending a de=
vice.
Maybe some uncompleted I/Os cause xfs shutdown, after resume error table?

If you glad to explain it for us, that's my pleasure:-)

Thanks,
Zorro

>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>
