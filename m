Received: from mout.gmx.net ([212.227.17.22]:43919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbfHPJrr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Aug 2019 05:47:47 -0400
Subject: Re: [PATCH] fstests: btrfs: Check snapshot creation and deletion with
 dm-logwrites
References: <20190814105544.18318-1-wqu@suse.com>
 <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
Date: Fri, 16 Aug 2019 17:47:33 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI
Content-Type: multipart/mixed; boundary="VIPhlhsz7li3u8YOEPvPQOMLat8dSTSvH";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: fstests <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <21a7b532-c16d-c014-e714-e280d0a1850a@gmx.com>
Subject: Re: [PATCH] fstests: btrfs: Check snapshot creation and deletion with
 dm-logwrites
References: <20190814105544.18318-1-wqu@suse.com>
 <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>
In-Reply-To: <CAL3q7H5v6jrFcKupRBZ9EnaQDKM2UooK3iwOgJ01wTvqMtizcw@mail.gmail.com>

--VIPhlhsz7li3u8YOEPvPQOMLat8dSTSvH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/16 =E4=B8=8B=E5=8D=885:25, Filipe Manana wrote:
[...]
>=20
> That will also make the test fail on systems with a page size > 4Kb.
> So either make it "_notrun" for systems with a page size !=3D 4Kb or,
> preferably make the test independent of the page size.
> If you want to increase the tree height easily, you can set large
> xattrs for files, like I did in btrfs/187, where even if with a 64Kb
> page size, I get a 3 levels fs tree.
>=20
>> +
>> +# We need inline extents to quickly bump the tree height
>> +_log_writes_mount -o max_inline=3D2048
>=20
> Again, setting large xatts (3800 bytes so that it works for any page
> size) is even faster then inline extents.

Greater advice for that!

>=20
>> +
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null 2>&1
>=20
> We should catch failures here. Just remove the redirection, pass the
> _filter_scratch filter and update the golden output.
>=20
>> +mkdir -p $SCRATCH_MNT/snapshots
>> +mkdir -p $SCRATCH_MNT/src/padding
>> +
>> +random_file() {
>=20
> The coding style is "{" on the beginning of the next line.
> Like the _cleanup() function, and the _log_writes_fast_replay_check()
> function you added previously.
>=20
>> +       local basedir=3D$1
>> +       echo "$basedir/$(ls $basedir | sort -R | tail -1)"
>> +}
>> +
>> +snapshot_workload() {
>=20
> Same comment as above.
>=20
>> +       while true; do
>> +               $BTRFS_UTIL_PROG subvolume snapshot \
>> +                       $SCRATCH_MNT/src $SCRATCH_MNT/snapshots/$i \
>> +                       > /dev/null 2>&1
>> +               # Remove two random padding so each snapshot is differ=
ent
>> +               rm "$(random_file $SCRATCH_MNT/src/padding)"
>=20
> I would pass -f to rm. Having an alias "alias rm=3D'rm -i'" is not very=

> uncommon (I have such alias for my accounts).
>=20
>> +               rm "$(random_file $SCRATCH_MNT/src/padding)"
>=20
> Might be interesting to add a few files to each snapshot too (modify
> existing ones, etc).

No problem.

>=20
>> +               sleep 1
>> +       done
>> +}
>> +
>> +delete_workload() {
>=20
> Same comment as above.
>=20
>> +       while true; do
>> +               sleep 2
>> +               $BTRFS_UTIL_PROG subvolume delete \
>> +                       "$(random_file $SCRATCH_MNT/snapshots)" \
>> +                       > /dev/null 2>&1
>> +       done
>> +}
>> +
>> +# Bump the tree height to 2 at least
>> +for ((i =3D 0; i < 256; i++)); do
>> +       _pwrite_byte 0xcd 0 2k "$SCRATCH_MNT/src/padding/inline_$i" > =
/dev/null 2>&1
>> +       _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/src/padding/regular_$i" >=
 /dev/null 2>&1
>> +done
>> +sync
>=20
> Why the call to 'sync'?
> Not needed, snapshot creation flushes delalloc and commits a transactio=
n.
>=20
>> +
>> +_log_writes_mark prepare
>> +
>> +snapshot_workload &
>> +pid1=3D$!
>> +delete_workload &
>> +pid2=3D$!
>> +
>> +$FSSTRESS_PROG $fsstress_args > /dev/null 2>&1 &
>> +sleep $runtime
>> +
>> +$KILLALL_PROG -q $FSSTRESS_PROG &> /dev/null
>=20
> You're very inconsistent within the same test :) Using both ">
> /dev/null 2>&1" and "&> /dev/null".

My bad, I mean 2>&1 > /dev/null.
What I mean is output stderr while skip stdout in previous calls.

Thanks,
Qu

>=20
>> +kill $pid1 &> /dev/null
>> +kill $pid2 &> /dev/null
>> +wait
>> +_log_writes_unmount
>> +_log_writes_remove
>> +
>> +# Since we have a lot of work to replay, and relay-log will search
>> +# from the first record to the needed entry, we need to use --fsck op=
tion
>> +# to reduce unnecessary search, or it will be too slow
>> +$here/src/log-writes/replay-log --log $LOGWRITES_DEV --replay $SCRATC=
H_DEV \
>> +       --fsck "btrfs check $SCRATCH_DEV" --check fua >> $seqres.full =
2>&1
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
>> new file mode 100644
>> index 00000000..6779aa77
>> --- /dev/null
>> +++ b/tests/btrfs/192.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 192
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 2474d43e..24723bf1 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -194,3 +194,4 @@
>>  189 auto quick send clone
>>  190 auto quick replay balance qgroup
>>  191 auto quick send dedupe
>> +192 auto replay
>=20
> Missing "snapshot" group.
>=20
> Thanks.
>=20
>> --
>> 2.22.0
>>
>=20
>=20


--VIPhlhsz7li3u8YOEPvPQOMLat8dSTSvH--

--BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1We7UACgkQwj2R86El
/qjIZAgAsEB8diZhj4xdMLUExpMUtpIUudwrBZ4B/gYDu3+uBP3BfP8O+bseZVy5
brhISoDQ0jnHPYZrYeFfcajYUo+FpR2cf+YEoKUspITc+cKpJCKF/RV20HosgPPI
xL+YZUfGLIiWkgyE9KvH2hDlkzEQncbOFj7Hf8YXFjS07pZ/4GRxUemeXuGKHXxR
+w4IwJ0kxBWxUV8eXd4qoncyvct8tpkzSqp35oo1XpNcHEV1ssBeDA6PSAibkS3e
iC1QV73IxEeANm11ZeVnRNmP8vWRFUWruVjmRZvmWgA1EC/E732W73SqX2EAvrfx
7X7n8z2Kle9BWoOldLW0nHbNIcl5AA==
=W9cu
-----END PGP SIGNATURE-----

--BhuUxfTa8gfxtpb5hCOgRvwKzuTMJiCzI--
