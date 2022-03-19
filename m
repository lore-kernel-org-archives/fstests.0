Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F07BC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 19 Mar 2022 03:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiCSDnW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Mar 2022 23:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241936AbiCSDnS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Mar 2022 23:43:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1A29D274
        for <fstests@vger.kernel.org>; Fri, 18 Mar 2022 20:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647661298; x=1679197298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rBnnsppqVO1qNQR0Hn84Ltzu4nKBBOBoUIx6SBn6I5Q=;
  b=XNU+xQard45V3TU5g6e5J2uVT+IDoYRycwOrBa1j3WXxYPzwsaJAZtAw
   Xo+1uXUXeNdKLhyUiOZmFqMMY++TQrOWtmrBYzbqMDnSFFE3KqlJMrTTT
   OuFLxs/RtalSDPERDUB2/s/NiYfatDSL9dnse1tH3s9C/GmwQkDp362w0
   9WfH+tMhE3yjJKCz3j17lXOq4CmPfzZrVI8+JOFui1gsYSdnBNzsh42ar
   i9el72ek8QXXPQc+IBLt38f9iEQHuj1fkN613N/Xva1F2xev8aIBTwC9t
   ztcT1M706dLGO++1wW/Wwyt0wKPJcCSJkphK9goOSEs4vFntpUN2a2QGZ
   A==;
X-IronPort-AV: E=Sophos;i="5.90,192,1643644800"; 
   d="scan'208";a="195747329"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2022 11:41:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciJhDBKgw/rW4ESF+NMORgX9KxbGhq+H5gDlk4pVp/CmoiV5EKd3VyZ9ygk4Th0SWfhcERIT6hp7fuLvuhDh0/uxeM6Od1RKWwa++SUngveJ8OFu+kfY1YC8wfqwKgIQYw2g27Cbte5xS4YyG8M47A/lcE5VAGDS6mKgbv6+NYwFxms2cYCwbOypzHhZqFdfOswIkbO9obN0RR8s2wI+F2wAmwaEcTSQ36ZoTw1pMvChTY7fNkEyLOJDA/f10FsgKRg7jX6j2CUkPmIZsgwm6FqQvdWluZLZSR/YwdpF3gJAY5R5yjLXCtv56DGxko+qOlYHBMAiPfyzDYduAM6wAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viNbSYaPR5yv4UIWVJ5BReu29F5VcNLlhf/q0xYr3yM=;
 b=amylxHSc4hkw+qkJDvW7QiZ5DdxXxleQOjKi+v/NQbqV/MriT9jloKPb/QXXsIk2iyicO3mrpWkzr2jcgFhNlQlXnCkQWlHcAN86KBGsX2mBxTr6cFQJ1DvCj6QP1meXFlPJM+KRFRMe/xUzTwaA7OCOCYxSsPt7pORRfP6lzmanipSm/1MwHP0hYpE7i/GoM1qlNfnLTNiTe+uPvGgf2gf3CJKwwUHN4zrEKhKT/FUNaAOq7jAkM9dI6mJY6ON9JqsebdDqbY57DNft796B1bUYyHlyOMqviBgVGpwvEairKK7UBx/7TlL1DJklPV92xFfVLtVvjTxdRNbtwTJ0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viNbSYaPR5yv4UIWVJ5BReu29F5VcNLlhf/q0xYr3yM=;
 b=HvtASCk4phlu73/mieCUVqbWTKcYEWNj01U35fjRCt4GUmU7U9txdCVAJ5GrQfFmDAV7cxDewi6fNxJAKMX4jAIL5QdFMYGdaW8mASkO7n5ic5Ql5bek73P2ZO1GxVqNcO3hTNrl2iuQCOT9MCaTbB9gXVJIO/I4A6xy0jhroAY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM5PR04MB0314.namprd04.prod.outlook.com (2603:10b6:3:70::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Sat, 19 Mar
 2022 03:41:35 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 03:41:35 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v2] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Topic: [PATCH v2] btrfs/237: Use zone cap instead of zone size in
 fill_size and rest calculation
Thread-Index: AQHYOfqObn2ZwWKzeUi+twUUxPGDSazExusAgAAaPwCAATFWAA==
Date:   Sat, 19 Mar 2022 03:41:35 +0000
Message-ID: <20220319034134.3qz6nys62qcoab75@naota-xeon>
References: <CGME20220317122843eucas1p1d01a061e25bd7bfaaf912780c011ffdd@eucas1p1.samsung.com>
 <20220317122839.44404-1-p.raghav@samsung.com>
 <20220318075448.ansaa57hy5k3jkge@naota-xeon>
 <400c8167-c1cb-77aa-2469-3ccaefbe8932@samsung.com>
