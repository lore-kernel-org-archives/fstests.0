Received: from mout.gmx.net ([212.227.15.19]:52469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfBMKoc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Feb 2019 05:44:32 -0500
Subject: Re: [PATCH] fstests: fix fssum to actually ignore file holes when
 supposed to
References: <20181029094340.18154-1-fdmanana@kernel.org>
 <5e65b105-64ec-bf99-ea4d-b20622ad12a9@gmx.com>
 <CAL3q7H4xbqEdr2PGFZ34oBgYF1z-VCdt0UunF-uX9SjMZO5OUQ@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9c380e51-2406-b455-5834-2f69caf2137c@gmx.com>
Date: Wed, 13 Feb 2019 18:44:11 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4xbqEdr2PGFZ34oBgYF1z-VCdt0UunF-uX9SjMZO5OUQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5TkDh87noRpD5ODlEj4dliSDOwup2wMfT"
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5TkDh87noRpD5ODlEj4dliSDOwup2wMfT
Content-Type: multipart/mixed; boundary="jdPu9krAnu3sCu6zTEu0xRK9B3RUEmyNR";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Message-ID: <9c380e51-2406-b455-5834-2f69caf2137c@gmx.com>
Subject: Re: [PATCH] fstests: fix fssum to actually ignore file holes when
 supposed to
References: <20181029094340.18154-1-fdmanana@kernel.org>
 <5e65b105-64ec-bf99-ea4d-b20622ad12a9@gmx.com>
 <CAL3q7H4xbqEdr2PGFZ34oBgYF1z-VCdt0UunF-uX9SjMZO5OUQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4xbqEdr2PGFZ34oBgYF1z-VCdt0UunF-uX9SjMZO5OUQ@mail.gmail.com>

--jdPu9krAnu3sCu6zTEu0xRK9B3RUEmyNR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/2/13 =E4=B8=8B=E5=8D=886:21, Filipe Manana wrote:
> On Wed, Feb 13, 2019 at 5:44 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2018/10/29 =E4=B8=8B=E5=8D=885:43, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Unless the '-s' option is passed to fssum, it should not detect file =
holes
>>> and have their existence influence the computed checksum for a file. =
This
>>> tool was added to test btrfs' send/receive feature, so that it checks=
 for
>>> any metadata and data differences between the original filesystem and=
 the
>>> filesystem that receives send streams.
>>>
>>> For a long time the test btrfs/007, which tests btrfs' send/receive w=
ith
>>> fsstress, fails sporadically reporting data differences between files=
=2E
>>> However the md5sum/sha1sum from the reported files in the original an=
d
>>> new filesystems are the same. The reason why fssum fails is because e=
ven
>>> in normal mode it still accounts for number of holes that exist in th=
e
>>> file and their respective lengths. This is done using the SEEK_DATA m=
ode
>>> of lseek. The btrfs send feature does not preserve holes nor prealloc=

>>> extents (not supported by the current protocol), so whenever a hole o=
r
>>> prealloc (unwritten) extent is detected in the source filesystem, it
>>> issues a write command full of zeroes, which will translate to a regu=
lar
>>> (written) extent in the destination filesystem. This is why fssum rep=
orts
>>> a different checksum. A prealloc extent also counts as hole when usin=
g
>>> lseek.
>>>
>>> For example when passing a seed of 1540592967 to fsstress in btrfs/00=
7,
>>> the test fails, as file p0/d0/f7 has a prealloc extent in the origina=
l
>>> filesystem (in the incr snapshot).
>>>
>>> Fix this by making fssum just read the hole file and feed its data to=
 the
>>> digest calculation function when option '-s' is not given. If we ever=
 get
>>> btrfs' send/receive to support holes and fallocate, we can just chang=
e
>>> the test and pass the '-s' option to all fssum calls.
>>
>> However this is causing more problem here.
>>
>> Now since fssum doesn't skip holes, for a super large sparse file, fss=
um
>> will try to fill all the holes with zero and spend tons of CPU time
>> calculating the result.
>=20
> Yes. So will md5sum for example and many other things.
>=20
> The problem is well known and it's due to the addition of the splice
> operation to fsstress:
>=20
> https://www.spinics.net/lists/fstests/msg11257.html
>=20
> It was also making other tests slower.
> This got fixed recently in the last Sunday's update by:
>=20
> https://www.spinics.net/lists/fstests/msg11266.html
>=20
>>
>> E.g. when seed =3D 1550703281.
>> We will have a PiB level file:
>> $ ls /mnt/scratch/base/p0/f3 -alh
>> -rw-rw-rw- 1 1441 2774 666P Feb 13 13:39 /mnt/scratch/base/p0/f3
>>
>> (well, 666, no wonder this will fail)
>>
>> But it only takes aroud 1M:
>> $ du /mnt/scratch/base/p0/f3
>> 1044    /mnt/scratch/base/p0/f3
>>
>> This is even more annoying than test failure.
>>
>> Can't we just filter out the fallocate/hole punching part in the test
>> itself?
>=20
> No. Removing fallocate and hole punching operations from btrfs/007, or
> any other test, limits coverage.
> There were bugs in the past uncovered by that test exactly because
> fsstress exercises those operations.
>=20
> Further, that would not prevent creation of sparse files. Operations
> like pwrite, dwrite, clone, etc also cause sparse files.

Although fsstress get fixed, I'm considering zero page detector for
fssum. Check hole first, then check all zero page.

Then we could handle large sparse file along with zero filled receive.

Thanks,
Qu

>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>  src/fssum.c | 65 +++++----------------------------------------------=
----------
>>>  1 file changed, 5 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/src/fssum.c b/src/fssum.c
>>> index 5da39abf..f1da72fb 100644
>>> --- a/src/fssum.c
>>> +++ b/src/fssum.c
>>> @@ -224,71 +224,16 @@ int
>>>  sum_file_data_permissive(int fd, sum_t *dst)
>>>  {
>>>       int ret;
>>> -     off_t pos;
>>> -     off_t old;
>>> -     int i;
>>> -     uint64_t zeros =3D 0;
>>> -
>>> -     pos =3D lseek(fd, 0, SEEK_CUR);
>>> -     if (pos =3D=3D (off_t)-1)
>>> -             return errno =3D=3D ENXIO ? 0 : -2;
>>>
>>>       while (1) {
>>> -             old =3D pos;
>>> -             pos =3D lseek(fd, pos, SEEK_DATA);
>>> -             if (pos =3D=3D (off_t)-1) {
>>> -                     if (errno =3D=3D ENXIO) {
>>> -                             ret =3D 0;
>>> -                             pos =3D lseek(fd, 0, SEEK_END);
>>> -                             if (pos !=3D (off_t)-1)
>>> -                                     zeros +=3D pos - old;
>>> -                     } else {
>>> -                             ret =3D -2;
>>> -                     }
>>> -                     break;
>>> -             }
>>>               ret =3D read(fd, buf, sizeof(buf));
>>> -             assert(ret); /* eof found by lseek */
>>> -             if (ret <=3D 0)
>>> +             if (ret < 0)
>>> +                     return -errno;
>>> +             sum_add(dst, buf, ret);
>>> +             if (ret < sizeof(buf))
>>>                       break;
>>> -             if (old < pos) /* hole */
>>> -                     zeros +=3D pos - old;
>>> -             for (i =3D 0; i < ret; ++i) {
>>> -                     for (old =3D i; buf[i] =3D=3D 0 && i < ret; ++i=
)
>>> -                             ;
>>> -                     if (old < i) /* code like a hole */
>>> -                             zeros +=3D i - old;
>>> -                     if (i =3D=3D ret)
>>> -                             break;
>>> -                     if (zeros) {
>>> -                             if (verbose >=3D 2)
>>> -                                     fprintf(stderr,
>>> -                                             "adding %llu zeros to s=
um\n",
>>> -                                             (unsigned long long)zer=
os);
>>> -                             sum_add_u64(dst, 0);
>>> -                             sum_add_u64(dst, zeros);
>>> -                             zeros =3D 0;
>>> -                     }
>>> -                     for (old =3D i; buf[i] !=3D 0 && i < ret; ++i)
>>> -                             ;
>>> -                     if (verbose >=3D 2)
>>> -                             fprintf(stderr, "adding %u non-zeros to=
 sum\n",
>>> -                                     i - (int)old);
>>> -                     sum_add(dst, buf + old, i - old);
>>> -             }
>>> -             pos +=3D ret;
>>>       }
>>> -
>>> -     if (zeros) {
>>> -             if (verbose >=3D 2)
>>> -                     fprintf(stderr,
>>> -                             "adding %llu zeros to sum (finishing)\n=
",
>>> -                             (unsigned long long)zeros);
>>> -             sum_add_u64(dst, 0);
>>> -             sum_add_u64(dst, zeros);
>>> -     }
>>> -
>>> -     return ret;
>>> +     return 0;
>>>  }
>>>
>>>  int
>>>
>>


--jdPu9krAnu3sCu6zTEu0xRK9B3RUEmyNR--

--5TkDh87noRpD5ODlEj4dliSDOwup2wMfT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlxj9PsACgkQwj2R86El
/qj2yQgAiqQX8H07V65zNy8+C3sGn7r1TvC8hnLCKGvgHKjstz5NhcQEHNhvivmb
vnGd5w2L5RBR27XbV0GAKTtVT7rQn3BPIIoYhBx/suVzHD/z2wI+YSDT8S5/kKyn
ri3FZ5VST9WFmwk+q6dayGJ3bMrPx35isMzkrQqWYkzqBtNP+ZxwWHsYGjR83XMD
HsaNJRFUIm40DaCqDdty+qNi8UBZpdHzk7/ve9Sety3ms5P/Et+ggxakQqPutUO/
RK1gqEo0qU/H5uJrG53+bKCo8XqXiWSgrgglIzFQ4jq+8EiD436x/kTR/KMlfW76
i/NlnoblBEeFhwLJxDFOcrsGzM3FBQ==
=eT3+
-----END PGP SIGNATURE-----

--5TkDh87noRpD5ODlEj4dliSDOwup2wMfT--
