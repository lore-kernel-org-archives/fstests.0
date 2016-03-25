Received: from mail02.iobjects.de ([188.40.134.68]:34511 "EHLO
	mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcCYMKT (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 25 Mar 2016 08:10:19 -0400
Subject: Re: [PATCH] fstests: add btrfs test for fsync after snapshot deletion
References: <1458839241-12379-1-git-send-email-fdmanana@kernel.org>
 <20160325035306.GX11419@eguan.usersys.redhat.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?=
	<holger.hoffstaette@googlemail.com>
Message-ID: <56F527FC.9020007@googlemail.com>
Date: Fri, 25 Mar 2016 12:58:52 +0100
MIME-Version: 1.0
In-Reply-To: <20160325035306.GX11419@eguan.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On 03/25/16 04:53, Eryu Guan wrote:
> Test fails on v4.5 kernel as expected, but I failed to compile btrfs
> after applying this patch, seems btrfs_must_commit_transaction was not
> defined anywhere (I did grep it through the kernel tree, nothing showed
> up), did I miss anything?
>=20
> fs/btrfs/tree-log.c: In function =E2=80=98check_parent_dirs_for_sync=E2=
=80=99:
> fs/btrfs/tree-log.c:4836:4: error: implicit declaration of function =E2=
=80=98btrfs_must_commit_transaction=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
>     if (btrfs_must_commit_transaction(trans, inode))
>     ^
> cc1: some warnings being treated as errors
> make[1]: *** [fs/btrfs/tree-log.o] Error 1
> make: *** [_module_fs/btrfs] Error 2

It was defined in a previous patch for 4.6:

https://git.kernel.org/cgit/linux/kernel/git/mason/linux-btrfs.git/commit=
/?h=3Dfor-linus-4.6&id=3D2be63d5ce929603d4e7cedabd9e992eb34a0ff95

-h

