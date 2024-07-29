Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CF15531B
	for <fstests@vger.kernel.org>; Mon, 29 Jul 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263123; cv=fail; b=hhtsg3CqgHrZzTaE1ZHFLMkAnVUDdLxnYFRv+5OwPFTlV+sGDezyagF3miXyU6T1Tzr/TFgiXpQkCJQfVDZBY5adQMo2LrioGesclVHaGuV1cP3aqhv/I7kcExM6HuP34PJKVLrpz4yRMd6m5+V+N5UsEC0c+RxHAOeiHQMWNuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263123; c=relaxed/simple;
	bh=E4u4B6lL6zln+5w0e8UkKQ9rWRUPZ0l1AupozM5PufU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1h19iAHDHHrMMaYK9iCY6tNGMs2O+Qmo4itE3ze0UaHblvCr85mS315w87ZKwHOMpaon83zNGrC4lN+e9otWUroy7KimMPdZWV6D0DMaJO1+SXimgHcvqV5cJgdVx0i2gTAWsNAxyzCelzfGUL22Hmk402XtK2YnksYjkAJGsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nCclQ+2W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hPBdjzet; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nCclQ+2W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hPBdjzet"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MbCF016439;
	Mon, 29 Jul 2024 14:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=E4u4B6lL6zln+5w0e8UkKQ9rWRUPZ0l1AupozM5Pu
	fU=; b=nCclQ+2WeATiP9OsGxFxoGmn0W7vpnbbHl8kvThPN5a2Oj0j44tLRkuwl
	QsGm0d45g2LwtWZBIck5b3C9v/mqvX5r/oFqLll5alwQ6rluuox6Jum//XH2o0wf
	2gjvfwpqycFXf2Cg5B9NKbXNoK8PIeaLCKDDM1GYXuyMaizZDiXf6wz/zT8jOb0+
	xlyI4ULVKHIsABSMUBzHnYG44SXPs/wR/JmPTXkvIybJoZ80Wdpkjw0Tw6Oricv9
	Qi0EqoeIDPgmzV2CQg+PrNXh2uieBWiBVU6RXposuq3ehyZRFM1e3tzs9rWLOAif
	REJowCHr/UWW+byVr+V/xPitQXOsw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyaq0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:25:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TDEbRJ005796;
	Mon, 29 Jul 2024 14:24:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4bxsw90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAkP2gXj20OeXUQuL8LFupjiZ0OwIzyfnHn8vUBHoEV+4ZLV8yfJoLAt3g/03gQoZvep7zgeXeZAbzQdO8gjPAvKnBbEHJ6kMBKUDO+yFAt8iRw0VbCBGWeOHZpGnIFtBFuvuxmB5Zj2RQcwXTctStuJiWDD1NhAuxl32PZuJlJCjhOv6DSYE9MdULcOJeMGYcjEB5JCc/n/6xjx48qsD9JoVum3hE/ht+afjT+q4puz5utUG+Z6o+G/9y9LEP11y0M8ZntYCxNCUoS89RHyp/54TcJuZYF+bYC7wPPY/iEVrFGX+XgLWMrlb37NoeeGHhMmAQiyfopY6B8kCmTT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4u4B6lL6zln+5w0e8UkKQ9rWRUPZ0l1AupozM5PufU=;
 b=iSb5WBkhsSrSr6FqwLY8NtgSKd7bmCL9MkELQ1tttIUhA4PMoKgg9LCszn9eHwWrtUWQqru7W+Rd3zzzpK5tUrD/qPKMGKZn385DnKGk3qSxI2+Aw6/i8p72i7JSoTKiatGNkmNOZCMlyaBsGgkUh2BHtEuyMWOPvUNBFmdcboSvdL/phHkCoyd1Pp6d2Cn6b8jr8X1O4CaD4Y8jxf4v2MMFWlajecydlm/9JZA3vUYxlkZM03t+Oq0hd/lS9SvAZU5U91amBd/8rsx87BE0Ct0NZVDRZ4R5FgoOt77kN9QopSXdvnH6U5/RjfkjdNNYHcSbqVK10lF4VG+sFRSHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4u4B6lL6zln+5w0e8UkKQ9rWRUPZ0l1AupozM5PufU=;
 b=hPBdjzet55CUzgIR74+UHxMorGF3TYI0ZTK2cDT3V6R/1+M3w6OsnvOuXWtj0O8oGO6a1btLt4PmBojH6o2XzwGzwDfWSinPx+RjISkymMcRRvQLB0nE+yObtNglMxQvQu+eXdkhY258ojiS3nTPdz6exLlDx9v7gk/pO3nef9c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6372.namprd10.prod.outlook.com (2603:10b6:303:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 14:24:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:24:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Yang Erkun <yangerkun@huawei.com>
CC: "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Hugh Dickins
	<hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Subject: Re: [PATCH v2 2/2] generic/732: don't run it on tmpfs
Thread-Topic: [PATCH v2 2/2] generic/732: don't run it on tmpfs
Thread-Index: AQHa4ZRp2uVJTyOYz0+HOEmUaMLQXLINwKUAgAABXACAAADuAA==
Date: Mon, 29 Jul 2024 14:24:48 +0000
Message-ID: <4E63C821-3231-4939-980C-D2F904138518@oracle.com>
References: <20240729084715.1736839-1-yangerkun@huawei.com>
 <20240729084715.1736839-2-yangerkun@huawei.com>
 <ZqekPERYzP93HacM@infradead.org>
 <D332E074-6760-4EC1-B3C6-437C1C52229C@oracle.com>
In-Reply-To: <D332E074-6760-4EC1-B3C6-437C1C52229C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6372:EE_
x-ms-office365-filtering-correlation-id: 5d2068b3-c8db-4d85-353e-08dcafda3386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzZjcEl0RDRYNmhhUnhmWUJSUjZjS1lkdHJ2d1JzZWJkZFo0QmxkblpmMFRR?=
 =?utf-8?B?NFExVVFGNWJkN0hwVjhsMERtOTBqakpMZFpMbmV5Y3VOTWhqcGtwTjVMd200?=
 =?utf-8?B?Mjdzcy9zczR3Z3V2ckVybUg1U25RZmRLRHlNTXhnWkVBZTVPclozVzc2cFUz?=
 =?utf-8?B?cUlkaG5DckhOMW52SnZJUDBGN0hyeWxBOVpxTTQyOHpUU05tajJIRnhNcG1M?=
 =?utf-8?B?VnNIaHlKNHN2SCtmcWhPblVKV0ZHR1pBN1RWRUQxSTBwSXFUUTdDbW4wVnpJ?=
 =?utf-8?B?ZlJWdGFXWTJVSXlSYW40WG5kdUVZNDdEZ2tOVzRxeWJ4WUY1OHB4MVA3UWFi?=
 =?utf-8?B?NFIyYlh4OEkwRTlkdVphNG1nSHNySFRFU0hSL0hpSGxlVnQxYWlaUnRmNGVX?=
 =?utf-8?B?bk00WlJwRFV3V1VPMkFjS2ZqQWVocnFIanR4YjRFd3IxdEZXSVJkNGw5cUR2?=
 =?utf-8?B?SnBPT3NyV1IydWE2d0ZVRDg5dTkxc2VHOThyNFVPOHFqaDdzamZHbHM3Z3BC?=
 =?utf-8?B?dnEzWlRlY0FHUVBRL1FwblRQT1JSRCtvSzZwazB6RGdjb3VZMVJQK0kzSjQz?=
 =?utf-8?B?NUZmRlg5R0lVdkhpeEhDalczVDc0SGFMTkZwRVcwY2VBcWk3cUgwdFBpMjVQ?=
 =?utf-8?B?ZnpEK0tMVGh5YzlzR1NyM3F5WHJhd09MK3M3TjlweEE5Zi9RenJ3eUNCMTJY?=
 =?utf-8?B?YjNHMTlpTVdMRTk1WHJwbTlwb09KaWN4cGJlNFNRKzJORU43ckxycTdRNlRu?=
 =?utf-8?B?OS9NWEpnOU10T1NBd1cvaFYxalhsMXRhMjNNSHIwTmNZNWErR2pwdjNhK1ZB?=
 =?utf-8?B?dzNkUmc0SXBEdU9PaWVHcEdnS2x0eDcyNVR1VE1IcTQrR3EzUnd0dENadnNO?=
 =?utf-8?B?clFGNmNFSHlZdzhYekZjM243SjZZNXlWdy9BaDROUnlxRmYyYy84L2RTRWVF?=
 =?utf-8?B?d0IxZ0cyQXE3V242UHZNOEI3MVNYOVMzc1VtRElTRDVSZUd5MTRxdW9EUFNW?=
 =?utf-8?B?ejlQZG9HWTkyZExuaHp3R1ZuMVg3bm1jTVZhQ3MvRWR0Z3BnbWREMERNOXJW?=
 =?utf-8?B?YnBnUFZBYXpoQk9qaWVCSDM4aTQ4NjAvZjV5M05ucGxaZnNqcWpkKy9zVWUr?=
 =?utf-8?B?RmdVc2d6VndpOGx2dEpSczR6QjRadFVKNEZGazlRT3I0bERReXhCVW85NGlE?=
 =?utf-8?B?ZmJDUHk2cXpYUlJFaHlxTFNuK3Q4bVBGeHJaSjBicGdOL0RPNDBPQy9PYWE0?=
 =?utf-8?B?eERXREM0djFQQ1hQYyt1L3F0Y0hyUWJJdnliS0dPMTVBQVNteEJnbEZDTTRt?=
 =?utf-8?B?S3lzYk1rQUtRa0E2NWl2cm9hY3NGOHhzakJJa215THhZRzBiQ0xJdlE0LzI1?=
 =?utf-8?B?MlNCd1Bpc1pVd2N5TDAxbi9KQjFianNGbHFHMG4vR2x0VENpNnVCYllWUFdN?=
 =?utf-8?B?bDNVL0NiVGo1ZHo4Yk44a3ZxY0hpQmlJeVhvMTU2ZE53WUN5QTVxblNRa0dC?=
 =?utf-8?B?dUdGRnV6UHBQWTFRNmxXSXZTMWtnNU9RQ2dRQVlwWGt5dlhCeXlVc1JkcW5z?=
 =?utf-8?B?M3FaRTUyQmt6amVqb1JSc2FFSElvSHhhRDRzaW5YOTJ5bHJiT2FBMVRqdCta?=
 =?utf-8?B?dXBiTW1mREtLRExXdXdVcTZHaloyYXJocitjN2RZRmZEaWtyTXhtMWlxUFhC?=
 =?utf-8?B?VzNYV0dSdk5sRXRHMDY2K09UVHdFem8xY1NibkhyNEJmaktEbWwvOXJ3MWUx?=
 =?utf-8?B?TjRTRFJBZlVjQUY1ZzZpTmlxbGt0RytqUlVJYUpWWHo3ZGhCaW1TN3hJZnZn?=
 =?utf-8?B?YWRLbGFTdzN6TWIrd0IwSksxVlB3NDlZd0x4L0NmYVlQZTFLUHhYSXRpMGdX?=
 =?utf-8?B?UGZLUUZYcExxVDBmZm5RdFRVcTl3citYaU1HL3lzOWJiTUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXdid2Z6c2U5MHRUN1R0ZmF5bDNEd01LZGxBSEducVRWN2xBS3hBNDlIZUZr?=
 =?utf-8?B?bHdOMHNwQTZEbTB4STY1L25yZHZQWGlhbTlpQmJxVzQ5SDhzOHJDMFhNZmd0?=
 =?utf-8?B?a2o1OURudGxMcDFtVnJVYlBMZ0dlY2hHTlVQN1ZLRU93dllqazRuNUxobmcy?=
 =?utf-8?B?UmZiQURXeVRlWEdsQkNVcG56bTg3UE9TY3Y4b2RvdUVnTlZvYis5UCtwVDR0?=
 =?utf-8?B?bk1jZGM2ai9tYlRRNUdtN05FeWxuZ1JTampvNHFTcFRON1IwNFFtOE9KUkVO?=
 =?utf-8?B?TVhGalB3L0VWaDZPRUd2VkpKR3J1UlRXRlUyQmhIZnNWbnlWMVgraWgxb1Rx?=
 =?utf-8?B?bStjUGRGQ013OCt1TUdrVTFBNjBSdGFZMDdUdlc1NTN0Um1nbWkyMFc4ZUJl?=
 =?utf-8?B?UnA5MHMwOCtIVmJFSFgzaE4velZpVGdDKzg4MmZxQmZXK3cwUE1FdkozRDZq?=
 =?utf-8?B?ejVNZGxyRnFtbnpwUHUrUkVpV0E1ZFVVaVI4MCtXYmtQb2N1VlZmaUd5aXd5?=
 =?utf-8?B?QVFPWDZOVkxGd0MzbGtnS1hSdkJkY2t0aWlSUllkV2lxSzU1YW05SEFJUDJk?=
 =?utf-8?B?VFNBZTVadml1dlR4aTRJZ1FXMVF2SjAvcGpZa1E0bWpyQ2xNeGhQUGJvWk5D?=
 =?utf-8?B?WG5Mcnd0QWJLVGNZWi82bjhpOXcyT29QRFJyRWxpTVB3RTRQTUd6dk9uMXBM?=
 =?utf-8?B?dHpIdEdxTk5GZGhnV1VVMi8vdldtMUxrOHRYbXBEbisvNGxXV0pqUDV5V2wy?=
 =?utf-8?B?bjhsdTQwTFhyRlYweERodGhZYy9PV2RpVVY2eFovQVZaNjhTNHlUQ1A1bVZG?=
 =?utf-8?B?Z0dOd0wvLzNjVWRyKzFybGRmVGVsM2p0ZjFFVmxjUlM0UVU4YzhrTEVLUTVV?=
 =?utf-8?B?Y3NIZ1RsTFArOTAxTlIycDcwQk5heERlRVAwbGdSWkZhQUd0STIwb0JNUDZF?=
 =?utf-8?B?eEUxSHhoNnhGNlpZekphQWhTREJvQkkvQ0tTbG11b1dXb0hUeG5HN0UrOHcz?=
 =?utf-8?B?ZHZiR3RqQ2czWHF2U3JmMlI0MkdPbHZiMml3R2drSC96WGVmSDVoWTUzWWpC?=
 =?utf-8?B?VnArY1pWeTlFbjFYL056MVdtK3lGQjJMeEhwdklDMWptNkhFdWlOdXV5S3Bv?=
 =?utf-8?B?RS9aNDlROFVrMk5FK3pEcUVVbGtuTXl5NURBazZrM29EeWp0K1o3Q01WSlZT?=
 =?utf-8?B?RUhkRmo5dXI0Z1JoM3NvLy9NS1BqdHJwZTZBTmtBc3FWZ0U5RTRIK2wwRS9u?=
 =?utf-8?B?VHltU2VQdnBoa2hvY21rbjRjNEd1Mm5aTGcwV1UxZEl1NjZwc2l3Y1JCdVNP?=
 =?utf-8?B?Y0k5cnp2SHFOY1FrMTN5d200MUJ1V1dCR2RRY2VkdnJPeHpoL2ZpMDQ0UEx0?=
 =?utf-8?B?ekVIanp3ZFVta3lBUzdkTGI4U2tKZkJvZjlzKzNLNTc3UGc2UmpjUDRUUTVy?=
 =?utf-8?B?MjBKUE4vU2N0bU90U25hUnZYcit2UDZCbzJ3d3hxUlVsWkdOKytYdm5jNEtV?=
 =?utf-8?B?SW8wRFhad21vYlI4QkRRbjBhcnpZM2haM3lvK0F5NmVGTTMyRlJPdWpLUjE2?=
 =?utf-8?B?dzhRWG5MY1EyMVloOTZJbWJOZmFJTW5hWE53NnBVOGowNjQ5RTNjTkg0ZnVm?=
 =?utf-8?B?cXd2bTM3T0VDaU9USS9CVC8zalIvcXN1a3ZzcmErNXRjMHE5NXdoWmRHY05h?=
 =?utf-8?B?bGJkVjZUbmpFNlpiLzcwaGJCcnVOMnQ0dGs3KzhZY25jZ0pUR1UwbjY4QzlT?=
 =?utf-8?B?bzhrNnhRRXlScUw0WTh5QXZrbUFmdkRyTnNMR2RFb3gwSzFUTFFoVXRkUVM2?=
 =?utf-8?B?L1Q0U2djNzlGWjRVNGhTdGZocWxrSkFKWTNmTHNPd3RBQWFKTFQ4R3FPWEQ4?=
 =?utf-8?B?TVFPODlKbk42dE9wajNIb01ZQitKRHg0RTFFdCtxeVpFUUxlWGhrWjN4bisr?=
 =?utf-8?B?aktKY1pPRGdsNUVadm1pbisrNVNnZEdHMnF3eWg0R3pVWXhNb3Y2K2Ria0Nz?=
 =?utf-8?B?cjlrTEIxVWVLYmtiZlg3QW9adjlhUG5OZkg2ME14V3d2RGY2cnJGTDV6ZXFo?=
 =?utf-8?B?SWF2d2ZkbjFFVy9xSitpVDNlcW1PVEZFNWVXM1JMSGlmVi9yS0VxNisxb0tV?=
 =?utf-8?B?cE1uaFQzT1pFWk5XYU9pR1UzZkZYMStIdDc4OVQ2M29xRmt3clRNT0RnSnlx?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B6A07D2C273C941821A2696DCAD5A79@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rYE9GkL9H2E/xPsci5WUBmCqkiC3zx+Dbbtez3SmucBtnMDqrQd5nL/0Zuzry5KVxFh1omv8zSqYk4pxR9we8T79FZvzhKlLHJwIL40jkJv3wlEjPvQPnbLSPHtNHXE/eJd8LkNf5s/hlAGhyEcEp91Zdv0sPUl63ZjMSYAw6s9pUZBGpwxoVfWGlIUOqK09x+BBZXuUQxp89k5oVjd/Das/7RGZLPSzrzxEzJ6hqYvrPHPsJq8lIyJ0j6WclK6ePq7jHzdTrFJbeJ3YtwbNjM0LqmwcfKFIlnS6nxeuLtjnkoraXUWInegRFYyon/s8NQD1J4zBlU2wE6uGyg8Z4Nlht2Bcd09oIGp0EN99etTrj5x+ws/IPKWyBmQKjOQmJ1840P9ob9rE/QpGdhhpdKG+7sjRVp7y2Jkitu8kDEA0bcscztDKoHCQdKxwijLAHSvaqJKB8grvbLyOt3C5beFh08KMLnCtHZaXMBf6brYQzU2wObz6WcS2n7Tju17oMvaVe5KZAyTxaHIcyxLr974Tyh8G2nCxsuHHjfKuCQyY/a+nieEH1rJHqGZbkutkoHOcoP/VOTT+LkaPO+fhdlv1sXdj0pO7ypi5bWQWVec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2068b3-c8db-4d85-353e-08dcafda3386
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 14:24:48.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81U047qr3bvpTo7SmuBpV4HAai0kgiX+nxEDp3LAM7vNyyJqmnSrvOiMWTG199U7uUYTMmYRN++RT6sQAG/bTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407290097
X-Proofpoint-GUID: UT9q3SLoMdIWTxFKBQ3-R4Wvpi8yhCU4
X-Proofpoint-ORIG-GUID: UT9q3SLoMdIWTxFKBQ3-R4Wvpi8yhCU4

DQoNCj4gT24gSnVsIDI5LCAyMDI0LCBhdCAxMDoyMeKAr0FNLCBDaHVjayBMZXZlciBJSUkgPGNo
dWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gSnVsIDI5LCAy
MDI0LCBhdCAxMDoxNuKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+
IHdyb3RlOg0KPj4gDQo+PiBMb29rcyBnb29kOg0KPj4gDQo+PiBSZXZpZXdlZC1ieTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+PiANCj4gDQo+IEkgd291bGQgcHJlZmVyIHRoaXMg
dGVzdCBjb250aW51ZSB0byBydW4gb24gdG1wZnMuDQo+IA0KPiB0bXBmcyBpcyBicm9rZW4sIGFu
ZCBuZWVkcyB0byBiZSBmaXhlZC4gSWYgdGhlIGdlbmVyaWMvNzMyDQo+IGZhaWx1cmUgaXMgYW4g
aXNzdWUsIHRoZW4gYWRkIGl0IHRvIHRoZSBleHB1bmdlIGxpc3QgLS0NCj4gaXQgZm91bmQgYSBy
ZWFsIGJ1ZywgdGhhdCwgb25jZSBmaXhlZCwgd2UgZG9uJ3Qgd2FudCB0bw0KPiByZWFwcGVhci4N
Cg0KTmV2ZXIgbWluZC4NCg0KQ2hyaXN0b3BoLCB5b3UgZGVsZXRlZCB0aGUgY29udGV4dCBmb3Ig
dGhpcywgYW5kIHRoZQ0KU3ViamVjdDogd2FzIG9uZSBjaGFyYWN0ZXIgZGlmZmVyZW50IHRoYW4g
dGhlIG9uZSBmb3INCmdlbmVyaWMvNzM2LiBFdmVuIHByb3Blcmx5IGRvc2VkIG9uIGNhZmZlaW5l
IEkgbWlzc2VkDQp0aGF0Lg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
