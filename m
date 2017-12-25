Received: from sandeen.net ([63.231.237.45]:56960 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdLYHrW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Dec 2017 02:47:22 -0500
Subject: Re: xfstests: generic/342 run failed in f2fs
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
Date: Sun, 24 Dec 2017 23:47:20 -0800
MIME-Version: 1.0
In-Reply-To: <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: philip.li@intel.com
List-ID: <fstests@vger.kernel.org>



On 12/24/17 10:30 PM, Chen Rong wrote:
>=20
>=20
> On 2017=E5=B9=B412=E6=9C=8825=E6=97=A5 13:56, Eric Sandeen wrote:
>> On 12/24/17 9:28 PM, Chen Rong wrote:
>>> Hi, everyone:
>>>
>>> the issue as below:
>> First we need to look - what does the test do?
>>
>> # Test that if we rename a file, create a new file that has the old na=
me of the
>> # other file and is a child of the same parent directory, fsync the ne=
w inode,
>> # power fail and mount the filesystem, we do not lose the first file a=
nd that
>> # file has the name it was renamed to.
>>
>> Ok, so it is a test of fsync'd file renames/creation over simulated de=
vice
>> failure, and wants to be sure that all files and file contents are as
>> expected if data integrity syscalls were made before the device failur=
e.
>>
>>> # ./check generic/342
>>> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- f2fs
>>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 node01 4.15.0-=
rc4
>>> MKFS_OPTIONS=C2=A0 -- /dev/sde1
>>> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sde1 /tmp/test1
>>>
>>> generic/342=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see /hom=
e/ubuntu/git/xfstests-dev/results//generic/342.out.bad)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/generic/342.out=C2=A0=C2=A0 2017-1=
2-13 13:47:20.144000000 -0500
>>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ /home/ubuntu/git/xfstests-dev/results//g=
eneric/342.out.bad 2017-12-25 11:13:12.928000000 -0500
>>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -8,8 +8,7 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48c940ba3b8671d3d6ea74e4ccad8ca3=C2=A0=
 SCRATCH_MNT/a/bar
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Directory a/ contents after log replay=
:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCRATCH_MNT/a:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 -bar
>> the test created foo, fsynced it, then renamed it to bar and created a
>> /new/ file also named foo, then fsynced the new file foo.
>>
>> Despite that 2nd fsync, the renamed file "bar" is not present in
>> your case.
>>
>> However, don't we really need to fsync the directory after
>> the rename and recreation to ensure persistence?
>>
>> iows:=C2=A0 does this patch make the test pass on f2fs?=C2=A0 It does
>> for me, and I think it's the only valid way to run the test:
> the patch works for me. but btrfs could pass the test without it, why s=
o different?

Filesystems are free to do /more/ than the minimum required by posix -
see ext4_sync_parent for example.  Or xfs_finish_rename, for synchronous
mounts:

         * If this is a synchronous mount, make sure that the rename tran=
saction
         * goes to disk before returning to the user.
         */
        if (tp->t_mountp->m_flags & (XFS_MOUNT_WSYNC|XFS_MOUNT_DIRSYNC))
                xfs_trans_set_sync(tp);

so behavior can be fs-dependent, or mount option dependent, etc.

But to be portable, if an app wants directory changes to be persistent
before proceeding, it must fsync the directory after making changes.

I don't know about f2fs's design intent, whether it guarantees more
than posix requires, but to guarantee that this test works on any posix
fs, I think that directory fsync is needed.

-Eric
