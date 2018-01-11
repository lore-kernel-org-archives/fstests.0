Received: from mout.gmx.net ([212.227.17.20]:51774 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbeAKHuo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Jan 2018 02:50:44 -0500
Subject: Re: [PATCH 1/5] fstests: filter: Introduce filter to filter out
 offset for xfs_io
References: <20180111065601.5831-1-wqu@suse.com>
 <20180111072323.GF5123@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d479db71-7753-e95e-03bf-0faf915120fe@gmx.com>
Date: Thu, 11 Jan 2018 15:50:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180111072323.GF5123@eguan.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j8OWYHuNH0HLwEHF4HSUqsInb8cgfDm4t"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j8OWYHuNH0HLwEHF4HSUqsInb8cgfDm4t
Content-Type: multipart/mixed; boundary="vpBKSTRvG24ne7OIUQpTOD7bwC5qzTDCT";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Eryu Guan <eguan@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, dsterba@suse.cz
Message-ID: <d479db71-7753-e95e-03bf-0faf915120fe@gmx.com>
Subject: Re: [PATCH 1/5] fstests: filter: Introduce filter to filter out
 offset for xfs_io
References: <20180111065601.5831-1-wqu@suse.com>
 <20180111072323.GF5123@eguan.usersys.redhat.com>
In-Reply-To: <20180111072323.GF5123@eguan.usersys.redhat.com>

--vpBKSTRvG24ne7OIUQpTOD7bwC5qzTDCT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B401=E6=9C=8811=E6=97=A5 15:23, Eryu Guan wrote:
> On Thu, Jan 11, 2018 at 02:55:57PM +0800, Qu Wenruo wrote:
>> Some test cases (AFAIK, btrfs RAID recovery test cases) read out certa=
in
>> location to verify its data.
>>
>> Such read is mostly OK, but the golden output contains the on-disk
>> offset, which can differ due to underlying chunk change.
>> (This time is mkfs chunk layout change for btrfs)
>>
>> So introduce macro _filter_xfs_io_offset to filter out the offset part=

>> wrote 65536/65536 bytes at offset 136708096
>>                        ^^^^^^^^^^^^^^^^^^^^
>> And offset from "pread -v"
>> 08260000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ..........=
=2E.....
>> ^^^^^^^^^
>>
>> Reported-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  common/filter | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/filter b/common/filter
>> index 9c33efac..77afcbc4 100644
>> --- a/common/filter
>> +++ b/common/filter
>> @@ -226,6 +226,15 @@ _filter_xfs_io()
>>      sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([in=
fa0-9/.]* [EPGMKiBbytes]*\/sec and [infa0-9/.]* ops\/sec)/XXX Bytes, X op=
s\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
>>  }
>> =20
>> +# Also filter out the offset part of xfs_io output
>> +# Some test cases may be affected by underlaying extent/chunk layout =
change,
>> +# so wipe out this part to avoid golden output difference
>> +_filter_xfs_io_offset()
>> +{
>> +    # filter out " at offset XXX" and offset of "pread -v"
>> +    sed -e "s/ at offset [0-9]*$//" -e "s/^[0-9a-f]\+:/XXXXXXXX:/"
>> +}
>> +
>=20
> I'd put _filter_xfs_io part of _filter_xfs_io_offset, so the callers
> don't have to chain the filter themselves, e.g.
>=20
> - $XFS_IO_PROG ... | _filter_xfs_io | _filter_xfs_io_offset
> + $XFS_IO_PROG ... | _filter_xfs_io_offset
>=20
> And I perfer folding this 5-patch patchset into a single patch, so the
> introduction and the usage of the new helper function together provide =
a
> complete context in git log.

No problem, update on the way.

Thanks,
Qu

>=20
> Thanks,
> Eryu
>=20
>>  # stderr filter for xfs_io to handle change of error output format (e=
=2Eg.
>>  # pwrite64 -> pwrite).
>>  _filter_xfs_io_error()
>> @@ -277,7 +286,6 @@ _filter_xfs_io_pages_modified()
>>  	_filter_xfs_io_units_modified "Page" $PAGE_SIZE
>>  }
>> =20
>> -
>>  _filter_test_dir()
>>  {
>>  	# TEST_DEV may be a prefix of TEST_DIR (e.g. /mnt, /mnt/ovl-mnt)
>> --=20
>> 2.15.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--vpBKSTRvG24ne7OIUQpTOD7bwC5qzTDCT--

--j8OWYHuNH0HLwEHF4HSUqsInb8cgfDm4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlpXF0AXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhrxQf/eRszddXc3jvgXaF7WmP/qsks
/o3hDH0PpmPanOJHOL9e84lApeYI+DVIZWgniUXRYW7683BNb3bTf8E01y9CrnIv
GBjYnlC0XENr8x+hRTa0IW57/wiQL68xWNNmzIXP2SuEQY9TyfQ9fc74RYUyYKqp
Cl4J8tTB26kYoiLJmYYW1+tkkKDgR/idtR1ETibGwdLqbIbQibGAm+o86MARPGuD
8sF4PKS/X8pa8ja1RcGuJNQt4oVguFAtJIho5kKnPWlFAa6F8CzlonpzFvOjPJAG
N1PRjXqBh2SQk/CkMfamUzm4yKuX6IbxG2z1momveDrQqJCZlKbQNfbP5rEwYQ==
=uO58
-----END PGP SIGNATURE-----

--j8OWYHuNH0HLwEHF4HSUqsInb8cgfDm4t--
