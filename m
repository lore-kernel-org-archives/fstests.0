Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F29C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Feb 2022 06:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiBQGeL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:34:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiBQGeK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Feb 2022 01:34:10 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0042D23A1BA
        for <fstests@vger.kernel.org>; Wed, 16 Feb 2022 22:33:55 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220217062640usoutp0190e240f3dd6f0a06cc42800a34cc8a1c~UftEW1xMn1997719977usoutp01W;
        Thu, 17 Feb 2022 06:26:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220217062640usoutp0190e240f3dd6f0a06cc42800a34cc8a1c~UftEW1xMn1997719977usoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645079200;
        bh=CuLzhAcd05Zxq7n/O4NoXSJY3ILX8fnOESD8yGxPLsE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=D+EkuVFK9ctCEZVgJy5m+tDqVrtBGBE6Gd+f8SP+//+UKfs73VxqFkWK6DXpjuoM0
         ZjZfU9kUwC2WAWiQ9nwcOEUSBxO7OPGEXaaKl+/M5neN8hQlM9UnCUSjzQBUQZDtRp
         xy7iMeazsOhM6DBf7YVBevxCSbxPlPE3DbG77KqU=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220217062640uscas1p2d7b88e17772f02a2bad3024dcfffff53~UftERU5KG2031120311uscas1p26;
        Thu, 17 Feb 2022 06:26:40 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 9B.A7.09744.0AAED026; Thu,
        17 Feb 2022 01:26:40 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220217062640uscas1p2f42a8b05a6f8baadf8db42af7ae6f6b2~UftEFRJDA2031120311uscas1p25;
        Thu, 17 Feb 2022 06:26:40 +0000 (GMT)
X-AuditID: cbfec36d-891ff70000002610-62-620deaa05854
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 87.12.09671.F9AED026; Thu,
        17 Feb 2022 01:26:39 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Wed, 16 Feb 2022 22:26:09 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Wed, 16 Feb 2022 22:26:09 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>
Subject: Re: [PATCH v2 2/3] common/btrfs: use $AWK_PROG
Thread-Topic: [PATCH v2 2/3] common/btrfs: use $AWK_PROG
Thread-Index: AQHYIg4pRg3saJtqwEKPlYxGvxMTH6yX0KIA
Date:   Thu, 17 Feb 2022 06:26:09 +0000
Message-ID: <20220217062638.GB93653@bgt-140510-bm01>
In-Reply-To: <20220215014845.4164719-3-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF7147968CADC14BBD08F81D3FF21E5B@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzred0Fr3iTDBbu4bE43bKX3eJv1z0m
        ixsTnjI6MHtsWtXJ5vF5k5xH+4FupgDmKC6blNSczLLUIn27BK6M9cduMBXM4644c+k/SwPj
        B44uRk4OCQETidfHf7N0MXJxCAmsZJT49/8oE4TTyiRxZlUvYxcjB1jVxvehEPG1jBI3zi+B
        KvrIKPGo/zM7hHOAUeJM40IWkLlsAgYSv49vZAaxRQQ0JPZN6GUCsZkFljJKbFuVDzJVWMBc
        4vYSRogSC4lja9tYIGwjiW1T3oO1sgioSry4uB6slRfoiJsXboLVcApYSvRNvc8KYjMKiEl8
        P7UGary4xK0n85kgXhOUWDR7DzOELSbxb9dDNghbUeL+95fsEPU6Egt2f2KDsO0krhy/BjVH
        W2LZwtfMEHsFJU7OfMIC0SspcXDFDXBwSQgs5ZDYsrmDGRJCLhLTpjpC1EhLXL0+lRmiZhWj
        xJRvbewQzmZGiRm/LkBdZy2x8M96pgmMKrOQHD4LyVGzkBw1C8lRs5ActYCRdRWjeGlxcW56
        arFhXmq5XnFibnFpXrpecn7uJkZgkjn973DuDsYdtz7qHWJk4mA8xCjBwawkwvvhIG+SEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd5lmRsShQTSE0tSs1NTC1KLYLJMHJxSDUyhCS6d1ToB7dyu
        QRXW4byhZ7yaltqltBgbT/MP57joWfRUwOTi5qe/H11xmrOo/IZul/ei0xcfO9UUGqi+PvBJ
        TajoVsy+xIe6d0MdKiWNP78sN/cJOJiVvs5C/b/6jH6dtPZHnJfO3bRNceNcae74OWDfLvfS
        udlyuz983D9X101WVfvcycu202y2zK3+szht4SPnE/cOKCnnzbJR0+VrP1Es3mLus8fyxu4V
        B2Y+2fX7iMHF02UBp8yfy3rfj5uy7sCZW/XLr1zMfe/iOO9O1daZfjWRJc9T9bwiVy1QFTzl
        3SZ+bFvflHbOLS1R56e90G2dYXNmhUZZja6CleTb1dZHVr1fs9VoGacyb4sSS3FGoqEWc1Fx
        IgBngTgFoQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWS2cA0SXf+K94kg+WvdS1Ot+xlt/jbdY/J
        4saEp4wOzB6bVnWyeXzeJOfRfqCbKYA5issmJTUnsyy1SN8ugStj/bEbTAXzuCvOXPrP0sD4
        gaOLkYNDQsBEYuP70C5GTg4hgdWMEncbBLoYuYDsj4wSv5unsEIkDjBKPLsTCWKzCRhI/D6+
        kRnEFhHQkNg3oZcJxGYWWMoosW1VPshMYQFzidtLGCFKLCSOrW1jgbCNJLZNeQ/WyiKgKvHi
        4nqwVl6gE25euMkCsXc3o8S8h43sIAlOAUuJvqn3wW5gFBCT+H5qDdQucYlbT+aD2RICAhJL
        9pxnhrBFJV4+/scKYStK3P/+kh2iXkdiwe5PbBC2ncSV49eg5mhLLFv4mhniCEGJkzOfsED0
        SkocXHGDZQKjxCwk62YhGTULyahZSEbNQjJqASPrKkbx0uLi3PSKYsO81HK94sTc4tK8dL3k
        /NxNjMDYPP3vcOQOxqO3PuodYmTiYDzEKMHBrCTC++Egb5IQb0piZVVqUX58UWlOavEhRmkO
        FiVxXiHXifFCAumJJanZqakFqUUwWSYOTqkGplaGq/y1OQp536f78z3sDd+x5OvLCI2pLN58
        Lo43gjzW9twITZ5m03vwIqOgqc57naPPcgW398ScsulsjbDqdI4PYq0J1LvP5FjC59Wgtcs9
        T0WLdXHnxggBUd7uhIbAg6INC7suuXvcyd12YeXOkKz8X35c7y/vM/00pWD3waYgkUcbk5YG
        eCjMvNV0eOJTHi3O8793f89k3Rqm80j2Y8nnv3bn5uUzxjzumxhSdtjt/bxFmf4z9I74sIed
        2ahWs1VGZrfTAQd1s6prxqWrC8rr1178bZN8ZMOCfe9zr3Wc0MgVOmSm+5P9551rdoFbpxx4
        6s70hHuv2A3tDSK//noIf5S/f8vJMS00uFleiaU4I9FQi7moOBEALmyBKjwDAAA=