In-Reply-To: <400c8167-c1cb-77aa-2469-3ccaefbe8932@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 155885d8-92c1-4d90-cbf0-08da095a5dfc
x-ms-traffictypediagnostic: DM5PR04MB0314:EE_
x-microsoft-antispam-prvs: <DM5PR04MB0314D787A3A096E06183ECD88C149@DM5PR04MB0314.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDrTA9kkt7w5wSr04g/5T6w4jWnNp6EZk3uhe2j7XyOOzjHN+4g08TgHWcNUq1kuGZ4gwHaT+A872EfQvSaXQgZRHO/4+alfzTyNUzxT9IGQtGm7mNnKczuN6qhCpiZssgdOaRsHuH+RwNO2WsCLaZQGrPAcpBcWsvBmmks9IKESp6vdlRyOwki4OaGsqD+K7iprK/POFWWmAAprkg00mLxcmYlvQpGpX61sbXE8h1YTSKDZyHHuHIUnR+MAZ46h+1sN4v5zcowio0FlF/+EXPUr+i5XPziNfaxa+rOX9PwotIM6mYPsSYBLPiIUMS5nd0TdSl78OSrtipViZhCjUR0iNgLq+GCDOOQqEsxxSuqBz1OpfBMcpcFzDhdgIxK9QbohbduHx28JB+XTlkigyf8erU/i1gPTscCUlXbdCliFxqp19Da4Ce7EP8aNMi37+EmuBsVp9iz2lx7+aYP/FhANT4WaswRYtLI9t+m9ggSDfYFkdQNbIvzTZGZcWmdtkWTUdVg2WizGJrEUWE57AxxsCkb4+ZtbM/c+EIbrKPg0F9H19SMpR1TP4QPS573sgKN0fqnRw6r1gCvdwcAzbl0TYDXRsGB5rs6aonXd3OW6sVEFA98nr7gDxC9Pu72Hl/vBk1NoeTvQIYtUG4WxVbMZBQgBn8MVsMU0+5qIdj3cp1qnWE2ZXl8WJ0qJ6WvI4gZZ26HBGddEsDain/12dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38100700002)(38070700005)(33716001)(86362001)(508600001)(54906003)(6916009)(91956017)(66446008)(76116006)(66946007)(4326008)(71200400001)(8676002)(316002)(122000001)(82960400001)(66556008)(66476007)(6486002)(64756008)(53546011)(6506007)(9686003)(2906002)(8936002)(83380400001)(186003)(1076003)(26005)(6512007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?44FKqXuyX9+CJaV/qDW5AaadCH76b+aTPNxjc2Y/l3E531RoIES4h54K4s?=
 =?iso-8859-1?Q?B6QnA5IQznXaxv+AM+eUqgrvx/h3DbLvn8dSeELbUHXHi8tWU4W1VxfEqa?=
 =?iso-8859-1?Q?DJP6Q3aCyRW/xg+kV3C22NNTSVccgxQz12g6yNUQBzdCrWlDEl+VmZsRVq?=
 =?iso-8859-1?Q?hICqeDBFQwi8mS+xWSeEtyjh7HTOpcXduunR9BiPRIBwh/zk4tfRxcmQ5G?=
 =?iso-8859-1?Q?c7SrtXfLO7GKqbjqGYxXaxTHB5loLr9VmMy+SvCqWvODVfD+uNhZ0RuBDp?=
 =?iso-8859-1?Q?N6fWX/68ffFBMFhFeT68NzgBqiIrfL8QSFVm2SkKDG+VVMxeaZ5YwB63gW?=
 =?iso-8859-1?Q?GFmn0oFOgwdzEYN2x/YtGxinTqj61ZwxMSa87tRArkG9bP8Mh1lOqvYqNb?=
 =?iso-8859-1?Q?RXVgqR793kwMGzSzWXDNSx1qEGmJlVxQjBk+6CY2yFSceTB3kbHPsF7f00?=
 =?iso-8859-1?Q?ZZTxIAsRTvlp6Dif9oadLpwFAaZU3yUsnOyjqAEotT8E0z6MW7jV2f11DN?=
 =?iso-8859-1?Q?XSnS7qsaanWupeN1RhhEPYs1DOvc95oqfR7scP09exonOgCvxmtbEl+zkT?=
 =?iso-8859-1?Q?ens+bzZS2YiStmycjb9EGtdXh0Y7FVR75jfmYA2y/hWI5Uc0eddFlmZOdn?=
 =?iso-8859-1?Q?4BzAPrJBKePJR+QK8znj6JW9qjibHQiqiyBPufZTbaowDFUje5k9stGmZP?=
 =?iso-8859-1?Q?vcs+4JnNnz1JsoBBUhfGXhdbKHLzscEdzEcC3PK/PLucw8GNzLZZUSPV9O?=
 =?iso-8859-1?Q?LRbxdTBlVL4nryODz+bz6fBMx7/AxDPYBw5zZD6gK8zXaQOArHZqm/WlvE?=
 =?iso-8859-1?Q?ogz6dPOgzw0VJMRxT5Cs5lvlc8ulgjZFvnBM0lkgYEc28PaKGWW4n9OGER?=
 =?iso-8859-1?Q?Zs9oQm3BSnz6sAkJRkIxztqTNhae+YII5mYH/DKIeEmNUUyLf5SFBJl0PL?=
 =?iso-8859-1?Q?EiZwlb2MI7xdPxGMjHj8oveGHIKsmndKX0wXe7m6TqHzt39841PFIHxDas?=
 =?iso-8859-1?Q?xD0o7Lbm07Ep1mXn5jbjDpBUOxxTJiyE0JAt1rKbc5ZnCH8vWkdjN+obn5?=
 =?iso-8859-1?Q?lJ6SW0fKxyoB4uf/I9nIIWr+C7yQTiF4ThkhpV8DCbGvp3hHoR8Cg3J8Qt?=
 =?iso-8859-1?Q?Y4434sCbcZkV9b+9ZsgqKPD26fVwRZPT8LUiU2PVp+CoWn0kY5RxX0vq/e?=
 =?iso-8859-1?Q?HrrhIBiL/k5A3C2MNbEdwqRSKIXZJI4hJxuVtmY4+heY9yYzKc0chqwcvJ?=
 =?iso-8859-1?Q?mnsXVQeWH4yq/CdRHLcKcw1kv8o5FvoCgnGs3s53CznSUbfhud5CZNgBRM?=
 =?iso-8859-1?Q?w7LT5pZRRd6/gYmh4Ef3VZ2YLISG4dv+2zqsE61WM5dNO+6motLkiMNx9Z?=
 =?iso-8859-1?Q?roIgzZt0a6dA3gZoYoUtqzmdGd/DB46DJ53Cj2oiWGKqlkQESiJsPcp36H?=
 =?iso-8859-1?Q?c1xGaja2e1GHIq1kIIeGkyn+VSqmndgUbfW9xB0GFcs0fWlLIjpU5BWLtm?=
 =?iso-8859-1?Q?xBLGZugAxLdhHNqArhxyXmQE2AgKsa3xLiBr44d/v1Hg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E35513A7959EB241BA2C463EC23620A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155885d8-92c1-4d90-cbf0-08da095a5dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2022 03:41:35.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WSLtFNxZXhzwFhUscLgJ5wF5Y/+O6nASXZJWHLu3zRJfQRAviUgKyCN2MQcisjjuhlkregN5cMK3SVIXVap/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0314
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Mar 18, 2022 at 10:28:44AM +0100, Pankaj Raghav wrote:
>=20
>=20
> On 2022-03-18 08:54, Naohiro Aota wrote:
> >> =20
> >> -zonesize=3D$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_se=
ctors)
> >> -zonesize=3D$((zonesize << 9))
> >> -
> >>  _scratch_mkfs >/dev/null 2>&1
> >>  _scratch_mount -o commit=3D1 # 1s commit time to speed up test
> >> =20
> >> @@ -49,12 +46,18 @@ if [[ "$uuid" =3D=3D "" ]]; then
> >>  	exit 1
> >>  fi
> >> =20
> >> +data_bg_zone_idx=3D5
> >=20
> > Hmm. Yeah, it's currently there. But, I'd hesitate to use that like a
> > constant number.
> >=20
> > Instead, how about querying "btrfs inspect-internal" like in
> > get_data_bg() do? E.g, like this:
> >=20
> > # Assumes SINGLE data profile
> > btrfs inspect-internal dump-tree -t CHUNK $SCRATCH_DEV | grep -A 4 CHUN=
K_ITEM |\
> > 	grep -A 3 'type DATA\|SINGLE' |\
> > 	grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
> >=20
> > This command dumps the location of data BG in a byte unit.
> >=20
> > Then, we can calculate the sector number and can supply it to "blkzone
> > report -o".
> >=20
> Got it. I also prefer this over hardcoding.
> I think we can reuse the get_data_bg function as it also outputs the
> same data BG offset.

