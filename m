Received: from mout.gmx.net ([212.227.17.22]:48547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753155AbeCFJZ5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Mar 2018 04:25:57 -0500
Subject: Re: [PATCH 3/3] fstests: btrfs: Add test case to check v1 space cache
 corruption
References: <20180306081555.3242-1-wqu@suse.com>
 <20180306081555.3242-3-wqu@suse.com>
 <CAOQ4uxhbJr9v6o-nEdFnpp9_gv6KhDNCU2VQRuVmEKS=EypPMQ@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <bfc2b302-14b8-b5a7-a3f7-7ca7abeb5605@gmx.com>
Date: Tue, 6 Mar 2018 17:25:41 +0800
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhbJr9v6o-nEdFnpp9_gv6KhDNCU2VQRuVmEKS=EypPMQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1hs61iMNhwQHAbpTmNW9eeMG8wnSP5IQG"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: Linux Btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1hs61iMNhwQHAbpTmNW9eeMG8wnSP5IQG
Content-Type: multipart/mixed; boundary="CnbxAVO7nQduLJLgXSQ0JKxqoIv6DixI2";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Amir Goldstein <amir73il@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: Linux Btrfs <linux-btrfs@vger.kernel.org>,
 fstests <fstests@vger.kernel.org>, dsterba@suse.cz
Message-ID: <bfc2b302-14b8-b5a7-a3f7-7ca7abeb5605@gmx.com>
Subject: Re: [PATCH 3/3] fstests: btrfs: Add test case to check v1 space cache
 corruption
References: <20180306081555.3242-1-wqu@suse.com>
 <20180306081555.3242-3-wqu@suse.com>
 <CAOQ4uxhbJr9v6o-nEdFnpp9_gv6KhDNCU2VQRuVmEKS=EypPMQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhbJr9v6o-nEdFnpp9_gv6KhDNCU2VQRuVmEKS=EypPMQ@mail.gmail.com>

--CnbxAVO7nQduLJLgXSQ0JKxqoIv6DixI2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B403=E6=9C=8806=E6=97=A5 17:03, Amir Goldstein wrote:
> On Tue, Mar 6, 2018 at 10:15 AM, Qu Wenruo <wqu@suse.com> wrote:
>> There are some btrfs corruption report in mail list for a while,
>> although such corruption is pretty rare and almost impossible to
>> reproduce, with dm-log-writes we found it's highly related to v1 space=

>> cache.
>>
>> Unlike journal based filesystems, btrfs completely rely on metadata Co=
W
>> to protect itself from power loss.
>> Which needs extent allocator to avoid allocate extents on existing
>> extent range.
>> Btrfs also uses free space cache to speed up such allocation.
>>
>> However there is a problem, v1 space cache is not protected by data Co=
W,
>> and can be corrupted during power loss.
>> So btrfs do extra check on free space cache, verifying its own in-file=
 csum,
>> generation and free space recorded in cache and extent tree.
>>
>> The problem is, under heavy concurrency, v1 space cache can be corrupt=
ed
>> even under normal operations without power loss.
>> And we believe corrupted space cache can break btrfs metadata CoW and
>> leads to the rare corruption in next power loss.
>>
>> The most obvious symptom will be difference in free space:
>>
>> This will be caught by kernel, but such check is quite weak, and if
>> the net free space change is 0 in one transaction, the corrupted
>> cache can be loaded by kernel.
>>
>> In this case, btrfs check would report things like :
>> ------
>> block group 298844160 has wrong amount of free space
>> failed to load free space cache for block group 298844160
>> ------
>>
>> But considering the test case are using notreelog, btrfs won't do
>> sub-transaction commit which doesn't increase generation, each
>> transaction should be consistent, and nothing should be reported at al=
l.
>>
>> Further more, we can even found corrupted file extents like:
>> ------
>> root 5 inode 261 errors 100, file extent discount
>> Found file extent holes:
>>         start: 962560, len: 32768
>> ERROR: errors found in fs roots
>> ------
>>
>=20
> So what is the expectation from this test on upstream btrfs?
> Probable failure? reliable failure?

Reliable failure, as the root reason is not fully exposed yet.

> Are there random seeds to fsstress that can make the test fail reliably=
?

Since concurrency is involved, I don't think seed would help much.

> Or does failure also depend on IO timing and other uncontrolled paramet=
ers?

Currently the concurrency would be the main factor.

>> +#
>> +#--------------------------------------------------------------------=
---
>> +# Copyright (c) SUSE.  All Rights Reserved.
>=20
> 2018>
>> +#
[snip]
>> +
>> +_log_writes_replay_log_entry_range $prev >> $seqres.full 2>&1
>> +while [ ! -z "$cur" ]; do
>> +       _log_writes_replay_log_entry_range $cur $prev
>> +       # Catch the btrfs check output into temp file, as we need to
>> +       # grep the output to find the cache corruption
>> +       $BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV &> $tmp.=
fsck
>=20
> So by making this a btrfs specific test you avoid the need to mount/umo=
unt and
> revert to $prev. Right?

Yes. Especially notreelog mount option disables journal-like behavior.

>=20
> Please spell out the missing pieces for making a generic variant
> to this test, so if anyone wants to pick it up they have a good startin=
g point.
> Or maybe you still intend to post a generic test as well?

I'm still working on the generic test, but the priority is the btrfs
corruption fixing.

For the missing pieces, we need dm-snapshot to make journal based
filesystems to replay their log without polluting the original device.

Despite that, current code should illustrate the framework.

>=20
>> +
>> +       # Cache passed generation,csum and free space check but corrup=
ted
>> +       # will be reported as error
>> +       if [ $? -ne 0 ]; then
>> +               cat $tmp.fsck >> $seqres.full
>> +               _fail "btrfs check found corruption"
>> +       fi
>> +
>> +       # Mount option has ruled out any possible factors affect space=
 cache
>> +       # And we are at the FUA writes, no generation related problem =
should
>> +       # happen anyway
>> +       if grep -q -e 'failed to load free space cache' $tmp.fsck; the=
n
>> +               cat $tmp.fsck >> $seqres.full
>> +               _fail "btrfs check found invalid space cache"
>> +       fi
>> +
>> +       prev=3D$cur
>> +       cur=3D$(_log_writes_find_next_fua $prev)
>> +       [ -z $cur ] && break
>> +
>> +       # Same as above
>> +       cur=3D$(($cur + 1))
>> +done
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
>> new file mode 100644
>> index 00000000..e569e60c
>> --- /dev/null
>> +++ b/tests/btrfs/159.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 159
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 8007e07e..bc83db94 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -161,3 +161,4 @@
>>  156 auto quick trim
>>  157 auto quick raid
>>  158 auto quick raid scrub
>> +159 auto
>=20
> Please add to "replay" group.
>=20
> How long does the test run? Is it not quick?

It's quick, less than one minute.

But since it's using LOAD_FACTOR, fast doesn't seem proper here.

Thanks,
Qu

>=20
> Thanks,
> Amir.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--CnbxAVO7nQduLJLgXSQ0JKxqoIv6DixI2--

--1hs61iMNhwQHAbpTmNW9eeMG8wnSP5IQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlqeXpUXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgWUwf+Oav6JpQbPHELZSwU3N3e1sPa
f33PcyoBz7A9eOQ08NQTAU9N2GufGMeJlyCJEm8v40G0z129BAPpEv/pI6n2SvyN
EWsvsltQCSRYDkrp4+ByPE9MMs/9EWVBwpSUSby1onC7VLji0PGJR6HTR9qFlar0
Pn7jCIp6VhEwG2WAVRlNwcj3+RViQde6ofwhcDsRTnG/PRXTi2tt4HfPHhw2x8WK
pKt6oD2ZZohR48eqpNS8tHzq8KIvZj1VZ5TmpZhkodMAkwpbF/HvhFWA4OSt/PyZ
2e1MEZLY1HwfvsOtr/rlK03cNX+i3gkSjWqpOBb37ar3z3LEAmoYY/H+bJCgVA==
=pRQU
-----END PGP SIGNATURE-----

--1hs61iMNhwQHAbpTmNW9eeMG8wnSP5IQG--
