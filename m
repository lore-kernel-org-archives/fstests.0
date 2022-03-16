Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629EEC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Mar 2022 04:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbiCPEJL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Mar 2022 00:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCPEJK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Mar 2022 00:09:10 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA1AE58
        for <fstests@vger.kernel.org>; Tue, 15 Mar 2022 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647403675; x=1678939675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/PMfjlVvbqFXHk9hdvCTnKR6clORZ3CTAaq5pVxzJdw=;
  b=I6y/jgteix1X7WvgcL1Fj01j2mLmNvTYaQLzIJ7vw4V/YXFxVTbhW3zY
   6+P0GTMtPSr80NgWgMvYohJZ5UPRhWuB/EUC9SDlJvMmK2juqdE7nBxPW
   XmM2pE98uVPiLlNp9OZkoArEY6B0qMuaWMkPHbl2Z1YrFmv4HNRnlhcA8
   76Ac6wQnrwdMI6CnPvuNXzqE4Cnyufekdn4ksYIzlY416kauRzuU7s4BR
   4sQEO7jTUpiBoqX6GTQc7+UCU3UnTTMBNCAPHss5yICyKPyM6zHCuBsDE
   CATvP6JrrFu02fNQPlGvbXxKVf7BrDZWaj5nBqcF9kXURdSvYJ6lGL7gz
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; 
   d="scan'208";a="307421766"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 12:07:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeAhsZOmRCEIfBK6kFsm5lXOY75e5HkEvp83zLX6P9HNz5Fcg13iV572iTKvovPFI9N/o5qAto0swLMaah+LGYjFzP92t/VQL+fKZFGpT+e3baWnrRHPfocvS4MCLUMk4xQP4HhG4OPi/5WrJh6CMmdKOIv/nzl7wwiRdZBut1joEBqiqGroetS5IsOJWZw+ahRcX8Np5srSOC7YVQqgvZz3zxNz9DlyHT+6AeS2N1iIcJpgXIKd0YJ6J9aEYeUra8SGDbt+TA/08DHRViYolzZGE4zngWxBwss9TQ36IDYz8P+11vxxibnnFIfvtu/w5ksN0XVGqR8wC5p9h0HOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+phQPVTBH3TflhY9UwBg4STFRg1UlYb7hlXVXSTyleE=;
 b=C2DLOP26RosFS6kfCjG51ky4xGKT6JJdW1M8San3ZXBzThDmPsne8WmI0cPin/dO98QFHQGm5Vd7HyfHoiHVw7Phn0JPd9bzdWSOUSMoQXnRHo3y/4DHUIEjWrz7j1JMBGFwNGUlOIzeXp9KELaxfbpsGJFems7zEjFgg0oDHoE3czmoSWw+4RZSZQu3yNImyuBhsS+FLMdDLjJq3ArwoxELi0n8Pf5L7pnVIKOowlMkpaOvRbCLlN0ibdyCUejdTP2BGOkYMVRaMeBZVtTxv2PjEJd8inYRC5nOis3BUGbEpDrmwAiSEp/9KQmey6aunppQk9fEBUiAgA2t/EU+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+phQPVTBH3TflhY9UwBg4STFRg1UlYb7hlXVXSTyleE=;
 b=VYXeuxmk7e+GRQO2HWnN/xeXQHCNds2EBVhZWIzbNYqnw4nTrgoskEoOVT1ZbBoxcmfPgwBVKR8yJoa54muzTRUTP63liJfk0DVxezmmbcCFmGjdYOpruAp10OBMsoWHpdlqhYuJJ4gOxUjAOcxdYUmBJzbd+WzgjcAbDN2H0Dc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BYAPR04MB5237.namprd04.prod.outlook.com (2603:10b6:a03:c4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 04:07:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 04:07:48 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH] btrfs/237: Use zone cap instead of zone size in fill_size
 and rest calculation
Thread-Topic: [PATCH] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Index: AQHYOKnio3xkIXTIeEChqO7JHW68UazBZXcA
Date:   Wed, 16 Mar 2022 04:07:48 +0000
Message-ID: <20220316040748.j5olvwr4qqpmvqgr@naota-xeon>
References: <CGME20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90@eucas1p1.samsung.com>
 <20220315201756.18829-1-p.raghav@samsung.com>
