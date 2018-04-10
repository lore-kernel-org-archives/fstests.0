Received: from userp2120.oracle.com ([156.151.31.85]:47504 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeDJAiz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Apr 2018 20:38:55 -0400
Date: Mon, 9 Apr 2018 17:38:37 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Directory unremovable on ext4 no_journal mode
Message-ID: <20180410003837.GA7493@magnolia>
References: <CA+EzBbCXWZZiP2jBnUQSn8LeTkav0tEJ-ra60GiVNxZK8zhLmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+EzBbCXWZZiP2jBnUQSn8LeTkav0tEJ-ra60GiVNxZK8zhLmg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: linux-ext4@vger.kernel.org, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 09, 2018 at 07:08:13PM -0500, Jayashree Mohan wrote:
> Hi,
>=20
> We stumbled upon what seems to be a bug that makes a =E2=80=9Cdirectory
> unremovable=E2=80=9D,  on ext4 when mounted with no_journal option.
>=20
> A sequence of operations described below led to the following state :
> =E2=80=9CA directory that was renamed, was persisted in both parent and=
 target
> directories, with the same inode number. This also means the rename
> was non-atomic on storage. In addition, the renamed directory becomes
> unremovable on the target with FS-error logged in dmesg.=E2=80=9D
>=20
> Here are more details of the workload and the corresponding failure.
>=20
> Workload :
>=20
> mkdir /mnt/test/X and /mnt/test/Y
> mkdir X/Z
> sync()
> rename X/Z   Y/Z
> fsync Y
> =E2=80=94-Crash now=E2=80=94-
> Remount

You're supposed to run e2fsck after a crash to clean up the metadata.
nojournal disables the piece that takes care of that.

--D

> ls X and Y (You will see Z is present in both directories X and Y, and
> has same inode)
> rmdir test_dir/X/Z  (This succeeds)
> rmdir test_dir/Y/Z  (This fails with a FS error logged in dmesg)
>=20
>=20
> Results:
>=20
> rmdir: failed to remove '/mnt/test/Y/Z': Structure needs cleaning
>=20
> The corresponding dmesg log has the following error message :
> [66799.504124] EXT4-fs error (device cow_ram_snapshot1_0):
> ext4_lookup:1576: inode #12: comm rmdir: deleted inode referenced: 14
> [66799.504131] EXT4-fs (cow_ram_snapshot1_0): Remounting filesystem rea=
d-only
>=20
> The sequence of operations listed above is making dir Z unremovable
> from dir Y, which seems like unexpected behavior. Could you provide
> more details on the reason for such behavior? We understand we run
> this on no_journal mode of ext4, but would like you to verify if this
> behavior is acceptable.
>=20
> Do let us know if we are missing any detail here.
>=20
> Thanks,
> Jayashree Mohan
