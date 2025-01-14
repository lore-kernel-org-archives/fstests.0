Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FE224D6
	for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736838604; cv=fail; b=KFiWKCSvHu2CgrgHacLktwODNpeSQ6qm05E2Eon+qcT4IgGTtPSidswX08BRMmTpCYly4Ei8nRK8MuEmXiaYObSJnI7Eiw4i05ywgUsgReZnRf3k5YFiD7Nr9H6LpWgSua6nncBHDbnb8MkszmkyPKOsHHBuik+yejAh3GeeOw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736838604; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7na6uNSluYT7TLCUZ53t6Ltyn4xItIaVwQCI7seIAu/gbMgJiv199njhiDPINjk7eomGzUU8ru3uwN/HrYoTfetBX3mG3mbhmdllQT0TQm/ndeA+7k64pGhTUgIVF34LVBQrka22NF+mBR70nJoDg1R1AlzvR0UH/Xav4jIck8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c8VzwMoA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zXUIrI+3; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c8VzwMoA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zXUIrI+3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736838598; x=1768374598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=c8VzwMoAqckNtayyF/tbayJaQtMs20aCTywnjkDfFWhqlTsUSQYl6Dw8
   wLn+zI0L2ioW2KtkW7ZC1SUfz8hlGVezjZpbRUb6ZqWfdDE4wh/4+yfDn
   SDk3INx6Ci0rQ9rY6i/t81wvkhy0k4DAfUwvrqqBItgo+dPc7Ok36RGli
   8Ii9Orwuu81EVCWx/kzX9pYhYVJ1U86UtI0f1SjAibncE3bsrtyH98N6k
   h4RVYW0PTIJ5LsCuZXED31P1XpkQn7jr95CwfoIy1lpD7W674Mm7IffKD
   FNjgrUdvguTKErPoFtKJ3Of8u77BaKZNwaC0nhjUIsG8dsxBqifQ1Y4ub
   A==;
