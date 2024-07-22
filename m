Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C368BEA
	for <fstests@vger.kernel.org>; Mon, 22 Jul 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658333; cv=fail; b=e8ZMNoINd36xMfYtqP4AqnG4zAddFm9TrOv0ijh0IjqwfkBHFNy5aSdT/OdLUQ6d4DuGNIBrn9RnJu6C4jYTYkaDdlFjjbiZoEz64BfcHjZdefwuhn6P8Ma+TiT307kPDL7mkEjvHD/877CcB2pGyTfLpTfaBaJOaUL3K0pihGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658333; c=relaxed/simple;
	bh=7A6i8/ZSmJlTEZHaJpudOq9zgvg3oQAJmyac/MiEl+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFQTYhNHmoUAkX7gl6EO+Ag1uetr1rcZ9P2jSyN06G3RQz1+OuOZVpX8PqzOdm5OeGvdwJzVaJ7spT8idDn1S1dMeKBI82yp2SzMzLQBExqG5+Nh/puRNXXZfbF2CidWcAsBdbGRetwkT4GXw2g8LtwUFp+JVqCyLXvU3PFNIOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gWdyKjnH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vE2HwQKf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gWdyKjnH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vE2HwQKf"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC8hZB015789;
	Mon, 22 Jul 2024 14:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=7A6i8/ZSmJlTEZHaJpudOq9zgvg3oQAJmyac/MiEl
	+Y=; b=gWdyKjnHe2h4TiCIR2owG5j6OZzwIs8XcPiz7pYKIYAg0gdhPmyfxgIZT
	W9vTXrOUEyxANY4063qsEiraVSI/aGhmMmXZHIn57KwiZ1nLOX6a6+JLnb1a8N9+
	c0xkJqLm2U0BkQJ/BnBjHCB7PFuuMQRgF0fBHY0JyJssieSbxhVPkdCB7SCr7KM5
	vHA8dRaEmwCyj+fyQ1PBVk0NRckK029XljgTXAPX1B8s4pn1bhDIhdmiHtx+769N
	8vzOfAgXmNkrx9fo0uYrjfnl97hh/d2DH0QCI1L9EsSygo5ueo2aQopMf4VksOP5
	uBDyWaFWzAS7amd3WNxleDiC0KBAw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkqsvsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 14:25:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MEJFBN034367;
	Mon, 22 Jul 2024 14:25:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27k2v2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 14:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjCdUSJIrroel0aIAOFYWLW+epjdkaO9dZHA+bbKniiRmT5n3unrQPR2fPytkS2uk1e7WU4RvMtXf/I/jirJCgl7FrwmLYepkg7V8eHTMcvC+Fa8HKusT2KbtvypkBN05WCw4xlRqm4IPPTiFZrj7DVebkgkGVAM6btrV98rX42qGfKEYWZeujI5NXyL6L7unybAGrxieG+i39UmE5uyh677t895iwBWT6WnA6Ep6rhTapuUhBDnmW4vASDant5QNnY656xOdAtw255hkmvlItzzxHIomH5AnyTjh9VBj0x06f6yQOdDO41y78q2jPYbq+yAR9grhjUvtyZucRYYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A6i8/ZSmJlTEZHaJpudOq9zgvg3oQAJmyac/MiEl+Y=;
 b=TV6fyKQ6JdpSwse5VrrWBD3PIcrG447KJOpZT22YPTp85s6m5XhRadmwC7MNISxUh7/XCiuvjZSJlDQhDXwW3bj6iFI98yB47Bsr+RAOcSRJbWKvW+4J6UTiVxZx+wKblGam9X0cCWbjmbcJj7wcRWsphZ6zN3Ancv32KSa3vVo/+3azRxNgeM2zAAOLzzvnb3ds0FuT0rJ32EvKe0K73RCdu5efOgpyMIHwKxs5Z51KwzCIbtlRXzACI6PO/a2AI087+Ixxw3LsYP8HypAhO5Ov+Ua0IoRyZA9zDQAglXbnYb2/46IMNzgF4tQVy7opgNlEcIpJ4ocKkGGrwWHAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A6i8/ZSmJlTEZHaJpudOq9zgvg3oQAJmyac/MiEl+Y=;
 b=vE2HwQKfbutkUqiFMMlrRE80S3bSje/AP4SygZ7Xn5c22HV9nR8ErvasDGGZOKJg0XhI5s5zB/rMVWm6AxBOIKAxb45vlwWE4MhL29dc8XqxFEekH+RDt92YhzvxGx301bP6w1nUrHhI+QdiO/MLBLPzbpJuJBPi6dWx1KxnZ4c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Mon, 22 Jul
 2024 14:25:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 14:25:03 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Yang Erkun <yangerkun@huawei.com>
