Received: from mx5-phx2.redhat.com ([209.132.183.37]:49012 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcFVDQN convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 23:16:13 -0400
Date: Tue, 21 Jun 2016 23:15:45 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <529685578.497532.1466565345726.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160622030422.GI27480@dastard>
References: <1466429073-10124-1-git-send-email-zlang@redhat.com> <1466429073-10124-2-git-send-email-zlang@redhat.com> <20160621070818.GT5140@eguan.usersys.redhat.com> <20160622000040.GF27480@dastard> <241381551.489652.1466559773511.JavaMail.zimbra@redhat.com> <20160622030422.GI27480@dastard>
Subject: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fail_at_unmount
 error handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, sandeen@redhat.com, cem@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zirong Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: "Eryu Guan" <eguan@redhat.com>, fstests@vger.kernel=
.org, sandeen@redhat.com, cem@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 2016=
=E5=B9=B4 6 =E6=9C=88 22=E6=97=A5 =E4=B8=8A=E5=8D=88 11:04:22
> =E4=B8=BB=E9=A2=98: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fa=
il_at_unmount error handling
>=20
> On Tue, Jun 21, 2016 at 09:42:53PM -0400, Zirong Lang wrote:
> > The umount doesn't hang because in _dmerror_load_error_table(), it us=
e
> > "--nolockfs" option for dmsetup suspend operation. If drop this optio=
n,
> > umount will hang.
> >=20
> > As I test, mount/pull device/unmount can cause a hang, because unmoun=
t will
> > try to writeback something to root inode? But yes, do more fsstress l=
oad
> > can help to trigger the hang easier:)
> >=20
> > I haven't known why "--nolockfs" will cause this situation. "--nolock=
fs"
> > will
> > make suspend don't attempt to synchronize filesystem when suspending =
a
> > device.
> > Maybe some uncompleted I/Os cause xfs shutdown, after resume error ta=
ble?
>=20
> when dm loads the new table, it first suspends the device. This
> freezes the filesystem, which means it completely clean. Hence after
> this there is nothing to write back on unmount and it doesn't hang.
>=20
> Using --nolockfs means dm does not suspend the device and hence the
> filesystem is not frozen before loading the new table. That means
> unmount occurs with dirty metadata still in memory, and so umount
> will try to write it and behaviour is then determined by the sysfs

No, no, I think there're some misunderstand. Looks like you thought with
--nolockfs umount will hang. But the truth is:

When fail_at_unmount=3D0,
  Without --nolockfs option, umount will hang(fail_at_unmount=3D0).
  With --nolockfs option, umount will not hang.

Thanks,
Zorro

> attribute.
>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
