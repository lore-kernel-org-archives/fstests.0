Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D758C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Feb 2022 06:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiBQGeR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:34:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiBQGeP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Feb 2022 01:34:15 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357323A1B9
        for <fstests@vger.kernel.org>; Wed, 16 Feb 2022 22:34:01 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220217062548usoutp026b727f77158a0f2a0c07613bd3127155~UfsT12ZOO1724817248usoutp02O;
        Thu, 17 Feb 2022 06:25:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220217062548usoutp026b727f77158a0f2a0c07613bd3127155~UfsT12ZOO1724817248usoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645079148;
        bh=GN2Em6aRC4JVNe8qNTvPgx2+BT4G/swU0OqG2mc4t+w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ReBsmQx5AmOK2G3YdN95yG0AFzqxxjIseKEhMTcvr94Kk0AHu2fiv+FxHNU6YYZci
         cRY5QqHe7SKLGb+KNyVnmZ8Qp7mgJtOyqZPc6Q1r47dZDWtbaxLgGiwN5Pnvub4fRs
         3WXU8aFojT7iY8tgJzaAtXyfHD4zEmsu5tI/28rc=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220217062548uscas1p1f368ac34b432b038deb660b5ddfad720~UfsTvj9Hc1237112371uscas1p1H;
        Thu, 17 Feb 2022 06:25:48 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id AA.A7.09744.B6AED026; Thu,
        17 Feb 2022 01:25:48 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220217062547uscas1p23d2fc0324629bdbc92e86c1927bcfd6f~UfsTJtWEw2031120311uscas1p2N;
        Thu, 17 Feb 2022 06:25:47 +0000 (GMT)
X-AuditID: cbfec36d-891ff70000002610-2a-620dea6b381f
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id D6.12.09671.B6AED026; Thu,
        17 Feb 2022 01:25:47 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Wed, 16 Feb 2022 22:25:16 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Wed, 16 Feb 2022 22:25:16 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2 1/3] btrfs/237: adjust uuid heuristics
