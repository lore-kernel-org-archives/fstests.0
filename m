Received: from mx1.redhat.com ([209.132.183.28]:35188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdHBBdQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Aug 2017 21:33:16 -0400
Date: Wed, 2 Aug 2017 09:33:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/449: make the test effective against xfs
Message-ID: <20170802013314.GP9167@eguan.usersys.redhat.com>
References: <20170801045528.GA4696@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801045528.GA4696@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 01, 2017 at 01:55:31AM -0300, Ernesto A. Fern=C3=A1ndez wrote=
:
> Setting acls on an xfs filesystem will succeed even after running out
> of space for user attributes. Use trusted attributes instead.
>=20
> Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.c=
om>

How about using the "XFS way" unconditionally in the test? I found that
test still failed for ext4 and btrfs when using the "XFS way", so I
wondered if we don't need to special-case XFS at all.

Thanks,
Eryu
