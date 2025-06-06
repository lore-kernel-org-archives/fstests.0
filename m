Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0972AEFE
	for <fstests@vger.kernel.org>; Fri,  6 Jun 2025 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177145; cv=fail; b=IgtRHK2St3EhKdIkUPRUaKQsA09y5lYC8VnnShxSL0ZXHG7WkIn5nouh7oUaeufi67fOYnd2E8vaDeUiphb2yBDS5vzNLMIWJz0VFQXJ8ZgNe0L+aqYsL3HD09RbQsVJWU6S8vFLpiAUBu5fG4zuNGIQjjK3YReMXOR51ecZAVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177145; c=relaxed/simple;
	bh=R2EUNiHryuKeiavb+Xoczc0ubIFzLw0ERSEszigdLJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCKUdgsN/VoMXV0C+GmG6IP+eVmwqWGgwWbxJmYOtji822gYEh0yIWgfIceqAj/utWijgdcrYS7wdHSIn2EmDRApraRmo6NGwHWzIgP5pE6N30RlEx4lbiopJ56/dOO7rEz2de7K2/SwMdV+ZfJ/jYeBcQIZS4QSJ7NP1RrewwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=bxWCFxpJ; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="bxWCFxpJ"
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5561eCon017159;
	Fri, 6 Jun 2025 02:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=R2EUNiH
	ryuKeiavb+Xoczc0ubIFzLw0ERSEszigdLJY=; b=bxWCFxpJsZRdOLCWUQN3kG/
	llQAfm1IfgXGJLyX0mAlkhXUQvtIztt8V5THFdMO/K3H2LSTtjAFS2ffvyNcPLIf
	6xhtBnAFjlO+hjfDdkerYzjYPxmRnz9/2MWMsN8m0yHEP769edGBGu1zMcAEZG4c
	RbqInqCoUaAqvl+dq5AyCiyydNBm6fGSjoJDzH0X1lDgUu/C2IQ90AW8YNsn9qgY
	uZhbtJLs0RAlRScoOqwusNaFU3S5YHxps0ico6XS4gJM4FsnjghIhN+JkZA2rSEU
	oJrAwaa+EULu4eqIMs0a47up2tihdhxHZ+KM7uly/Nq9rVO9NIowIxuCzVsh6Yg=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012020.outbound.protection.outlook.com [52.101.126.20])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 471g8kbnmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Jun 2025 02:31:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzK984WhZRTQ/z0Rp9VyDPjxbZRa6TeJQisKniqyvPaXHiqltm5kIW+3tTiaNARatITARTi/xZ7nOG35XaRhKVWb9eRXem4gDs6+ZCqYzLHg2ivKOI1R1BwSBE1eeGwYr8zYmHT2Ce4F0XZzIfTufw2/xQxgyGGteAxwebUV8Hb8xUAB+ikjvfU2TpQAfnSgVGIZxoldT5PKbaDUYwlQ3eJTEScTM4PNMU6Nrk4607zWAOVyjh+xb2YRzILD99bdhWtoEEoxaWllSM86F9NV/bZnHYphmOVf+l/zGPsR7/Qc5v4iqPm08H8PAyR8agg77iN/GIVBlTMZ4c5Kj7N1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2EUNiHryuKeiavb+Xoczc0ubIFzLw0ERSEszigdLJY=;
 b=PzJacv+zBDXhSJ50gwgwcwbFhWWSWl5W7hXvF5C9cN59448mOCR13uYWe7yoqd5OnPzwga08msZoNuFIa3rRkHyGPO8YSyKYy1bh8iPT15yPyqywGxwjWnJUEfxf+M+O5/G2dB8vsor3bV+lKTXMsw6lUhhwRY//MSuO/CSFPrDLcwjUuRByuJbkIHnaeCgyNe1O93BmwwlTadSNtstCsVmwtFNhQdPJxvVoPwnQOJo31oZmpmj+LKz891xiEkYdTyZkWsIQwkBQzKfbjxOqqSjxxGT1c8qJ11IvLHnMPGDk7bjGxl6wSHI/GT139tEeB6EpBWQDxfJdVYK5fO4j4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB5972.apcprd04.prod.outlook.com (2603:1096:101:65::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 6 Jun
 2025 02:31:52 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 02:31:52 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Zorro Lang <zlang@redhat.com>
