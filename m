Received: from mx4-phx2.redhat.com ([209.132.183.25]:36486 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbHQOHJ convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 17 Aug 2015 10:07:09 -0400
Date: Mon, 17 Aug 2015 10:07:07 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <387572219.9382582.1439820427728.JavaMail.zimbra@redhat.com>
In-Reply-To: <1439819393-7713-1-git-send-email-zlang@redhat.com>
References: <1439819393-7713-1-git-send-email-zlang@redhat.com>
Subject: Re: [PATCH v3] generic/084: use src/multi_open_unlink to replace
 tail command
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: fstests@vger.kernel.org
> =E6=8A=84=E9=80=81: eguan@redhat.com, david@fromorbit.com, "Zorro Lang"=
 <zlang@redhat.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=80, 2015=
=E5=B9=B4 8 =E6=9C=88 17=E6=97=A5 =E4=B8=8B=E5=8D=88 9:49:53
> =E4=B8=BB=E9=A2=98: [PATCH v3] generic/084: use src/multi_open_unlink t=
o replace tail command
>=20
> generic/084 try to run 'tail' command, tail will use inotify.
> There're some limit about the number of inotify. For example
> fs.inotify.max_user_instances specifies an upper limit on
> the number of inotify instances that can be created per real
> user ID.
>=20
> When I test on a machine with 154 cpu cores, this case run
> failed, and hit many warning likes:
>=20
>     +tail: inotify cannot be used, reverting to polling: Too many open =
files
>=20
> Because the fs.inotify.max_user_instances is 128, so if we
> try to tail 154 files, it will be failed.
>=20
> So use src/multi_open_unlink to instead of tail will avoid
> this problem.
>=20
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> Reviewed-by: Eryu Guan <eguan@redhat.com>
> Reviewed-by: Dave Chinner <david@fromorbit.com>

Hi,

Eryu told me I shouldn't add "Reviewed-by" at here. Sorry for
my mistake, I just thought I should add everyone who helped me.
Please help to review again.

Thanks very much.

Zorro