CC: Christoph Hellwig <hch@infradead.org>,
        "zlang@kernel.org"
	<zlang@kernel.org>,
        "fdmanana@suse.com" <fdmanana@suse.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        linux-mm
	<linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton
	<akpm@linux-foundation.org>
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
Thread-Topic: [PATCH] generic/736: don't run it on tmpfs
Thread-Index: AQHa2oA7EytQH4xmnE+FwylJW5vDVLICz8yAgAABB4A=
Date: Mon, 22 Jul 2024 14:25:03 +0000
Message-ID: <37A714EA-B3BB-4F74-96D8-9BEE3E911115@oracle.com>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <Zp5q16N3m6qGilMu@infradead.org>
In-Reply-To: <Zp5q16N3m6qGilMu@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB5962:EE_
x-ms-office365-filtering-correlation-id: f58a59b6-35d1-49ac-7150-08dcaa5a138f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2lYSkltNU9Sem9GQU5qL2QyTkpEL01QaUU4amxKMko1U3U4a29LNDgvalNR?=
 =?utf-8?B?Yk0vY2FvdjZxdmE4dHBadFFNNHZvcFJWSE54MThDdmxTMXdVbnhoYUdIOGhv?=
 =?utf-8?B?R1hkVDhIdzRQakRPOW13UGpjOHJjbCtCelh5Ung3YkRhWUVPd2JHQUpuc3hQ?=
 =?utf-8?B?Mm5zTUwxM1ZyT1RNMkloV0Vhd29YOHRKSERrYmNzZTRSZ3hmcU5pc1A2RFpx?=
 =?utf-8?B?dTBpODR0STZTcHNEM2FUaW8yOVBTSHlTK2NyUGNSV2pJcm5Id3JPM0UzSTJq?=
 =?utf-8?B?N2xzTXdGdnQzUjNDbVo3SGpXTmR1LzZyOWdzUmNldUE2TURqT0ZJTEpuRmdV?=
 =?utf-8?B?RzVKVmRrUFkrTTZENzBjeHFmT0tLWXFlQitwUnltT1ZMUDFKRVZKdWV0TFN5?=
 =?utf-8?B?d1FOT3NENVJUcXdwd2VEditjQ2NuaU1vWlRCY0p1d2lFTzR3VnZ0bDB5RENw?=
 =?utf-8?B?Z2xDY2lPQy96eHg4TWt0c09DdTNqRitkVUhCWVA2VVRRWncweFZRRDZwNTFE?=
 =?utf-8?B?ZThtNm9JY2d3QmtKVGxNeXdaK0VrZzlrTHh2Rm5nWjR6YTBHL1FPSDFIbEMy?=
 =?utf-8?B?dDdqYVc0U2dHZlVyelFDMHpITDc5VTltN2hzL1loaGUrSGNwejA2K3hUMlVl?=
 =?utf-8?B?TjNPcVdqbklpUk56TEdiTytBQ3g5b0hxSmExMTZEMW5ER0FFT3JDSUhxTE8x?=
 =?utf-8?B?M05WeHVHWFFlWCtaNE1ZNU1HYkVUOW1VVzhWUFA3d3lyWHhOSW1qSlFhRGIr?=
 =?utf-8?B?dVN0OG9IM1NMeTExdVgwV3RjRE5oZlduL3ZnUThrMGpBMnZNamU1bHpKS1h1?=
 =?utf-8?B?UHBDeGl4MkFTRWMvY1l6MDRqMUg4Z05NS29rQVNqejdIRm9tejBaQ2lJVkVk?=
 =?utf-8?B?MnRlOXJzTDRab2xSTmZSWmhUZ3pMenpxOWJFRjNNR2ZLcTVjRnMzd3dpOXV3?=
 =?utf-8?B?MlBzU3UwQlN1dm9odFF6UlQ2UDVjUnZpMXVOYUV3NlhDa09zT3JhQ01QeFlv?=
 =?utf-8?B?TlJycEE4MG00SW9mS2Zza2JKa2RXNVF3K2l3RDEwQ1dVb3B1TityQ3Vkb1Nw?=
 =?utf-8?B?cERNOXkwUGxQZ0JMemRRK0dEU2cvd2RRUXBycFNGRDNIc3dEcVIvc05aOWNV?=
 =?utf-8?B?bWo4R3FGS2YwSXZNaE96VDRZL2x2LzV4bkIzUUhRMkZzRTJUMmdBN05ZQzI5?=
 =?utf-8?B?d0d2M0U4NFBsOFpST05jOTFLeWliTm9tSTV0ZGJwdTdMWmczenR3cVZtWW9O?=
 =?utf-8?B?ZUVIMWRLWnExSmgwaWc3bTFXSmdWVEdFdDNXdjVNWDE2emdEWkZLb1d3Nk1I?=
 =?utf-8?B?VVhqM0wzK29Ud2ZMWHdJNUlkTkNDVmN6cDY4ZjZBamFvM2g5bDJCSUJuQklt?=
 =?utf-8?B?STI4c2VuaWJjc3NBaFYrakNYMmROakVGS2ZCR0YyMDRKblRpWS9pd0ROeXV3?=
 =?utf-8?B?d3VVczA0VVptd1lkSkhtaGtxbHhMaGRpeE8vRER4UXJtL2kxVFRkWE9nYWIz?=
 =?utf-8?B?UUxucXNWZUJGNmVYbTRMNDJGNVhZbUhwOGZXa080WndoMDl1SXgvaUJ1Y29J?=
 =?utf-8?B?R3ZmNnJqaEpMckZ1bzdhVytEbmoyaXVsUUIwQlBuczVxclhkN2orZ1hEOEh0?=
 =?utf-8?B?dDdwTFVaMXZoQkk3QUlJSmJTTDk0Q0x0aVlMcUxqL2VCRi9TTU83bHFJUFZ6?=
 =?utf-8?B?L1BkajRSVm5KNURuRkFlU1hzKytBczlwOFJGMy84UW01cGZPWk1YVjhQYWZD?=
 =?utf-8?B?a3FyVTBwdEtaR1BSYVBLRmhGbm9SV1dKczBlTmQ4ODBzS2QwVHBGUkx2ZitS?=
 =?utf-8?B?NU5ncjBId2p1U1o5ZWhBNmFNenRERFFkeGZlTTdOelE4ZzY0NDZ6TXpORFBo?=
 =?utf-8?B?dTN5RFdHM2lKc1Z4eCtpZzdCbFZZZS8rZXYxMVRMQzJnNmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWIyNW1zT1psTDhOc29ieUdqZlFCd0QvYmNQcWxlcnpQWWFjdng3YURRWjdB?=
 =?utf-8?B?cmI4MXJKNnQ3Q3ZCaThUSTN3aThJek5xRDhleU1weDBkQ25HcXVWUzRyR0FH?=
 =?utf-8?B?REJ4K01nU2Y3SzVpRUdBaHA3akVWUEJIUWQyOW4vOVF6UEhPM0E1WVNjRWZ6?=
 =?utf-8?B?WnJSZFB3QzVlTTJhU2lEVDZOVVZIMkRTVVdFZFFSMExxdEo5NmtMQ09wT3oy?=
 =?utf-8?B?RDhvaVdMMDBEVllST01RK2EvajlWMGlxeTBsNFUzNms3MFZhdWc3SnQwbVJF?=
 =?utf-8?B?Y0tKUFJHRmxwcVFIQTdJZm8vZGtFb3JmS3l0eTV0Qm96aFFWQXFPSzV3anJz?=
 =?utf-8?B?QmJYay85SW9ndTFMSnBxNTBKaHAxekJBWFV6c0lvd3BUVnkzZ2RyY0dYUHlO?=
 =?utf-8?B?T3RsQi9HK0RmVmRHNU0wSW9kQVdOWHpnMTEzWjdTeTVpSUJYTTlLTWduVi9h?=
 =?utf-8?B?K1lMZDAyMHlQeFlrZGl0dE9ocVAwbDlSaFBCb2lmVjB4Zi9KSVBQaUE0dmxv?=
 =?utf-8?B?UEVTK1d3SnExcStTajlZQmFRdDFjbXZuN3BQcXlWRjMvcGsvTG8yNlV6Sy9Z?=
 =?utf-8?B?UHczYVZISUQyVW5HOEswSEMvdzZDdVB2T29HVzJMSVNlaDJtNUdVZmRsTU1z?=
 =?utf-8?B?cGdULzFYblBzWFlUN3haUnM5UkVONjRiSkVYT3c4ZStqZVJXOGZKeGw0bGYv?=
 =?utf-8?B?ZE1pY1ZzOGJOSU9LUlF5Yk8vcWNXNlZYTFhaSU00N1pSL0tNbjNrY0pjenhZ?=
 =?utf-8?B?Nm40OWFQa1NqTzhGb3NJc201T215RWkxR0Nham9heW4yNWNkSlZQVkxQVmlu?=
 =?utf-8?B?VkxTaUliVXBQVVYrZWE3UXBGQWNCRnBnblNSRVM0bnMweW14b0l3MHBPamg4?=
 =?utf-8?B?V1pBUGVPYWp1Ulc4V2RFRGlFeTFKc0wvN0xab2trbERkVFV0U0RXUkhjWFRX?=
 =?utf-8?B?dmlsUzUvQlRUaFpucTl0dGpNZ2FJSU1hUmVUVzV5a2c3bWZLV090Y3FQOHZI?=
 =?utf-8?B?ZHgvWjBKeTBBclBRNVZyNUhyZUVkbFY3M2FDN0hlSnZoUDFWY2VxWFNTbGU4?=
 =?utf-8?B?UkpIMzRHbGVkeUtFRFFNREgvT0p2TS8rM1Q3cTNzQU9PNHRJcmtvNGpMaXVw?=
 =?utf-8?B?a1QydllqRTRCdmp6UFFrcGRCQkdWNi9uR2hlaFJVRExUV3Y5MUZOWXFnSzlz?=
 =?utf-8?B?SjIxamxLbGNTWXNNNU1NK3gyL25NdWZTNzFBQ0lrNEwzdEJzV2tkdmxaNHZK?=
 =?utf-8?B?aEdFZ2ViOGRITzE2TG9ZQzE4ZFNFelpUUW9SbC92K0tCc1I1akZXRUJ4Q1dQ?=
 =?utf-8?B?YlBWWFZQRUVnZFlIUUhSYmpLOW1zSVhoUmZuZUhORkxNR0xlVU1MZzBxYVFr?=
 =?utf-8?B?ZHFOK0lhOTdUQ2g5ekgwQW9sbjRvMVNaUkNNVWVHcEdIQWhXd3NGdE9xZ1g4?=
 =?utf-8?B?TXcyOEliMnp4TjFreXJ0bExoWTM1V0pMOEVsTUxNK1g0MmlROGRLQVRYT3lH?=
 =?utf-8?B?eEk4Nm1oTjd5R3NvMXRLSUtIeFBMTE9pTUowODNadGZsbWlGdytrNkpIN2lO?=
 =?utf-8?B?SDRRMlhLZ3o3R3ZJRzJERStsYnloQVhmdW5ZMGdtbU8vN0IraVFGbFhoR09V?=
 =?utf-8?B?WENTUW8yNCsxcUtSQkdIRzNzclVpOENYVW5NVGE1eUtLNy9qZ1dsaDR5MWRR?=
 =?utf-8?B?UnhJTnBqR2llOVNQSUcwMGtvZnArTlg0dHhWMXlEZWkvZENvNGJ0YklNMFNo?=
 =?utf-8?B?YzdVZS9OQkt6RGE1N0loa1lTVEJUenNna2pWU1lRYzhES1A2VFRSZEsvNVNE?=
 =?utf-8?B?K2dYYjB2MTdtcVRES0s5VFZ4bjZ4Q251RkV6aUN6OWtEcEp0NGUrRFFmVEMr?=
 =?utf-8?B?MTYxQzNsb1RHWTl1SHQvR2dLcXVNbko0STJocFU3MW1qbEVVRnBqVzRwSDll?=
 =?utf-8?B?bkdBTzM3bTNZTUJkeDI4ZVMxWC9CelJJbm9Jd1hTdzBKZmJXQUVkZllGVTlJ?=
 =?utf-8?B?dWhQd29kc21iUytkK3hYRnVIdVF4UFEzYW5ncTlDejVScmFSbXV6V3g5U1pN?=
 =?utf-8?B?c1dnTVdZZHpaVmF5WlE0NFFiaHVjSkorSkh3dHYxd291TXVZZmZjOEdZclJo?=
 =?utf-8?B?dGUwejBLbjNlVnRYTUgwQkROMmRDYWNRZkt1OENsK1F2dFJzTTFBMnNwVFNW?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C20CC4AFAA50004EB54A1046770CB505@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	04F72J/OCMUPQasgnUDI05cDMJCTNCpD/o5xIskCgUOUj2OkfcXgZ2ovlfAv8VowTZSHUwH2ZTYzdI1vVW7yzVmUbJ6AOpDheT7K+ek+1XiMsPMphRF8OxbUIo4JuMuJWXR4nNaGwMTW15IThagYT8mmT7ASbLwhiynKJ0PW10zSJECkMxnXSYDsTvkxAZHQZ8HPHUBNiNgYtnios/lJtlco64rC6iayjxwTzsz2pxzDOVh9NE6hObraw3ff5q3LSt2WK/Vt6XEOfZQa3JN4HWYDDw6GCHm7mKWVoroTpZC7IFLLthg4ZnW7fkeay2L8sHY59QLEaEdiN82qgNuKDlxYkvVfDIC07w0Cv3BrdEeKbnb/71AHdsHcLg/f6fmB9X4jsfM5uJmvrcO6K5aRC2F1Rh29B4zcsJMEdUHp+oaI7FkDj/I4cJe3Bd8ofXqNpZSfn4aReqIx7z4AuaD+lf/6Ta2To3zhKKflFNxuj8dQhE4bim2ge0Q2dSqg3ydDSNyi8ZdVHSWMvNRK1IdhJdhiL61a0PSAeYF528T6j/NGDRQz5Xtfc4IMo6z4tq/pYnT2bXZBVDdCNmCXcDdkd0XkXB/XsbdUedVqhnoAIsA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58a59b6-35d1-49ac-7150-08dcaa5a138f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 14:25:03.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyVg6RKvpMD5SMP6CwM+qaaMeld998SjmcllIRU5hMCNjlWQxl0+b/vXfXbO55DeTxVWRYCTZ2cwNH0U4ydO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=787 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220108
