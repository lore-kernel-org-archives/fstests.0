Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869B3C28D13
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Aug 2022 14:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiHVO33 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Aug 2022 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiHVO32 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Aug 2022 10:29:28 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837BB1A803
        for <fstests@vger.kernel.org>; Mon, 22 Aug 2022 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661178567; x=1692714567;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZOF6FNyBNU2ffs7fvEEuQfnQ8AznNiZ0R0SANtuwEgU=;
  b=Hu0PkrMr+eAt2NSstHxaSLbGdFmKn2KenBCIugYGnmS/Xb+b2jstHcAC
   0d1ODJONFyQPG+LZxnIcrDJDz0yLjZS3kgNrJxsNrF+hmhcExwpJM+0Gp
   5F1Gz7quNdE4LdhoGFa1hRy7JyZP/oGX6Q3JEZG1D8KZT1CHAebHlWNyZ
   CuCcuf26wQ1ZT631Qh2euBKASzNxFvL/ADrbSZ7WfrK8ssZoR20zi+L+x
   GzsWvqQy1Rx4IL3JKGvpHYq6mvhTc2ly4sb2dsz1bEs53deVEO31onTMx
   0lzJ/8rTCcoj+YTtzOz25k7zqbyXGtIGehfCWtOA0uHtjr6OvZKoDJ/Y5
   g==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="209843437"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2022 22:29:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzk+qjjtC2RXRU97ACnzJFDcubtAVALLm9oeW+y8MdqRD6/JYlYpBu82qnybLylpWo4k2p8iDCVE6HnV10hvf4/dRo0dNfs6Sy9F7W5IDpOIgWlGshijlPIg7qGKsVk+APxRBuq64qq5bGyYfyOIbRVZdTxSTCE1kGpX4UK0aIOIZShLO5FreO8HNgHKXWWRlknJFkl6mCkQjzRKHJ1ELsawCiAO/WBh/smDAKeu6d0WesGQBXZW/bZFETaxco/JPTPE5+PHxaJjfb4meVDxdDF4jndfCGQ4V9YBVfqQvQQAxLHlSFp7OSjt3yoGgXQnqXLClHkgnDpX5oUxdbMI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwLUDo9Y1x79M4ab/sTzv2XG43WQ/hKms4fiurnKvAQ=;
 b=XEDqVkgKlwEAVI4hFy4NV7/3/Ctvv0E9Sd6Yixp4a/9O07eHyAoJKNJhO8wbXL4PWLC0rUCf41BbHHUJ7x5p4g9xlliAPKYkWKnm4RgIaL+JWjxVom5QUfgj6SB7A6dYh5oAhFImjVZomIUJFOqoyWb+bEUKJVikwozZVV/GzO2b29jE+JYCAKPHkl4Rei/NRiJV6rog8q6vJeyS84Ee1x0vU3Sm8dvSg6VxwazKtj9ZyTYNpOcBGJh9sINzNdSjcNVNsT3/6Tn83jc69zaiiWs41NBogN1lP0nSP3nSKV3NNJ92zTA4Lz+OVutNFgCYaTajPjW41rmAPdzlKEXETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwLUDo9Y1x79M4ab/sTzv2XG43WQ/hKms4fiurnKvAQ=;
 b=fb9Ir1SHrrCoV8pf6txmxrQ7gnESDHesZS17OKZuiHcSdfModVvI7NToDTO6kQ8OzqoZ3ofVX3Fh6/g1f+W0gbvAy6i80fIcXeTPBRXJlxEgN3qNI6w9X9FKBrYS8bZ7DN+zZNdSefBE7+kglLyUhqar/koHdqyqQ2N+sKYoZbA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6016.namprd04.prod.outlook.com (2603:10b6:208:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Mon, 22 Aug
 2022 14:29:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 14:29:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [RFC 0/1] adapting btrfs/237 to work with the new reclaim
 algorithm
Thread-Topic: [RFC 0/1] adapting btrfs/237 to work with the new reclaim
 algorithm
Thread-Index: AQHYs8JWlxw6WsDQP0KbESsZJt2/fg==
Date:   Mon, 22 Aug 2022 14:29:22 +0000
Message-ID: <PH0PR04MB7416A0B8F8FA5698EB11A0D49B719@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20220819115338eucas1p11b916296213572e97a03241ebdc399d0@eucas1p1.samsung.com>
 <20220819115337.35681-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 550a4310-51ea-4dd5-cab4-08da844ab50c
x-ms-traffictypediagnostic: MN2PR04MB6016:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0+8F1k56kDTeu83J36BNaHa6hfaLiMduFuPa7jWr0qlYRX9AmUoiiuZBwu9G/F0TXcPqTIuJJyFsRts+giuSO5xdSlCaxJsUn4T7HMlXMpFUFext6/tsgmPZHb0t8xyXLcfdAVZ6GLSB0TYXtHaCfEBt39Wv4NqH0F4VMre5qOj7ucmnXkShUpyMmKrD2LCboPSBe45tZg1QFHpimor28tftZuMKwrgzxjIbDIoPagvGsv6S3VT/dhvg7bYjJ5z8MYblOV/JAx2CegQ5FY7ipv5Fy2YjYvq3QvJUB9BMqX8WC4kI+5kV/9r8TA7SSYSyCZyYH9q5Jgl2cuGhZAzjEbvMQlCv5p999jTRlTtWpRXc6t1Mqn4VSXf6a3PEfgNdWWxIk71DoOo4MfXeYYoTAR6APELJug4Tmki11OTAmTX0vzpH9cU0N96xzdg8yu+Q2eN5FuHKTIRRDlmHve9rzym/7Sx913JHpPJBtsA9ZT2zC+d5ivgC699E4M8Vs53UZ+VrGbI8q8YF8DgWqGWXI7JexSdt99thXsaA3fggTCW1xb3z6mzUpJjpPo4CiD3M4BlF9HPmrgBHb/oS9tcwqbDJcitoOvTizuwnbAbl+8l46eDOj0v015hbYjr+0jWsxvx7CVICNzAOt0hg7+40RmWMt4BYDjXZ3wt2wGBqLqEXpQSeAJr7POzqxveycwxIgcuIL31E7XbgUIJW1fAs5wF+fFeAhcP+XW/IP5/xolWdKV632zOinwZcuJCEwCHoy7RGGsoGk0wTY4djE+F5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(6506007)(7696005)(53546011)(9686003)(478600001)(55016003)(71200400001)(41300700001)(83380400001)(2906002)(186003)(4326008)(8676002)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(5660300002)(8936002)(110136005)(54906003)(91956017)(316002)(52536014)(38070700005)(122000001)(38100700002)(33656002)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJAiwSlCafvr15aUJr25OnAZ4aJQcLpr9EdhBVPdToHPNPHpCtQhDrXoZCzl?=
 =?us-ascii?Q?imyEnJgyUsrs6fRLUJwabgZIfwJiLlzgAGqtYCJJEg0sryXVBXG1FcWeytif?=
 =?us-ascii?Q?h1/hu/QNvshXVI7CWnhdGSyZrTunpZMuA6W+wvSDcD4LTn+LZFTI6Z/zU0v7?=
 =?us-ascii?Q?T4MZGX2cwQ842ZuTZ7P8m9z8uLn5MOIAB3+IQe9kEhdao8C8AakksGJE8hHG?=
 =?us-ascii?Q?bAb1roN/ZcbcbaYsxFHrkWS3jLpvCIkcyhBLBHMlaWSrm5lAvvGcPv9tl8ZC?=
 =?us-ascii?Q?tbEQQrC5uYAvdwtbF0LipNNRPzKHOVol8A9BQ6zjsqPhO4LlDLfjtR59hrKn?=
 =?us-ascii?Q?k+jvicfLkWMLpjEaQWEbi/TCUR5rkucGYJU9Peuw+eZvpeh3spFwofDgaTd3?=
 =?us-ascii?Q?yKB1GRz9rfRa2cjGHqwKYHUfvmp8YJvFlxow4PuxJNq3/74mKHV1yyYOSw/b?=
 =?us-ascii?Q?k9aZCwoAFfiR1c90IhVsyfVX4iIBDLhxQL6qNeb5njlG4Izshu42yx3809bp?=
 =?us-ascii?Q?FJzfFE6pt9qMxDKW91M0n1E+/PMUD1hvSOf6PVYvgFr7YE9ae+zPDaUOtFtp?=
 =?us-ascii?Q?5nl9bU2j1KDhwqaggwlxygGomQaFO87gPApsmrrcPA6gUjEI6rDWUz4jFdwJ?=
 =?us-ascii?Q?eqKqOmYNAhLlpt3xGFNJfpQqlc7htQeyyOxm5mFgLtqbySFImNo5OGGYF6Bw?=
 =?us-ascii?Q?IRqMbrOiJQ4BexFSmf0MOHgQvKvMrf9bXDOw8gH5JPzYdm21vgSPVN8l/iVG?=
 =?us-ascii?Q?Ts2sXzuJ7yi4TnClKKjpogfEQY/qj/DHwt9WMaEy5JQPI6vNmr/dc/WEPa8D?=
 =?us-ascii?Q?rr6JnJdyi9Z8Byyw7LiMK6Fu7hz/XUO+QsGARkzvRdV2DLT17aeh9BzM57qH?=
 =?us-ascii?Q?uxaBoO/cVzRSlDNOIgJW6NAvL0McqfmD5tRdr5ONQae8wYyv5pV9QnpWj/4T?=
 =?us-ascii?Q?bNXrornTnQyslD9xr9frejYeqegA6DHVV6ypJ6ZOX5fpAub83fy1439MO2Ik?=
 =?us-ascii?Q?5vmAdP/TqIAxq2FCitIXXtc2agPn0pvWXxcnYxmvYb3VntdekosGGXsiP0I4?=
 =?us-ascii?Q?iM09cT8Qg0yeNkb4W0J7vA35+2WSNosZBcefcSvgtXzRXEmQoV38eS9XB3rW?=
 =?us-ascii?Q?Zx+x+cgJeG52HJDxPlUnFSv6NYdE0v33JSdGQ+Rsknf+JARbxC0Ys7dx6rAk?=
 =?us-ascii?Q?i5fvz/M4dvBHtkAzBJqfKKqQ+/1Yk/D4S7mjYCG68Vp/cC2xFH7IC3xU1Soe?=
 =?us-ascii?Q?nXyH5rVoiHYc9YaEUAu/DQb/NNDE857pEZ+I3KX8ql5FUIfGO5EZzzoN6Uu1?=
 =?us-ascii?Q?r68tefScMGTTLxbHQL949qQdHn37bErv+jbbPS7BLmWqrLZoaaVFPTg8cypl?=
 =?us-ascii?Q?OEestD+fttpohSQsGBoiqS6odOxYyWvJ5Ob3yDAF8EBtQIqlKdqKFt8jnH81?=
 =?us-ascii?Q?ExN/Kk2sfDHyNUMb7fOXuKZ9pp0Yuu9uziteWHU5NPpyYyK8WtjtBI42Dh7b?=
 =?us-ascii?Q?Xe+y0dUCyNnLbJtTPkUkO0O8FPCMn8dqtDPyJhPJYbDJvoFJLQCJa7cnxTZc?=
 =?us-ascii?Q?VBXBCQULFxKoeoBgCwjwM4+Pe3n7euJWGVKAldLXDXz/2NjFe7EuajiExbna?=
 =?us-ascii?Q?FB3aLDk4KejUx2yncZuL6kmhJKvbd/zipUHYNYpq/Zaz9I22WERArNgkcgmb?=
 =?us-ascii?Q?8taJ8sWkltuYGhTdr9upeoKq7Yo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550a4310-51ea-4dd5-cab4-08da844ab50c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 14:29:22.6151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TSQn7fs5iIqov3UOZLM66rxaqsc/HWFPvYdZUO0dJ8GhMYVwg9AfcnCadB2/81nKdetn4ZcLR31ckwfQl1O8pqPPzyPk/NNlyB2x8QZS5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6016
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 19.08.22 13:53, Pankaj Raghav wrote:=0A=
> Hi ,=0A=
> Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")=0A=
> commit, reclaim algorithm has been changed to trigger auto-reclaim once=
=0A=
> the fs used size is more than a certain threshold. This change breaks=0A=
> 237 test.=0A=
> =0A=
> I tried to adapt the test by doing the following:=0A=
> - Write a small file first=0A=
> - Write a big file that increases the disk usage to be more than the=0A=
>   reclaim threshold=0A=
> - Delete the big file to trigger threshold=0A=
> - Ensure the small file is relocated and the space used by the big file=
=0A=
>   is reclaimed.=0A=
> =0A=
> My test case works properly for small ZNS drives but not for bigger=0A=
> sized drives in QEMU. When I use a drive with a size of 100G, not all=0A=
> zones that were used by the big file are correctly reclaimed.=0A=
> Either I am not setting up the test correctly or there is something=0A=
> wrong on how reclaim works for zoned devices.=0A=
> =0A=
> I created a simple script to reproduce the scenario instead of running=0A=
> the test. Please adapt the $DEV and $big_file_size based on the drive=0A=
> size. As I am setting the bg_reclaim_threshold to be 51, $big_file_size=
=0A=
> should be at least 51% of the drive size.=0A=
> =0A=
> ```=0A=
> DEV=3Dnvme0n3=0A=
> DEV_PATH=3D/dev/$DEV=0A=
> big_file_size=3D2500M=0A=
> =0A=
> echo "mq-deadline" > /sys/block/$DEV/queue/scheduler=0A=
> umount /mnt/scratch=0A=
> blkzone reset $DEV_PATH=0A=
> mkfs.btrfs -f -d single -m single $DEV_PATH > /dev/null;  mount -t btrfs =
$DEV_PATH \=0A=
> 	/mnt/scratch=0A=
> uuid=3D$(btrfs fi show $DEV_PATH | grep 'uuid' | awk '{print $NF}')=0A=
> =0A=
> echo "51" > /sys/fs/btrfs/$uuid/bg_reclaim_threshold=0A=
> =0A=
> fio --filename=3D/mnt/scratch/test2 --size=3D1M --rw=3Dwrite --bs=3D4k \=
=0A=
> 	--name=3Dbtrfs_zoned > /dev/null=0A=
> btrfs fi sync /mnt/scratch=0A=
> =0A=
> echo "Open zones before big file trasfer:"=0A=
> blkzone report $DEV_PATH | grep -v -e em -e nw | wc -l=0A=
> =0A=
> fio --filename=3D/mnt/scratch/test1 --size=3D$big_file_size --rw=3Dwrite =
--bs=3D4k \=0A=
> 	--ioengine=3Dio_uring --name=3Dbtrfs_zoned > /dev/null=0A=
> btrfs fi sync /mnt/scratch=0A=
> =0A=
> echo "Open zones before removing the file:"=0A=
> blkzone report $DEV_PATH | grep -v -e em -e nw | wc -l=0A=
> rm /mnt/scratch/test1=0A=
> btrfs fi sync /mnt/scratch=0A=
> =0A=
> echo "Going to sleep. Removed the file"=0A=
> sleep 30=0A=
> =0A=
> echo "Open zones after reclaim:"=0A=
> blkzone report $DEV_PATH | grep -v -e em -e nw | wc -l=0A=
> ```=0A=
> =0A=
> I am getting the following output in QEMU:=0A=
> =0A=
> - 5GB ZNS drive with 128MB zone size (and cap) and it is working as=0A=
>   expected:=0A=
> =0A=
> ```=0A=
> Open zones before big file trasfer:=0A=
> 4=0A=
> Open zones before removing the file:=0A=
> 23=0A=
> Going to sleep. Removed the file=0A=
> Open zones after reclaim:=0A=
> 4=0A=
> ```=0A=
> =0A=
> - 100GB ZNS drive with 128MB zone size (and cap) and it is **not=0A=
>   working** as expected:=0A=
> =0A=
> ```=0A=
> Open zones before big file trasfer:=0A=
> 4=0A=
> Open zones before removing the file:=0A=
> 455=0A=
> Going to sleep. Removed the file=0A=
> Open zones after reclaim:=0A=
> 411=0A=
> ```=0A=
> =0A=
> Only partial reclaim is happening for bigger sized drives. The issue=0A=
> with that is, if I do another FIO transfer, the drive spits out ENOSPC=0A=
> before its actual capacity is reached as most of the zones have not been=
=0A=
> reclaimed back and are basically in an unusable state.=0A=
> =0A=
> Is there a limit on how many bgs can be reclaimed?=0A=
> =0A=
> Let me know if I am doing something wrong in the test or if it is an=0A=
> actual issue.=0A=
=0A=
Can you try setting max_active_zones to 0? I have the feeling it's yet =0A=
another (or perhaps already known, Naohiro shoudl know that) issue with =0A=
MAZ handling.=0A=