CC: Amir Goldstein <amir73il@gmail.com>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v1 7/7] generic/633: add test requirements
Thread-Topic: [PATCH v1 7/7] generic/633: add test requirements
Thread-Index: AQHbz79IjN15oAYQK0yOsomc0lg+ZLP0qcaAgADF4a8=
Date: Fri, 6 Jun 2025 02:31:52 +0000
Message-ID:
 <PUZPR04MB63167B990F5D144392C67EDD816EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-8-Yuezhang.Mo@sony.com>
 <CAOQ4uxihwu9-rqFEUboDaDV9onaip4N5QsbdU_xTZQ7MnBDCzA@mail.gmail.com>
 <20250605141757.wx45cw2f5ets7hpr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20250605141757.wx45cw2f5ets7hpr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB5972:EE_
x-ms-office365-filtering-correlation-id: caf54cf0-f5e3-4a75-a980-08dda4a24c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmQrSG5hcmNTUmY4VERRcmZmaC9iQ1Q3RzN1U1EyQmFuZHJwdWRJVmNtNXpL?=
 =?utf-8?B?N1dhV2p3dU03QVpOMUJod2hPdUl4RDRVU050S1dtM2swRzUrejRWWWZFTktW?=
 =?utf-8?B?bkhyTkpLVFMwdXZiV3RuUXFZajMzSmtYMndrK3NzSXF3TEtpeG9BeHhlY0Qv?=
 =?utf-8?B?d2VXRjdzZ2lzOVVwdUJ5OVd1bWFnM3R1SVlFSERseFFIWHNvV3dMSVVsd0F6?=
 =?utf-8?B?NUcrQitnWW5jbHFaTkFVWlN6ZmFPakJkMkk0dkZpUCtHVHEraU5lK2k5MG5q?=
 =?utf-8?B?bndjaWYxTjJTUWltWWgwMlhmcUxTNEJMNSt4aXNyRVVTZTdIaUxBclpUN1I4?=
 =?utf-8?B?bmEyMThJUnlYSnEyMm0wOFJDWXpEL2U4R0RIMTErUS9QRkpzZy96VlJVeUVa?=
 =?utf-8?B?NU14YkVwenh0TnFQejV1SkJIVWwrMlZ2dFFHdE41VkVBMkxpdVY1K0p2dFNN?=
 =?utf-8?B?TDlBbldreEtjY2djcFlxTDM1Q2lzelBNMnN3T1RObkY0cGVxWjFRWE9GUDBq?=
 =?utf-8?B?SUw3dk03d2krSUF3TmVhMGhJanoxaWhTNzRiVGgyZVJUWHpyYlJ3QU1jT1U4?=
 =?utf-8?B?QlFBeWJ3OFVLa25JL052QXh2ZVlDUjI5SG9oVUo3dU1LU3lDMlY4NU9SUWRZ?=
 =?utf-8?B?K3pkYzkwTmQ0NlFFbEErREtZRHZOL2RHdm5IU0REeWlqcnZzTC9wMFRYK1NC?=
 =?utf-8?B?L0YwbXg5bTB4OG5FMk5GenhJYmczeXlBQnFWdGJ4eGhRWEYySUdoTmJiVTlw?=
 =?utf-8?B?WmRQa0I0T0JJUHlWRGtLSDVmMVpwTmxYQjBjSVd1a2FEbkEvdFZPYnZIT3J2?=
 =?utf-8?B?Q0U5K2FlRTUvYlhybEVnUk1tV01NMmNvM0JNSkgwZFRwT0tKN3NBL3NkREJh?=
 =?utf-8?B?TmN2M0UxK084UDdGckNkU09QSkZkZnpvYTNTK2hPNlZQZG40MVRDUFplNm43?=
 =?utf-8?B?bm5FR0hLMXpYWmVKVzJCSTJmR2RjakMyazZBa2I2Z1ovTDhyWXdsN041WGRo?=
 =?utf-8?B?N0JvbnFlem1STTN4R3c2N3hjL0ROZXZRa0pKcnJwdnAybVYzZ080YmQ1ODVq?=
 =?utf-8?B?YWcxaXJTY2tndmhhdzNmMnc2MVZyYS9vVVVjN3hSMlY2dFBaaTd5amVMTEN3?=
 =?utf-8?B?N0ZzcTNvWU9RaVZJZk1vay9PbGgxbFExdE1KSEhnWmhMM3gxQldJVEswK3Y4?=
 =?utf-8?B?S2h4czBpSkQrWHVDWjViVlBrR1BxZ1dRLzhEUWVzbXhCZTE3S0xNZERwNjNv?=
 =?utf-8?B?SXM1KzZxaHZWaHBMOFNIWXpJNFY4UmFuRU9zaHN1S3ZPdkRNTWZpd3FZczZU?=
 =?utf-8?B?RnBVeXZSdFZtMml3dmhtL0xxc2tCRzQwTVZQN1pYUjE5TlpIcU5JV2Z0c2xU?=
 =?utf-8?B?TlV3ZjZzaUZ5UWFxWkVzcUVBNXp4WndvNDM0UnFwWng4cnZNcEhPck5OcGxL?=
 =?utf-8?B?MExvelI2NmVaY3czR21WTXVRYlpmb2FydFYwOE5GV3l6QXVsQnJVMnBhL3RD?=
 =?utf-8?B?eDVTaUx4SUVKbkt0NDkwRXNEekxnMElsUVplVnEvN2MrNFNEVzE3VVNxZFgy?=
 =?utf-8?B?TUR3NjlPM2hlSnFVTENTSXVpYkluVVY0c1V4czFmUFlCcW9TbTFSVjMycitY?=
 =?utf-8?B?MHVCMEw1OTZlNGJra1RlcUpGd3c2Vjh3WTJ0UHcrS1R1UU55Y2taS3c4ekpJ?=
 =?utf-8?B?WlB6enQ3ckdYamtpWjl5WEVsYkxXK3BuVUdzY0pXc3hPcGFwd0VUU3g2Sk94?=
 =?utf-8?B?SEZyanRDU29zZnpaTExBN05KYWFEM1UrZWc5cmpweXphdWUyOUN5RU5FRlVV?=
 =?utf-8?B?Skg3cE1JL2JRc2VyblNJeFFHVHN6VTViZEdrOTlmSmgraGZzbUNCcEJNbFJT?=
 =?utf-8?B?TWtKcDVTaHZmMGtldkFBMVFOY2ZQMEVCOFkrWEo5aTZpY01yK2FVeFpkdnVP?=
 =?utf-8?B?UGhwUVVMUlN6VnhLSW4vQWozV1hLQnZON2l3NHRjN2FvcE9ISCsyTUpGazI3?=
 =?utf-8?Q?iE9I/3YDMXqGRpWJd/SeWbw/3XXwdA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTB1eG5uMkZMc09jc1JwbEdpWk1MSkp4NGVibVdpblJGVlZ0bUtlR29zSi9u?=
 =?utf-8?B?ZEpUVUdaUHFFdjdFVjJpbGdqU2F0Tm5sS2Y3akszL2tMS0ZtUk02NmtMZTdB?=
 =?utf-8?B?OEQxSkNxMGtpd2FPdyttcGtQa2NBelMrVlZ5SThyTFV4eWE1Wkh1dWJ6M2d6?=
 =?utf-8?B?K3NhT1lGUFZNVk5KS1RyVWM4dElJTTYxamNmODZLekNKdkZhcmdNZUV2cHVC?=
 =?utf-8?B?SlpiT0FzVklmRnZRTFl2R2cweWc2Z2JkSk9MSEo0YmFoSHdDWVd3am5CalBF?=
 =?utf-8?B?dlh4b2gxd3l1dklXejFrQ1djMlhSWU1LK0ZnTzJSUXlqdVBJeGo4S1RPUngw?=
 =?utf-8?B?Z3lySllBeTVuUFlDQmpneHRMWU9MWU84amZ4b1cvbHRMSnN6VkdWWXZtZkor?=
 =?utf-8?B?U2VyZVJIOEJtVEE1R042ZFI3aXMzUjUvOFcxdTBxOG0yWFpCb1dxM0UzWEQ0?=
 =?utf-8?B?NzUwNmRadDc1R05lT2tZR2hsdHZSdE8yalZsMVkwY0oxb0d4ck9rVDBKZXFk?=
 =?utf-8?B?NnRpWEdvTWwreUNaR09UOTQvdmY5U3czRElOUFMzT2ZZSXZnd0ZWRjRrSGJL?=
 =?utf-8?B?ekdWUStMZFRRMVhmZFc3aUVWMEk4K3RQZzdWSTR6azZUWjRjVHNkc3JzUzJk?=
 =?utf-8?B?QW9FbzY0cUVMYkNwQ2w0eFlFa0FZNFFsRnpCaDArQ2JjSk1yK2liSlpiaG1h?=
 =?utf-8?B?STBIcDNnNHdTeDBFaktsOGFnQUhkTzJVajFxNWM1MSsrb2g2VzF6bzJJMVAv?=
 =?utf-8?B?dHZjYWYxOUFBM1lEUU1MTDJXdnYvMGNWUTVsemNNQmQ2VXYvTlRlTmRqYW9P?=
 =?utf-8?B?MDF6Y1pDbUdXdDV2ckgzb0RDM2RtVWxmQThaTVd3Q1A4MEpRQVMrdU54b2ZL?=
 =?utf-8?B?QUVnOG1mbnhBNWNpOHF1VHJUK3I0WVhmVjdCRXFMeVozNE0rcnJrd3Z6dkU1?=
 =?utf-8?B?bzQxOHZMckhkTVorMG9VUlNDVkRCS24vWWVqMUh5V0JTSW9jM2l1cTBra0lR?=
 =?utf-8?B?RWlZckk5b1RDVVZIdEdqSTdwVTFxVm1iWkExMVRFaS9RY3hyNWs0VXJ5Y2tS?=
 =?utf-8?B?SWZTbFh0Q2pnRUpNd0t5MjhGQVd3cDNvaTk4YWh5S1BjMGF4QUE1SnlpS3B2?=
 =?utf-8?B?TWNqK0F1RGpucDE3dXpXZWY1MmpSeW43MDlJZUs0WlVKQWh3UEp1U0RvZk5X?=
 =?utf-8?B?RGZzN2xWbEtramw5bWN4bzJJTmxlOEFLTHpDUDdkK3BCV2ZudG5qMW1TY1pu?=
 =?utf-8?B?cjRMMnhuMFk1MzVvWDNKZzZ2dllOcjlEMlNha2NOdWFQV3ZmTG90Tks3U3NO?=
 =?utf-8?B?U0FJcUc2VklCeSt5a1JmRUZpVTcwcllWWDVwSGQxVmNtMXUyeVZZYTRNTXY2?=
 =?utf-8?B?aWNHeVg5bWVwMk9ReTl0NXhUUDRCek9LS2NkUmxjMkt1MS85WHloQ1g5cGw2?=
 =?utf-8?B?VUgvMXJyVmw5ckEvQWw1K2dnaDNBVDdJUTBPSDIwWW8rVmdaeXFJY09lNWt0?=
 =?utf-8?B?Ny9YV0ZXd2Qrb1FjNTRsQWRSVXhKYXpwSDNaNUdiMW5qNjIxWDF5UHh3M09h?=
 =?utf-8?B?eGp4ZGV5SExaQzNlcWtPMS9yVmtBdUJDYVIxK0U5SXRJQ1BuVURBSWJ4MnNp?=
 =?utf-8?B?S0pldWJWY3ArTGZjTmtUVmtIRllTRU5BWlR3SDJpbEU0dkJ3a0swRk5VeHB6?=
 =?utf-8?B?bWFKakFtU05EVVZUUTZOSkFUZWZlcUNTS1crcnRwOUQvbUI0OVVzeThGbVZF?=
 =?utf-8?B?NEFzZDVnY29xYnBDL2Ntb2lwZVpNSUV1WUFyRkwzdWNsUGVzNWQxalNqeEJK?=
 =?utf-8?B?YWZFdm5Gait6aFB6QVVWa0d0VTdYNFphem5FZTc1UzlZbEVGVFBkKzlKdnRY?=
 =?utf-8?B?K1hTclN4ZmU4bE9wam5LeFREcVhDM1RVMUQxZnVoeE5ONGlEdk13c3BNeUNo?=
 =?utf-8?B?Mlh3WTl1ZVVPWVJkTFNPbnByaGpjRW43TlRQWVgrRW1sczViUTZkWE1QZHY3?=
 =?utf-8?B?QThPTzZHcFRHSjNyTjRseitFWXRpMWY0SDBZb0xPMUxPY2EwbisxMHNETFJS?=
 =?utf-8?B?WnNONTNCeGNrWUx4Z0dVSFBuMXZ2dWdTSlduRXFEcWlzOW51OEpsQ0RMZDUx?=
 =?utf-8?B?VkFpbzdJZzc3a3NNbjRRYTQ4YndEUGhlTGtVMUw0VXdmbjdDUXcvVWZuVm1M?=
 =?utf-8?Q?Xv8hpDQmTo+Y+Lh2tzskPxE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8/umBtxjGjNEYDojvsbTWTpUxKu0VYEs/GnQ8Z8XPKGmL2U7Y8sNYeBypWs8BenKtUfR5TRfXa74c5fxmsi9BzEIZa8Oipai2G7JBcEUHlilgZBzfs0uS7CQTupBwr03UhJGBNsCFzdPMFmq6BK3OgEGeKE3xSSFqnoLR1PlYrOCnRCUcHIk3HsKjwxJYsms+OOxG2aHVcz38fo/tPJOPulpazrFQTAbgOUZBTGVP1+chgNu5Lb6fdryWCIXlZP0FszGDBUlNykgatPUR0syvn65CQORmyXIirH+qKUVrLIGD4n0dU87+tm0O3EZqdaWKKln7LlVpfjFd1pG/ng46KFzm8mVtoyATUtJdFqb4Ty4H2BuoZwXSxwSNko1YhLc4r4dVIoyGCUdwDW+9c4H8rZsh2TTK3AwRHwUALUyvy55wZv90aMqnjKUyS7nWglzDmuVng1EkU3S0I2r1FzXqn7Ca4jUkTGvdXir5YIm692M6d8EsM+/TSGmruWik4zWW+Bqliqq8B4vNJUexSCU1pi7Wy/Tw6C2RLOOhr047aJq/yiAQ72t3EZf3SYJFNuKsghVe3PKqZCYGJGLa3q2bhOXXdK4OMsRYKHRta/Um3ybEZy6XMQc/ZydTOkmsk1e
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf54cf0-f5e3-4a75-a980-08dda4a24c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 02:31:52.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76p1K3TcvH2az0uaMoxoamMTM17pHXBv8URbSfN8wkGxUjhp7O+vs0cIoBs68D7X3WrWSsmsIoTYLGGp7Xb6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5972
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAyMyBTYWx0ZWRfX8fzRqeoN4lri voeJSgP3Zr+mBwa8WnGMtyYURNRPlY2/lxtm+n43Mpnb9jOs4bIxB7Xc0FsNAV3HDJdDx+mDvDo q9U+mY1AB7PPNXezwGmzQiQD7KZpOk7QBaUPzyzBGX6d9wVeNad2HuS2CeXHBZTxwumG0SHxJT6
 ncghfvhN4Em/BvG9wrk3c/aMN23+botYKLKKWYtoN9sQbrTmtIUah+kExeIoE1eMcrfTQz4/vYe 0m5g61fMjCtkKv6j8aLMhv1O+B6ogJgQzfS/JMAyHh1GXx3btwJ/uHbsKbaCfUsgbAoYtGGtyKZ FJywvrnDOZkC/PDNCWKJlKulnaLRqyGZn28Rt8YCB6zQ8zxVJJfgv/nle+C/FTXQJP8Xfym5PKQ
 EmhdKiPNknEnlucZ4zgmWslMwwSt3yir9dbjlYBUVG4y1jPGo1UXVK9Kl7hdz0zFXK42TpLU
