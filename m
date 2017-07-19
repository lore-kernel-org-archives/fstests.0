Received: from mx1.redhat.com ([209.132.183.28]:38540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdGSGpy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Jul 2017 02:45:54 -0400
Date: Wed, 19 Jul 2017 14:45:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [xfstests PATCH v4] generic: add test of file mode when setfacl
 fails
Message-ID: <20170719064553.GA2478@eguan.usersys.redhat.com>
References: <20170719055146.GA7249@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170719055146.GA7249@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: fstests@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 19, 2017 at 02:51:50AM -0300, Ernesto A. Fern=C3=A1ndez wrote=
:
> Check that the group permission bits of a file are not altered when set=
facl
> fails. At the time of this patch the test fails for at least ext2, ext4=
,
> jfs and btrfs.
>=20
> The failure in setfacl is induced by filling the device and setting as
> many user attributes to the file as possible. For xfs this is not enoug=
h,
> and the test will not run.
>=20
> Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.c=
om>
> ---
> Changes in v4:
>   - Continue to set attributes even when the filesystem claims to be ou=
t of
>     space. With this change the test will now fail for btrfs.
>   - Call _notrun when setfacl succeeds, since no check can be done. As =
suggested
>     by Eryu Guan.=20

Thanks a lot for the update! I've queued it for next fstests update.

Eryu
