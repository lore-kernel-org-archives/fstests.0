Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B56C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Oct 2021 03:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595BD60FBF
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Oct 2021 03:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhJYDUx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Oct 2021 23:20:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:16456 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhJYDUx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 24 Oct 2021 23:20:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209656421"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="209656421"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 20:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="464708622"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2021 20:18:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 24 Oct 2021 20:18:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 24 Oct 2021 20:18:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 24 Oct 2021 20:18:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh15ksrl1egnTlXujadBvrhHTdpMu7raHsmmANm2gZoN6LLKMBLe4XihT8GFdqNyXgXCfmHJAcvVoahgbrgdO8oGMDYel6Cth2SXhV0k0whkJjiMPlJrmWN5ICc35/YjT9kmrUhk3j4iDMPvE0HOvSPQDqFkxxbOd+g3CGDjxuM2YTxIIlp6zEGEP8/78gqu0L5gfqFCdNdO+raEQDBK0Kc3DJvSIsFhlAVl8OlJwUfxEaiG+9A0UZuDoitoTCFB5MFHWe5eOW85uw84nfJ2Ad98EO2KEOLTzfsftg7+ziQbs3jwKPCbWpM9QTqnbvKZwxbNmjF0FOXBGpfbGi1UPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iysyqm134Yl9SJ9XifZ0z5OseHQtWA0LoVMGShQSFTU=;
 b=lC+dolCVCdSNt9+S6QgXSOpKoirczQacItiShBUeHiPQ7qBH6LdgfXwwGEIT+4st8yU57xvRzjXuGZvP7m7AdYsaTwtClVLy93f9sp8aQEQtxDX+vwt+Jr//dSwhz6Ufh2RrScUFKQRaJXZqcBM3uw503GwCcoqzmN9almlPYZWn0sE+qYd+e2b9CByzKvkT90TCb7Rdpck3/e0ZIR3a3pVzAMZXSDOiVXsSBlQqUsaAEF+TfEiJRCcfa6SF6V5OCzrnHF1425KdCBesKvqT450jNTQJRDNuMUjGtE1/8kOxinNjbMQ6LrXSJ+o0SueDT0Pv2GeasH2BCp/N5WbqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iysyqm134Yl9SJ9XifZ0z5OseHQtWA0LoVMGShQSFTU=;
 b=SqIOMXZxIhs+8+n+OvGGQvppkIvJ3ocj3KRf4UZighWCnzaEmjYMQ4EJumMib5ZgoaJOhKgDg3TgnWNchASo5e0HX0avAB7DOCyqs4wklG6ZqI1U8JqcmS3VsSNmeKajqGRLr0Zo+Fo8RFOW5iRXwtzO6yjB7vhpH5AG4Lx3jt4=
Received: from DM6PR11MB3932.namprd11.prod.outlook.com (2603:10b6:5:194::17)
 by DM6PR11MB3100.namprd11.prod.outlook.com (2603:10b6:5:72::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 03:18:26 +0000
Received: from DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5]) by DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5%4]) with mapi id 15.20.4628.018; Mon, 25 Oct 2021
 03:18:26 +0000
From:   "Zhu, YifeiX" <yifeix.zhu@intel.com>
To:     Eryu <guan@eryu.me>, fstests <fstests@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [PATCH v1 xfstests-dev] tests/btrfs/012: check size after mounted
Thread-Topic: [PATCH v1 xfstests-dev] tests/btrfs/012: check size after
 mounted
Thread-Index: AQHXyU6yLyToj/7mq0y3NNf9atRpNavjCv/R
Date:   Mon, 25 Oct 2021 03:18:26 +0000
Message-ID: <DM6PR11MB39322A6A3D9BE19BA1CACF7884839@DM6PR11MB3932.namprd11.prod.outlook.com>
References: <20211025031435.61171-1-yifeix.zhu@intel.com>
In-Reply-To: <20211025031435.61171-1-yifeix.zhu@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 1c1de313-1772-0790-60a9-819180df3b84
authentication-results: eryu.me; dkim=none (message not signed)
 header.d=none;eryu.me; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9dedd2f-50d0-4fb1-66b2-08d997661c06