Thread-Topic: [PATCH v2 1/3] btrfs/237: adjust uuid heuristics
Thread-Index: AQHYIg4p/zxQIwcP2EO9+sobqPOr2qyX0GAA
Date:   Thu, 17 Feb 2022 06:25:16 +0000
Message-ID: <20220217062539.GA93653@bgt-140510-bm01>
In-Reply-To: <20220215014845.4164719-2-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <288A89CF8157B2438EC135A62A0FCA01@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djX87o5r3iTDI4sY7I43bKX3eJv1z0m
        i6VLdrBZ3JjwlNGBxWPTqk42j/f7rrJ5fN4k59F+oJspgCWKyyYlNSezLLVI3y6BK6PjWD97
        wReeitlvZzI1MO7n6mLk5JAQMJHo2PCUqYuRi0NIYCWjxM5nD5khnFYmiSmLvrLDVP1afIYV
        IrGWUeLxjG1QzkdGiZet/xghnAOMEnv3nGcCaWETMJD4fXwjM4gtIqAhsW9CL1icWeAQo8TD
        C24gtrCArcSM/3sYIWrsJKbMmAxlG0lM2NzJ1sXIwcEioCrR22cJEuYFuuLWGYgxnAKWEv+f
        /gS7jlFATOL7qTVQ48Ulbj2ZzwRxtaDEotl7mCFsMYl/ux6yQdiKEve/v2SHqNeRWLD7ExuE
        bSdxY8VqRghbW2LZwtfMEHsFJU7OfMIC0SspcXDFDRaQfyUEdnBIHF+6mB3kTgkBF4k/++Ig
        aqQlrl6fygxRs4pRYsq3NnYIZzOjxIxfF6Cus5ZY+Gc90wRGlVlIDp+F5KhZSI6aheSoWUiO
        WsDIuopRvLS4ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw9Zz+dzh3B+OOWx/1DjEycTACg5+D
        WUmE98NB3iQh3pTEyqrUovz4otKc1OJDjNIcLErivMsyNyQKCaQnlqRmp6YWpBbBZJk4OKUa
        mHa1Jim1n3naevYPX8yl9rxvjguS9gi4PkxhuFo83as2fPtvno2V0W3MM7ZMlk+YrNZ7X/3O
        1+mqAlevvLoYw53ktOP7W8c88Y021w6uLHZLXH9i90p+88c/a4xXhW7q3jHr+Y/IlMsLpi/L
        efs7rCPT661Wo+XT91Fz1fofvXjS/3QW4z77m+fX1Pwp+n/6xOpGVdMZGzs/nji5o1Zox+8f
        lorvDT6tKGLb9oJvJdePaxF9a6Jvn+UJ+TZzaXBK7N2gvbOvyJ79pH7e5d6WunCmnuf7Jr6Q
        70gI3rPL9V/w9PnXD6wKnrM/1rFylmF4t/jSH9mPbq1jbmM+ImHnE+lUu0zVi/urNu9Lr7t2
        JT+1lFiKMxINtZiLihMBzhLsFawDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWS2cA0UTf7FW+SwZE9vBanW/ayW/ztusdk
        sXTJDjaLGxOeMjqweGxa1cnm8X7fVTaPz5vkPNoPdDMFsERx2aSk5mSWpRbp2yVwZXQc62cv
        +MJTMfvtTKYGxv1cXYycHBICJhK/Fp9hBbGFBFYzSpzcVgthf2SUaN3k28XIBWQfYJTYv+wy
        M0iCTcBA4vfxjWC2iICGxL4JvUwgNrPAIUaJhxfcQGxhAVuJGf/3MELU2ElMmTEZyjaSmLC5
        k62LkYODRUBVorfPEiTMC3TDrTMgY0B27WaUOHB5AztIglPAUuL/059gNqOAmMT3U2ugdolL
        3HoynwniAQGJJXvOM0PYohIvH/9jhbAVJe5/f8kOUa8jsWD3JzYI207ixorVjBC2tsSyha+Z
        IY4QlDg58wkLRK+kxMEVN1gmMErMQrJuFpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zEst
        1ytOzC0uzUvXS87P3cQIjNjT/w5H7mA8euuj3iFGJg5GYAhyMCuJ8H44yJskxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnFfIdWK8kEB6YklqdmpqQWoRTJaJg1OqgclRaOViX9OKCbrVWap6z1a6
        MGQlf6us5Xl9tdF8/S6lbV+f3+FSuOJ/h3uT5ryP8RHH/K+dk5us1f7+SkPI3g1X5lRInVJY
        +fdo5r1NMazXMz4wXs6pFA8LuqggOX/29v0db15s/nzD+/Nv74PZUb8v7K6W7HSSnL2xX1em
        Tsve3eP8h7X6lj/r9C98PVgb7yy8XUpQKvtJPx/H2Z3TPrzsz8tNycx7o5L4qfTHR5X5fCs6
        T2tc6pfder3dKlz86v9FIr2vBVYsKdEzc6v7dUOc7eWPsEDOdafkbn/ilVVX1J28fdeEL3/L
        Oy5auRSJ2613i5kSmNDXYbHjYN2fdF8Hx9jNZcttRNpzrjb/+KnEUpyRaKjFXFScCADEMeWH
        RwMAAA==
X-CMS-MailID: 20220217062547uscas1p23d2fc0324629bdbc92e86c1927bcfd6f
CMS-TYPE: 301P
X-CMS-RootMailID: 20220215014855uscas1p287bc86c114c4b1c7e5afecf768799f01
References: <20220215014845.4164719-1-mcgrof@kernel.org>
        <CGME20220215014855uscas1p287bc86c114c4b1c7e5afecf768799f01@uscas1p2.samsung.com>
        <20220215014845.4164719-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 14, 2022 at 05:48:43PM -0800, Luis Chamberlain wrote:
> Using $(findmnt -n -o UUID mount-directory) only works on
> util-linux v2.38, not on 2.37. Even debian-testing has util-linux
> v2.37, so use a mechanism which has worked for longer to fetch the
> UUID.
>=20
> Without this the test fails on permission failure on accessing
> the file /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold as $uuid is
> empty. So while at it, add a check to ensure the UUID is never
> empty.
>=20
> Use $AWK_PROG in case the preferred awk program is not the
> preferred awk program.
>=20
> Cc: Karel Zak <kzak@redhat.com>
> Cc: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  tests/btrfs/237 | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index 5168777e..96940549 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -41,7 +41,14 @@ zonesize=3D$((zonesize << 9))
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount -o commit=3D1 # 1s commit time to speed up test
> =20
> -uuid=3D$(findmnt -n -o UUID "$SCRATCH_MNT")
> +uuid=3D$($BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV |grep uuid: |\
> +        $AWK_PROG '{print $NF}')
> +
> +if [[ "$uuid" =3D=3D "" ]]; then
> +	echo "UUID for $SCRATCH_DEV is empty, this is not expected"
> +	exit 1
> +fi
> +
>  reclaim_threshold=3D75
>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
>  fill_percent=3D$((reclaim_threshold + 2))
> --=20
> 2.34.1
>=20

Looks good.

Tested by: Adam Manzanares <a.manzanares@samsung.com>=
