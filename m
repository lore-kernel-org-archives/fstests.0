Received: from mout.gmx.net ([212.227.17.20]:60417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752538AbeCPIpB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Mar 2018 04:45:01 -0400
Subject: Re: [PATCH RFC 3/3] fstests: generic: Check the fs after each FUA
 writes
References: <20180314090230.25055-1-wqu@suse.com>
 <20180314090230.25055-3-wqu@suse.com>
 <20180316040119.GN30836@localhost.localdomain>
 <90382d48-0f21-d758-3896-467d8616d74b@gmx.com>
 <20180316081952.GQ30836@localhost.localdomain>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a1b7dc82-2233-e08e-f61e-f69fe941c2d8@gmx.com>
Date: Fri, 16 Mar 2018 16:44:45 +0800
MIME-Version: 1.0
In-Reply-To: <20180316081952.GQ30836@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h2jgI8jFWVSV154R5pDLU2pr3jv8WmRYb"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h2jgI8jFWVSV154R5pDLU2pr3jv8WmRYb
Content-Type: multipart/mixed; boundary="NwgCgKx42CaapAiI8voH44Suvy58FFtqL";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Eryu Guan <guaneryu@gmail.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org, amir73il@gmail.com
Message-ID: <a1b7dc82-2233-e08e-f61e-f69fe941c2d8@gmx.com>
Subject: Re: [PATCH RFC 3/3] fstests: generic: Check the fs after each FUA
 writes
References: <20180314090230.25055-1-wqu@suse.com>
 <20180314090230.25055-3-wqu@suse.com>
 <20180316040119.GN30836@localhost.localdomain>
 <90382d48-0f21-d758-3896-467d8616d74b@gmx.com>
 <20180316081952.GQ30836@localhost.localdomain>
In-Reply-To: <20180316081952.GQ30836@localhost.localdomain>

--NwgCgKx42CaapAiI8voH44Suvy58FFtqL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B403=E6=9C=8816=E6=97=A5 16:19, Eryu Guan wrote:
> On Fri, Mar 16, 2018 at 01:17:07PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2018=E5=B9=B403=E6=9C=8816=E6=97=A5 12:01, Eryu Guan wrote:
>>> On Wed, Mar 14, 2018 at 05:02:30PM +0800, Qu Wenruo wrote:
>>>> Basic test case which triggers fsstress with dm-log-writes, and then=

>>>> check the fs after each FUA writes.
>>>> With needed infrastructure and special handlers for journal based fs=
=2E
>>>
>>> It's not clear to me why the existing infrastructure is not sufficien=
t
>>> for the test. It'd be great if you could provide more information and=
/or
>>> background in commit log.
>>
>> The main problem of current infrastructure is we don't have the
>> following things:
>>
>> 1) Way to take full advantage of dm-log-writes
>>    The main thing is, we don't have test cases to check each FUA (this=

>>    patch) and flush (later patch after clearing all the RFC comments).=

>>
>>    We have some dm-flakey test cases to emulate power loss, but they a=
re
>>    mostly for fsync.
>>    Here we are not only testing fsync, but also every superblock updat=
e.
>>    Which should be a super set of dm-flakey tests.
>>
>> 2) Workaround for journal replay
>>    In fact, if we only test btrfs, we don't even need such complicated=

>>    work, just 'replay-log --fsck "btrfs check" --check fua' will be
>>    enough. As btrfs check doesn't report dirty journal (log tree) as
>>    problem.
>>    But for journal based fses, their fsck all report dirty journal as
>>    error, which needs current snapshot works to replay them before
>>    running fsck.
>=20
> And replay-to-fua doesn't guarantee a consistent filesystem state,
> that's why we need to mount/umount the target device to replay the
> filesystem journal, and to avoid replaying already-replayed-log over an=
d
> over again, we create a snapshot of the target device and mount cycle &=

> fsck the snapshot, right?
>=20
> I'm wondering if the overhead of repeatly create & destroy snapshots is=

> larger than replaying log from start. Maybe snapshots take more time?

This is the interesting part.

Repeatedly creating snapshot will become slower and slower, and in fact
for ext4/xfs it's pretty slow, so I use the small nops for fsstress
(512), as for later snapshot creation it's taking quite a long time.

But if we switch back to no snapshot, but pure replay-log method,
replay-log itself will become slow too.
But at least it can go much further (nops=3D2048) and still get a somewha=
t
acceptable speed.

Either way, we will get slower and slower when the number of operation gr=
ow.


However personally speaking, the pure replay-log one looks a little
better, as I don't need to use LVM to create snapshot. :)

>=20
>>
>> I would add them in next version if there is no extra comment on this.=

>>
>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> In my test, xfs and btrfs survives while ext4 would report error dur=
ing fsck.
>>>>
>>>> My current biggest concern is, we abuse $TEST_DEV and mkfs on it all=
 by
>>>> ourselves. Not sure if it's allowed.
>>>
>>> As Amir already replied, that's not allowed, any destructive operatio=
ns
>>> should be done on $SCRATCH_DEV.
>>
>> Yep, I'm looking for similar case who uses $SCRATCH_DEV as LVM pv do g=
et
>> extra device.
>>
>> Or can we reuse the scratch_dev_pool even for ext4/xfs?
>=20
> I think so, IMO pool devices are not limited to btrfs. But I think we
> could use a loop device reside on $TEST_DIR? Or if snapshots take longe=
r
> time, then we don't need this extra device at all :)

That would be much better!

Both common/dmlogwrites and the test case will be much simpler.

Thanks,
Qu

>=20
> I have some other comments, will reply to the RFC patch in another
> email.
>=20
> Thanks,
> Eryu
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--NwgCgKx42CaapAiI8voH44Suvy58FFtqL--

--h2jgI8jFWVSV154R5pDLU2pr3jv8WmRYb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlqrg/0XHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhx/QgApr2scLjyGDIG/o9W/UYHolnv
SOWWuZotZh+ndoXi7vXEu9EmUk5Kbclf01meBnuQdqIdAFKgZzaAb72W66SOnvul
0jVZBPVWOBwXI2OAqhRg/w1x+C6dMK1CBckFmnMAuorATREk6CsfSLx7HCdQ8iV2
WYanqbZwhqXPjUnXcLv4shikQZNKVobosYVfc101ObJQ5vEdmZNvcqJVz+ZFIL8D
dpdApwdqaaG4+q/0muvl4dn5S6WTH6dZckwlNU0ePyQFxQwt+L0Vjy5qY9igQlHy
6PaRg3lgyn8XDIxhlwgr6YJIhUeLnv/jbLnHUqOEUUJbeP1gPIQP3d4YF+4H6Q==
=q3ed
-----END PGP SIGNATURE-----

--h2jgI8jFWVSV154R5pDLU2pr3jv8WmRYb--
