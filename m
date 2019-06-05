Received: from mx2.suse.de ([195.135.220.15]:54200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbfFELQP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Jun 2019 07:16:15 -0400
Subject: Re: [PATCH v2] fstests: generic/260: Make it handle btrfs more
 gracefully
References: <20190603064009.9891-1-wqu@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <261bff5e-c0c1-2a38-28d9-964a6c713745@suse.com>
Date: Wed, 5 Jun 2019 14:16:12 +0300
MIME-Version: 1.0
In-Reply-To: <20190603064009.9891-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 3.06.19 =D0=B3. 9:40 =D1=87., Qu Wenruo wrote:
> If a filesystem doesn't map its logical address space (normally the
> bytenr/blocknr returned by fiemap) directly to its devices(s), the
> following assumptions used in the test case is no longer true:
> - trim range start beyond the end of fs should fail
> - trim range start beyond the end of fs with len set should fail
>=20
> Under the following example, even with just one device, btrfs can still
> trim the fs correctly while breaking above assumption:
>=20
> 0		1G		1.25G
> |---------------|///////////////|-----------------| <- btrfs logical
> 		   |				       address space
>         ------------  mapped as SINGLE
>         |
> 0	V	256M
> |///////////////|			<- device address space
>=20
> Thus trim range start=3D1G len=3D256M will cause btrfs to trim the 256M
> block group, thus return correct result.
>=20
> Furthermore, there is no cleared defined behavior for whether a fs shou=
ld
> trim the unmapped space. (only for indirectly mapped fs)
>=20
> Btrfs currently will always trim the unmapped space, but the behavior
> can change as large trim can be very expensive.
>=20
> Despite the change to skip certain tests for btrfs, still run the
> following tests for btrfs:
> - trim start=3DU64_MAX with lenght set
>   This will expose a bug that btrfs doesn't check overflow of the range.
>   This bug will be fixed soon.
>=20
> - trim beyond the end of the fs
>   This will expose a bug where btrfs could send trim command beyond the
>   end of its device.
>   This bug is a regression, can be fixed by reverting c2d1b3aae336 ("bt=
rfs:
>   Honour FITRIM range constraints during free space trim")
>=20
> With proper fixes for btrfs, this test case should pass on btrfs, ext4,
> xfs.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
> - Return 0/1 instead of echo "1"/"0" for _is_fs_directly_mapped
>   Although it may be a little confusing, but make
>   "if _is_fs_directly_mapped; then" much cleaner.
> - Comment change.
> ---

Nope, the output is rather unhelpful. Current misc-next of btrfs fails
and the output is:

[+] Start =3D 2^64-1 and len is set (should fail)

[+] Trim an empty fs

13554941952 trimed

[+] Try to trim beyond the end of the fs

[+] Try to trim the fs with large enough len

15727198208 trimed

generic/260	[failed, exit status 1]


There is no 260.out file which is supposed to contain some of the error
strings which in turn makes the test tedious to debug...


<snip>
