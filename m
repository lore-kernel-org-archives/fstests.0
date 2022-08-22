Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E41C32789
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Aug 2022 09:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiHVJki (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Aug 2022 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiHVJkg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Aug 2022 05:40:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8452981D
        for <fstests@vger.kernel.org>; Mon, 22 Aug 2022 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661161234; x=1692697234;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5bInC/nmFlQQ38Jc+TvtrkHL9JK0QDv0JkgL2obGXX0=;
  b=k9ZDesMk5ZSPR1UVC4LAV3ERF46rzAzA+B5tpDL1w7qyAIF1erj/djeq
   F2/jDMAqiTO744XdJt2J+sl1oUp5Owye+OOYYyfSGgmvHCJEZuEFpxM9k
   aYS8o/VGSqH8J0uWmDGsO35p0CvDO7TytcvF3JZ4ZstO0uMGNvGmqDVt6
   ME4KjK+0h0p101dKDRTdI0RzpmLBrhD9Kmb80bOooGQZXyjtLThAW2oOQ
   9VRBuBuFd8Jrp1njM4aX7TcvVNPH5fy2FsE0fLefY1aaN++m/alT9CeED
   a8+ED2tj54v20SsHJyGKxqeregi7DSZxWHA7hxdoN1e7nZ7yQZtG11Z6l
   A==;
X-IronPort-AV: E=Sophos;i="5.93,254,1654531200"; 
   d="scan'208";a="321413781"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2022 17:40:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5tL+Ww5FqVt51OlyPEmOtyjdekydAv64/RASR7uYUN8gytJzFRVUH7JMBLo3xqDwF4OFCid+T/qVkkOD7pD4IRdJncTWvYtyutzQdsuyvmAAdUXu/qKeEYmbIbmasAyscWluFWy8tr1o8jJqzwQvlh863YDHG8ZxQpyqHNlUmlBh+rIuksoyUMptFKcDw2o1rIPEHS/hHhoB5u7oCc+FMq6EyAjS6amFyw+u/C9eKziogvrJzCA8AIB/BHTCH3OVe1/a6KKtCxG7sDuYuvqOECOGbLkaF9K25fzb0pvuTVmoICFBGrTuJ6pYLoLjj8drW2XY/SvR68CCQs3yRglXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fURCiExNzwla0pNETq6htyCCM7Uu/JRizjGKGU1PNfs=;
 b=ZV5+SEIkgzyvbSN7/llEuGgtvcXuTXHrJy2GE8GbntSCzlXtqYgMmAhnUIV2VpNLvqH/Ov0bw/Rf3EveQKtvwWfwsetWlaF/Hh+dXTmOtDuE0iR8gyTUGQHOk8bMHHeBww6qp1PrnhB/qLA0jlHLBBaDM/i1PGKSpIDyj/ArTi6TvJUkB7fXJ8DYZ9UY1BQiw2FHzuzF1fXdaHe+VTACesfpoFrDcGyTkGbpxDlTY4AIVuLB1ibP7IL5vv+i/G/ZjoN/riEOC22RCVn6DN9Ur2L2uhFSl3eT9nH54s04Hl33JW2TQO5HGugxXO6RnUaBbvh4P1w37Sav7YfnWA5FRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fURCiExNzwla0pNETq6htyCCM7Uu/JRizjGKGU1PNfs=;
 b=M9SMov3M+CZYU6BcOf4bWQZcxO1KbkwC76cybhnFZHaBtiTjswq+PrZ04hRGZs0QVXTP1RunMVFkXSKOrGpFzBFwschio+XrWb5L4ELTYCNEBkSXrqkmmULYle+AvDalF2HYH1s+pk/ooVFka4/8YyCm1vOhpOJWE/y9GqMT8xc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4440.namprd04.prod.outlook.com (2603:10b6:a02:f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Mon, 22 Aug
 2022 09:40:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 09:40:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [RFC 1/1] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Thread-Topic: [RFC 1/1] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Thread-Index: AQHYs8JZ3PpGE6SanE6ok8KWF5+l2w==
Date:   Mon, 22 Aug 2022 09:40:31 +0000
Message-ID: <PH0PR04MB741618CBF8C989CB7AE2E6E99B719@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220819115337.35681-1-p.raghav@samsung.com>
 <CGME20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad@eucas1p1.samsung.com>
 <20220819115337.35681-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 364fb894-e51f-4e72-b2e4-08da84225ab5
x-ms-traffictypediagnostic: BYAPR04MB4440:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AwScw26VkipGRVzXtDOvCrz2m2lBmMS7IuSRSEwdOP3wOW37wb30uR4bSz3a3LumhBLUwYuc45uEI6IRT5ZVytTRX2AYcdweHYc7h7Tb9f2EsaU1tVw3BKhXVTvMvIF70WrOSm1drQSyE6lqkTCTR9pCTWQ2xC81C/p4SlY/1MebizYrpReYhLZd58E6Q99fLEcOyKKLABzPCQHCrScQaSUsCB9TqD6pVG8gBIi1mWnk95DAe4U5WV7s4nNW6ccZrshzfOMJR6tGnCLf3Ri6yAdRcxykJDTJJ9Swa2Ik08veQzZxPQ9aevYM2uBwhphDVAEAYnaC6maoxAlqdDUCNcZlurpn9DesbX/VB9+UqszQiop7CKEY06yHEWWqvjjDzZqv8Y+lOcHwZGZI99tt5CQOD04/NVBq5MaiRPop7V01I8qw8Kif2p3W+wYssBqTVKm75Fo/jHMdEIwNsmKfhz4hW7tPaVdgFUtuzpQ8ZtU61OLCS+sZGMMgeHfYJSqEm03ziHtba5Exr2SPVDmGmytBF8b3GdiRHH4qjbxFI2dfpLaJ9vdrFXPBNfQwKafvQ/ckAvqddy8VgJ39lODrh632yVl/T6sOFJD0ejqFdfoosyI9L6j6crN04KTTa+MH7oy8CfS33BCvxEwVHEOWsZ9VNsn44iV/qrvlnXcoAgaazT4hTEhwtGejJ4BmE+CrxPDGn34xedZiBFlCPy5esJZGN3Ij1jVBdoqJ/Ytmj/Gx4oIIopYh2LCLn6IkKhtS03M/AAwYPaMxl9ddvtrmog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(186003)(82960400001)(83380400001)(122000001)(38100700002)(91956017)(38070700005)(41300700001)(66556008)(4326008)(66476007)(76116006)(64756008)(66946007)(66446008)(316002)(7696005)(54906003)(2906002)(8676002)(86362001)(52536014)(55016003)(478600001)(8936002)(5660300002)(71200400001)(53546011)(9686003)(33656002)(110136005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aRMlI/OIx0jCB9eeH4kuXnF6WkRAp4+spG05wqwqeRWNvbplt4rbDvdzVZAY?=
 =?us-ascii?Q?T02y4mrktdCHt5TbMLNFKTgsyZ5uKqz/WOruWT3KRMk+rQZbD9eRjVM6kaIX?=
 =?us-ascii?Q?E/2YOKNwLuw3dp76Ahg9kdJ6rTorXXzv+clrKlT5li/T8DCa9hewipOPfw6t?=
 =?us-ascii?Q?2oYM/SA0ic1pPCJd1ntROL4YvJqyXIBZAKRgS9AIo6Wx2KjOoU4GhTbcP4DQ?=
 =?us-ascii?Q?s4Mr0wziU4Fxv+Rhmer7bN+9znIlc4VJXl0j+Odz7CM5H2OwlN9/Vthhw6d+?=
 =?us-ascii?Q?H4lkQvir+ZSKOGsSTdsKkZccN0ix1D4h3VIKaBLxGCecWQU06hGfr7zjjUsX?=
 =?us-ascii?Q?RDj0r6WnOU2jV4XAaGeuwz9k5/mRnuDfvAC6QdL29KWTB0cFWeMIiBYuLTqG?=
 =?us-ascii?Q?HVpiBBxpgr6ytHSff3fn+EFxq9khfamTdHQZfTPTuM+nlpfZkzHHCS1Btjc7?=
 =?us-ascii?Q?dT4qQI7cpzwlUMPh91Y/Qufq57GDncmCMT7ouH4pir4cGk2HxwfI9F9MxmD4?=
 =?us-ascii?Q?gi9S5ELDeI87p9ctpKlhAUhehDVDo/CMVbyI/RkvC0ZE10CeqAreOw8HqvqC?=
 =?us-ascii?Q?7f3sc44tXq+tpyRKgrD280ZKnLjar8qWh6Bm6XhtnyPJCHg8W97rLy2uTH6Q?=
 =?us-ascii?Q?2XhKsww2juEQfgFoHYEJmWGxh0/DBI15HSqqvPjB1ADoX8bUOPpP/kSk3OY9?=
 =?us-ascii?Q?SqFC/tN9+53tPMx3jHd5h02vG8P8PeVsmuA/ZuRoIPFoRg58u+qj8QmZbgcr?=
 =?us-ascii?Q?NIBRIuNF46VNpcg9z5I0mPL4mtyaYOdMN5JWp00XNAaSwPezut+CTXNGWUnA?=
 =?us-ascii?Q?IlMGfrVE5oimUzV+VjsyuN06J3/uQgtTN6nDhA+0JBcbXM1WKPd7MaYP/4je?=
 =?us-ascii?Q?+pW4RbRnbjecjjf/cCeJOwOS/xJJc+i8Yru2Czb/laEKks0HR3W6ok80c19g?=
 =?us-ascii?Q?C/YnYoK4f/VCWRJnbV6IVxmUgvF5kM9OPKXA7TEmBiC+1UkN0I4ooTrs8S1n?=
 =?us-ascii?Q?OOTHvqOmai+Fv8mYM3w2//y0+SsMNmHbLuAV7WZHlLwnoQStqvcMvNmoI3cz?=
 =?us-ascii?Q?d0QyzYZt3JrO3PSA3udZbXJR2q88teIq8q8h9PYa9H0YpEy3e3jJW/X8vPHN?=
 =?us-ascii?Q?SBtyD6WbGV+f/N2x6OeynRF1vAXrWXpNo4ewv0x+vh1dBiW/RW9EU8CYWdNa?=
 =?us-ascii?Q?ryP9bRQtLKqVKUNuafXC/zfzCjPZLT1tN+FwsDsWIHRSCu/+G7Es8dfzaFnZ?=
 =?us-ascii?Q?MmGYOk6gylFcKshlZexMOdcGqe7xsklCDhZUwNvv9P/97gzIcdMqaQje3dsw?=
 =?us-ascii?Q?bTTzcrKm6BPXLhHDFVFDOIj+kRMHHqcnp5ERv277TeHgWtBjawke1NOa7Dgs?=
 =?us-ascii?Q?j8g+IoNxtMR2zYv/ic27Lk/BIMjV7OpkQ2EoTqBq9ldBKDMA7oVhAaRx6yT7?=
 =?us-ascii?Q?WB6wrvSEMPTn2ADE+ZmpuKswr2L+cug+WDVQvePSB2HXI3cMfd7blt+7/eqn?=
 =?us-ascii?Q?rK/MwuiDwRUge7Z1yRxsSW7IYvKgMD4rjB7NTCgm7/pXul9jXB+Z1+Hw6XB1?=
 =?us-ascii?Q?GdB6n/p5DKDtUsRjUijydGrgolBi0Mt6B2pLmZnB6yl3JziHz3TBJPAHz2e8?=
 =?us-ascii?Q?zjMZLN9sN7D20KwaQ8/da7FrCjf3hfbDtZ0Bsv1UAKweCoonkayNPUxnCm9n?=
 =?us-ascii?Q?z3sGN8yNGfAHTi40nl+3zOP+z44=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364fb894-e51f-4e72-b2e4-08da84225ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 09:40:31.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRlymEQ8stE9I/Jic+ZfgbU8ED/YZx9KINQMUnog3C4Gf9DCvBGQ3OO4weBK0HOLA1YnvRArYHMGKyleX/4WViqxSzZg/9nT89Qcs27ZoqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4440
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 19.08.22 13:53, Pankaj Raghav wrote:=0A=
> Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")=0A=
> commit, reclaim algorithm has been changed to trigger auto-reclaim once=
=0A=
> the fs used size is more than certain threshold. This change breaks this=
=0A=
> test.=0A=
> =0A=
> The test has been adapted so that the new auto-reclaim algorithm can be=
=0A=
> tested along with relocation.=0A=
=0A=
S-o-b missing.=0A=
=0A=
Thanks for doing this!=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
> ---=0A=
>  tests/btrfs/237 | 80 +++++++++++++++++++++++++++++++++++--------------=
=0A=
>  1 file changed, 57 insertions(+), 23 deletions(-)=0A=
> =0A=
> diff --git a/tests/btrfs/237 b/tests/btrfs/237=0A=
> index f96031d5..18945e78 100755=0A=
> --- a/tests/btrfs/237=0A=
> +++ b/tests/btrfs/237=0A=
> @@ -54,46 +54,80 @@ if [[ "$uuid" =3D=3D "" ]]; then=0A=
>  	exit 1=0A=
>  fi=0A=
>  =0A=
> +fssize=3D$($BTRFS_UTIL_PROG fi usage -b $SCRATCH_MNT |grep "Device size"=
 |\=0A=
> +	grep -Eo "[0-9]+")=0A=
> +=0A=
> +allocated_fssize=3D$($BTRFS_UTIL_PROG fi usage -b $SCRATCH_MNT |grep "De=
vice allocated" |\=0A=
> +	grep -Eo "[0-9]+")=0A=
> +=0A=
> +=0A=
>  start_data_bg_phy=3D$(get_data_bg_physical)=0A=
>  start_data_bg_phy=3D$((start_data_bg_phy >> 9))=0A=
>  =0A=
> -size=3D$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\=
=0A=
> +zone_cap=3D$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DE=
V |\=0A=
>  	_filter_blkzone_report |\=0A=
>  	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)=0A=
> -size=3D$((size << 9))=0A=
> +zone_cap=3D$((zone_cap << 9))=0A=
>  =0A=
> -reclaim_threshold=3D75=0A=
> -echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold=0A=
> -fill_percent=3D$((reclaim_threshold + 2))=0A=
> -rest_percent=3D$((90 - fill_percent)) # make sure we're not creating a n=
ew BG=0A=
> -fill_size=3D$((size * fill_percent / 100))=0A=
> -rest=3D$((size * rest_percent / 100))=0A=
> +fs_reclaim_threshold=3D60=0A=
> +bg_reclaim_threshold=3D75=0A=
> +echo $fs_reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold=
=0A=
> +echo $bg_reclaim_threshold > /sys/fs/btrfs/"$uuid"/allocation/data/bg_re=
claim_threshold=0A=
>  =0A=
> -# step 1, fill FS over $fillsize=0A=
> -$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqre=
s.full=0A=
> -$XFS_IO_PROG -fc "pwrite 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.ful=
l=0A=
> +fs_fill_percent=3D$((fs_reclaim_threshold + 2))=0A=
> +fill_size=3D$((fssize * fs_fill_percent / 100))=0A=
> +=0A=
> +# Remove the allocated size from the $fill_size=0A=
> +fill_size=3D$((fill_size - allocated_fssize))=0A=
> +=0A=
> +bg_fill_percent=3D$((bg_reclaim_threshold + 2))=0A=
> +zone_fill_size=3D$((zone_cap * bg_fill_percent / 100))=0A=
> +=0A=
> +# $fill_size might not cover the last zone block group with threshold=0A=
> +# for reclaim. Add the remaining bytes so that it can also be reclaimed=
=0A=
> +last_zone_offset=3D$((fill_size % zone_cap))=0A=
> +=0A=
> +if [ $last_zone_offset -lt $zone_fill_size ]; then=0A=
> +	fill_size=3D$((fill_size + zone_fill_size - last_zone_offset))=0A=
> +fi=0A=
> +=0A=
> +# This small file will be used to verify the relocation=0A=
> +relocate_file_size=3D$((zone_cap * 2 / 100))=0A=
> +=0A=
> +# step 1, fill FS over $relocated_file_size and $fill_size=0A=
> +$XFS_IO_PROG -fc "pwrite 0 $relocate_file_size" $SCRATCH_MNT/$seq.test1 =
>> $seqres.full=0A=
>  $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT=0A=
>  =0A=
> -zones_before=3D$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw=
 | wc -l)=0A=
> -echo "Before reclaim: $zones_before zones open" >> $seqres.full=0A=
>  old_data_zone=3D$(get_data_bg)=0A=
>  old_data_zone=3D$((old_data_zone >> 9))=0A=
>  printf "Old data zone 0x%x\n" $old_data_zone >> $seqres.full=0A=
>  =0A=
> -# step 2, delete the 1st $fill_size sized file to trigger reclaim=0A=
> -rm $SCRATCH_MNT/$seq.test1=0A=
> +$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test2 >> $seqre=
s.full=0A=
>  $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT=0A=
> -sleep 2 # 1 transaction commit for 'rm' and 1 for balance=0A=
> +=0A=
> +open_zones_before_reclaim=3D$($BLKZONE_PROG report --offset $start_data_=
bg_phy $SCRATCH_DEV |\=0A=
> +	grep -v -e em -e nw | wc -l)=0A=
> +=0A=
> +# sanity check=0A=
> +if [ $open_zones_before_reclaim -eq 0 ]; then=0A=
> +	echo "Error writing to the device"=0A=
> +fi=0A=
> +=0A=
> +echo "Before reclaim: $open_zones_before_reclaim zones open" >> $seqres.=
full=0A=
> +=0A=
> +# step 2, delete the $fill_size sized file to trigger reclaim=0A=
> +rm $SCRATCH_MNT/$seq.test2=0A=
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT=0A=
> +sleep 5 # sleep for transaction commit for 'rm' and for balance=0A=
>  =0A=
>  # check that we don't have more zones open than before=0A=
> -zones_after=3D$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw =
| wc -l)=0A=
> -echo "After reclaim: $zones_after zones open" >> $seqres.full=0A=
> +open_zones_after_reclaim=3D$($BLKZONE_PROG report --offset $start_data_b=
g_phy $SCRATCH_DEV |\=0A=
> +	grep -v -e em -e nw | wc -l)=0A=
> +echo "After reclaim: $open_zones_after_reclaim zones open" >> $seqres.fu=
ll=0A=
>  =0A=
> -# Check that old data zone was reset=0A=
> -old_wptr=3D$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\=
=0A=
> -	grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)=0A=
> -if [ "$old_wptr" !=3D "0x000000" ]; then=0A=
> -	_fail "Old wptr still at $old_wptr"=0A=
> +# Check that data was really relocated to a different zone=0A=
> +if [ $open_zones_after_reclaim !=3D 1 ]; then=0A=
> +	echo "Error relocating the data"=0A=
>  fi=0A=
>  =0A=
>  new_data_zone=3D$(get_data_bg)=0A=
=0A=
