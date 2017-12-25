Received: from sandeen.net ([63.231.237.45]:39958 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbdLYF4s (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Dec 2017 00:56:48 -0500
Subject: Re: xfstests: generic/342 run failed in f2fs
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
Date: Sun, 24 Dec 2017 21:56:46 -0800
MIME-Version: 1.0
In-Reply-To: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On 12/24/17 9:28 PM, Chen Rong wrote:
> Hi, everyone:
>=20
> the issue as below:

First we need to look - what does the test do?

# Test that if we rename a file, create a new file that has the old name =
of the
# other file and is a child of the same parent directory, fsync the new i=
node,
# power fail and mount the filesystem, we do not lose the first file and =
that
# file has the name it was renamed to.

Ok, so it is a test of fsync'd file renames/creation over simulated devic=
e
failure, and wants to be sure that all files and file contents are as
expected if data integrity syscalls were made before the device failure.

> # ./check generic/342
> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- f2fs
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 node01 4.15.0-rc=
4
> MKFS_OPTIONS=C2=A0 -- /dev/sde1
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sde1 /tmp/test1
>=20
> generic/342=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see /home/=
ubuntu/git/xfstests-dev/results//generic/342.out.bad)
> =C2=A0=C2=A0=C2=A0 --- tests/generic/342.out=C2=A0=C2=A0 2017-12-13 13:=
47:20.144000000 -0500
> =C2=A0=C2=A0=C2=A0 +++ /home/ubuntu/git/xfstests-dev/results//generic/3=
42.out.bad 2017-12-25 11:13:12.928000000 -0500
> =C2=A0=C2=A0=C2=A0 @@ -8,8 +8,7 @@
> =C2=A0=C2=A0=C2=A0=C2=A0 48c940ba3b8671d3d6ea74e4ccad8ca3=C2=A0 SCRATCH=
_MNT/a/bar
> =C2=A0=C2=A0=C2=A0=C2=A0 Directory a/ contents after log replay:
> =C2=A0=C2=A0=C2=A0=C2=A0 SCRATCH_MNT/a:
> =C2=A0=C2=A0=C2=A0 -bar

the test created foo, fsynced it, then renamed it to bar and created a
/new/ file also named foo, then fsynced the new file foo.

Despite that 2nd fsync, the renamed file "bar" is not present in
your case.

However, don't we really need to fsync the directory after
the rename and recreation to ensure persistence?

iows:  does this patch make the test pass on f2fs?  It does
for me, and I think it's the only valid way to run the test:

diff --git a/tests/generic/342 b/tests/generic/342
index ed64e05..6a9e5bd 100755
--- a/tests/generic/342
+++ b/tests/generic/342
@@ -68,6 +68,7 @@ sync
 mv $SCRATCH_MNT/a/foo $SCRATCH_MNT/a/bar
 $XFS_IO_PROG -f -c "pwrite -S 0xba 0 16K" $SCRATCH_MNT/a/foo | _filter_x=
fs_io
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a/foo
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a
=20
 echo "File digests before log replay:"
 md5sum $SCRATCH_MNT/a/foo | _filter_scratch

without an fsync of the parent dir, I don't think we can
guarantee that filename changes or additions will persist
on every filesystem.

> =C2=A0=C2=A0=C2=A0=C2=A0 foo
> =C2=A0=C2=A0=C2=A0=C2=A0 File digests after log replay:
> =C2=A0=C2=A0=C2=A0=C2=A0 9e5d56a1f9b2c93589f9d55480f971a1=C2=A0 SCRATCH=
_MNT/a/foo
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 (Run 'diff -u tests/generic/342.out /home/ubuntu/git=
/xfstests-dev/results//generic/342.out.bad'=C2=A0 to see the entire diff)

Generally best to do that suggested diff command to see if=20
there are any more pieces of changed/wrong test output.

> Ran: generic/342
> Failures: generic/342
> Failed 1 of 1 tests
>=20
> Is it a problem with my computer or a already known issue with f2fs?

or a problem with the test itself ...

-Eric
=20
> thanks!
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html
>=20
