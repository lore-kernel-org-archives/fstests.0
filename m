Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D73C001B0
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGMPDM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 11:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjGMPC7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 11:02:59 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350C6B4
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689260577; x=1720796577;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=BZcudv0hc49T56W/9Tz5btCY7xYASKMcm3/1Fx9SSZPCGglRYsaEfgeC
   thCfN+8cKxsBxBEhyLg21rFEU7PtREhWJURPETWf2z4kaepooVy2AoXDX
   I0ZH++EpnOiyC21Hb0jk/Hhpzw0Vm73s6hfboWPxag1uL9+LUYkyaDodT
   IPX3QrQ+rT5sI+hPPbYk5QMXC7wg9ZkOvpH5+SoWR9hKuRuLM769JaEuq
   u+qtvjh/Wb6Wbkcah0j2b6Y07NYZlR1CDzoHaIVgHrjgHPBon2H2nu2pf
   w1ScVyQvLXRLL/Ij8j+Tsj7F7ef7Y3D3+CTft00pVYZrXZ5oiHHwJaU6l
   w==;
X-IronPort-AV: E=Sophos;i="6.01,203,1684771200"; 
   d="scan'208";a="242623699"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 23:02:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqQOFmIU3duWuyVexjGzr+6wGs1+DLkgJAz6BaL/tj27NlCYc0cyPkUa1xNWkjTaTNAGDCEKx7+VDR5vab+17PQvyAHDdNj/v1f8G5PBXq9G/KqqtMTuvZk6qz/dslfOetwbFhUbTPBTKWjrk+VSWoZMsHxL1I2KW5029EPq6F6Ll21W3BAZU/BAcU2hzUVG9k+R7VDoyBte488lA6/wmjLaUkfuDZs4J2FVoTPJtVUFetYwuyVRQTqbD5mlO7PqBQ3WS59pb1/vevX280rdkksfEb9k8aVCCd81EiltzBq4qwHUut/f9NDtKqYg3vhTG8MFIp6xrBlyhV6WDCYoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=cnI/wXj3RTItod5r7ghnBclraYK3hfEWSOJi62Y6cCQhBAMbNn4miekykmsIJ29dxU+6RvHugwzZOcL5z52ZtHyT9g6ze85D+WG1D/6KpqEthN6kUra0c/CRA1f/Z0IKuqJsdijWsfmsIMrpNZX9gcgH/gQwg/7VFTArxz2GvmrLoYKnA5i8s6OXfLZQbZME4CvLw8zEl8Tmd2OR8YNXYryGdgJHYIFMrEHb+8FV3aHLcJZjNMWeRjSG5e9Z10IriERwABspphqj+QX0PhS+CegzrWp63DSeRkNugFJBy+OXWPdUZXHakeqZPpZ4T48EwkJcI2VbLMFWhdpXNs45oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=uDgBAoazj9LX4M0Mt9t4owxHWxyItUKSlXoAB/G83PYgoEP348XL652xDAEO2Rc/Spyfn6WGur5ItjN8SkvCZvnpmFZBX6+9IFuTsQRBJT3/iPvFsebEReR5wACnGOISs7rRwiYSUzEITuMh2aAbBiTPs80Xx3lAiTSICu8fBPE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB8428.namprd04.prod.outlook.com (2603:10b6:303:147::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 15:02:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:02:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Anand Jain <anand.jain@oracle.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Zorro Lang <zlang@redhat.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Thread-Topic: [PATCH] btrfs/237: adapt the test to work with the new reclaim
 algorithm
Thread-Index: AQHZET1XdmD67XKqgEu5ivTFCU3xbA==
Date:   Thu, 13 Jul 2023 15:02:55 +0000
Message-ID: <PH0PR04MB74169F01B827C44AD59BF78B9B37A@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20221216105822eucas1p1370af7eb55b70fed78ee43f932b214d0@eucas1p1.samsung.com>
 <20221216105750.28493-1-p.raghav@samsung.com>
 <f6365013-ab73-5b2b-6dba-3b628dbe1b56@oracle.com>
 <b1bee446-4099-e605-ce59-e9cdaf19bd25@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB8428:EE_
x-ms-office365-filtering-correlation-id: a8d0b1e9-423f-47a0-9f36-08db83b23cf1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BPzYYsnocHL68IFNS/kLfQxVyB9lDquXZItMi8M1DwZ6/j0eODXYci5VH/Ax3s9T5boLWvgMBQQGu85QjDP7NRR96GSTaOHv5pXBC0AX9/3eQgnSNABIjqPZWrKLICJTNo9XaWGIEe4g9/1UOX2tPuWbQtyEmzRdw7JH/Qs5uer4MBOR32oFCk2NYB0TR+xs1/Itkyw6LSwJcGF4C1rJf+2wUiICuVeC9aPv7LvvbGuooGY9J1qMWo9xHFD77yZGegzVHWMD9bKMPxkYOqZHdLaBS1JP8wun0AJ4w98aabvpJBaiIgoND60KdfS53U/tCBIZJGcdBB46YzX1Fo/bnFXkT2HCANjtGcdk1ZtI6oY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(7696005)(71200400001)(33656002)(478600001)(621065003)(4270600006)(186003)(6506007)(73894004)(9686003)(55016003)(316002)(2906002)(82960400001)(41300700001)(38100700002)(122000001)(91956017)(76116006)(66446008)(66946007)(66476007)(64756008)(66556008)(4326008)(86362001)(8936002)(38070700005)(8676002)(52536014)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rd6xw3Ks32dU0XcjfDO9Yhmni0HTBl/dmvolpaRZQp4SUNMn4+r+lIFWtT?=
 =?iso-8859-1?Q?4bCoBDZtxWNj9ilM27Yms/Y0v9xsrsbmBHwt0tJviFLcbc41vVN8bJWVTG?=
 =?iso-8859-1?Q?DuaHy+VAQP6Hf3sDyzM/AFnuBmyhX9kDnnxFgDy7oZabFm/DDs4wmLIdbr?=
 =?iso-8859-1?Q?vpGcG9+ugy3e+WTxOx9uBIA3xuAk8mbs5PueAr9KXNmWVYtpvo66T6U9Li?=
 =?iso-8859-1?Q?T1OwwcL+ZkY3tq3+RPM2lDTOSLxpLu7qL+9F6XGoebM7FKWNWdTAIuLrRi?=
 =?iso-8859-1?Q?uiApHN7WVgMxeluLkTdR6mmf+wkbnGuz/UzXTrIDm+nIMYPO1yor9uaQ7z?=
 =?iso-8859-1?Q?sxAGY5HeRr3ta+HTSdTV6pNo84sgOyilCj/JhW1wg2aSaJmc3remtzAub1?=
 =?iso-8859-1?Q?xZldO8xs7uM8X0d8fJhty/kRqsgPV+fmxorURnCvtz914K4ZNsUKZCHNQX?=
 =?iso-8859-1?Q?Dv8n7Ip9h7wPZKD9bS5RSTRn2DFLdEeJFLzFqXRL5Yl0hoxxF3yU35ERoF?=
 =?iso-8859-1?Q?vdv5Z45+1wJY8X8VbcyG2o5N5bnQ8hjktAAmWpsSqNFs+eoJc3dgrPaQYs?=
 =?iso-8859-1?Q?l50xdo8tHRygO5O9E4a8RV6pFaYhWk8nfk/WgLhlas5HcHQptbuDxqrNkY?=
 =?iso-8859-1?Q?+DR7a1YkuDGCBkGeOHdlp8WzgPbWpgMbBgrxUaxdfruTUtd7E/yqAnkahq?=
 =?iso-8859-1?Q?ozgKJuVeZlZnAGOqATiU+HeIuj4UreisirvTROkFWAkkSGna+GiOdURRFM?=
 =?iso-8859-1?Q?4lUIWx8KQf3GNKQ7hzAvIQf/X9y2h0pstZxrClz3zr4Jmf1XGpHhQIKpTi?=
 =?iso-8859-1?Q?E0fjI+PoFNojhR2U9Nye2KI9NLS4PyeD8GZAPRIh2dx4cH/TysgeVgtF9m?=
 =?iso-8859-1?Q?3PXq2Q/BtRxs7Y337Yh752CfGwSktrbmrVaqSiIsjsY7jy5s1GWzlvxWB7?=
 =?iso-8859-1?Q?9GIFEDvppECE9FxcUl+dOohTnQ52/+QpresBhYyTN4X5ZvA1WyFzHzSAyp?=
 =?iso-8859-1?Q?YB8docIPe8pz694aFyQChwEkLuwT8BQcsLlDv07dyHcj5jE69FAqRpl9I6?=
 =?iso-8859-1?Q?TA2FjWx9ZEG02NjJGIfgzBo/EwFcSyx9TYVkK5dH4WCbfYhnitTAiFBzQL?=
 =?iso-8859-1?Q?j6WLWwDUaJWWylxkHevzxpzo3fPY6+Lv5jR7hNoGXDGcIkd/T7eblQU0OT?=
 =?iso-8859-1?Q?WXb4r9I5H/3HS/3vHeJmtPEwq9M27f6bTnhZnhHljsq9RewqmSUbz5bqE9?=
 =?iso-8859-1?Q?++x7HEYwdDecAcoJ+lhkB+/ykLjV3ppuqJN5VHqORczi7pK+AwtqwUUn9E?=
 =?iso-8859-1?Q?sOoDPHPusg8/b2QSvBVZaUPUYZZb64jH0fmFOe9ujs0R85FywWp4oSmytC?=
 =?iso-8859-1?Q?MFCGcwnXhskhTBbXOe1VjIA6FHs15NGbcc1dvtOl5YhRyM+FbgKSh8fbLI?=
 =?iso-8859-1?Q?NP+CaCf8gLSbkZZ2ufd6mGNsBmqXLKd17VAPuucn5SY2HwCniPyP+VNiro?=
 =?iso-8859-1?Q?RldIpaS5k/X572EMAmu0M1FzV6XwcWZVkibAdmzZxscwa8DZgRY51XR/wu?=
 =?iso-8859-1?Q?PcpUzpqYCJkSP+SarLOsc+dvDbdlf/mK4MSRXa22wEeYRZapfjssVNAzwo?=
 =?iso-8859-1?Q?NwPySUbIkAn9RTgb1+uKg3wiksyJz3hCcbjZG1VcdychmoKldr66YguFbr?=
 =?iso-8859-1?Q?9O03Nhv/mPJYNwCoDGjiYDnzIjLek3Wi3OwQYzOWopkz0szTDrYyUHXZ/c?=
 =?iso-8859-1?Q?JNaA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lOLSmvQkSM/se7txMrsPfBSf9vza4nTzT3evEumgQlQj9oe45Zwp0zNrQwnOCpR052s1XA4hfmJ5LEXqscHndtRZHB3yiyLn3dXMHRuulONdPJh8ojZTOEULqnjghnbSKQ/FgplTgybQR8K4kaLjhOAWCuG/F7lk7Uy9EmBPg4r4ftgwkon35C8GSJPI+91Zoodb8VoLIYgFOk3dO01xwK03Snz7+c7HjX4PZsbYEvp9rauRI33VpGiq/zPLWKNUJaUfZ59PmeUYtH18EmDekkNrVQoyk8dIsIMvG91M1mZAzGqBj8SZLvSKfNn0iuf2ldiz5G2DbMLszk6oZMlap1SuzTRNIGD/NM5IoUJMS5pfyhh2WozVT15q8habxPx6nlU8iCYUtDnRsP6jte9QRC4F/p+dKtVbtFP933W9TIIfELDIxQOXnyzesvOsDBtmDgqo1VOElvSwKv21baGeA+L2VYx58urJJfJIXCFsdGfdf1c7qBWpPi9OleiaCDNpUWq8w4Mx5FHFBQg5Ai5s3aDx3kR1kZ3OTtekButbL2ZWL5m9hwuwGxyZs0kKfIQVPEdHFCFtpabktvZw9ZhqLX9KurBKfflSCTLnG6aLBEhcOuhsJ2wFd68R/wnlosfsZIecl2OvHuDj4uWbkII0lLK/+DxUQe/ulFBItG/E7cUamUK1gXWphJhA0kvnATzCVN6umVIsESGW5I4IjjPbAA/cOllQz83xaL5I5wDt8Pr7+XulbapPn/gu8wSZic1alSORXPas42HoJlCPqF0f2m2F9T7j6KjCyVIG38DbzvikhooSlvWf2PKwnf27xRdL9RMa/AuOCiS3SKldwdY9grC2PAPLg2ogOs+Wcbt9D/VeThzEhEIIbdJ9KTyurIQFWRlQMd95W+gdBlcWOGOVVg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d0b1e9-423f-47a0-9f36-08db83b23cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:02:55.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYxMB9CLezjYT7tybR+qshdLORDZe9Z9JD7x+VxKg62n9+Z5piyEVeW674W2c2eggujXUOhi/PsMWT4Kyjkp9sCHLbp/NAUDA7oVIO3zTIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8428
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