X-CSE-ConnectionGUID: 728uowuDRiS/Df1t6iZuGg==
X-CSE-MsgGUID: u9rA/No/TUWPmKh/igjh9Q==
X-IronPort-AV: E=Sophos;i="6.12,313,1728921600"; 
   d="scan'208";a="37075660"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2025 15:09:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJdn9FnOyoKpYs72UkT8v2ee8SYvhgMCGwUEPqJQeSDDF4JXPaNjoVpQk2BaR6ySCX/6Duyaj5OSFs/Oh27DqbAfy0/qjnNkeiH/GktSulDU3slISY2T0+p83sdLvHmaH81VITD2OJspV/uGoQuokvAr52Gyy0MQ9DWuxdfZm2PiMNkxk5Z/uvsuisvGQ23IePnQmmdIgNfgjW/AfLNWYJBneGfdwUIeafN3gDY2t9GtmpVzX4xoDYpY/mFnLKL8IWDB2poviVaHx1olHY6J6mfIRLy+Dv352v5BSQhK6Vuq5zsbRVv+5FxqnCFV9HyzZPmSklhD17kGC06QxiEUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fsYkmutbTYUrHR5ftuN30w4xQqunIbf0VrUSdoeuV+8hyZMYN6RC+mFCnqq6SnuwvtcdJipUPM8LWfXI6GwaAqBNPP0UzpWRSJH86Xv9zNygspga9aHn6RW75WwN4K2zfqlJdvFB2AW+RLqKSQ+ytYE0OMfiY/0RWa58jCggX0GL7xQAGapZ0nGVz4xQ1ZInQTifMV3R7BPyv3mS5cPIQP49SE6Egs6RHqeKoWg2yZ901Qyr8iD0azvpDcbg+Ie6kX95yIXKVBE2JAylVSWakBpoUlofaurhcnx4c7XMfhv93KZzcPCg2LgkXrRgBsvbtogTTISfvT/yPj/TCqDW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=zXUIrI+39WS4qSXmfXAwLi7igFDsmROhlF0MUbG6ypJXkT2bzxQ3NJVwoGr9T5uN/4BseaAoEgoPcrsS/IaoGbkt2lk98bDVFDetkn2bG49/ApESmeKkmZ8wBQ0SZ6YgcFPlbRr3OALvmboMpYs9twyF88LAPQbfkwHybN8pk7c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB9414.namprd04.prod.outlook.com (2603:10b6:8:1fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 07:09:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Tue, 14 Jan 2025
 07:09:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fsx: fix compile error for preadv2()
Thread-Topic: [PATCH] fsx: fix compile error for preadv2()
Thread-Index: AQHbZlNNdf0n7JuTjk+VJRWfUZfXBw==
Date: Tue, 14 Jan 2025 07:09:50 +0000
Message-ID: <57f6daa7-2315-4c8f-8d6e-bf450896511f@wdc.com>
References: <20250114034831.1128945-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250114034831.1128945-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB9414:EE_
x-ms-office365-filtering-correlation-id: 5da365fc-13f7-4875-7321-08dd346a7018
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVFINzhCekk4NE1aQXg1RHhLTENkWXI3dXhuckZuSjF6emh1VldxNDYyM0V5?=
 =?utf-8?B?RU45ckVGL0NVTS94TkpkQnRUem1BcmZtam14RUZkS2FFaEU1R1Z6dTFUQU1I?=
 =?utf-8?B?N0JxeXg1bjdyVkFNanIrNHNIWURlaTlFUkZVczcyaXZXOGg4UzlUZ3NaMHJX?=
 =?utf-8?B?cVhLN1BrS0lJcWRZNnRnY2VNVWpLN2YwNGZEN3l5MTJOT1pxSmV6eE5OTVJj?=
 =?utf-8?B?ck9SbTc2UDN1SVU2dk5iVkZYZFBpQ0FYbWVEd25ES09ZSlJXMjZHU1lIU1RL?=
 =?utf-8?B?OVlSemVRR0dXaVlZbXVWUTZxSmR3Q3c0MnNWTkVtT3lueE1rSDV2ck9keUNQ?=
 =?utf-8?B?RktMQ3Z2MW44S3JQSkplbWI0eWw3VzhoTVpEeTI4blVJMTZyT1BLc090ZG9C?=
 =?utf-8?B?a3cxcmZZZUYzeE55N2tvcTgzYktPc0Z3eHZRaS9EamxTYUNwblNXdlBtcnJt?=
 =?utf-8?B?a1A5QytVU0V0M2ZBQ3BQWVQ0QmljRHoyYmRGcHFjcTlKaUJ0SXUyeXZjVDM2?=
 =?utf-8?B?U2UxazFHdlZESlBDcFpKdDBLUEIvcmRKa0U0ZWNRM1E4UUtCK0YrU05xOFZ5?=
 =?utf-8?B?VThuLytlVnNublo0N2ZZaUhQVFFmM2dnb2Q4cEppSkZiNk1pN01kRE5UbUsy?=
 =?utf-8?B?S1Q1aXNKcEdYc1JvQk5TYmhNdzR0SnUyaW1zM0ZFaFRzSW9FdGYraWREemw1?=
 =?utf-8?B?a1cvcWl2Q2xUMEJUVjNpdWx1ZElyVDE4aTNkNFZ4SUkwejNzOHc1SUN5Snph?=
 =?utf-8?B?TjBLNW03T0MzY0YxZk9VUk9wNUh4T0h2S1IzcXczdzFQdVpzR2lUWTgwcmta?=
 =?utf-8?B?K3lZVHFLSW9wK0g4dHp2ZTVNM0JnajFwei9QNXgza2F5ZEhQRDl4S0ZzeDZp?=
 =?utf-8?B?QlpoUWtXY3NUczVvNldzOUc4anVwSDU5QURLMm0zL1pJSDBvclpYR2pWUjdV?=
 =?utf-8?B?S2E3YXpwZ3NNaXZwODRYMUFoSFNQK3Q5aFJZSDhDRzV2S2E4Z2lGTHJkSmVF?=
 =?utf-8?B?RGVXeDFmanVtdnJ3N3czekZ3bGtDd2JSaE1idkZsUEV2UjdBTDhRWk43NGRp?=
 =?utf-8?B?QmVEeGNtZUdiL0lNMW4zdXJCOEI1bXVjZjg4WHdVZ2EyTnZwN21TMnk2cERo?=
 =?utf-8?B?V3NJQUZkRjFKblhRbUg5Rk02N2NhOGFubnptcXg4V1JaQzF1SDJ3Z2hIdDlT?=
 =?utf-8?B?d1pES0Ivb3RCcFpGcWZiZTVGZ1RkSG5waUt2YytScGlUTE1jbnpCT0RtdXVV?=
 =?utf-8?B?eFlVYThWWVBnbjJ4NDg4ZHRFVlpURERjWWh5VStSTk5HbGg2VkZqb281VkR4?=
 =?utf-8?B?RzFCMEdaTzVBYzYrOGFwRUpZREc3dnVYeTBPdkpvdENCd1gybUg4bmJhMlFt?=
 =?utf-8?B?dVlFL1NzY29GaUcwakM5NnZjVzA5NFFKaGNNT1Znc0lMMndBLy9GWDQ5dm9a?=
 =?utf-8?B?MmNkVEtTMDFCNmxISTJDVGtxVnM0Vkw0REF2Z2YwU0JiZ3FDZXk4ZDE1bFZk?=
 =?utf-8?B?Yk5PRjlYM3hORzNqemZrd09WVHBjSEhLMXE5N1pQQmMwK2xONURWWFV1OXJo?=
 =?utf-8?B?cjRtaXlnQkVidkJzamNmY3FCVDRPQ3gzbDZOeTdvQ3U4YVRJSXczZUNTU1lB?=
 =?utf-8?B?THJlRlF5T3I4aU9FelY3WGRQb2FkTEJqcGtmZWt6aExMZWFCTVF3dkJpaE0r?=
 =?utf-8?B?bkZaNldmcVJxbHBFQURaVC9xSEhlVmlpQnd5WDFhKzdvOWtLMDl1WkhXUm1M?=
 =?utf-8?B?Nzc2TTFZV3JOc0xlT0xNei9TYzNTcWNIVUVYQlhMUFJaZGc2KzZkMG5nK01w?=
 =?utf-8?B?RDRqeTF6a3dyVWNRa2d6N2JLZnc1SFFCYWdEV08yeHRwU0F4K0JLUUpWajY2?=
 =?utf-8?B?dmF0TlBEN2Vlc1gyUVY0aGQxNEhPQmtiRDZVM2plcklSQ0txdGhOOGNzS0p3?=
 =?utf-8?Q?Z5XMOS9ITvTIJOTQs5EtXA8e2u/eTB2T?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2lLLzhGbVVkWnI4aGtzVzJwanRxazdlbUZOcUFWSUZ1Q2w4a0xmYnBGTk1R?=
 =?utf-8?B?VHVKRiswQVJYR3lTYmRHbkcxK3NxMnZsNnkxSHAvSkpONWUrRlIvSFkrS0V2?=
 =?utf-8?B?SytZSGJ6UkNrN250KzdQVlIvUzBzc3hKZGNwY2VXaDY5dVV3TkZOV2VXb3FY?=
 =?utf-8?B?MllyQmM5d2pEdFYzRGE0c09YcFZobnJNcWlhSzJIQjdTeGF3aUpJaWZIOUI1?=
 =?utf-8?B?ek5pUllKczhVdVdDT1F1WERGTi9SWEFnTGgrSHpBRG5FSnBoUFF4YU5DcG84?=
 =?utf-8?B?b1lXNWNMVFFOeXJ2b25aRFpYTk5yYURtQjROODhxcnF3WjJuOERBQmpmeDJv?=
 =?utf-8?B?dHMvRXcxa1R0TFo2ZWxvNEs3YjVzbmlOeGtTTEFyZURteHRFa2kwSWhsWjA5?=
 =?utf-8?B?U3BsZW5xeHdWYTRsRFFtRFY4N0NwWWkrczhlUGNlVVJnZHVGNHlxWjY3YnVU?=
 =?utf-8?B?Q2JZNXI3NGM2d3JHaW1UbmVqQ3R4T3RFUGMrSnVUbWZYb2ZORlJGSXZJbzE3?=
 =?utf-8?B?R1l1WGMwU0Z1T2h6ODlUVjN0RXB6VEcvd0Z1RWpyRDRqVkNWWFRXODJCdVdy?=
 =?utf-8?B?YXpDblE5RGNBYk1POVVLbGxRK3FjMkJmak8yS1NnUExUODJoQllDK1BSRi9h?=
 =?utf-8?B?WXR3dkcvcXlHL0NmVmhoRFNYNngzUnhqWkZEWTFySk9PK2FxYlNoT1NRRnJM?=
 =?utf-8?B?b3U1OHlHcUpOYnB6RTZxR2xUSkk3RElhN1llUzk0MU5MWVQ0SVFwYXpCQ3ZU?=
 =?utf-8?B?VUgvc3c0Z3VsN25XQ2EwYTRBbjBKZUhhOElheXkxSWszVC90Y1hHeHZpUnhQ?=
 =?utf-8?B?blJuS0ZnZUw2VDBHZFFIamZ1S0Z3bTNVRnhweVVxR3BsUEo3cnZqbXR4QXNZ?=
 =?utf-8?B?aDJrMTJmTXVkZkV2S2JkY1hvNGxtb2dTSVdFczdUMFZLS2RHcGlPclJSUmxm?=
 =?utf-8?B?ZkR3Um9qWXZjRlZVdWZJV0R0Yi9KUlV1ZmVHQmlGVzdHa0pqbVcxQTlta0Yv?=
 =?utf-8?B?VGhZWGtwK0lBWmc1emRoOVdvbjdDMWVTbkZMdStuS3BHNDZjWnlUek1LWmFH?=
 =?utf-8?B?SGdYbmFVU1g0Q05EMnVaaDI3cDJJUk16NHUwTGg3SnlQME5SWmo4a0psaVQx?=
 =?utf-8?B?dzV6azJ0T3dBZFRWYUNEVmhJb2tZSmdpRkpkS2lOUGhKcTZKR0FXanEvU1dZ?=
 =?utf-8?B?bzNPbWN5SDdUTGR5RXRxcU5ybzBySFRnalFIWDlUZHdjSGdaU1RNR3NuTE9h?=
 =?utf-8?B?dDZzWjduRjQxSm9VK09zOXBUOGE1RGtwWHlCMjJtZzh3dWJFZE5hbWpPNlFr?=
 =?utf-8?B?NTdtTnBvTlR0VXNucDhwd09MdmlsYmpJbWdXdTZselRjaTcwZWZYemhla1dI?=
 =?utf-8?B?NkNFMkllaTBZZFZpS0RiOUxicm5reEIwUjRtczhrQUFPZVNuYVpBbFo1Nm8v?=
 =?utf-8?B?SkhGSHRybXEwcDhsQ3ZmWXNZbzBFWk9kU29TbnU4Kyt6UEkvRUc2TFRzNkto?=
 =?utf-8?B?SkMzWEUrVjdiaVdtS3dPd3pkSk84Q1F6VWl6WTlsQStrb1R3SEJJeUdmbTlu?=
 =?utf-8?B?MEhOT25XWGpyU3hEcmNpQUVLMEFYNFFneUNYR1V4SHZ6bldBMXY4eFBxLzV2?=
 =?utf-8?B?MHR5QnVKdHU4R29YdVBNQWtWNC9IdzBXSWI5RDJ4VDQ0c2sveXBrQXYyYmVu?=
 =?utf-8?B?SkxpbThENlJpWUZ6dW5YSEwydnAyN2p2UEI3UnlLZmhyR2V6Tk5XOTFodjY1?=
 =?utf-8?B?K2l0YityVG5nSXpteGkyNXdZTlFZajZwWFlLbGVQRlFQeVFUaCs5UzZ4SmZj?=
 =?utf-8?B?bS9sOTM1cHJ1WUpxRzZWQjl4Z2NnQXpVSXIxYkdBQnMxR3JwYlFObHF3VThI?=
 =?utf-8?B?aS9vZ1NqTGRJMXoxRFlTSzd0VGg4dE00SGFPM3dRWUVEZnR6TUo5TzA2U29H?=
 =?utf-8?B?YWpud2NvTnNWcHdvblNWUTJpRnlMcHVuY3ZoZXZadFliWFg4NGl5ZHo4R1FR?=
 =?utf-8?B?OXhKbTdTd3BYb0VUeStISnJrSVkrTnpoSXVqZHlOekQwd1FVVnc0RzlVbnQz?=
 =?utf-8?B?M3ZORGlwNUdUbS9nVkovVkJtanorZ2VYcnY0OGZLTUpsU3NBd1gxZExYYzBh?=
 =?utf-8?B?VDJZcGVPYUdzMkEvL01pOERFSjc0Z3JVeWV6RTF1WUhKNUNIaFNMNVprMGFY?=
 =?utf-8?B?RVMxa00zYW1leFVucmRvRGxSaHhtQUdiaWtYVFlOeE9MTjBZUlFpTktHM0dQ?=
 =?utf-8?B?dm10WXBYSkduWitsWC91NC85VUF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F90EE0C72F101449ABEA9374986B8BB0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LoluGjql/O8derAfx3ZavSmnHESbzCcuowdHDC8aymIm7DkQyyLbMs/JDhKoGOeuNXreexFexowRIb+f8SK4Ceb4heYmS/tvoK+8CHcyqZZfF7xZOyFwIOQJI6I1MDoj+4yh/HgrMONkqCx6s0QSrgZS0OpF1Hw9U3A03J3A73ozyU2151UWCMb8ewtGsvIIQy4z60H1gpChoQ0kd0qQSxGI1C1qoxE2N7xY8DKNYq8VB3oxV54AoO77bon/BYSIBLfC2IC8+kMcKnKe4jn5Ob4UvMTPEGYiKG5Uf9KX/YTwSrrgH8ZPot61SQ6xAXbIVY7JQ0a7TEYfMbX7+HtH/u42900bCLQUKHFoIEGzc4WOs6jnzxgav81k2dB0H1W5eupdK81Loz72E/s73pe+cRlcc0tFBxD/v7xUV2R6bEIfifULfFdthzgx1xJof+/NoDsC4UpukIHIR/OaBg5Ie+YoXj6zRaLHWFobtNeuPzYd6RONCGDbs5zJ5pACmZGgxKSJp47ZAd4feDs2a0MnIEjukU6Q4Wg5Bn67a9tARn1jarcP4RtAfPZKm867nKWNqWNQ7zZbg3dHz/+GrI+2I6Im9PTXqGgfAVVz2EhHOtFXRgExJSIxH+seWaET96+l
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da365fc-13f7-4875-7321-08dd346a7018
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 07:09:50.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/2BLOclL1Mifl6B7lUFkQTrsMmIdzuii0i70TREQUhY2r7VLRLD6XipAnO6UkW1qAzAygBUxcpxgtcFJArLV+26aH1YlH4VZ7AjGWXJ+nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9414

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