x-ms-traffictypediagnostic: DM6PR11MB3100:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB31007D0204C64F2A89617B6284839@DM6PR11MB3100.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:279;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 026CA+MfFoY5uSNhIQ575o4eFkZ5R/KrUe7vYwm0A9iVc2p72YhyOfqJB6PhbMMlmyjY++jlasoZqGTW3Kjm+ue0kIu2zOtr23xrYzcMIaTOzRYE5T86RBLN9iqXPKvwdfFA9hlNb6HlWZkd8vhmK8Nl6cWjn7mmfvDD4IDYf3I+ecPenrO2PkmvkhMn08j4zlax8/tttuoAoQ0QMcBPTVqTI14oHsivMXU5ow4wd2EmB7AW4Pbdf8Q61ohqNPwzY8vG/ng5jClUXSeNY9SoaCoag/v6szahidAMkGMysq5O5eBqRNRReT5FJq913rvfo70li8GPJHBxmVkDEsfwzqXH8ANHxd8OFSVveUArhNFL+d8KclWYv19mrngNlRNhcba8TmW3vGcAnjK0YiHIfVVscN8Q2i7fLf1Fgsr44vLw4tr9lOr+VmeIZx+YAfY96/6KK9nHvJBeaJxxXnK4LVxrLklEfasCNRtS05ae8t2guWBc0jPihf2Xyr5Mv51orevII2+7u+hcuH1ax1WanTXUIgVQYLots8kmXMTeDqqzZk/50QC9GSwaEoTNEdVY26TpEkBi5UrITUJwqyxhrFjQRGgJx/ixbqR/eR6pvu8ZGuxRltGa1yNzJw5HNCOLzVzb2hizZ4ZTaI3R2M49HleNMIdSG2A0/5eE1gzLDVJt55NeecB/vIebwEfH0AX1ZkAfUxT/n38iaBwPansp6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52536014)(8936002)(66556008)(64756008)(8676002)(91956017)(55016002)(66446008)(26005)(66476007)(38070700005)(66946007)(38100700002)(186003)(82960400001)(2906002)(5660300002)(53546011)(6636002)(71200400001)(7696005)(76116006)(33656002)(6506007)(83380400001)(122000001)(508600001)(316002)(86362001)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TjBETWRCLzQ3ZzhtUGkxZkoxb3BPTU9WaUtXblViQ1diY0lLY1VhNVJs?=
 =?iso-2022-jp?B?UG9aT0FhUEhpSVNzdDF4QzVJRW1zcGV1SkZ1bUNQNW5XQURmbTlOTiti?=
 =?iso-2022-jp?B?M2g1cjVDZVFJUnh0SXZMa29KMlFpZEJ0QWVSMG9WVmVwTnlKODg5Sm9T?=
 =?iso-2022-jp?B?MlU3cmFaSXhXeTJDQ3orM1Z2dGxpTnp6ZWc1TXlNNi96MHlCaUYyUTJD?=
 =?iso-2022-jp?B?RC9zZm5jcGthRStKRk1TL0xLc1AwZi9KbStyaUl4ajRyZlJiWk9aWmxE?=
 =?iso-2022-jp?B?dVJZT2FOQW1NUk1YRGNMQXBwbk5SemE0N3FSSVlYeGxzNWlBK2l1YXV0?=
 =?iso-2022-jp?B?SGlkNkEvL3BuWjZHNmkxbk9RMzFmYmpiRmowenhrZjR0QVMxcnEycTBw?=
 =?iso-2022-jp?B?WFN6UmRQRHRIaHdPNGNOaURyTHZKb1RMaWtSdXZTZ2I2VkFCQmpoR3U5?=
 =?iso-2022-jp?B?NDFaeCtEKzRzVXdPQ0d2RVNvU05HR1MxN3VtbzlpNnZBZHpTMk44b0hO?=
 =?iso-2022-jp?B?M3V6OFdVSENzQ1ZMdUlvV0ZSc3drK2ZhQWUvZE9tMnYyWEtKc1RaNlFZ?=
 =?iso-2022-jp?B?UzZLMnBUbTdEWlRpUFd5bGNLR2lrNktCUXZCUVVSRHpreVorQjBIM3VJ?=
 =?iso-2022-jp?B?WEUxMHV3Y1NjREkyN3Vsei81RGZMVy9GL0p1MEsxL3lWdGVkcDMwVVpS?=
 =?iso-2022-jp?B?TG9RQ0R2NDBDMlIyZkdXSHFaL05TWDV4UHdNdEFLamk1NUgrV1VQRHNt?=
 =?iso-2022-jp?B?NGdtM0pDbDNhdzNXekVMV3kxems0MWRYRTgvUzlUTjNFU1pEWmpMaXdn?=
 =?iso-2022-jp?B?bzJ3bmtyb3hYR3MvaEtKbjJXTW5UbjFVSVltMVZFQTN5Sy9kbzcrYk1x?=
 =?iso-2022-jp?B?TUZ4N3l3WTEyc1dnVTFMMjF2SlU5UnV1ZHN4ekYxRHZjVnpJNkdPN1E2?=
 =?iso-2022-jp?B?ZGNlVEViamkzWEpmR3ZQRlc4RW81d0lDdk1qMzNYNHpobFNtQ2hhUnh6?=
 =?iso-2022-jp?B?QU95WE9memFLUElXUW5sOFhLSloreXNjd0tHSTRwMEw5NWYzcWlrWHUz?=
 =?iso-2022-jp?B?Tk1WT2dHMjUrTytyTWdIVFJhS0l0SHBpZ04rc0YxV09qRjhEWDZsSGFq?=
 =?iso-2022-jp?B?TmFqTkIvd096NWE4UjkwN1lvU05HTHdZempaUUVtdkdaV0tMMVlqbU5C?=
 =?iso-2022-jp?B?TVUyRjN6RXZoT0hhMEdaMlArclIzZWpqbUx5Zkl1bUV6ZFpWWTJSQ1hQ?=
 =?iso-2022-jp?B?KzBpZVZiM1RFekRkUDdFM1U4eUQwNzN3cmgwT2VMYUFRTHJ4M0hrU0N3?=
 =?iso-2022-jp?B?WFlWdVovMGZEK1FaS2E3dWhuR2NvTUhyalEwVkk0U0ZHd0dSZGI5dzRL?=
 =?iso-2022-jp?B?OWRWZDFGOXB5aGpmQWhFbUNTTkVEbFlUdEROdDlKQS9ySUhhUTJ3RXdj?=
 =?iso-2022-jp?B?UUZVMnhISzNnSmZyMmJKVlJ3U2RlTDhkblRuSmlvc0NYT1FHWjMyWGhR?=
 =?iso-2022-jp?B?K2N2MmRFVlpydVErWWxhWVN6MTdXUGlhY25KQStDVWpDemhmMWs4OVll?=
 =?iso-2022-jp?B?TVhhbnIvVWJMcVBISjhTL2tIY3lnNE9VaGRJNlpvTjNON0dCbWZneElG?=
 =?iso-2022-jp?B?ZkRlcEJITFdobXFUTWRwcllLQjV2YThvS2daZGR6R3lsU1hNaWpQMENh?=
 =?iso-2022-jp?B?RkZyT05STFNuNG1oY3Q1dDl2ME5acko5aXRhdzFYWVM0M3VmSVpxS3Mv?=
 =?iso-2022-jp?B?SlFOb3hQQmlzYlBESEE4Ni9BMUF1L3lEeVhGRU1ieXVHbklBaGFvNitu?=
 =?iso-2022-jp?B?NkNnbytqZTVEeUNxWlFNbVV1ZWVCa291aTJMd0VOcW5zOGVWUFc0Q1ZU?=
 =?iso-2022-jp?B?MUp4eVNaYmxmQnBBdUFjc1Q3ZG5XWXpEU0VJMGFLQWFXMkRtdU96UXRL?=
 =?iso-2022-jp?B?d3c4RzRkb2RSOUgxUkVnbVI2TG5hVkRiMGFBMzVoSVVPYnZFVWxNLzN0?=
 =?iso-2022-jp?B?VEx5VDJucTBCMXU4WmJ5aXlVLzNJYjB3eGpQa1NjdUxYcGFXdm5JVTZs?=
 =?iso-2022-jp?B?OWhhb1RFM1Y2dENiRnhHeHp2bHhoN1FqdCtMOEI0ei9tSTdLSStJM1U3?=
 =?iso-2022-jp?B?cWdQMFdnS3dQellUcWN5MmFNSDNSRkVOUndmdVRyT1lFQ3lGY2FVZEtw?=
 =?iso-2022-jp?B?NjIvRXM2dkxpUGZNb0tORUo0ZlczemRON2lMS1BjY1UwU00rQzQ0MmYw?=
 =?iso-2022-jp?B?THBhaUhJZ0Q1KzlCRmo1Y1lLV1BERjVzMXdPMlFkNnpJb21pcjZEWG9V?=
 =?iso-2022-jp?B?MUIvYU1ab1lFRzJIazhCMmMzaDR1eW16MFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dedd2f-50d0-4fb1-66b2-08d997661c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 03:18:26.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWs6IWG5azpY88U83s49WP7J+SIHsyQcgkSiN5NNGZCs3MjUo7mmTiQ1DuE9ZvbOBEg+ZTF6VEjBaSrlR+e6uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3100
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Sorry, a wrong email, please ignore=1B$B!#=1B(B