X-Authority-Analysis: v=2.4 cv=VJbdn8PX c=1 sm=1 tr=0 ts=6842531e cx=c_pps a=UWyk5+a1JXsQzCbzjc+Vwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=z6gsHLkEAAAA:8 a=3eymR4pQxwxBNCYt_iAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hparIF7PZgVSkpcVdSa7L5b_9hKv_nAt
X-Proofpoint-GUID: hparIF7PZgVSkpcVdSa7L5b_9hKv_nAt
X-Sony-Outbound-GUID: hparIF7PZgVSkpcVdSa7L5b_9hKv_nAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01

PiBPbiBXZWQsIE1heSAyOCwgMjAyNSBhdCAxMjo1Njo1NVBNICswMjAwLCBBbWlyIEdvbGRzdGVp
biB3cm90ZToKPiA+IE9uIFdlZCwgTWF5IDI4LCAyMDI1IGF0IDExOjE14oCvQU0gWXVlemhhbmcg
TW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gU2luY2UgdGhlIGZv
bGxvd2luZyB0ZXN0IHJlcXVpcmVtZW50cyBhcmUgcmVxdWlyZWQgYnkgdGhlIGZvbGxvd2luZwo+
ID4gPiBzdWItdGVzdHMsIHRoaXMgY29tbWl0IGFkZHMgdGhlbSB0byB0aGlzIHRlc3QgdG8gYXZv
aWQgZmFpbHVyZXMgb24KPiA+ID4gZmlsZXN5c3RlbXMgdGhhdCBkbyBub3Qgc3VwcG9ydCB0aGVt
Lgo+ID4gPgo+ID4gPiByZXF1aXJlbWVudCB8IHN1Yi10ZXN0cwo+ID4gPiAtLS0tLS0tLS0tLS0r
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
ID4gPiBoYXJkbGluayAgICB8IGhhcmRsaW5rX2Nyb3NzaW5nX21vdW50cyB0Y29yZV9mc2lkc19t
YXBwZWQKPiA+ID4gICAgICAgICAgICAgfCB0Y29yZV9oYXJkbGlua19jcm9zc2luZ19pZG1hcHBl
ZF9tb3VudHMKPiA+ID4gICAgICAgICAgICAgfCB0Y29yZV9oYXJkbGlua19mcm9tX2lkbWFwcGVk
X21vdW50Cj4gPiA+ICAgICAgICAgICAgIHwgdGNvcmVfaGFyZGxpbmtfZnJvbV9pZG1hcHBlZF9t
b3VudF9pbl91c2VybnMKPiA+ID4gLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gc3ltbGluayAgICAgfCBwcm90
ZWN0ZWRfc3ltbGlua3Mgc3ltbGlua19yZWd1bGFyX21vdW50cwo+ID4gPiAgICAgICAgICAgICB8
IHRjb3JlX2NyZWF0ZV9pbl91c2VybnMgdGNvcmVfc3ltbGlua19pZG1hcHBlZF9tb3VudHMKPiA+
ID4gICAgICAgICAgICAgfCB0Y29yZV9zeW1saW5rX2lkbWFwcGVkX21vdW50c19pbl91c2VybnMK
PiA+ID4gLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gY2hvd24gICAgICAgfCBoYXJkbGlua19jcm9zc2luZ19t
b3VudHMgcmVuYW1lX2Nyb3NzaW5nX21vdW50cwo+ID4gPiAgICAgICAgICAgICB8IHNldGlkX2Jp
bmFyaWVzIHN0aWNreV9iaXRfdW5saW5rCj4gPiA+ICAgICAgICAgICAgIHwgc3ltbGlua19yZWd1
bGFyX21vdW50cyB0Y29yZV9hY2xzCj4gPiA+ICAgICAgICAgICAgIHwgdGNvcmVfaGFyZGxpbmtf
Y3Jvc3NpbmdfaWRtYXBwZWRfbW91bnRzCj4gPiA+ICAgICAgICAgICAgIHwgdGNvcmVfaGFyZGxp
bmtfZnJvbV9pZG1hcHBlZF9tb3VudAo+ID4gPiAgICAgICAgICAgICB8IHRjb3JlX3Byb3RlY3Rl
ZF9zeW1saW5rc19pZG1hcHBlZF9tb3VudHMKPiA+ID4gICAgICAgICAgICAgfCB0Y29yZV9yZW5h
bWVfY3Jvc3NpbmdfaWRtYXBwZWRfbW91bnRzCj4gPiA+ICAgICAgICAgICAgIHwgdGNvcmVfcmVu
YW1lX2Zyb21faWRtYXBwZWRfbW91bnQKPiA+ID4gICAgICAgICAgICAgfCB0Y29yZV9zZXRhdHRy
X3RydW5jYXRlX2lkbWFwcGVkX2luX3VzZXJucwo+ID4gPiAgICAgICAgICAgICB8IHRjb3JlX3Nl
dGlkX2JpbmFyaWVzX2lkbWFwcGVkX21vdW50cwo+ID4gPiAgICAgICAgICAgICB8IHRjb3JlX3Nl
dGlkX2JpbmFyaWVzX2lkbWFwcGVkX21vdW50c19pbl91c2VybnMKPiA+ID4gICAgICAgICAgICAg
fCB0Y29yZV9zZXRpZF9iaW5hcmllc19pZG1hcHBlZF9tb3VudHNfaW5fdXNlcm5zX3NlcGFyYXRl
X3VzZXJucwo+ID4gPiAgICAgICAgICAgICB8IHRjb3JlX3N0aWNreV9iaXRfdW5saW5rX2lkbWFw
cGVkX21vdW50cwo+ID4gPiAgICAgICAgICAgICB8IHRjb3JlX3N0aWNreV9iaXRfdW5saW5rX2lk
bWFwcGVkX21vdW50c19pbl91c2VybnMKPiA+ID4gICAgICAgICAgICAgfCB0Y29yZV9zdGlja3lf
Yml0X3JlbmFtZV9pZG1hcHBlZF9tb3VudHMKPiA+ID4gICAgICAgICAgICAgfCB0Y29yZV9zdGlj
a3lfYml0X3JlbmFtZV9pZG1hcHBlZF9tb3VudHNfaW5fdXNlcm5zCj4gPiA+IC0tLS0tLS0tLS0t
LXwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gPiA+IGNobW9kICAgICAgIHwgcHJvdGVjdGVkX3N5bWxpbmtzCj4gPiA+ICAgICAgICAgICAg
IHwgdGNvcmVfcHJvdGVjdGVkX3N5bWxpbmtzX2lkbWFwcGVkX21vdW50c19pbl91c2VybnMKPiA+
ID4gLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiA+ID4gaW9fdXJpbmcgICAgfCBpb191cmluZyBpb191cmluZ191c2Vy
bnMgdGNvcmVfaW9fdXJpbmdfaWRtYXBwZWRfdXNlcm5zCj4gPiA+ICAgICAgICAgICAgIHwgdGNv
cmVfaW9fdXJpbmdfaWRtYXBwZWRfdW5tYXBwZWQKPiA+ID4gICAgICAgICAgICAgfCB0Y29yZV9p
b191cmluZ19pZG1hcHBlZF91bm1hcHBlZF91c2VybnMKPiA+ID4gLS0tLS0tLS0tLS0tfC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4g
bWtub2QgICAgICAgfCB0Y29yZV9leHBlY3RlZF91aWRfZ2lkX2lkbWFwcGVkX21vdW50cwo+ID4g
Pgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+
Cj4gPiA+IFJldmlld2VkLWJ5OiBGcmllbmR5IFN1IDxmcmllbmR5LnN1QHNvbnkuY29tPgo+ID4g
PiAtLS0KPiA+ID4gIHRlc3RzL2dlbmVyaWMvNjMzIHwgNiArKysrKysKPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dl
bmVyaWMvNjMzIGIvdGVzdHMvZ2VuZXJpYy82MzMKPiA+ID4gaW5kZXggZjU4ZGJiZjUuLmUxOWEy
MDQzIDEwMDc1NQo+ID4gPiAtLS0gYS90ZXN0cy9nZW5lcmljLzYzMwo+ID4gPiArKysgYi90ZXN0
cy9nZW5lcmljLzYzMwo+ID4gPiBAQCAtMTMsNiArMTMsMTIgQEAgX2JlZ2luX2ZzdGVzdCBhdXRv
IHF1aWNrIGF0aW1lIGF0dHIgY2FwIGlkbWFwcGVkIGlvX3VyaW5nIG1vdW50IHBlcm1zIHJ3IHVu
bGluawo+ID4gPiAgLiAuL2NvbW1vbi9maWx0ZXIKPiA+ID4KPiA+ID4gIF9yZXF1aXJlX2lkbWFw
cGVkX21vdW50cwo+ID4KPiA+IFBsZWFzZSBub3RlIHRoYXQgdGhlIHJlcXVpcmVtZW50IGFib3Zl
IGlzIHdyb25nOgo+ID4KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2ZzdGVzdHMvMjAyNTA1
MjYxNzU0MzcuMTUyODMxMC0xLWFtaXI3M2lsQGdtYWlsLmNvbS8KPiA+Cj4gPiA+ICtfcmVxdWly
ZV9oYXJkbGlua3MKPiA+ID4gK19yZXF1aXJlX3N5bWxpbmtzCj4gPiA+ICtfcmVxdWlyZV9jaG93
bgo+ID4gPiArX3JlcXVpcmVfY2htb2QKPiA+ID4gK19yZXF1aXJlX2lvX3VyaW5nCj4gPiA+ICtf
cmVxdWlyZV9ta25vZAo+ID4KPiA+IEkgd29uZGVyIGlmIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8g
aGF2ZSBhIGNvbGxlY3RpdmUgY2hlY2sgZm9yIGFsbCAob3IKPiA+IG1vc3QpIG9mIHRoZSBhYm92
ZSwKPiA+IGUuZy4gX3JlcXVpcmVfdmZzdGVzdCwgd2hpY2ggaXMgZGlmZmVyZW50IHRoYW4gX3Jl
cXVpcmVfaWRtYXBwZWRfbW91bnRzLAo+ID4gc28gdGhhdCB3ZSBkbyBub3QgaGF2ZSB0byBhZGQg
YWxsIG9mIHRoZXNlIGZvciB0ZXN0cyBydW5uaW5nCj4gPiBvdGhlciB2ZnN0ZXN0cyBzdWJ0ZXN0
cyBpbiB0aGUgZnV0dXJlLgo+IAo+IFllYWgsIGFuZCBzb21lIF9yZXF1aXJlXyBsb29rcyBvcHRp
b25hbCwgZS5nLiBfcmVxdWlyZV9pb191cmluZywgd2h5IGlzIGl0IGEKPiBuZWNlc3NhcnkgcmVx
dWlyZW1lbnQsIHdlIGV2ZW4gcnVuIHhmc3Rlc3RzIHdpdGggaW9fdXJpbmcuIElmIHNvLCB3ZSBk
b24ndCBkbwo+IHZmc3Rlc3QgaWYgaW9fdXJpbmcgaXNuJ3Qgc3VwcG9ydGVkPwoKT0ssIEkgd2ls
bCByZW1vdmVkICdfcmVxdWlyZV9pb191cmluZycuCgo+IAo+IEFsdGhvdWdoIHdlIGNhbiBhZGQg
YXMgbWFueSBhcyBwb3NzaWJsZSBfcmVxdWlyZV8qIGNoZWNrcyB0byBhIHRlc3QgY2FzZSwgYnV0
Cj4gbW9yZSBfcmVxdWlyZV8qIHRha2UgbW9yZSB0aW1lIHRvIHJ1bi4gU28gSSB0aGluayB3ZSdk
IGJldHRlciB0byBhZGQgIm1pc3NlZCIKPiBfcmVxdWlyZV8qIGZvciBzcGVjaWZpYyB0ZXN0IGZh
aWx1cmUgb24gc29tZW9uZSBmcywgbm90IG9ubHkgIkkgcmV2aWV3ZWQgdGhlCj4gY29kZSwgc28g
SSBmZWVsIGFsbCBvZiB0aGVzZSBhcmUgbmVlZGVkIgoKRG8geW91IG1lYW4gd2Ugc2hvdWxkIGNo
ZWNrIHRoZXNlIHJlcXVpcmVtZW50cyBvbmx5IGZvciBzb21lIHNwZWNpZmljIGZzPwpMaWtlIHRo
aXMuCgppZiBbICIke0ZTVFlQfSIgPT0gImV4ZmF0IiBdOyB0aGVuCiAgICAgIF9yZXF1aXJlX2hh
cmRsaW5rcwogICAgICBfcmVxdWlyZV9zeW1saW5rcwogICAgICBfcmVxdWlyZV9jaG93bgogICAg
ICBfcmVxdWlyZV9jaG1vZAogICAgIF9yZXF1aXJlX21rbm9kCmZpCgpJIHRoaW5rIHRoaXMgaXMg
bm90IGdvb2QsIGZpcnN0bHkgYmVjYXVzZSBpdCBpcyBoYXJkIHRvIG1haW50YWluKG90aGVyIGZz
IG1heSBhbHNvCm5lZWQgdGhlc2UgY2hlY2tzKSwgYW5kIHNlY29uZGx5IGJlY2F1c2UgY2hlY2tp
bmcgdGhlc2UgcmVxdWlyZW1lbnRzIGRvZXMKbm90IHRha2UgbXVjaCB0aW1lIChpbiBteSBlbnZp
cm9ubWVudCBpdCB0YWtlcyBsZXNzIHRoYW4gYSBzZWNvbmQpLgoKCgo=
