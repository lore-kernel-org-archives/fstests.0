Received: from mx5-phx2.redhat.com ([209.132.183.37]:59121 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbLICno convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 8 Dec 2015 21:43:44 -0500
Date: Tue, 8 Dec 2015 21:43:42 -0500 (EST)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <1388401159.33713787.1449629022222.JavaMail.zimbra@redhat.com>
In-Reply-To: <5667118D.2000502@sandeen.net>
References: <1449244857-19283-1-git-send-email-zlang@redhat.com> <5667118D.2000502@sandeen.net>
Subject: Re: [PATCH] xfs/133: add quota name beginning with digits test
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org, eguan@redhat.com, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Eric Sandeen" <sandeen@sandeen.net>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>, fstests@v=
ger.kernel.org
> =E6=8A=84=E9=80=81: eguan@redhat.com, sandeen@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=89, 2015=
=E5=B9=B4 12 =E6=9C=88 09=E6=97=A5 =E4=B8=8A=E5=8D=88 1:21:17
> =E4=B8=BB=E9=A2=98: Re: [PATCH] xfs/133: add quota name beginning with =
digits test
>=20
> On 12/4/15 10:00 AM, Zorro Lang wrote:
> > There're two bugs on xfsprogs:
> > 1. when a project name beinning with digits, it can't be found
> > by run xfs_quota 'quota -p -v ...' command, but 'report' command
> > can find it.
> >=20
> > 2. When user or group names beginning with digits, we can't
> > create 'limit' for them, and can't find them either(likes above).
> >=20
> > This case will create user, group and project names which beginning
> > with digits, then create limit for them, and query them.
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >=20
> > Hi,
> >=20
> > This case need a test user, that doesn't like user 'fsqa', fsqa is a
> > common user for xfstests, but this case need a special and temporary
> > user and group. So I create and clean them in this case.
> >=20
> > But this's the first time a xfstests case add test user/group by itse=
lf,
> > so please help to review, if this's appropriate?
>=20
> So, I came to the conclusion, and talking w/ Dave I think he concurs, t=
hat it
> would be better to document the need for these users in the README; the=
n,
> just like the "fsgqa" user, your test can check for the existence of i.=
e.
> a "123456-fsgqa" user, and simply _notrun() if it's not present.  This =
way
> /etc/passwd stays under the system administrator's control, but it's cl=
ear
> why
> the test is skipped if the user doesn't exist.

OK, if I don't need to create and clean the user and group, this case 'll=
 be easier.

Due to project name test is independent test, it doesn't depend on user/g=
roup name test,
and they're from different patches of xfsprogs.

So I will make a separate test for project:
1) User/group case will '_notrun' if no appropriate test user.
2) Project case always can be run.

Thanks,
Zorro

> =20
> -Eric
>=20
>=20
