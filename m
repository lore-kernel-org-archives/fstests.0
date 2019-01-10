Received: from mx2.suse.de ([195.135.220.15]:42366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbfAJN7e (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 10 Jan 2019 08:59:34 -0500
Subject: Re: [PATCH 2/2] fstests: btrfs: Introduce stress test for deadlock
 between snapshot delete and other read-write operations
References: <20190110061415.32045-1-wqu@suse.com>
 <20190110061415.32045-2-wqu@suse.com>
 <CAL3q7H7gG4gLWaSHhLmxR-ngT-WBPXtx1=iziwcK4iquaQ6-xw@mail.gmail.com>
 <c2306946-c239-2cfa-b397-699ee42b4190@gmx.com>
 <CAL3q7H7st9hhNhgQf-pt--LOMMvzoJU6Mz7jSrq8oUtKGzXPDg@mail.gmail.com>
From: Qu Wenruo <wqu@suse.de>
Message-ID: <cddf660e-779a-e278-83b7-e54f010374b7@suse.de>
Date: Thu, 10 Jan 2019 21:59:28 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7st9hhNhgQf-pt--LOMMvzoJU6Mz7jSrq8oUtKGzXPDg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RHvCR8uFKt4Dk9xIkAwmq85bX6JIvp3Bl"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RHvCR8uFKt4Dk9xIkAwmq85bX6JIvp3Bl
Content-Type: multipart/mixed; boundary="PzJgRRx6BgghyBkeXhGq6uI5Y8Dx81rTl";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: fdmanana@gmail.com, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <cddf660e-779a-e278-83b7-e54f010374b7@suse.de>
Subject: Re: [PATCH 2/2] fstests: btrfs: Introduce stress test for deadlock
 between snapshot delete and other read-write operations
References: <20190110061415.32045-1-wqu@suse.com>
 <20190110061415.32045-2-wqu@suse.com>
 <CAL3q7H7gG4gLWaSHhLmxR-ngT-WBPXtx1=iziwcK4iquaQ6-xw@mail.gmail.com>
 <c2306946-c239-2cfa-b397-699ee42b4190@gmx.com>
 <CAL3q7H7st9hhNhgQf-pt--LOMMvzoJU6Mz7jSrq8oUtKGzXPDg@mail.gmail.com>
In-Reply-To: <CAL3q7H7st9hhNhgQf-pt--LOMMvzoJU6Mz7jSrq8oUtKGzXPDg@mail.gmail.com>

--PzJgRRx6BgghyBkeXhGq6uI5Y8Dx81rTl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/1/10 =E4=B8=8B=E5=8D=889:53, Filipe Manana wrote:
[snip]
>>>> +# Workaround to handle killed workload with unreturned syscall
>>>> +sync
>>>
>>> I can't understand that comment, nor why the call to sync (probably
>>> most readers won't either).
>>> What do you mean by "unreturned syscall"? It hangs, blocked? Because
>>> of the deadlock? How does the sync makes it "return"?
>>
>> I mean normal "btrfs subvolume create/delete" ioctl syscalls.
>>
>>>
>>> When you say killed workload, you mean though the kill commands above=
?
>>> For all pids or just some in particular?
>>
>> For the workload, it will be a forked bash process, and then executing=

>> "btrfs" program.
>> While "btrfs subvolume create/delete" could call ioctl and fall into
>> kernel space, kill/wait for the bash process could return before the
>> ioctl returned.
>>
>> So here we try to call sync which will commit current transaction, mor=
e
>> or less wait for unfinished "btrfs" ioctls to return.
>>
>> Or should I change to the more common loop of check "btrfs" process an=
d
>> wait?
>=20
> Doing something like the following seems to be what you need:
>=20
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3Dd0e=
c5f5af9479137526b73b8b4f48ef028444ffc

Thanks a lot!

It's much better than my ugly workaround.

I'll update the patch to address all your comment.

Thanks,
Qu

>=20
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>>> +
>>>> +# success, all done
>>>> +echo "Silence is golden"
>>>> +
>>>> +status=3D0
>>>> +exit
>>>> diff --git a/tests/btrfs/179.out b/tests/btrfs/179.out
>>>> new file mode 100644
>>>> index 000000000000..cb9eba3d34b1
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/179.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 179
>>>> +Silence is golden
>>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>>> index 04c0254aa4bf..46dd3c9523c2 100644
>>>> --- a/tests/btrfs/group
>>>> +++ b/tests/btrfs/group
>>>> @@ -181,3 +181,4 @@
>>>>  176 auto quick swap volume
>>>>  177 auto quick swap balance
>>>>  178 auto quick send
>>>> +179 auto qgroup dangerous
>>>> --
>>>> 2.20.1
>>>>
>>>
>>>
>>
>=20
>=20


--PzJgRRx6BgghyBkeXhGq6uI5Y8Dx81rTl--

--RHvCR8uFKt4Dk9xIkAwmq85bX6JIvp3Bl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlw3T8AACgkQwj2R86El
/qi3Cgf+LE9C5Kb0jM1FS8nD7eM6X4xcMXxIqVniKx/fjxnKcvBJdcR01NIBMJ/3
KMksvRd1VC5tN7VWJOwhxYEeD/hRXXL31eHD2Ae5GcrLuAFPDmN0so8dy6qTPxpV
O5qqWdItYNueYPWWAzyvIlGm2oE83LRCgPLHnB9eB3/fKaR/6RKQIzRl8lOQn/gO
6/ORKgINWaByJ8hbB1WoInYuYEdbbHHgwXSlZxGX1vQQ9uS33L+HYTUwL/uMa81u
6fnWQSyd2aRBWHd7jPoOZZX+vWbU2VieUHl7gJziKPYVtcWbwsZaCwBAnTPTUvPm
kEY+ZU4KTsn2MfBEYsV5wJMVKrhIfw==
=Acmq
-----END PGP SIGNATURE-----

--RHvCR8uFKt4Dk9xIkAwmq85bX6JIvp3Bl--