X-Proofpoint-ORIG-GUID: _mIFaS1yMmTpoVYZEXFdVZokF_cQffW6
X-Proofpoint-GUID: _mIFaS1yMmTpoVYZEXFdVZokF_cQffW6

DQoNCj4gT24gSnVsIDIyLCAyMDI0LCBhdCAxMDoyMeKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gU2F0LCBKdWwgMjAsIDIwMjQgYXQg
MDQ6MzU6MzhQTSArMDgwMCwgWWFuZyBFcmt1biB3cm90ZToNCj4+IFdlIHVzZSBvZmZzZXRfcmVh
ZGRpciBmb3IgdG1wZnMsIGFuZCBldmVyeSB3ZSBjYWxsIHJlbmFtZSwgdGhlIG9mZnNldA0KPj4g
Zm9yIHRoZSBwYXJlbnQgZGlyIHdpbGwgaW5jcmVhc2UgYnkgMS4gU28gZm9yIHRtcGZzIHdlIHdp
bGwgYWx3YXlzDQo+PiBmYWlsIHNpbmNlIHRoZSBpbmZpbml0ZSByZWFkZGlyLg0KPiANCj4gVGhp
cyBob25lc3RseSBzb3VuZHMgbGlrZSBhIGJ1ZyBpbiB0bXBmcywgc28gbWF5YmUgd2Ugc2hvdWxk
IGRpc2N1c3MNCj4gdGhlIGJlaGF2aW9yIGZpcnN0Pw0KDQpBZ3JlZWQsIHNvdW5kcyBsaWtlIHRo
ZXJlIHNob3VsZCBiZSBzb21lIHJvb3QgY2F1c2UgYW5hbHlzaXMNCmJlZm9yZSB0aGUgdGVzdHMg
YXJlIGFsdGVyZWQuDQoNCklzIHRoaXMgcHJvYmxlbSBhZGRyZXNzZWQgaW4gcmVjZW50IGtlcm5l
bHM/DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==
