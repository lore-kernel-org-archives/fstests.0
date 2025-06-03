Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E32253B0
	for <fstests@vger.kernel.org>; Tue,  3 Jun 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942694; cv=fail; b=DQwclO9YFGVEzCvxPc6GrSI99Ch6Ik/vYxTj+9wN9wYVwpgYKfiisuGBqroXZf/MK+PzP3t+ZJP0xQ2omgotPiw0Rw2JFUmW142kj+zJx3diL/XQ/UQNDVHeokTU2YPyY1RcnZSPpiVawJpCERgxy/Ii78VxZqGpOrNuW+ZKTtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942694; c=relaxed/simple;
	bh=57kiFUBQoMuqpiBAELQMOYb8FbAYI+3bOnyGdwwqqIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VwfRpXtBZipDV92B9U+0zXbl77K3OOT5yXu5JbNvTTbuhu2xztLKcXs9LHXkxuUUYMELoiR/mfhc68JWqs7EYR+R/D1ylojZNn7LVKQkQCbqgL4v1SYYwVSZzmPTS5d6fxI83qQfQkI/0OgX4LVgnghtrMmX7x30/qPyLJBtTSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=D9WAGIZJ; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="D9WAGIZJ"
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5533X802005732;
	Tue, 3 Jun 2025 09:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=Tk2w9R7
	1s6O+PjClQeE7RwYh2L2MOgktHDFu3HjHvvo=; b=D9WAGIZJ2TWnDLTtyCTmCoN
	fQJeyNUo21ykRqaEciX3K7BiTOX940viy5HtoJu5+VteDIoR3LFDww1dSr2tY2uN
	ofeAb5RTJzvnuRgo0XRPYOFlX3haMGoeDag1QgMQ7/IVH6B43IXwDxklk3JiMkgL
	ZpRejCpn30nyqUFBBgOudOtxFcbDFqkviBdi42x+OWD3Qc7bZkTEeaTOLslbxADQ
	3MEkCMSlJek+Sxz54N2iDTgKxjdNRaY5WtgvQXl/cPwqr999NYqn+ZiAKwKRcgAj
	uzbLwpfNXQ0SzO7zp0dqvkfmX4XTCkoAxTpW6UPFobPJfm+IlA6pjXuw7J/Z4gA=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 471g8k8q9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 09:24:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTo1kMp6X9w3X60oOz7ZCpMIdQvuqpxAFp1VjtM9y/IcA6AITZTT0PW5eFBKWBXQXlDLm5xyOY//9vGYI3vi7LaplbQz1kEvaxTJTMe7KwcEFeIpjgViggDh7y/SKox0wCTxmtTKlL7dSoVZbmM3ocVBUwmBbJBErEYAG8BxvNLexDHCRX/MEMdYjXR07ZiIdsKhvd9p55nzFf2eL7HonHSMJcp3nwOUzpWI5JJI5eM3/msN2r/kG6w7zwmomRejoLCt91V2Ji3r3I83CImosXWjxRdlqZxR/8+ptv5+IFINxdI0W67J9Jjy0vFDCzfbuNTB+D6nRG8Ykh5+ggLP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk2w9R71s6O+PjClQeE7RwYh2L2MOgktHDFu3HjHvvo=;
 b=Ey86VDqm/+O+Yo8+0cJ8nyh4z2SneVp7q2DZEC+Lq82eEk0+sEB9wdB1u1q9eUOx74zyncC8cNTznBWXjhUwuc+aZaPN51m4Vc298yPvUhGwSw04g8CVMS+vwQ+NUldVhiK1pOWu5KeDiChNPfICMO2C1r2RJRhLDEEdKwGQCNiLjTU6WHfwMQV9+qluZPyEWlGYoZ0YJu/E17BrwjeubRhfU1uvyqcxClk2BesWwkDyLsoUzlFvgTKjUmFusqhWZedSrb5c8NF7j5yWWlRQUmkUQ1KH+4cpAobXCZ4S/1MSljdsWS8I7HLj2ALUple9K9YC7SKAkkZLvfZ35bgwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB5855.apcprd04.prod.outlook.com (2603:1096:400:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 09:24:23 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 09:24:23 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>
Subject: Re: [PATCH v1 0/7] add test requirements
Thread-Topic: [PATCH v1 0/7] add test requirements
Thread-Index: AQHbz7/bZDNWPayv/UuenYc/K3KYVLPpEgungAZQzICAAVqQx4AARNIAgAApFtA=
Date: Tue, 3 Jun 2025 09:24:22 +0000
Message-ID:
 <PUZPR04MB63169D2D52D5C5EF50161C33816DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <aDbs_Fr-8CVCxdxy@infradead.org>
 <PUZPR04MB63163EFBDDF33FFC83B863008166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <aD0514qLBX-MSazZ@infradead.org>
 <PUZPR04MB631648D55D06ADFEF408ABA9816DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <aD6WSkbLt7__Ohuq@infradead.org>
In-Reply-To: <aD6WSkbLt7__Ohuq@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB5855:EE_
x-ms-office365-filtering-correlation-id: 68de4a65-1368-4695-4b18-08dda2806d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Jqr3Fog5lxK6bBQsI33aFznlHpeirfTX6ZGofV10//E1ZLPWrlCmUO6MWv?=
 =?iso-8859-1?Q?hk7SJgAfX7RrgvjDQL01Oa2HcSoWLjZMNVX4DlJ477OLuL1dDkXau1QV+3?=
 =?iso-8859-1?Q?hJDlkKOamX1qaPafbpXMW5//Q2fRIu5aX8uvar7mMUErJ6cYWVhpOqEh6p?=
 =?iso-8859-1?Q?RwMB6ULZyqM+QMqMUp+g3iQep2TO82YBsTj396CtptJTEyrxvs0YuFyN9r?=
 =?iso-8859-1?Q?F0crb/LoEknGE6/A1B5CBF+fHbaOv0U3DKzhoQsLPGE3ScTbnZ4hVVDSy4?=
 =?iso-8859-1?Q?5PGUokJVFUjJmhDotU25XRRQfX6u3h7JvAo12W8u6qPsS9DK2zes+ZqQ2q?=
 =?iso-8859-1?Q?0JnderWyVDuzsaHiBUMtBGrSWjmOkOIQnVvv/esX6atWZTrvpMreoX58ay?=
 =?iso-8859-1?Q?GbVoDVcxSe6u+3GbaS9MXH1mCb5L+GUEo0DvJXa+i5CSItXNv2qQJ4YIui?=
 =?iso-8859-1?Q?d/zE02wPMRR6iczO/p+fHPXHTRZGizZZ5+f+Boc15dJUXhmBOkJlc+g7sO?=
 =?iso-8859-1?Q?dkg8+SqNPV12Wwinj2I0J+VXt/tuabfXZQTU7JeYtobmBYdbeKZatAVqVI?=
 =?iso-8859-1?Q?wCTzWa8xAdG0fLf3s67/ezK2fcr+FNtsojBVYqCqBcqRe8nN3vNDAX2r72?=
 =?iso-8859-1?Q?eKUcjkddhg6NK/ziEnd3MYJhAymEq6ZhydUM4vKppX+efs3hdeVgPEFpDw?=
 =?iso-8859-1?Q?Yzy8yZAN3HE7xepB1b8Xb7UmD8tlv7t4acjCTCIvcEyA/g91p6a1YeXVy1?=
 =?iso-8859-1?Q?7pSfVGVx03vqsxWbIuYRyk8XVF6UYtsgj6yQLZr4H2yWySiO8ySRBOH+SK?=
 =?iso-8859-1?Q?tSIg4nhdZeYRQaVEYN93SGLcq7QnmGOiWlJR9Xm02RL4UFr0OJhYBzCJT5?=
 =?iso-8859-1?Q?sSev8IJfbd/eXAiod1HQO/sG0O3ay6uf8u253PAFS4Jg1npvSeHRGGH/D9?=
 =?iso-8859-1?Q?G6khQIB8H+3X1mTXp0AKOnNtCYIhRcR1lVEAGm4lZiYtOa1wmlydpDBo8a?=
 =?iso-8859-1?Q?g5RJsxEKWxkhEYp6AaUrQUl7lbMLQkt91RHH+omuciBfNZ53sl4ZmVjgWU?=
 =?iso-8859-1?Q?tlbVt9vJgGCrxeylggV4ypMgCrnMwPYNBUN888jlt3oT7OS+w/NOrRuC7F?=
 =?iso-8859-1?Q?t/eoAmTP96EztkB90kDS3fpZC684s8iKSLHMjcA9hmUVnVLVd+BY+evdr6?=
 =?iso-8859-1?Q?6zdZBRdYPjN8zmwFI4/JpckolRvPqqPGWkXTOY0hLcvgZBkctKdQlNYXA+?=
 =?iso-8859-1?Q?EcWgiGkH+HW+Uu9hNgJ7ISEi70buF2PuuLIHcpADZWo3e6w7R1ZRholrdu?=
 =?iso-8859-1?Q?1XiP13CJsiEkY1yUo/SNWnUkDjK3+X0BB1U03gz8RPRZu7Q8AhQi/Lys7b?=
 =?iso-8859-1?Q?twrCZKkqc/hlbdOuOPyT7HnaCW+UE6jzFmm3bOS8CGNYdj4rCtj4mFoUAn?=
 =?iso-8859-1?Q?OqvB1+gN+7Fvj9Iohi2ARhhQm1+26vI4uFugTL0g48F5hIQcSkvN7amlli?=
 =?iso-8859-1?Q?U9Wds/1Bo9qlNGhbzp4PO1o+CnlsxBRc3Upta5zodKOQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/tgJKs7dHMPkulnwL0UHFM5Fem8z3i5eq/1g5TltHWzm+b0Y9STYBcy7Ro?=
 =?iso-8859-1?Q?g9OpUBYI5aQgnuhgLNdGEQhaZrzPnuZSoKwPf2rZLLBpyCGZkCkXvuQkla?=
 =?iso-8859-1?Q?idrnSreP8bByLA7ifi8SnCWQpUuVRwC55osjfScMp7qqW27vBlAagLK6de?=
 =?iso-8859-1?Q?cHGLEOaQ6pnB4+1vc8DHegHsUpCkSQ+6K++UBs6SO8OGAGxMOmp40L+dVm?=
 =?iso-8859-1?Q?ONUu4pEOd1Ik09706EjnFy0uGqP2CG1KBBj0j3I0amWZ2QnjXJQ7/a8T2X?=
 =?iso-8859-1?Q?BhruPFys3n98gWLlU/2LLdR+pZWF3dhAjbZdVI1wUZCHuYV6I9PvDuiZ2C?=
 =?iso-8859-1?Q?yIMbvSYRutGvcFckRITeE4vIdDocH4zVgbZKjrOHkah0c1wl2muBWPF4qU?=
 =?iso-8859-1?Q?CKKPmOQWb2Z8JyaPAzWbAEy1uP14mdHPmnlwe7zlaG9PwMCDL7PbzzJQU4?=
 =?iso-8859-1?Q?hrs26lNhE7QyyQ+5u5y2/MmVQY4/cIvyx58e3AQ0Jx1AIY1uIThZcMrErW?=
 =?iso-8859-1?Q?nrQpxBPFfyTibnptO4Ilj38zG4YDM3B0FYWrCYpam2SO3Gh1KuAgH1WDf9?=
 =?iso-8859-1?Q?OV/iAba0cWMwU+v4/VDrNy+cyNojgcAL30ZqsxM3UVQzfUB4ZTmtB++TLi?=
 =?iso-8859-1?Q?wqSsqzgUZn8ukbaykHKDxeIi4n+zMMSyc5jQAT0gpRP22DJpdRWYi8I3uP?=
 =?iso-8859-1?Q?CKVvfjcyQA7uvKh35jCeh5MMluoYj5URwQloGj4PT0rXUNitxJZNa/OTTc?=
 =?iso-8859-1?Q?d/DQ6ESvYfWTjXw22jav8GQAAONBvi92GM+O3VlNzssX6DG4Q25a+MUN/H?=
 =?iso-8859-1?Q?eBq5cbDfxKgeMMzq7M0/ssttWzAtoA+coqADAq3dHqGQIcapWJpeLkLWI4?=
 =?iso-8859-1?Q?bw0IpsyLwNd0ZBtuAywCnwV5YqsO7VmMMSoOaLrtc4jwmAF32hj5yrI6uN?=
 =?iso-8859-1?Q?V/OAc5nXdcDmLeeLGBPSb1zwyzoYJwF05QoBS0SLtreSXlXZy7bYxvQ/ny?=
 =?iso-8859-1?Q?Ee/cKaguJWlzNrPkSr7QzUGmCxzQ2Pj887OduZEeQuMUqKp41h0He0/TSk?=
 =?iso-8859-1?Q?025cCpfVJojHybhOVY257OWy52wxlRMTkdqOJyMsCPwlFPVZ9g5OAW8Pyx?=
 =?iso-8859-1?Q?TQtoSc3D8VG6wEmEQV4Y3li1fYYHUdNmUM+heiJQ75zah/xtYoroonMjNX?=
 =?iso-8859-1?Q?0jCCpb1lPIAFieS3bV/Mkrh8MZO9bkXt19e40vOBgqDxEjt0vtvMqNEID7?=
 =?iso-8859-1?Q?f63IUOoXuKmCQBvwvibAvHSF3C5DO0zYfL3HtldnWw3NG2jN4lMyJLSURX?=
 =?iso-8859-1?Q?vD3RKRxiKvBm8Vd4HxNZrx8DCE4bXmsKVKf9VyS2rwv1RntbOIozb7IBmx?=
 =?iso-8859-1?Q?UUmBPLTePMcCG6TgTEAOjJcJg4Ev3H+s2EEffWx/p36Neri9kFafXxmRR3?=
 =?iso-8859-1?Q?W7CX8HnrShP8+72dRYfCO4r7jYqadvFKxn7XXApNxmh94UpV47fW8KDiqj?=
 =?iso-8859-1?Q?ZVvoKATjFp6lAAh6UvkUSAFSNSaL30YUXx0T2NI3foy8H+EHfp4c1YReQl?=
 =?iso-8859-1?Q?HvESDZQAYI0jZ7uDTeVnIs5/RJPzfsscleEN9PuK8g31LsTg2H8fsBiOK3?=
 =?iso-8859-1?Q?fCY8CwfodUk4l3X/k59UxeW/u/0xY/qHZ2cUeP99K8/ayEe+aFmP3zBoST?=
 =?iso-8859-1?Q?BSo9kgm49EeeBU9nsjM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZTDpdJiEsqSELGW6Tr1CwDhELO1o7pklAnpT96kIo7MiFKQV92YdXRX2S2Qq0yf1xqR3x/7lZj9K+FXo6ipruIgc5Kkff5kKZ32X4gIkZsEsknS6y8/2V/KTUu2jc9asOLUOsIu/Je8/E4SHCBII13VKNZpKvHJCuQsR0K4AugHS8skI4yvMHLU+qUOMkTssDgnS591Xwyq77F0tK1lJiEyDcDNBFVkIL5lEyQMf3HAnJ07a1n7B1gx/tIofqCAayJ6OOL1g0iUEqfkXCIQwTLch5SFCjsK2r3fVvUsTl4DQUqh7ZBQuyyt3M1WjFarm8NV78spTIdbSw8ROvoAA5Vv3CLW+bI0jXxIAk4/w4afyIB7kqPqg+hAF1NuION+DpT2sqIHiBgOiREsiuVMY5R4OSglG79hTkEjyZLXRmf71CvSeeI2YDq5MJVmQ9FaJvMIco3ZbeP3NFse+TDf7RCjaGmpL2FdG0Kr/I1JDpUFtq5RUPsMmkbt7E6k5nmFQr6ccOtnjYAWUewYTiuSn06ycBLFpO8GrDYst8hWGnlgt3qk+/Z2uEqoCOZ1OibDQzOA0yfsqAPzO9923kCpP3TFCvbDGEij5K8F62Wb/WSNjGorfrdCd10MrzzYvnL6f
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68de4a65-1368-4695-4b18-08dda2806d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 09:24:22.8536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXVBb4utFTVsWpUfdreBhL75oLZd5t38dsOQOWpDbpgpQupz2tGh/2SlIJ6YYMD+RxtAzn6cQ3lr0wmC+z82cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5855
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA4MSBTYWx0ZWRfXyZ0gPUfwL9r+ i+04of/rsvzyCIW/2IWwzDmhqzlPU1PiAULsNqH8JOC2FwZ6JPcYlfOpQVBNIayIUOHQXps4ISq eXLxrzhzxXfGzTfosFkto3PkyAvSZQ5jrp+XlImWCH76Vbu65n2JxmoOH9xfIhJGVX0N0rCstXp
 7QlV4eydUgJj+3BuXF6S6g587ly7u+8XIwY5O5+v1XnBsb++/ilK0gIzLzrCI2Pu33tEkYHn7Iq v32wKt2k4Z/WdYtF//tSHtgQVnOkiENZdVryTUauQA1AXpp2OvfGYNyyipcOuJXMQkcxrt9JaG9 ckmWAMD+4+HIbOJ8016Hmms23MafuPibtsfWVRLx8Yjw2HEbehy7OL7FnuBV7imQ7wDC+wgdzF/
 h7j1owD0ybiDv0VI43g+lAEZFflJduQb1kuQ1TKp9D5Z/2ijzRlEU6pUdQEb4QZRa7dX2rEJ
X-Authority-Analysis: v=2.4 cv=VJbdn8PX c=1 sm=1 tr=0 ts=683ebf5a cx=c_pps a=2f4GpZrjudwefLsJDHAgyg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=z6gsHLkEAAAA:8 a=GVzPKNVB_dCwR_wl0ugA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: g8MpZY_nNkbjMeotyxBHVQfLB1puw0i3
X-Proofpoint-GUID: g8MpZY_nNkbjMeotyxBHVQfLB1puw0i3
X-Sony-Outbound-GUID: g8MpZY_nNkbjMeotyxBHVQfLB1puw0i3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01

> On Tue, Jun 03, 2025 at 02:35:04AM +0000, Yuezhang.Mo@sony.com wrote:=0A=
> > Yes, this patch set also for other file systems like exfat which do not=
 support the=0A=
> > above features.=0A=
> =0A=
> So is this for exfat or "other file systems".  How do the results from=0A=
> an auto run with exfat look with these patches?=0A=
=0A=
In my environment, except for the following test cases, all other cases pas=
s.=0A=
=0A=
generic/622: It seems that some adjustments need to be made for exfat=0A=
generic/689:  _require_acls should be added, I'll append a commit for it to=
 this patchset=0A=
generic/740:  exfatprogs's mkfs.exfat doesn't support foreign fs detection,=
 but other=0A=
                      mkfs.exfat might support it, adding "_exclude_fs exfa=
t" doesn't seem good.=
