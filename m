Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2B374D1
	for <fstests@vger.kernel.org>; Thu, 29 May 2025 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495699; cv=fail; b=YEwVp/l99QiLGF7RKi53ym5/9ThB40CmYtBHrrqE1V9ix9DL1eyGfN73vTQCAzywUSOta9ovnSjILdpbA6MQzRxBrNpZVRq6qAxRU5YfeDI9SPjO5ROFB3mupkEv4EY2tD222mm888p8w5yUk7G2Pll+2GBk+4KLvqHS1ichJUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495699; c=relaxed/simple;
	bh=v9ezfXAjtPMArmdCYDXLuZNNIR+0RAX3tMyX5Qkea9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOtiY34U8u5xwkUiplj4b8fyjB/5qH7nvMKdlwdgict/iJdfcDX81IRu84cJAswx+yfmlFSb2zgEnGdhpWkM39c+nRH23B6F2Hb3kgtCXYP0Hc554Bb3VoYZSrFDlbgDA/B2HfW4/cCDnBdctVJL4IvpruTsQerLZbb4ch1aJmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=dWhwNnqX; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="dWhwNnqX"
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3UShF001455;
	Thu, 29 May 2025 05:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=v9ezfXA
	jtPMArmdCYDXLuZNNIR+0RAX3tMyX5Qkea9o=; b=dWhwNnqXEB5xWZWeiGmTSa5
	0bzpfUDuV0bJoiMjzfnbkTbuMCtvIB1DeIhRB0sSWvfxhSXyL/AJ15FDV3HsR7m4
	jV3Qb0SvoSruo4VlT+CI6SygUbnu0FebbUZEYn6gw5xNsoUOXZfGmYcGm7RoknxF
	MsPiHohtCr+j0hiAZWK6L/U8KEwq+FHxzOV7fu2VNIBp3aeD8SUFaYIkTUBNz1eI
	KWafZe71xWdyspF20CGGMUDCUL/dL4TROcxRWyUzTCiaNRMdDFaBMorc41V/2Mtb
	736X/4Y/wMzQSUJHZVokWfWjMgM3PLn/UGHhEwXTb1FILh9YEHWlpfmU9QNYSAA=
	=
