Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC78C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Oct 2021 01:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EC160FED
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Oct 2021 01:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhJUCB3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Oct 2021 22:01:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:47989 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhJUCB2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 20 Oct 2021 22:01:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="216090593"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="216090593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 18:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="527295129"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2021 18:59:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 18:59:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 18:59:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 18:59:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 18:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmHeUQV3fjx33zTZo2W2c1JNmem5sBV2kj91a+SPSpzdrhJEsNq+251zXZTHiCbcQ1qr+zOSZtbLw8S7H8xc0QMYHX8bPFpDfM64CJd++ZiVySh8ZRKSvZi1DkfCJjTJVXD9GkPAC4u54SVdfmQ6x6vfDtinKG8qafYVKKc3fL3JsP/+gEhHGB5nVgnr5KLOxazJ982TpJxOdbiGCb0ZAudAVm4NYE1OLYy1t8kEJsDcoi01jHFjcRpJgEteWbBXhZ88Uj7bBSflI7kFkrRzNHNfn6nBuK/2IAvDwi7UOR/VJ5oxzwaymBSS7mKYf3ZQ2OrYQoneYztx5BRhVo0YZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN30iodvZLMgS/wy4Q7dpfRGrWYpaOB1UqC5OiE2Os0=;
 b=PA64fj/oP9l/bCR6VTEr6pZY8eLWODjZduyoPE4E01XzXrWrnfSOFrOlwtOt1YMF/ti9RJs3XLe/8oJUlv//aahCcEkszA3uGM76RiRcBf2HSdnT/embLSfB+jSJ9UftBgWqLUXJmitXqeCVDae4Xbn6iZqgNqRbC1etGvGXSJudBxWg30+VbcysM34W5C8XSxA/brtb310gcXc2c5TDZL4rBEPXU8CahvM5OisF8BoR8pf/cTuGbYIEaOFclSHh+J81CSacL62sPjuSsON74xGeOtJqrdjxqQtAYiBosmWcMr5U4r4dgXdLeFeffBT4yAqSyr4yYcehyLkpDQJJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN30iodvZLMgS/wy4Q7dpfRGrWYpaOB1UqC5OiE2Os0=;
 b=DUl1jCvx08h/P4WZaPhMCpCkFMDqV+yMjjHnFyHGyIhTPLsP68U62N9TEEzaPQ2e9DP+SrfGbNGll8sKkOPDOVpI3pIUZmu3sMTuJy6IQpt2Zb2R+3V19lwo+4t4gf0xYee6gjlaCi+qhQUW15EZbzat1ROt7/oBQ1jB3otZjKE=
