Received: from mout.gmx.net ([212.227.17.21]:53133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfIYKDf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 25 Sep 2019 06:03:35 -0400
Subject: Re: [PATCH] fstests: btrfs/011: Fill the fs to ensure we have enough
 data for dev-replace
References: <20190923124347.30850-1-wqu@suse.com>
 <CAL3q7H6Fo+79a36Bp1kRpfyczK5diRwtgkcNLewEY1Fj=dTPiQ@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <52c7fccb-a760-25ae-f3d0-14994ffe480e@gmx.com>
Date: Wed, 25 Sep 2019 18:03:22 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6Fo+79a36Bp1kRpfyczK5diRwtgkcNLewEY1Fj=dTPiQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a
Content-Type: multipart/mixed; boundary="30Ye9FkBfAyuyOC14LFV2JVgRFMmLzVlA"

--30Ye9FkBfAyuyOC14LFV2JVgRFMmLzVlA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/25 =E4=B8=8B=E5=8D=885:48, Filipe Manana wrote:
[...]
>> +
>> +       # If the system is too fast and the fs is too small, then skip=
 the test
>> +       if grep -q "No space left" $tmp.filler_result; then
>> +               ls -alh $SCRATCH_MNT >> $seqres.full
>> +               cat $tmp.filler_result >> $seqres.full
>> +               _notrun "system too fast and/or too small fs"
>=20
> It would probably be better to require so minimal size for the
> filesystem instead.
>=20
>> +       fi
>> +       # If killed properly, this file should be empty.
>=20
> Confusing comment for me. If killed properly? How does that influence
> the file being empty?
> What influences the file being empty is that it's impossible (in
> practice) for xfs_io to complete the write in less then 2 seconds,
> assuming the fs isn't very small and it hits ENOSPC in less than 2
> seconds.

The point I want to express is, if xfs_io is killed by KILL signal
halfway without finish, it doesn't output anything. So if the output
file is not empty (and not ENOSPC), we must have something wrong happened=
=2E

I'll rephrase that line.

Thanks,
Qu
>=20
> I would rephrase that or remove that line.
>=20
> Other than that it looks ok to me.
>=20
> Thanks
>=20
>> +       # If something other than ENOSPC happened, output to make sure=
 we can
>> +       # detect the error
>> +       cat $tmp.filler_result
>>         sync; sync
>>  }
>>
>> @@ -147,7 +178,7 @@ btrfs_replace_test()
>>         if [ "${with_cancel}Q" =3D "cancelQ" ]; then
>>                 # background the replace operation (no '-B' option giv=
en)
>>                 _run_btrfs_util_prog replace start -f $replace_options=
 $source_dev $target_dev $SCRATCH_MNT
>> -               sleep 1
>> +               sleep $wait_time
>>                 _run_btrfs_util_prog replace cancel $SCRATCH_MNT
>>
>>                 # 'replace status' waits for the replace operation to =
finish
>> @@ -157,10 +188,10 @@ btrfs_replace_test()
>>                 grep -q canceled $tmp.tmp || _fail "btrfs replace stat=
us (canceled) failed"
>>         else
>>                 if [ "${quick}Q" =3D "thoroughQ" ]; then
>> -                       # On current hardware, the thorough test runs
>> -                       # more than a second. This is a chance to forc=
e
>> -                       # a sync in the middle of the replace operatio=
n.
>> -                       (sleep 1; sync) > /dev/null 2>&1 &
>> +                       # The thorough test runs around 2 * $wait_time=
 seconds.
>> +                       # This is a chance to force a sync in the midd=
le of the
>> +                       # replace operation.
>> +                       (sleep $wait_time; sync) > /dev/null 2>&1 &
>>                 fi
>>                 _run_btrfs_util_prog replace start -Bf $replace_option=
s $source_dev $target_dev $SCRATCH_MNT
>>
>> --
>> 2.22.0
>>
>=20
>=20


--30Ye9FkBfAyuyOC14LFV2JVgRFMmLzVlA--

--d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2LO2oACgkQwj2R86El
/qgdiQf+JvjWxMjjgcaYOMb0mQONW+5PDuP1gGCbeaT52FG1P5DzXOtE9tzN613A
osI/bo/cUU0bTu3wZ8iOIXgoGRBWnfFemS8EflAJAHiIpdq5Bxaqi68TjjIbrl9I
xKQS9Evx1InoUF3N1I2n7+KQ2Sd/kJ+Fxn77vtpyBzgDQgGgLkq5RsCrA70PClkN
8OLooKoCCn5E10Ka7Az720SM8Ufg4CDgjb9dSO2Vk3c2BCLUMIYjJYGCKSR6TbqU
UB29dNCHoHeJILhZpJElRV9G4a27Vn9rfrEzBJi9tTYPMbab7V/qjyQ9ApqKqBML
eeb08UJM5G6/xvXL/VSQdEiBQlR0CA==
=CRBe
-----END PGP SIGNATURE-----

--d8FnmPzJ4kQJgw99XsYZzXOMbuqHBGA7a--
