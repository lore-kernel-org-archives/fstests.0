Received: from mx2.suse.de ([195.135.220.15]:43268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390540AbfEXLCG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 24 May 2019 07:02:06 -0400
Subject: Re: [PATCH v2] fstests: btrfs: Validate that balance and qgroups work
 correctly when balance needs to be resumed on mount
References: <20190523011101.4594-1-wqu@suse.com>
 <20190524090205.GN15846@desktop>
From: Qu Wenruo <wqu@suse.de>
Message-ID: <d539cf23-f9bf-7b82-6919-46512195a9cb@suse.de>
Date: Fri, 24 May 2019 19:01:51 +0800
MIME-Version: 1.0
In-Reply-To: <20190524090205.GN15846@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV
Content-Type: multipart/mixed; boundary="6qVQhlPrTJwvkGAkCZVnMDP0UddY4Mv49";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <d539cf23-f9bf-7b82-6919-46512195a9cb@suse.de>
Subject: Re: [PATCH v2] fstests: btrfs: Validate that balance and qgroups work
 correctly when balance needs to be resumed on mount
References: <20190523011101.4594-1-wqu@suse.com>
 <20190524090205.GN15846@desktop>
In-Reply-To: <20190524090205.GN15846@desktop>

--6qVQhlPrTJwvkGAkCZVnMDP0UddY4Mv49
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/24 =E4=B8=8B=E5=8D=885:02, Eryu Guan wrote:
> On Thu, May 23, 2019 at 09:11:01AM +0800, Qu Wenruo wrote:
>> There are two regressions related to balance resume:
>> - Kernel NULL pointer dereference at mount time
>>   Introduced in v5.0
>> - Kernel BUG_ON() just after mount
>>   Introduced in v5.1
>>
>> The kernel fixes are:
>> "btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
>>  dereference"
>> "btrfs: reloc: Also queue orphan reloc tree for cleanup to
>>  avoid BUG_ON()"
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> The summary seems a bit long, does this look like a proper summary to
> describe the test?
>=20
> "btrfs: resume balance on mount with qgroup"

Wow, that's short.

I'm OK with that.

Thanks,
Qu
>=20
> If so, I'll use this summary on commit.
>=20
> Thanks,
> Eryu
>=20


--6qVQhlPrTJwvkGAkCZVnMDP0UddY4Mv49--

--qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlznzx8ACgkQwj2R86El
/qgjMgf/dJpUSL9OUUsVR6jfSFS4RYp4x1YzCFinUh/DmyteXRsyOay8cddgYdB9
LTw+pmbcdmNARKlvLTZfLHovA/DV3LjCOBZ4heztcAuQUx13WHWFs4EQ3lujkAYd
rhdqBbjTdMTvBWdAMIwpbGCa4brnmrHBfna2GTob57Ms73KD1yijZHshyrPTjjTm
N+rDtq6eEh+5qSoV/UMO3QQUs1E97lJg/fveMaPQ4V3iTL+gMqinTXesji4s5PUR
pzC3rKf1lOpTvZAO1KyTKLfFfsPppgDfclcbrQEWyxh5F/xtNVa4lrIGy6XsL43j
3eBpousNuUI3aFqntyMtmXYDofvyCQ==
=mWk7
-----END PGP SIGNATURE-----

--qKrZaXhmeluwTSShBPN4uUqGDLFQhBGSV--