Received: from DM6PR11MB3932.namprd11.prod.outlook.com (2603:10b6:5:194::17)
 by DM6PR11MB3436.namprd11.prod.outlook.com (2603:10b6:5:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 01:59:05 +0000
Received: from DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5]) by DM6PR11MB3932.namprd11.prod.outlook.com
 ([fe80::b029:69b2:f711:b6e5%4]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 01:59:04 +0000
From:   "Zhu, YifeiX" <yifeix.zhu@intel.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "Li, Philip" <philip.li@intel.com>,
        "Ma, XinjianX" <xinjianx.ma@intel.com>,
        "Li, ZhijianX" <zhijianx.li@intel.com>
Subject: [PATCH xfstests] btrfs/012: check size after mounted
Thread-Topic: [PATCH xfstests] btrfs/012: check size after mounted
Thread-Index: AQHXxh7+b27cS9Jmu0WbRGG/+65ILg==
Date:   Thu, 21 Oct 2021 01:59:04 +0000
Message-ID: <DM6PR11MB39324F4B7F5EB9B686DE29B084BF9@DM6PR11MB3932.namprd11.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 66255b4e-250b-b3a4-4001-702c4095581c
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02d04a16-4a0f-4727-f362-08d994365c73
x-ms-traffictypediagnostic: DM6PR11MB3436:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3436E0E497933B650ABEFAF584BF9@DM6PR11MB3436.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBMTKumYrtY0mbzWqhqRD5KK6LdstzhPoH9ggN85tgTQGVXWJlxGSWGvCKV2iRWY3jNovfgWdGjgT61zEhSM3scAhWFXaYp0aWlP7sQ8DXMP/UDxAdWZlvFyKh5kwO+WzX5J2OBRy6N5xZWBZkgPEgq5ooaZxUhzExRsCg047TUIGCRuaQWPU/i8/KrwU/sckli3RNaSSrqtI+kv0oJltpf8jqFO62bWKYr9cdwSggmflY4j5lKaFLKTTHtMbqLLtpD7gvxOFevS0LulURDCWKCCQz66mCGeSzjaqIvuZe/4nmsnQavhxx3hrXs51NwI7CJFKXh/G1zWnMbq4P9OdqbNuWhNgULuFKpGuhQXBHopDUoQh+KkaGEE3GTabWHzufjwJNiUdAvhMuM8nDehgbAWkFYlQ/oC9Q1fpmC9l8N5m3hkBOU96HCdXjPW5hm/hO+lihiPLrpWuk/x2CKK7yvp8Lux6LUmwfGYUfOULKvZ7c9yuIRMIdI+U9aPsffF70O0ZNaSP1FdpmbX1M1H44gACw986U46xYVnfIYPwBwa4My9weNRoUwqwJ+SZju5hmOZjP06oCJTp7JwV5Y5Q+0VeBQfb+6a4GdUAIZhnpHs+FTiQ7Vz86+q9vcvdCDM97OkaHDrcS4wqwaAmwz4f3yb6MTwFlz17ZdXlAjhYT6acZvCwFf97JoNpDQqfyMfYR3U46s3WMdZphMTVJOxYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3932.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(66446008)(66946007)(86362001)(26005)(64756008)(508600001)(107886003)(6506007)(316002)(82960400001)(83380400001)(33656002)(38100700002)(6916009)(8676002)(76116006)(186003)(122000001)(91956017)(71200400001)(52536014)(8936002)(38070700005)(54906003)(5660300002)(9686003)(4326008)(7696005)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zuu82MKlseYFmtgTVsTagseNzq9hISNaHrSqrtfHDBHCi3tmOQrUGY/KFQ?=
 =?iso-8859-1?Q?bqT2B9zbu5Pyg9C2tX855AYxCj7SIVkQmMra7HxQ/Th66ZmIroilxPNB1q?=
 =?iso-8859-1?Q?GUXtU2oQDd9LpXKW70Ww+pFLncfjoVa6aHE37DEzfOM3GdyKEW9zLjo4RY?=
 =?iso-8859-1?Q?BZpCAYKzsCxKq74F++9/N1UU/Sv7aFPxHZCGFCmfyOUcq0r8YAXwBiEKsp?=
 =?iso-8859-1?Q?8Tv9flVkd1PMvV9aACY7LlG1nGXhD1go3a9e4XR3MD3fRqr774OJAH8xVA?=
 =?iso-8859-1?Q?U6tRxFdwpcP4Z8JcfCUVdlUXV6xZXrsH6YIpl7ah0ZOLsEiOji0VM0LkDM?=
 =?iso-8859-1?Q?HlhqDaELVFfu/pdbuUh9G52/qTX3VJ1izik0z5Ul/p4XOa9gDShCC1m9Uw?=
 =?iso-8859-1?Q?pfd7v2zL3lAlHWYtWLXMUQlhRPdf683fVs/Co7KpPP+EUVvgiSXUIAOqMA?=
 =?iso-8859-1?Q?82ru5ToyNbuQegVz4ECd/eMtsNsihd+ZyrI1lUGnP8cZvhIAWbmFwHSBND?=
 =?iso-8859-1?Q?1/0S2xx+qMZpBs/PuB+ZQ5DN6Lvjip399ZMiRKpzfSesvf+Fo6iTkl8xI7?=
 =?iso-8859-1?Q?6586q3sGkLktlFIApC9+tbBP0IwCOvg0j6o4Pf24TG2Xys9DKh4/hJCiw5?=
 =?iso-8859-1?Q?bEYYdho8na/tgjwFGJ1IQIpGmzpQKc8uV7kE1ZIJXo+zxRZ+Y5mgd/RMk4?=
 =?iso-8859-1?Q?4q3N3HVy2Hvou35MBQV+TK+2au90qnVxFLZfnBRW3ipLbbXcJz2tZ+kN/q?=
 =?iso-8859-1?Q?xf/6w3l6M/Q/mBDWDzQtlZRmM+ZgCAcbS5CnLLBxtq9PetezkqKKSkaFQI?=
 =?iso-8859-1?Q?Bb/Gf9yvpb8KfDx+32W01tvyHgvApzCnlAh/+4nqeAWrLcVxqSJyYvIG3a?=
 =?iso-8859-1?Q?UB+RswsO9FLTECRdomSGLejs9Npvy3N/uBHPDkOr4NdP5IHAQEgHw+y6st?=
 =?iso-8859-1?Q?ebczd6C+HEnNGmLu+IZR6pleutquU4eg9iFsAIRKkiqUdTp3D8+R24eeR/?=
 =?iso-8859-1?Q?FYCPwFugsbAowgLhCFSvS2VK2QDwi1tXWTRTbcAjBIODr28xyCR3xsjOBn?=
 =?iso-8859-1?Q?Fvw6ZYBzDwHmlyUlUovP7qT+qKVaIl7QqlY5g1xdR0cZ3Bdf/jk0En7hre?=
 =?iso-8859-1?Q?s6o6jCIauVv2kEbAaxPg+JhubUNyOzGj2e0E+ShL0q9+B0AZOekFEXmGSn?=
 =?iso-8859-1?Q?KugUhGY7FaY4vkIEo/wMy1bnacYeW67/F1Ifel8mBf3ArA64Eo5dPoMTtp?=
 =?iso-8859-1?Q?Vo+Hr5/6IbZFI1J2ZicyhO3f/dNcgeax53QtCV4npCRf5GkkIT9aV12rVe?=
 =?iso-8859-1?Q?8quyUAOGBf+b5uh1HJoR2oyfOAVhkKt6kUOhhMwrlg96IOtcrt6U6fWLto?=
 =?iso-8859-1?Q?zwety8safq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3932.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d04a16-4a0f-4727-f362-08d994365c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 01:59:04.9013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yifeix.zhu@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3436
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

check the disk size is enougth for test, should move '_require_fs_space'  a=
fter mounted.=0A=
fix error:=0A=
btrfs/012       [not run] This test requires at least 0GB free on /fs/scrat=
ch to run=0A=
=0A=
 Signed-off-by: Zhu Yifei <yifeix.zhu@intel.com>=0A=
---=0A=
 tests/btrfs/012 | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/tests/btrfs/012 b/tests/btrfs/012 index 46341e9..8b11cf9 10075=
5=0A=
--- a/tests/btrfs/012=0A=
+++ b/tests/btrfs/012=0A=
@@ -29,8 +29,6 @@ _require_command "$BTRFS_CONVERT_PROG" btrfs-convert  _re=
quire_command "$MKFS_EXT4_PROG" mkfs.ext4  _require_command "$E2FSCK_PROG" =
e2fsck=0A=
 =0A=
-_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_PRO=
G} '{print $1}')=0A=
-=0A=
 BLOCK_SIZE=3D`_get_block_size $TEST_DIR`=0A=
 =0A=
 # Create & populate an ext4 filesystem=0A=
@@ -39,6 +37,8 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.=
full 2>&1 || \  # Manual mount so we don't use -t btrfs or selinux context =
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT=0A=
 =0A=
+_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | =0A=
+${AWK_PROG} '{print $1}')=0A=
+=0A=
 cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT  _scratch_unmount=0A=
 =0A=
--=0A=
1.8.3.1=0A=
