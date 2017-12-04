Received: from mx2.suse.de ([195.135.220.15]:40822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752034AbdLDT45 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 4 Dec 2017 14:56:57 -0500
Subject: Re: generic/399 and xfs_io pwrite command
References: <7235f31f-5427-ff12-11f9-cba98431e71c@tuxera.com>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <f0861212-4af4-a2b7-3215-2057d2e45e54@suse.de>
Date: Mon, 4 Dec 2017 13:56:52 -0600
MIME-Version: 1.0
In-Reply-To: <7235f31f-5427-ff12-11f9-cba98431e71c@tuxera.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Ari Sundholm <ari@tuxera.com>, fstests@vger.kernel.org
Cc: Emil Karlson <jkarlson@tuxera.com>
List-ID: <fstests@vger.kernel.org>



On 11/30/2017 08:21 AM, Ari Sundholm wrote:
> Hi!
>=20
> While debugging an issue, we found out that generic/399 seems to rely o=
n
> a behavior that is specific to ext4 in the following section of code:
> ----------------8<--------snip--------8<------------------------------
> #
> # Write files of 1 MB of all the same byte until we hit ENOSPC.=C2=A0 N=
ote
> that we
> # must not create sparse files, since the contents of sparse files are =
not
> # stored on-disk.=C2=A0 Also, we create multiple files rather than one =
big file
> # because we want to test for reuse of per-file keys.
> #
> total_file_size=3D0
> i=3D1
> while true; do
> =C2=A0=C2=A0=C2=A0=C2=A0file=3D$SCRATCH_MNT/encrypted_dir/file$i
> =C2=A0=C2=A0=C2=A0=C2=A0if ! $XFS_IO_PROG -f $file -c 'pwrite 0 1M' &> =
$tmp.out; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! grep -q 'No space left =
on device' $tmp.out; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo=
 "FAIL: unexpected pwrite failure"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat =
$tmp.out
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif [ -e $file ]; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tota=
l_file_size=3D$((total_file_size + $(stat -c %s $file)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> =C2=A0=C2=A0=C2=A0=C2=A0fi
> =C2=A0=C2=A0=C2=A0=C2=A0total_file_size=3D$((total_file_size + $(stat -=
c %s $file)))
> =C2=A0=C2=A0=C2=A0=C2=A0i=3D$((i + 1))
> =C2=A0=C2=A0=C2=A0=C2=A0if [ $i -gt $fs_size_in_mb ]; then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "FAIL: filesystem never=
 filled up!"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> =C2=A0=C2=A0=C2=A0=C2=A0fi
> done
> ----------------8<--------snip--------8<------------------------------
>=20
> What happens with ext4 is that the xfs_io command gives a nonzero exit
> value not when the pwrite command fails with ENOSPC but during the
> *next* iteration when opening the file fails with ENOSPC. Turns out the
> pwrite command failing does not cause xfs_io to give a nonzero exit val=
ue.
>=20
> With one of our filesystems, pwrite fails considerably earlier than we
> become unable to create new files, making this test case misbehave as
> the pwrite failure is basically ignored while we keep creating new empt=
y
> files.
>=20
> While I understand that supporting out-of-tree filesystems is not what
> is done in fstests land, this issue looks like it is generic enough to
> at least warrant some discussion. It is not inconceivable at all that a=
n
> =C2=A0in-tree filesystem could have something else than this specific e=
xt4
> behavior.
>=20
> The issue itself could either be fixed in xfsprogs, allowing the pwrite
> failure to propagate to the exit value in some manner, or in fstests by
> having an alternate/additional mechanism for detecting the ENOSPC (we d=
o
> have some simple, nonintrusive ideas, if there is interest).


There is a new option added in xfs_io pwrite command called -O or
perform the operation once, for incomplete writes so as to get the
number of bytes written so far, as opposed to the final error. Calling
it again on a full filesystem with -O should give a ENOSPC error. Can
calling pwrite with -O multiple times be used for the purpose?

--=20
Goldwyn