In-Reply-To: <20220315201756.18829-1-p.raghav@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08f5e480-b35a-468f-0dba-08da07028895
x-ms-traffictypediagnostic: BYAPR04MB5237:EE_
x-microsoft-antispam-prvs: <BYAPR04MB523766CE798848CAFA443FBC8C119@BYAPR04MB5237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKSeDMQjoPTE2GThPwqZlQp0Jw9i9Lo/FdIdVvkEJ71zbH8Z+FvKQUz8Y949UfuSeOtWGuqj1O7pswNE1LOBjjhi5dctAND7IMqlaRTNbqKjWeDPzrFl7O6nc5z3sDWYxcXMWRmnsMrtBLt0ILqu3kDyY2/T3UrtSQnfPWAHzNPQAlDE/KjJJxXknKRz3CgutjO0UoKsMGWMXQszQxbohgwxChmoYw/qJyvJm9fwmQXED2PtkMFWmS4Y3aewYDpLx3wCAaM3h4xy6//bzjmPJvEUcRT4yxowomzhpzeneLUWfnaCMf4DJH5wsRtOQVSmThriUr1WKOy1fcILEbtEYMK3l4P2pVcyPr8ggHpR7CRi2jHI4LE1D77lwVKIGDHy362X2lj0GGuEV95UtGLxbVIZ8do9EVAA7F0GZWLSgiMkPaEtM39+AGslnzdrOWl9DmnYeaWRncw0PozLhqL76qOAmT+SHao3+6hEWKC42jEvG1Gu9hUg6rE7S1vI6xapIEvBSwQuK62thr1Uf5Y9y06kQRCGOBOL/GeoYwiEie3j8h6t/dJUda29Fn0IusDts0quScQuRyDkYSnPfe+pZx9shW3G1XLzWqVeH3xbVwGc3z1k+5H61mBdiOnuM8mZfNelcwWuexd9ZZ/YGj113UozXb2Qg73beWFn742t+/48s5X4x2PpeNQag2zrd64wp7rNBB5WKVZ7O3O/C0tQnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6512007)(9686003)(6506007)(33716001)(54906003)(82960400001)(316002)(6916009)(508600001)(71200400001)(86362001)(6486002)(122000001)(26005)(186003)(1076003)(38070700005)(38100700002)(83380400001)(66476007)(66946007)(66446008)(2906002)(64756008)(8676002)(66556008)(76116006)(8936002)(5660300002)(4326008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zk527QjJQKLzOttpn5FzoABuRlRTK8j6TaLkxE9cXZb64J2PTGseRf76Fz?=
 =?iso-8859-1?Q?tVlLpXabmiveQP5L/ocnfPGOhzu4xE+imZD+kia7vlSnPDlabgY3fOnQF5?=
 =?iso-8859-1?Q?kloi45JtEOUno2+QLx2DHH87gO9OyUIvePRgEaq7ufzTVL0Eh2F3lyMsQL?=
 =?iso-8859-1?Q?kYAv2NuPc0LYPP/z+AX3QIPHAzOhIV5BxU49+FfESlfl03GdZXBe80MZG8?=
 =?iso-8859-1?Q?CkW4WX610m7tl1Zwz0sRBzC84sk96dXBKbGWdga2Jep4GPOGxE4mrvLkQc?=
 =?iso-8859-1?Q?n4fu08TI0r0A94+7Xp2ytyIxf3p8c23pnA9KRc2bClFIuvxEVGlCXfOEbk?=
 =?iso-8859-1?Q?PyG2NO8Vj8uN5WmgH7rRkxtSHksNzciqoYNe/vgFXIj20Hwf+Mwm1WwJ3z?=
 =?iso-8859-1?Q?pHrV055CRbjZ8IY0nIRj2Z3W5M82wnW6RuR85TX/uEvI6F8QXIv+6JtuVF?=
 =?iso-8859-1?Q?xA+F+s0h8w4C0PSGz2mQUDNIKHx/r7tcR1qeQ05i9i1gW2awJ0VmzjkKoE?=
 =?iso-8859-1?Q?yHr3FEROL2Uk9YrCB4/WpZSb5f5GHP6tS6He8RtgEyjsYo83s+0zz3z5Qp?=
 =?iso-8859-1?Q?A9yHRP1kdFLykuMAouUxTxbaqTCQZx4mO4ZWYhhTnse397IS7iUgwc9jKl?=
 =?iso-8859-1?Q?HwQ95jQ0cu0v8k4IVFt7LLzI0y5nowqR/RuW7H70AMde+3AEzrgUYrm22W?=
 =?iso-8859-1?Q?v4D/TBjcLKeV8NFyfYpAYVFPgK6eOj0l2GftyumIGqLJ4poM/WNcEARDQq?=
 =?iso-8859-1?Q?C+OfITq39H5uuLB6ROf7qJBgCrkTqwnxOAGwHIVD/jxCLkNj4J3GkvrjJQ?=
 =?iso-8859-1?Q?xC60VO3J6u+VlSei05t2f8P3/dsZkSxSlNaopY3ypnTUpW4KVuKzeduyu3?=
 =?iso-8859-1?Q?FHO3IHYOItJvh8fKmLLfJRgX8Mi/zsD7XT4XQN9AiBRZ80zBArth4TizTP?=
 =?iso-8859-1?Q?aRbB4RuYfzOiqV6Kn9fuM1SoTH0Pcd+nEJ/rfr4I+hLnGWKH85nagT2iwT?=
 =?iso-8859-1?Q?hIpP5nAmi7LPNtfwT3hrCySKnQk1+m3pJtr0NWnh5z7NeSjTqjKTx7fNkH?=
 =?iso-8859-1?Q?lJKa0/8TpRgBER4tieuFo8JSmhzbn6MmiVjfNkyY9yGpSf3uazUj30Tx+H?=
 =?iso-8859-1?Q?6ElM03XJRmET4jeSWBq7V49UNYgAXsX4Ei41rd84IzQ9rl3Eqll69rOSFu?=
 =?iso-8859-1?Q?STz6y99UhFtEvMIdK92qbzGrfsqYwYqkn62EQOP0pLnkTwTy/qwlcSxgr6?=
 =?iso-8859-1?Q?2ILI7c/gZQZ+hBnjPkxZL8WII7QiWCefrjxWS2OeuVTThVy+7F28FgByEb?=
 =?iso-8859-1?Q?kczUuKuPyLCEJwTrUsBlNnEZ3v9afStOiHQOvfUqpppbC5Ch7PrZCEg2Cb?=
 =?iso-8859-1?Q?hDkBusyiCVgOsfNsw6EAkRGdKPdTVZhhPvzQ2WLFv9tOkS3NocUy5zyl8E?=
 =?iso-8859-1?Q?I1KWfeewm6iEJju/F5IUAr2FZKJol/vGwXWtIcqbn/k3lL0cqRLD0MeAYy?=
 =?iso-8859-1?Q?Xkj+AYicXTIrncexxFTeiPVmsvFWhanq9t3Q+CUq+kKQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <06B1E8EB2ECCA545AFCB793D0DEE1FC5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f5e480-b35a-468f-0dba-08da07028895
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 04:07:48.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfeSe+it8PArpQM89VMI+/gAA2z+qsXSzAgCRI7INezWY0CeFIu3b/hKnK1QKsPHEYTEIWuTezdjAhYteePbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5237
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 15, 2022 at 09:17:56PM +0100, Pankaj Raghav wrote:
> This test will break when zone capacity !=3D zone size because the
> calculation of the size to be filled is done using zone_size instead of
> the actual capacity available per zone. Fix it by using zone capacity.
>=20
> The support to extract zone capacity was added to blkzone only from
> version 2.37. So zcap will be used only when the blkzone version is
> greater or equal to 2.37.
>=20
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  tests/btrfs/237 | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index 96940549..6d3fe2f2 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -36,7 +36,21 @@ get_data_bg()
>  }
> =20
>  zonesize=3D$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_secto=
rs)
> -zonesize=3D$((zonesize << 9))
> +size=3D$((zonesize << 9))
> +
> +# blkzone supports printing zone cap only after version 2.37
> +_blkzone_req_major_ver=3D2
> +_blkzone_req_minor_ver=3D37
> +blkzone_ver=3D$($BLKZONE_PROG --version | cut -d " " -f 4 | cut -d "-" -=
f 1)
> +blkzone_ver=3D( ${blkzone_ver//./ } )
> +blkzone_major_ver=3D${blkzone_ver[0]}
> +blkzone_minor_ver=3D${blkzone_ver[1]}
> +if [[ $blkzone_major_ver -ge $_blkzone_req_major_ver &&\
> +	$blkzone_minor_ver -ge $_blkzone_req_minor_ver ]]; then

I'd like to have it as a helper.

Or, how about adding a filter and a wrapper function to add a "cap"
filed whose value equal to the zone size for the old version (like
with _getcap() and _filter_getcap())? Then, we can just call:

  zonecap=3D$(_blkzone_report ... | grep -Po "cap ([0x\d]+)+" | cut -d ' ' =
-f 2)
  size=3D$((zonecap << 9))

> +	zonecap=3D$($BLKZONE_PROG report -c 1 $SCRATCH_DEV |\
> +		grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)

But still, zone capacity can vary for each zone. So, we need to read
the capacity of a zone where the data BG resides on.

> +	size=3D$((zonecap << 9))
> +fi
> =20
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount -o commit=3D1 # 1s commit time to speed up test
> @@ -53,8 +67,8 @@ reclaim_threshold=3D75
>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
>  fill_percent=3D$((reclaim_threshold + 2))
>  rest_percent=3D$((90 - fill_percent)) # make sure we're not creating a n=
ew BG
> -fill_size=3D$((zonesize * fill_percent / 100))
> -rest=3D$((zonesize * rest_percent / 100))
> +fill_size=3D$((size * fill_percent / 100))
> +rest=3D$((size * rest_percent / 100))
> =20
>  # step 1, fill FS over $fillsize
>  $XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqre=
s.full
> --=20
> 2.25.1
> =
