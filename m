Received: from mout.gmx.net ([212.227.17.20]:51155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfAJNts (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 10 Jan 2019 08:49:48 -0500
Subject: Re: [PATCH 2/2] fstests: btrfs: Introduce stress test for deadlock
 between snapshot delete and other read-write operations
References: <20190110061415.32045-1-wqu@suse.com>
 <20190110061415.32045-2-wqu@suse.com>
 <CAL3q7H7gG4gLWaSHhLmxR-ngT-WBPXtx1=iziwcK4iquaQ6-xw@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c2306946-c239-2cfa-b397-699ee42b4190@gmx.com>
Date: Thu, 10 Jan 2019 21:49:30 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7gG4gLWaSHhLmxR-ngT-WBPXtx1=iziwcK4iquaQ6-xw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RteSPvmFPy7O7JAkGM3LWrXEorvMkZe5M"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RteSPvmFPy7O7JAkGM3LWrXEorvMkZe5M
Content-Type: multipart/mixed; boundary="xweoOpA08ZhglxcwQxqhpW9T0nx823Vke";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
 fstests <fstests@vger.kernel.org>
Message-ID: <c2306946-c239-2cfa-b397-699ee42b4190@gmx.com>
Subject: Re: [PATCH 2/2] fstests: btrfs: Introduce stress test for deadlock
 between snapshot delete and other read-write operations
References: <20190110061415.32045-1-wqu@suse.com>
 <20190110061415.32045-2-wqu@suse.com>
 <CAL3q7H7gG4gLWaSHhLmxR-ngT-WBPXtx1=iziwcK4iquaQ6-xw@mail.gmail.com>
In-Reply-To: <CAL3q7H7gG4gLWaSHhLmxR-ngT-WBPXtx1=iziwcK4iquaQ6-xw@mail.gmail.com>

--xweoOpA08ZhglxcwQxqhpW9T0nx823Vke
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/10 =E4=B8=8B=E5=8D=888:08, Filipe Manana wrote:
> On Thu, Jan 10, 2019 at 6:15 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Commit fb235dc06fac ("btrfs: qgroup: Move half of the qgroup accountin=
g
>> time out of commit trans") could cause ABBA deadlock between backref
>> lookup with write lock hold (subvolume deletion) and other read/write
>> operations.
>>
>> It's going to be fixed by "btrfs: qgroup: Don't trigger backref walk a=
t
>> delayed ref insert time".
>>
>> This test will generate pwrite background workload, along with
>> constantly subvolume creation and deletion to trigger the bug.
>=20
> constantly -> constant
>>
>> It needs some time to generate enough files to bump the tree height to=

>> trigger the bug.
>> In my test environment, with 'unsafe' cache mode for the VM, it trigge=
rs
>> the bug at around 70~90 seconds. So I leave the default runtime to 120=
s
>> to make sure the bug will be triggered.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/179     | 121 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/179.out |   2 +
>>  tests/btrfs/group   |   1 +
>>  3 files changed, 124 insertions(+)
>>  create mode 100755 tests/btrfs/179
>>  create mode 100644 tests/btrfs/179.out
>>
>> diff --git a/tests/btrfs/179 b/tests/btrfs/179
>> new file mode 100755
>> index 000000000000..771d12fc49e3
>> --- /dev/null
>> +++ b/tests/btrfs/179
>> @@ -0,0 +1,121 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 179
>> +#
>> +# Test if btrfs will lockup at subvolume deletion.
>=20
> Misses the most important part in the short description: "... when
> qgroups are enabled."
>=20
>> +#
>> +# The bug is caused by commit fb235dc06fac ("btrfs: qgroup: Move half=
 of the
>> +# qgroup accounting time out of commit trans").
>> +# Backref lookup with write lock hold (subvolue deletion) could cause=
 ABBA lock
>> +# with normal top-down tree locking sequence.
>=20
> I would omit this. Relevant information on how and why the bug happens
> is in the kernel patch, QA
> people only need to know the test's purpose.
>=20
>> +#
>> +# This bug deadlock is going to be fixed by "btrfs: qgroup: Don't tri=
gger
>=20
> "This bug is going ... by a patch for the kernel titled ..."
>=20
>> +# backref walk at delayed ref insert time" which reverts above commit=
=2E
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch
>> +
>> +# default sleep interval
>> +sleep_time=3D1
>> +
>> +# stress test runtime
>> +runtime=3D120
>> +
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>> +
>> +mkdir -p "$SCRATCH_MNT/snapshots"
>> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/src" > /dev/null
>> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
>> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
>> +
>> +fill_workload()
>> +{
>> +       local i=3D0
>> +       while true; do
>> +               _pwrite_byte 0xcd 0 8K "$SCRATCH_MNT/src/large_$i" > /=
dev/null
>> +               _pwrite_byte 0xcd 0 2K "$SCRATCH_MNT/src/inline_$i" > =
/dev/null
>> +
>> +               # Randomly remove some files for every 5 loop
>> +               if [ $(( $i % 5 )) -eq 0 ]; then
>> +                       victim=3D$(ls "$SCRATCH_MNT/src" | sort -R | h=
ead -n1)
>> +                       rm "$SCRATCH_MNT/src/$victim"
>> +               fi
>> +               i=3D$((i + 1))
>> +       done
>> +}
>> +
>> +snapshot_workload()
>> +{
>> +       local i=3D0
>> +       while true; do
>> +               sleep $sleep_time
>> +               $BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/src"=
 \
>> +                       "$SCRATCH_MNT/snapshots/$i" > /dev/null
>> +               i=3D$((i + 1))
>> +       done
>> +}
>> +
>> +delete_workload()
>> +{
>> +       while true; do
>> +               sleep $((sleep_time * 2))
>> +               victim=3D$(ls "$SCRATCH_MNT/snapshots" | sort -R | hea=
d -n1)
>> +               $BTRFS_UTIL_PROG subvolume delete \
>> +                       "$SCRATCH_MNT/snapshots/$victim" > /dev/null
>> +       done
>> +}
>> +
>> +fill_workload &
>> +fill_pid=3D$!
>> +
>> +sleep $((sleep_time * 2))
>> +snapshot_workload &
>> +snapshot_pid=3D$!
>> +delete_workload &
>> +delete_pid=3D$!
>> +
>> +sleep $runtime
>> +kill $fill_pid
>> +wait $fill_pid
>> +kill $snapshot_pid
>> +wait $snapshot_pid
>> +kill $delete_pid
>> +wait $delete_pid
>> +
>> +# Workaround to handle killed workload with unreturned syscall
>> +sync
>=20
> I can't understand that comment, nor why the call to sync (probably
> most readers won't either).
> What do you mean by "unreturned syscall"? It hangs, blocked? Because
> of the deadlock? How does the sync makes it "return"?

I mean normal "btrfs subvolume create/delete" ioctl syscalls.

>=20
> When you say killed workload, you mean though the kill commands above?
> For all pids or just some in particular?

For the workload, it will be a forked bash process, and then executing
"btrfs" program.
While "btrfs subvolume create/delete" could call ioctl and fall into
kernel space, kill/wait for the bash process could return before the
ioctl returned.

So here we try to call sync which will commit current transaction, more
or less wait for unfinished "btrfs" ioctls to return.

Or should I change to the more common loop of check "btrfs" process and
wait?

Thanks,
Qu

>=20
>> +
>> +# success, all done
>> +echo "Silence is golden"
>> +
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/179.out b/tests/btrfs/179.out
>> new file mode 100644
>> index 000000000000..cb9eba3d34b1
>> --- /dev/null
>> +++ b/tests/btrfs/179.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 179
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 04c0254aa4bf..46dd3c9523c2 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -181,3 +181,4 @@
>>  176 auto quick swap volume
>>  177 auto quick swap balance
>>  178 auto quick send
>> +179 auto qgroup dangerous
>> --
>> 2.20.1
>>
>=20
>=20


--xweoOpA08ZhglxcwQxqhpW9T0nx823Vke--

--RteSPvmFPy7O7JAkGM3LWrXEorvMkZe5M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlw3TWoACgkQwj2R86El
/qh12gf/fRoHtAlBUlRQHuGe1XevrCRhtagsy6Ja/MgbYB6k64NZ/7NHMkSo3vce
didFtq/PLj43K/36LgkD8q2gCmfttSwRqZJwv5qrWaM0DbmFIpaBqIVoTo6FSoIl
S5WVZQb0pxKNYeUaAft1VMUvCAZRvxj9yL9oed9sYZjY0rEQY/SZ1+oE0fmcXS+n
sNK2ugem3MUmHFYTARWWmie6jMOS3c/XNzq0mPU31A3t769yJqcVHPbPAnr4fxTu
S/Voq+RyPo0MYEq/QAPbrHn8zaMIRMegMSIl3jSJDIjDPOqB9OZ/6YHhEgGtLeSY
S+u7vNr5D4hZvZ5UHYcjbgmj9ZsPPg==
=tIxB
-----END PGP SIGNATURE-----

--RteSPvmFPy7O7JAkGM3LWrXEorvMkZe5M--