________________________________________
From: Zhu, YifeiX <yifeix.zhu@intel.com>
Sent: Monday, October 25, 2021 11:14
To: Eryu; fstests; Li, Philip
Cc: Zhu, YifeiX
Subject: [PATCH v1 xfstests-dev] tests/btrfs/012: check size after mounted

move '_require_fs_space'  after mounted.

=3D=3Dbefore patch=3D=3D
btrfs/012       [not run] This test requires at least 0GB free on /fs/scrat=
ch to run

=3D=3Dafter patch=3D=3D
btrfs/012 189s ...  194s
Ran: btrfs/012
Passed all 1 tests

Signed-off-by: Zhu Yifei <yifeix.zhu@intel.com>
---
 tests/btrfs/012 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 3040a655..db3beb00 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -28,10 +28,6 @@ _require_scratch_nocheck
 _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
-# ext4 does not support zoned block device
-_require_non_zoned_device "${SCRATCH_DEV}"
-
-_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PRO=
G} '{print $1}')

 BLOCK_SIZE=3D`_get_block_size $TEST_DIR`

@@ -41,6 +37,11 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres=
.full 2>&1 || \
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT

+_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PRO=
G} '{print $1}')
+
+# ext4 does not support zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
+
 cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
 _scratch_unmount

--
2.20.1