Received: from os8pr02cu002.outbound.protection.outlook.com (mail-japanwestazlp17012051.outbound.protection.outlook.com [40.93.130.51])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 46u4w7c35p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 05:14:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnBH9pXZnjQXwsrK48U41dxSqsoWejjJhzoL9fZJH5P9vya5xo9Bdpa9zxfkYtQPvyhc7Sv6PcO6pH9LJ7rAXB5vQYVLB0uU0HfPJ44jWTs+PNGFxKBpYjBec2Tq+nscinRskjaGy7+VmfrL9vATmG2DkYQAxoH6CE05EATfQ8PtPmlUelLbF8uobR35yhioV9CHSTsVIluNLUg7ERuz/s34wxgGwEu+aypo8GHmtiEu0dax6cjkO8xhjlxuYx8gdoekVA7B63qD6d1KYJib7Uyugv8BTAem0IsttthPfQ/0+oUFF5Z9xgHlJiqmhIpN6+yZ90XbtetBsjkUVZZpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9ezfXAjtPMArmdCYDXLuZNNIR+0RAX3tMyX5Qkea9o=;
 b=DFkcdPoNCZAJlIUJe67ltsS2au+sUS1CIQv9KbbsDpld7cJpQl8UwVxl0IA8RHsEY95Uu9ppFN+gEW9rX/JU0IbD6isadDlO+gef66uYmkmIhW3/X5YEe0BT9zGwegT5GZcMaBBCV+LWL6WnS/+Nt6DOjBlaREU747iHyd8An6aZazC+0DWqxXOsj8HSxnZi/swfoKSOHsN2tAY1Xr/r5hviucMlxGr5DAK6VMwn7Ez6eGy0iWrt8UPa7uKgci60P0QJkSD9V0uaRMi7e3M1j19NHVkBaklIPrnqSKXhE4h9GkcdJ8lrZvX4Ma7AhBgFDRgUMakY7szCJmqABKPSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB8270.apcprd04.prod.outlook.com (2603:1096:405:de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 05:14:36 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 05:14:36 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        "Friendy.Su@sony.com" <Friendy.Su@sony.com>
Subject: Re: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
Thread-Topic: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
Thread-Index: AQHbz73+BfFwW9W2+0eg4U8nmBjKLbPpD4gG
Date: Thu, 29 May 2025 05:14:35 +0000
Message-ID:
 <PUZPR04MB63169A8C1008035BB2D104568166A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
 <CAOQ4uxiaO6kj5eVyPX5FpfZgc2Uw8GQqAJryPfRSv6pgiSHXUg@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxiaO6kj5eVyPX5FpfZgc2Uw8GQqAJryPfRSv6pgiSHXUg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB8270:EE_
x-ms-office365-filtering-correlation-id: be4b9bba-a2bd-4f80-e84e-08dd9e6fb453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjlwbkNCK0d3ZmZhaHA2aWx1ZHBnbFhwK2N3K2pRVjJMS0U5MlUvc1poMWZ0?=
 =?utf-8?B?ME52YnMyYlNEeWhJMDVmajlSL2N2N2M4M1pJTE5rS2NPNDNWL1o4QkhrSWZX?=
 =?utf-8?B?Zm9XWGJ2am56R3ZCRUszZWtzRWJmSUdqR3l2ak03Tk1WNFJvRU1TV3ZMVlE1?=
 =?utf-8?B?NFVtNzgwaTNDTm14NnZzOG5la2JGdDlScXY5RWxubG9TOFhGMHJTYm5obExW?=
 =?utf-8?B?NndFcmlKVzE4QmVZVFQ4dUhiVkdGZmR4WjlVTWV4cCtxdEZXMTJOdjFwZkFU?=
 =?utf-8?B?MXpYbW8rc1B6RmQ2WmI3My9sWnlDbzV6emxYTWgxNXV2UFpkOVVhUmhMSTB3?=
 =?utf-8?B?dGpJN0Q3cE9rc3V1emJUQWlHYk1WaEtCVnhnRnBHZ2J4SVA3c2FVbXJwVWJo?=
 =?utf-8?B?NUxzbnFNK0pmR3c1WkwvZE5Kam1uMFhDa2w1QVUyOS9SeWZZZXFTU1dxbWxt?=
 =?utf-8?B?ZHpBQVRmYTZPZTNWUUtGMEl4cExCWWQxaDd5SUJRS3ZKVnl2UVlSV25sY1ZK?=
 =?utf-8?B?cDlKY3ZHZFFaL0U4ZWV3MDd4SEcrUzl3ZFBjUGxnanBGVUVNNVFxek9uenNB?=
 =?utf-8?B?Y01WekFHUldIdHBhT09LVHN4ZEVPcHptdHVZcUlkUyszclAwandqNEM3VXNM?=
 =?utf-8?B?RHh0UWZOMXZnRFdkK3cvUW04a2VQdWNTN3VZWGRjZWtSZHVTTlJBRGJoeGIy?=
 =?utf-8?B?NGp4ejhQbytKMW5rRXZ4aExKd25DaEFQNWh2c1ZvWmFCc0NvR2pEdkJIa09Y?=
 =?utf-8?B?Vms5SnVmZDFTdkVTOGtUV1NvSU5TdHdhVnBPTm9yakxkbUdVbUNNSFo2L0pq?=
 =?utf-8?B?STVKZjRkSG0zUlNhK0pKQ3R3NG5leVV2TS9PTlAvMmhBN2lKRW02eVBwNFhD?=
 =?utf-8?B?akNhRTJoMkVaZzE4ZGJhSnZoNVN3Y2g3MmJFYTlKR0lhTWc1Um5Fd0p4bFk3?=
 =?utf-8?B?YzF0VDEybUFGSE1tWHdyMmtaaEJ2V3M0SmQwMUxmdGg0cWNjUFdHYlVsSVB1?=
 =?utf-8?B?a3VQbHM4cmx3NElJM1Q5Y3lWNDd0NGFtL0VmN0VhNFhlc2drckRVa2dWQnF0?=
 =?utf-8?B?b0hiMnJKbWswZ1NZZk1sbUJMdWNrK3hscm5NOExwRGpZdGlRd1h6WnVwQW82?=
 =?utf-8?B?VFJoVjVQNTdwbmo0YTBocEx1ZmFMRVlVZFQwajhsdjhNQ256VVB2ZTJYd1hM?=
 =?utf-8?B?b2xURjIzd0I0VzdFTW1HYWd3R2hDVHRQK0FjM1dzY1RQQXU2cTkxbldqWmUv?=
 =?utf-8?B?a3hSTGlYOFg1UjFNOFU1V1FxdkZOaVR6RFNjQnJmTGVaUS9RSWFlM1BPYTRi?=
 =?utf-8?B?ZERyanNVWTUvcEtnTjdSVk1Renk3SWZ2SVVuaXBSZi9KNHBxV2gxOENOZHdi?=
 =?utf-8?B?U3o1YkNwTHp3YVZaZ1dqcGZ0VTlPVFpMZ2NoSWFwN3A4RVNNdGlVRnlEUkl6?=
 =?utf-8?B?TTNSMHhlbmJWc0MzU2lBWWF6MHltZUkyZkZxK1l6Z2YvTkVyYng3bXhOZWky?=
 =?utf-8?B?dnYrdDJOK1lhZjRNWElCNm0vdUltbmtVQktHTnJkaWdwckd6eEVkS1BmTy9D?=
 =?utf-8?B?YzY0azkxRHh4aDg0aS9Odm5TamRTd3JLY3Z0WlJqeDhLZkZScHdtMnk3UVkw?=
 =?utf-8?B?d0IvNktkQVZuazRsL3BCVit2ZzRFSldQTlZ1VFRFQ2cwaThNQlQ4UnRvbUtF?=
 =?utf-8?B?Mjl1WmJUWHNLZzFYOGY2eis4eHNnLzlYRGMxZWFSaktSQVRGSWZPelBrWXg5?=
 =?utf-8?B?djdBNlVVdmhxTkNGMXo0L0MrNDZWbS94TnU3ZUpEbjd6NnQ2cVg3Z0pET3BL?=
 =?utf-8?B?U0V5dnRjRlROaVZybzZEL25MU2dWOXpwVVROVXh2VFArOUFxSG5yZ3FjcVAy?=
 =?utf-8?B?V05zY2g0M2NGRmhyU3ZEL2piYmd1TmRCTVo4SUNmcDAxeWFLcWRvUHUyQ2xk?=
 =?utf-8?B?Z2Z3UVRnby9UMUdTSzBBaVRZbFg2NnlrWGk3bTgzL1lkZjkvckZSVzZWdSt0?=
 =?utf-8?Q?/Y8f7UyRTfjFYvEl9yx34bnkMlPiG8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2J6SklxL1p2Yk5CRHRWMHRoRVVrdUszUHVaWWtuTjhWOENFVlNOQzNOTGFK?=
 =?utf-8?B?UFNrS2NHWXU3THZESGtneFg0RjNSWnlSeTJTVk1OVlVpb3Z3OWFJZWc1K0Fz?=
 =?utf-8?B?djhPZXlVaExOMTc2SWk4Vk5rRjM3eldXWTVCamM5T2pLOHVDamtoQWtwYW9F?=
 =?utf-8?B?QTVCWmpBRGZ2QVlRb0xjSThCWXJ5azZHYW9NNDJQUzJsOElrdUpYWWZ6MVFy?=
 =?utf-8?B?WGpDMkMzM3k0QkpSZEdTTFhqVHBPZjBWOEwvVUhYUVErOFNxaDhvNHJMMkdZ?=
 =?utf-8?B?Z2tSbFpnSHdtdHg5RTJnaTlHeUJoNWJKOEs5Wk1QRERSZzRwTFZUV1N2V3Jl?=
 =?utf-8?B?ZE9uanZxc3BMQS9YSTlwSklXakRhWFdqRGhZYUk2WkJQU01FdjlJUzZjaXk0?=
 =?utf-8?B?TzR0UzdTM2N4Qm03eXBqZXAwM3JGQlhHRnFiSEhERjZjRGVqY0N3alhXUTRp?=
 =?utf-8?B?alJGUG1sMk9ybWxidnZPRk1mdDhycGx0UWlMMGdGTktwQ01PT1lHSitIWDZG?=
 =?utf-8?B?anBVRGlzVWJLMURwelNacHg2d3VJeDdkcmNXUm94UmlpTmRodHlLbnN3OTFl?=
 =?utf-8?B?ajF0UGxVdkkvU2s3SVdla3FXU1lSaG9pRTFkcFkwc2VrZm1xQ1owanBJWHR0?=
 =?utf-8?B?QTVhZjVDcDBKUTlOSU5uYXdXNlQxbngwMGJiQXR4VnltWEM2VGNSVmU5amlG?=
 =?utf-8?B?NEFwcU1rTUl0dXBrY2o2MHNXbitadlBJM1MzSU1IVytmOVVVaE1rakp1Tmg0?=
 =?utf-8?B?VzFPV1VEbUpiRTVGKzZtaURLL3IwT0ttSkRmb05JRnJDMjY2U25qTEJDNmt4?=
 =?utf-8?B?cmJ3NFBFV00rQTZITTlQWG9XYmR6Y21TZVRUbzY1b21jMUlzRXFjdllrOXhV?=
 =?utf-8?B?Nk9lMlNZY3EvVTRSMThpQjE3ZFdpOUIvUWE4Tkp1N3ZldXVST0JYUmR5RDdU?=
 =?utf-8?B?K293a2JPakpCZHpPK0c4K0lXU1QxbXY4U2pHRXJjOGZIRGZJOE5CZlAyRzNB?=
 =?utf-8?B?RlZFU1hYMlZjNUJPbkNjcTMwenRBY1Z4RzRTRmsvdkVnSTRPU2RvUCt1VXcr?=
 =?utf-8?B?YUhqQlRZcmRjVXJlbVFQMkp2RElzc3V3M3VLUWhYK1BSTlp5Nlpid0hpcVVk?=
 =?utf-8?B?ajZEbGNiZHJPaU0rdFBMUGx5WjRaNmhSRUsrenlMZ2NVWElINnZLVFRnUlZl?=
 =?utf-8?B?TFhEVGprSm15TUtBZFNwMkVLMVVRTDVvTHJHRlZTejhDbXYxbWc2ZUE0WTg0?=
 =?utf-8?B?eFloeWJseE5NaWpoRGpTUkFLSFdzaVlONnFjUElpVGFQV0oxUUtyb2lRR1A3?=
 =?utf-8?B?SkM0Q28vQjdBcEZ3d1E0VUNaUmdsR29TYmUzMEMvVlZzQStwT08xMWppWEt1?=
 =?utf-8?B?NTNNNUVmS3NXNE54U2lSSnBTNkY1YWtuNmRnR3plUlRodENENkpFVitiZTlv?=
 =?utf-8?B?bkg2d0lKS0JyaGE3d3FrZm5aWVBoay85VHV2Q2hhNFFTWmV2THNpcnVkcmhr?=
 =?utf-8?B?cERjZ011anYxb1QxdGJkSDVNY1JYMmdtSXBGMzl0UUhsbUxmWWx2blhkTmlM?=
 =?utf-8?B?MzVIUnluKzhvNFd2SmR5cnNBL2RyclQyTElRNWhwL29YYnh2endLYm9VUHhR?=
 =?utf-8?B?cElVdDdwM2h4N0xqbll6Z1dsT3Buc2doM3ZhRit6Nm9xSzI2alg4UkZkcmtP?=
 =?utf-8?B?NzRyT2dkNWZ1OTBRcnJEcUV2bk52ZVhycGMwbjdaYUJ1Y0QwSlpGZG82bDFj?=
 =?utf-8?B?N2V6NGUzRld0M2xEUmYrUkQyclB4clhjS1I0OUh1TEtmYkhIU3hBeDUxZlQw?=
 =?utf-8?B?UXVQWHFVZ2pZclRSd1M5ekY5dmtKMU4vK1hiSVhHaU54MlN4ekFwYVFibGNL?=
 =?utf-8?B?emU2Tnh0V2t2SXlQVlJvaUxXbTZDWCtqUnV6OHVqMVlFdUdlLy94T09mK3Jj?=
 =?utf-8?B?bWNHTXo2bkJxcTBsSld3QjA5MDcxdjVYWUpET0xVemtsR3hteHErS0FmVHRK?=
 =?utf-8?B?WXdZS3AxNVRCeDMxYXora2RqUmxpUS95NWhqbHpITDlUQW5US1hWc1ZYM3hN?=
 =?utf-8?B?R0JtOXpabjViOWRqdlhCaEZ0b0hMbzNWZityaVFZMncyWnhLZ0hyYURRWmxn?=
 =?utf-8?B?RkkvNXJ3Rm1Ubi9XdTBDZmtPcnZtK0N6NWhQWVV3ejFQQkVyR1BDK0JuMUFs?=
 =?utf-8?Q?uO+o0H3QUAPKd57BUMFV5ss=3D?=
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
	7GKScr6bad3qbE3IpHm1H8TlhwcRFiosqDpAWPWDIp9pbV7LrA2SjxBln/LGoWjoAXbDAYaUa9de/RosMlqg9L5OVqWiid6YaJaodGDL6oP7xyVuFtl7L4twlTZIOlqDMsGSeKexu9bRBQKr1R/mO7EIZSZWacwjWtB+ohAsH/9e7Q2UXTgqFIxnnddY5A63GzsslgmPm+St2pJR7AuFcxd1iz5b8jEzIrLyjXPUIss4/nP7ECBBZfJVpBHQHsd9hSxaufHThAW0OskrJtwL9gOqTsjxjE0+9OSZEO5OE1Nb0jchOd5/ta5jRVjXtFq8svsyt2Dyg0gfLiy3k3EpNHQUxGaYoeHDj6QTfl6KSEXz7qJUzlXBqJR9AiImrplsK30rGRSuT1HK5OepiT9clO93meaaVqiCfIlqefKkjhwYsngFqDH4HMFAdoZ0PY7FNjZW/xwSN2SWGVERR8hQ2xoGC+33njh3bjUyY9z5hyapFzrSw8b9i0q/aZtIfH2gsXQVFt+Fx7HEO6znJgS9Kyt7zpIo2K3IxEOExREkLr/nFAcvtKtjEmQriKm0SSn9D0S9bbMj8EEyFb5Bxlk5zhJQWKnkHzYFQ8q1g8DA6PljkLBw33EQHhjlR+UBAk51
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4b9bba-a2bd-4f80-e84e-08dd9e6fb453
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 05:14:35.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtnUzYrqt2qHlJLEDyaCQaetqhxD81GP0J9B8zx8xSVg2+itjcWhgTfxw843qDCYIXbzjuuWW2HAQDav6ZcrHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8270
X-Proofpoint-GUID: 8BhTJM6RVLr8N8KcY26xObz4hjVy9hA6
X-Authority-Analysis: v=2.4 cv=GJAIEvNK c=1 sm=1 tr=0 ts=6837ed42 cx=c_pps a=NoeV5uI3RRAbvH9fnRMG+A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=pGLkceISAAAA:8 a=z6gsHLkEAAAA:8 a=Uwu7rENS8DzqZOhrhyIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8BhTJM6RVLr8N8KcY26xObz4hjVy9hA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA1MCBTYWx0ZWRfX4Mc5hzF78GpI 9XN7JFzoHHz/0qUO+ZeNr620yVD4zYfdns/lz3ZbIWc1lUeLVuvTNSKpsStL+9SaTV+N+frw802 pgZ3cwqKmio/Ac69lJZjnpPR38a3gKXrfup4o+TyZrk2hhLWXftSWNnqiFA340pKQOcS8axV5Fd
 8R13Sn+Pxzk4ugXV77ULwHkJmC+DLFxLk5JuXA16Yt2zwPCjDVelUjeaqb+X/QoB8axwisCDyuR AhMoFEuHcFItRLcu4ona36BtbQSDJ0NOWnAFvhMBqnGa6NUZ3nBxbsaczqZTD1Q3ujeLCuq8+5K D5tA3xaM2867K43fLl+GAVuJ15FwEYeImOutQ//SNODSJdCP9feTaYn+h59WK4i8ZuVcpM4eVyZ
 VyHq8/zXZrTACsvK1wYR80Aeu4z718Fp+3CcUx3+fDnlEChsh8G4OLzdGJSVtS7o5Or7TD/J
X-Sony-Outbound-GUID: 8BhTJM6RVLr8N8KcY26xObz4hjVy9hA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_02,2025-05-27_01,2025-03-28_01

T24gV2VkLCBNYXkgMjgsIDIwMjUgYXQgMDY6NDfigK9QTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPiB3cm90ZToKPiBPbiBXZWQsIE1heSAyOCwgMjAyNSBhdCAxMToxNeKAr0FN
IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4gd3JvdGU6Cj4gPgo+ID4gQmVmb3Jl
IHRlc3RpbmcgZm9yIHNodXRkb3duLCBjaGVjayB3aGV0aGVyIHRoZSBmaWxlIHN5c3RlbQo+ID4g
c3VwcG9ydHMgaXQgd2l0aCBfcmVxdWlyZV9zY3JhdGNoX3NodXRkb3duLgo+IAo+IFdoZXJlIGV4
YWN0bHkgaXMgdGhpcyB0ZXN0IHBlcmZvcm1pbmcgc2h1dGRvd24/CgpUaGUgZm9sbG93aW5nIGxp
bmUgcGVyZm9ybXMgdGhlIHNodXRkb3duLgoKIGVjaG8gMSA+IC9zeXMvYmxvY2svJChfc2hvcnRf
ZGV2ICRTQ1NJX0RFQlVHX0RFVikvZGV2aWNlL2RlbGV0ZQo=