No, we cannot.

They look the same in number, but they are different in type. The
get_data_bg returns the logical address (virtual btrfs's internal
address) of the BG. And, my command above returns the physical address
(on-disk address) of the BG.

> Like this:
>=20
> start_data_bg_zone=3D$(get_data_bg)
> start_data_bg_zone=3D$((data_bg_zone >> 9))
>=20
> size=3D$($BLKZONE_PROG report -o $start_data_bg_zone -l 1 $SCRATCH_DEV |\
> ...
> Let me know your thoughts.
> >> +size=3D$($BLKZONE_PROG report -c $data_bg_zone_idx $SCRATCH_DEV | tai=
l -1 |\
> >> +	_filter_blkzone_report |\
> >> +	grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
> >> +size=3D$((size << 9))
> >> +
> >>  reclaim_threshold=3D75
> >>  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
> >>  fill_percent=3D$((reclaim_threshold + 2))
> >>  rest_percent=3D$((90 - fill_percent)) # make sure we're not creating =
a new BG
> >> -fill_size=3D$((zonesize * fill_percent / 100))
> >> -rest=3D$((zonesize * rest_percent / 100))
> >> +fill_size=3D$((size * fill_percent / 100))
> >> +rest=3D$((size * rest_percent / 100))
> >> =20
> >>  # step 1, fill FS over $fillsize
> >>  $XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $se=
qres.full
> >> --=20
> >> 2.25.1
>=20
> --=20
> Regards,
> Pankaj=