X-CMS-MailID: 20220217062640uscas1p2f42a8b05a6f8baadf8db42af7ae6f6b2
CMS-TYPE: 301P
X-CMS-RootMailID: 20220215014854uscas1p1958ddc714c4135f24e42f36eb53dd1ca
References: <20220215014845.4164719-1-mcgrof@kernel.org>
        <CGME20220215014854uscas1p1958ddc714c4135f24e42f36eb53dd1ca@uscas1p1.samsung.com>
        <20220215014845.4164719-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 14, 2022 at 05:48:44PM -0800, Luis Chamberlain wrote:
> Use $AWK_PROG instead of just awk in case the preferred awk
> program is different.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/btrfs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/common/btrfs b/common/btrfs
> index 5de926dd..2fdefb18 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -9,7 +9,7 @@ _btrfs_get_subvolid()
>  	mnt=3D$1
>  	name=3D$2
> =20
> -	$BTRFS_UTIL_PROG sub list $mnt | egrep "\s$name$" | awk '{ print $2 }'
> +	$BTRFS_UTIL_PROG sub list $mnt | egrep "\s$name$" | $AWK_PROG '{ print =
$2 }'
>  }
> =20
>  # _require_btrfs_command <command> [<subcommand>|<option>]
> @@ -418,7 +418,7 @@ _run_btrfs_balance_start()
>  _scratch_btrfs_sectorsize()
>  {
>  	$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
> -		grep sectorsize | awk '{print $2}'
> +		grep sectorsize | $AWK_PROG '{print $2}'
>  }
> =20
>  _btrfs_supports_forget()
> @@ -460,7 +460,7 @@ _require_btrfs_sysfs_fsid()
>  	local fsid
> =20
>  	fsid=3D$($BTRFS_UTIL_PROG filesystem show $TEST_DIR |grep uuid: |\
> -	       awk '{print $NF}')
> +	       $AWK_PROG '{print $NF}')
> =20
>  	# Check if the kernel has sysfs fsid support.
>  	# Following kernel patch adds it:
> --=20
> 2.34.1
>

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
