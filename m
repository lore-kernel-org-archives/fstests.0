Received: from mx1.redhat.com ([209.132.183.28]:51255 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbcF3Dqs (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Jun 2016 23:46:48 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F032F552FE
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 03:38:06 +0000 (UTC)
Date: Thu, 30 Jun 2016 11:38:05 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfstests: Fix installation for extended names
Message-ID: <20160630033805.GP23649@eguan.usersys.redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 29, 2016 at 04:57:55PM +0200, Jan Tulak wrote:
> xfstests supports extended test names like 314-foo-bar, but installatio=
n of
> these tests was skipped (not matching a regexp). So this patch fixes th=
e
> makefiles in tests directories.
>=20
> Signed-off-by: Jan Tulak <jtulak@redhat.com>

Thanks for fixing it! But this breaks installation in other subdirs

# make install
...
../../install-sh -o root -g root -m 755 [0-9]??-* /var/lib/xfstests/tests=
/btrfs
cp: cannot stat =E2=80=98[0-9]??-*=E2=80=99: No such file or directory
gmake[2]: *** [install] Error 1
gmake[1]: *** [/root/xfstests/tests/btrfs/-install] Error 2
make: *** [tests-install] Error 2

Thanks,
Eryu
