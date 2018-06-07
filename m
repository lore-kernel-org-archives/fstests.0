Received: from mail-pl0-f49.google.com ([209.85.160.49]:45903 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeFGFkE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jun 2018 01:40:04 -0400
Date: Thu, 7 Jun 2018 13:39:57 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/rc: skip atime related tests on CIFS
Message-ID: <20180607053957.GC2861@desktop>
References: <1526959436-7170-1-git-send-email-xifeng@redhat.com>
 <20180527125058.GC6581@desktop>
 <246296494.4735384.1527489656588.JavaMail.zimbra@redhat.com>
 <529728696.4429280.1527550001433.JavaMail.zimbra@redhat.com>
 <CAH2r5msb92E2e7gePY01qBPP4fJ0CKcEsnKLdnL1Ms8cUaQ4sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5msb92E2e7gePY01qBPP4fJ0CKcEsnKLdnL1Ms8cUaQ4sA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Steve French <smfrench@gmail.com>, Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Xiaoli Feng <xifeng@redhat.com>, fstests@vger.kernel.org, linux-cifs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 28, 2018 at 11:11:02PM -0500, Steve French wrote:
> Agreed but I do want to follow up with Ronnie on loosely related questi=
on of
> how cifs and NFS and similar filesystems parse no op mount options like=
 noatime

I take this as an ACK then, please let me know if you didn't really mean
that :)

Thank you both for review!

Eryu

>=20
> On Mon, May 28, 2018, 22:55 Ronnie Sahlberg <lsahlber@redhat.com> wrote=
:
>=20
>     Hi Xiaoli,
>=20
>     I think it is fine to skip the atime tests for CIFS.
>=20
>     The behaviour of atime/noatime for cifs is basically noatime always.
>     When we read from the server the server will update the atime indep=
endently
>     of
>     cisf.ko but then any further reads that we do from cache will never=
 push
>     any updates
>     to the server.
>=20
>     Ronnie
>=20
>     ----- Original Message -----
>     > From: "Xiaoli Feng" <xifeng@redhat.com>
>     > To: "Eryu Guan" <guaneryu@gmail.com>, "Leif Sahlberg" <
>     lsahlber@redhat.com>
>     > Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org
>     > Sent: Monday, 28 May, 2018 4:40:56 PM
>     > Subject: Re: [PATCH] common/rc: skip atime related tests on CIFS
>     >
>     > Add Ronnie to to list.
>     >
>     > Hello Ronnie,
>     >=C2=A0 =C2=A0what's the expected behavior from CIFS on atime/noati=
me? We want to
>     skip
>     >=C2=A0 =C2=A0the
>     > atime related tests on cifs for xfstests just like nfs. But not s=
ure if
>     it's
>     > correct. What do you think about it?
>     >
>     > Thanks.
>     >
>     > ----- Original Message -----
>     > > From: "Eryu Guan" <guaneryu@gmail.com>
>     > > To: "XiaoLi Feng" <xifeng@redhat.com>
>     > > Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org
>     > > Sent: Sunday, May 27, 2018 8:50:58 PM
>     > > Subject: Re: [PATCH] common/rc: skip atime related tests on CIF=
S
>     > >
>     > > On Tue, May 22, 2018 at 11:23:56AM +0800, Xiaoli Feng wrote:
>     > > > From: xiaoli feng <xifeng@redhat.com>
>     > > >
>     > > > The atime related mount options have no effect on cifs mounts
>     > > > now or in the future. So skip these tests on CIFS.
>     > > >
>     > > > Signed-off-by: xiaoli feng <xifeng@redhat.com>
>     > >
>     > > Looks fine to me. But I really need an ACK from cifs folks.
>     > >
>     > > > ---
>     > > >=C2=A0 common/rc | 2 ++
>     > > >=C2=A0 1 file changed, 2 insertions(+)
>     > > >
>     > > > diff --git a/common/rc b/common/rc
>     > > > index ffe5323..d3af55f 100644
>     > > > --- a/common/rc
>     > > > +++ b/common/rc
>     > > > @@ -3244,6 +3244,8 @@ _require_atime()
>     > > >=C2=A0 =C2=A0_exclude_scratch_mount_option "noatime"
>     > > >=C2=A0 =C2=A0if [ "$FSTYP" =3D=3D "nfs" ]; then
>     > > >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_notrun "atime relate=
d mount options have no effect on NFS"
>     > > > + elif [ "$FSTYP" =3D=3D "cifs" ]; then
>     > > > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_notrun "atime related mou=
nt options have no effect on
>     CIFS"
>     > >
>     > > Or just change the check to a case-switch on $FSTYP?
>     >
>     > Ok, I will change it on the next commit.
>     > Thanks!
>     >
>     > >
>     > > Thanks,
>     > > Eryu
>     > >
>     > > >=C2=A0 =C2=A0fi
>     > > >=C2=A0 }
>     > > >=C2=A0
>     > > > --
>     > > > 1.8.3.1
>     > > >
>     > > > --
>     > > > To unsubscribe from this list: send the line "unsubscribe fst=
ests" in
>     > > > the body of a message to majordomo@vger.kernel.org
>     > > > More majordomo info at=C2=A0 http://vger.kernel.org/majordomo=
-info.html
>     > > --
>     > > To unsubscribe from this list: send the line "unsubscribe fstes=
ts" in
>     > > the body of a message to majordomo@vger.kernel.org
>     > > More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-i=
nfo.html
>     > >
>     > --
>     > To unsubscribe from this list: send the line "unsubscribe fstests=
" in
>     > the body of a message to majordomo@vger.kernel.org
>     > More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-inf=
o.html
>     >
>     --
>     To unsubscribe from this list: send the line "unsubscribe linux-cif=
s" in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.=
html
>=20
