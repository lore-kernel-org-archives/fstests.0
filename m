Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A711A2C20
	for <fstests@vger.kernel.org>; Fri, 17 May 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983054; cv=fail; b=iDF3Q20j1/O2QPkwskEHPZKJwecp8dQSZuK3i8PsMHGf7F+Hz2PYqWWNAvJggwtd/Y0ROwjbuSECXidwzUpVPRBLt+6D3/Cv0CL7AUAcYyzEJtvrx1c80ZhSwNrQJHuETwpqIvHJuH6Y8UuqriPfhUGRVnQi3DHuKefyfoDWyZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983054; c=relaxed/simple;
	bh=IuCcM4JF2dK5FAAk3MH91s6Tzdy1VGV6DmrH0OQJHOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iDQ64yVKO512dWTXydX5a1yAbLhClj0KseG5soCsO3UJVzq5umVCR1LxeieUP5nK8kV9rQkSCzOl4QNte/QwLcGZ7ojJRcy+CGNIX+BKxMTrUxcq3fqgIuL+SV22htG28jfdKjJ8BUVbDOYi2Zv5+xwGZHoqEgq0ZCYs52fv6VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bOQRzs0n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MgMqFDd8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bOQRzs0n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MgMqFDd8"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HLauN5028556;
	Fri, 17 May 2024 21:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Hl1EFtyEiBypDjqp8IQogoCNoGkOOmSsUgJ7CLVbbzc=;
 b=bOQRzs0nmKUsDBYdaObicVv+L8H1cAZHpbsQF2BxQeqi8D+NTzySoJNJyP5ZGOPGXQ41
 F70Y3ryyUel6eCG36oCuPQYjaXIncrNrnDBcXRiPVsLD8tvtCUuEpr5Xeu4hqssxomrA
 Zdo7HtVYc8FFEGQlJLZ4F4AwZlLnH2dB+LpazxOyNJyX5ePa7wSF0BGFXJuJMF6CBx9S
 GY15YjjLP5f0hOMqyLvUxVUds6ubgI0C8Ewsaty9OMLti86YjPMkxXroDe84ka6UcH69
 k+46VPqBLYgW31Oarz5TD8DX1Kx5Ic5Se4oihpfMJDhnXWtSSSjGPJmYaOCjCjuOOBzv GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx8rg40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 21:57:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HKWi5I018212;
	Fri, 17 May 2024 21:57:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4jdu67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 21:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3CAkqOim+Om8FL6Y+gOGbORTgYIH3z3Yk0MZz6ngpD6cd0wB9XzLa6yKzinr3LtKRb9KHMk15jPopgznayb8xDIQDlrQK9T9sSYbqerwOIZpoiCDQ02quINkZ9s01iSz5Ahc5gYAgSt4+nGfFSrRFAh1QADRCgm6T+U8GO2XvS43JqD+EdI4ckyQbgDW+RM4taMeCsJvqF0/LrP14Invx1cDTcilmaEchHwB51iSkIktFc/JL6wfMd7o0zUrFFKnQsOpMFEKvA1Ji+advfj3inoH0pmD2DQKblxLEiFkLdaXEkaDDu2F5DuDl0akQn8vdG0NMZRJ1EWvNzlrHxmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl1EFtyEiBypDjqp8IQogoCNoGkOOmSsUgJ7CLVbbzc=;
 b=JZRAZJCRGlFmB+u9uXvgS/ftPd1KL7UxwWZyV01M273smqEl1+TWLez2tqQriv2jcSuwG/EyTgQOAgtMPdSBYgqB5GULcV63lNp+VikQQkGO4TaLp+zsXR4xyg1fxc2NZn1zpLO5rRZmVlKDsj9kSXcBRaiWdAu2/zC/86amCY4+Fp57cZZN5BelEwfyKM9qNZEPA0BT5AOVEF4JnYc/VlCvCrojl37mw6b1DG9P8VzZif1yPkq9N2eIh++WYjbWLeubsCOaSXaaHvcv4m77rX/lXWywl3CEgWxrGwk8uNAcLweAhhn/YTaRIq9sQoTSocLOVtRw5ZHjVTmji8Helw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl1EFtyEiBypDjqp8IQogoCNoGkOOmSsUgJ7CLVbbzc=;
 b=MgMqFDd852btVj9Bi1MAnGj4LjHJvbK/d7r0cVPOsoB63G2MV5wP3oKcX7scM+kWuWA9OHOMmrDi+HCBPacWOJr9i6yui2UqtONi5jmvRmo4tc/AxIyZiWadHQK5o702+d0E6r0TWCO1iybFK42F8XppvnhSC+VNYJZbmOnbQ6k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5681.namprd10.prod.outlook.com (2603:10b6:510:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 21:57:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 21:57:20 +0000
Message-ID: <30c274a6-adc1-42a7-91cf-8a386884106f@oracle.com>
Date: Sat, 18 May 2024 05:57:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] common: udev settle before _scratch_pool_mkfs
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: josef@toxicpanda.com
References: <cover.1715896529.git.dsterba@suse.com>
 <b8e39744f98bde6484d222c6e90240f074df1eaf.1715896529.git.dsterba@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <b8e39744f98bde6484d222c6e90240f074df1eaf.1715896529.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4725fdd5-8cc0-473f-e71a-08dc76bc52eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UHBad2svdzlpZGR3N2ZhaFpZZ1Nkak4yNnFENG16MGY1ek9TaVJVeHQxYnpY?=
 =?utf-8?B?Sm1qYUxhVU1hSUEwVEtzRmhRRzgxRHZsMFY1L0VCcHJtVnc2VDVwYUhvWVd6?=
 =?utf-8?B?a3h0U29RYVdpVzFxZ3RhS08ydFZ3U2d6amhOdlVaK3lGVUgyWVB6OHpmT2FD?=
 =?utf-8?B?WHpYTlJaMkZvR04vRUhDRlg5OWg3L3dYajIzWWxmMWdYMUY5NnFUaWY0MzhL?=
 =?utf-8?B?WHdPZmxJUzlxbDM3V3FMbHNzQ3NQK1ErQVRZMGZhalJpWitjM2pnejVyOXMx?=
 =?utf-8?B?eG5DaGtkMENObW01SzlBclRxK0hhVGR4ajMveC9HRTE2YjlEckRpKzBMSVly?=
 =?utf-8?B?QzN5cUJ1NVYzTVFOeU1laHB0WndKWVVyeU1SbUNMbHZiNkFiYW40WTduK0wv?=
 =?utf-8?B?cUZ3am9xNmtURHR4TEhkWWxvbWZUMThIdG9iUUoybERDbVJVb1p5NzQxT2hD?=
 =?utf-8?B?L1c1SG51VldWKzBjQ1dEMVJsRm96VkF3RDh1bm1OWFRDK1JiclN5TElXckNX?=
 =?utf-8?B?bkNybkErTUUvbDF4REYyYlNkL0xrcW9iRUU0VW8wcytXSDJvZjhYN0FQQnQ0?=
 =?utf-8?B?YXBYbzArMDBIK3k1dFV0TlI2a1Bja0ZPVlhBemRnZ3Awazg4b0hLT25td2dx?=
 =?utf-8?B?cXRTWWIvdks4TW1oWGZMaC82SVBqZ1kvc000bHpnYjN5VWNIVUlZbk9LOXhN?=
 =?utf-8?B?S2ttRVYvTzBIOWdvOHdiUFZidURsNmN3c1ViRjdieUVjdWl3ZUdGMFJSMUIx?=
 =?utf-8?B?UTBwdHVWUzVQV2lLN3dFRHJ6MnFVNGRHNjNVS2t6NUhmMmwva3pFVmZIaU9I?=
 =?utf-8?B?L2hUTXhJbzFrajhIMWxrSHgyTFl3bFZZcTZPckRtQ1J2a0tLeEVzbkl1bm5J?=
 =?utf-8?B?VktXUzVjSXZPdUF5S2c0cWhTblJsSGErSjBuZ3I3WTNidVlCbDE4aE9pVG0r?=
 =?utf-8?B?K0dEUVVzdm9rUDM0YVR1WHBaR1daSHM2T3NyY0E1RHdrY0hwVmhzWVZEQWda?=
 =?utf-8?B?R2RyUjR2VHRZd2ZKZkwzWjgzZHB3NTVMRlZqeWxLU2p5cS9XbldVUE1raWVW?=
 =?utf-8?B?MnMvZGR3aGw1ZmxnMGZzeGtnRVVGeTRqK3dabkRLK09IclB5WXVEd1cvQmJz?=
 =?utf-8?B?bWpNWGFPRERnVEhuRVNOTjR6YXdMMFc2ZHVSc2VvU3I1cUl2L0c3UGtIUHFw?=
 =?utf-8?B?OC9LZlNreER3SHJrc2JISEJQNFROZUZZbXRBR1RXRmlFRnk1YzVlVUZiK2Ur?=
 =?utf-8?B?VG9GVXBOWXNqNUJvU0RiUnFCZGZYdGdtUW5wVjFIOE9ucnROY0p4ZTdGanZt?=
 =?utf-8?B?K0pPTFBkSTRvNllOK3BCOHV5bldNcFpDR2M0dWdCNlczeS8wUlV2VGl5R21v?=
 =?utf-8?B?OTdtUDc5QVQrV0gvV3ZXbjZLdzV2YjVrZCtmaTZhSVFtd3pVY29xTk1iTmJD?=
 =?utf-8?B?UzAxc055OHE3MGxBLzR4MGZjQ0FTYXF3MUJqcGkxRnZLRjE4cG8zek0zVGh5?=
 =?utf-8?B?dmdtSlNYUTFmeXBWY0s1Ry9ZSTFEaHV0cUNXckpTVTJET2dHOUdjOVJYUDB3?=
 =?utf-8?B?b1lNdktnR2l5Z2l2RSt2M3pmeVEycGtxcEVxSUpOZzhuLzd0anc0dThGRGs5?=
 =?utf-8?B?VG9sMmJHemVkNTVGVkllT3VaMm5DbDRHaTg2S2dLWENaMUplNzFIT1ZSZkVq?=
 =?utf-8?B?Q21TTFRCRzFtTnl1TUtzbTh6YmpvUEJidUhvaWViLzZFM3FlSlgrZTJRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Unh0T1VRZlowV1BEWE0xaGVqcTF3RnU5bjJEVmxWSUhxMzVISlRLaXZWTUph?=
 =?utf-8?B?SmZGdVVUNUhQYlN0bTZ2KzFFNEkyUDRpMlhaSGdwSTYxUlNQek1oaXloYnVp?=
 =?utf-8?B?U3JxQXlCcTdVVm5hWEtSSmhONlFydzBIcmxqaW4ySWlWSllKY0lCZjZIVnZB?=
 =?utf-8?B?Z0RsNkRZOG4vRnhycTZjOVZFOWNDVWZoY2Q3Wjc2T1EwM0JydFJqSTdaZXM4?=
 =?utf-8?B?ekhGRUVCUnE4MUxFQ0tLNjNjeWZHTllqeTZQZ3lSWGVHTXlVTGhUL2RTWCsz?=
 =?utf-8?B?VGRyYi9UMWcwTXNlR1h4YzdpemhqeTgrYlpHWThBVXN4Mzloa3AwV0NOamZs?=
 =?utf-8?B?dUEybEYwL3FtZTNNRXZIUnlSNjA5dkFpUVVBV3JwSlhNdGR6UU1EUGVWVEk3?=
 =?utf-8?B?emdFRVovN2JPOExWVXNKR1RIYk05Z3lJNHh3eGhKYXg2NkpES0xML0xJWlBD?=
 =?utf-8?B?MG1DNGprUFQ1Z3RaWndsZXNQbGVzMHVZMi9rRUR6RGVvZFllaWR0SFdZdnVk?=
 =?utf-8?B?MEJoOUtBR3IyVGErbUJxMC8zbE1FMnZ6SlhoMkZMWkVsbWZtY2hLZlZULzFI?=
 =?utf-8?B?RW5rWk5qQkpzakFrcVNyeTZEdmhyNEt4V3RrYjZ6N21WaW55NWxLWlVvZ2tN?=
 =?utf-8?B?TkpuNmRmQU1Bc2tycCtXSG9yQWRlNXF4WHZIR3ExTUZkNmdDUmExWWlkU0Mv?=
 =?utf-8?B?dlh5YVp2WGtjU0w2NjUrR3VkTUJRYjhkbDVya3hWVnQ0OW9lSlFmWklJdGcz?=
 =?utf-8?B?UjFCMEp4enFUa0ljZUFhb0xOcys4VlZGNzc1ZnVOTW5RejN6b3JNMzhieGhh?=
 =?utf-8?B?RWM4SnlpSndYMURUeEZZTXpGdmNSY0N3cjFUWE5PdDE0ZWgvZ3NSOTQzWXVZ?=
 =?utf-8?B?a0xzb2hLY0VRdUpoWHJWTkxiUVF5QVpzQnFkcjdaeXBwanpIS1hUNjFsQmM2?=
 =?utf-8?B?U1FldkVVLzVvZlhLK3MwZmxHTVlpRnZTVDlRQUNtVm1USkE5L1RBWElFaENC?=
 =?utf-8?B?ZGR3dzBsL3I2d1lpNGhSZnRYRmlDNHhoUjRFSkhTbjcxd2taQ213UkhwdURy?=
 =?utf-8?B?Q29LajloN2Voc1I2dk1xTENWQkxyVW9hRXh4VVNUM1RzT20rRDEwZ3YvQ1Rj?=
 =?utf-8?B?T2o1YTNaRTR6ekdVTFBvWDA2NnRwenk4eGpqOGVSWE11MkJSVDZkWGdjU3Va?=
 =?utf-8?B?a1RTcFlldjcvK0IvYW5tWC9idHdtRjIvcEYwQVdRMkUwR3QwZmxpOEtSYTFt?=
 =?utf-8?B?UUFrVlQ5K0lGY1FmSFIvQWljZHpUVHY4QXllY1FzSTF1Q3hoT2luZk9MK3lT?=
 =?utf-8?B?cUVxTHQwY0hyR0M0MXlwMUpXMzZqTGdFWlZ5WGVzNktNbDJLU0pWM1ZzRWJY?=
 =?utf-8?B?T255ZCtRY2tuNXpSaEx0ZGZVajNvSlRnTlNITk8rZzBHd1BOakVzM0I3MGdL?=
 =?utf-8?B?UXFpMitrU0F1TktjQW4yT2lzWE5tVDR1aERxQ1BXUzZ1bWh6ZlVvSm5NVlY3?=
 =?utf-8?B?NGJVNnpmR2V5d0ZpVEVvZ0w5c3pacFZrYWd2amlQb1JrWnE4RjlaZm1xVFRC?=
 =?utf-8?B?ZFNYVjVDd20wVDZlY3lZbWtCRWNiVXR2Mk1wTzdoZVBlYXgvUHoxSDBiNXly?=
 =?utf-8?B?YlZRTCs3R2pWUlVyVUhQaXRRQ1BMNVZpNkU5Nkx4Si9aQmx6WlFNamJESEZX?=
 =?utf-8?B?bFkvY3ZVcFpiZFdURXF6UkIwb2NEWFY2MUplcmN5bUtEajFsNEN2RXVlNVdK?=
 =?utf-8?B?K2VoRWFRUlZzc2dacVdZZXNTalRtQyt3dkZPb0UwdWd3d3htYU5VQWMwaEU5?=
 =?utf-8?B?Qm9TMEkrSm13NHdydXRsOEREb05ITDFKSFNQNnlGbmY1MnFCeFdMUlI5QjU2?=
 =?utf-8?B?Qk1PTWQvcC9pbzF5YkFXVHBVUXE5RGp1MnVYRnhYK0hxN0hEYUxkdm9lNDFR?=
 =?utf-8?B?aFhySXFTMkRMb1hBTURDbi9OcU9OeWY5MHBMLzhBMHhXaHhjQjlhbTQ1YlNq?=
 =?utf-8?B?UXlRbG9LNUhYd1JRQU85d3BmQ1hwS1RwNzlDZHordUQxdmFMV1ZCSXpVd2xq?=
 =?utf-8?B?VXBiUEN2RTBPL2Uva3UrUWR1cmNlbFRPNFVZT29ZUXRoK05ISCt6VHpwVVQv?=
 =?utf-8?B?akRNYVY3SU55Q3hSSUFDdlRESDVzdTFzbTA5VmIzbUhzWWk5bHpid0Q4S3Fl?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vm3awt5dbJ55xLw0Y8QC3y7iOlZV/xiG08ghaXJfG3ZxT3s8JIxaKeQsOCNoZgaRcx24FA7mDKkcK0EsvYbNRrAc1GCBO1Bl66MMQayue/VYxQw88i97rOVTq3o2yU73FJ4HIJZ37GKat6XGhioKEO6VZQpauxj4sjS4dz2p5G9FlMg+5WsASIbLMLVu3jg8+p6Y1oro7e+Nb8LYUsRoMhY31F5+56qbRZjAmRv7mMo4/67hxriT+p35hwyCF3ZazPw55sGzfyNHLpD5l0SOF18mO92tFljWLwVG9Ifj6ea2j+xIKfrGdga57i1ryud0hIZjzQ7dlmhoZwfQ+XzWm1fXRL+OrZd1yOdMfnpPsliiroUd+MTOrF+hYANcIeNuYL3SOzqHBJcIz3vgrc7Vw+3WBv3ne4UmvhtF+09hRWAP5pa/03ZAQgPzCNZJxYifYzDkQSAt1Zgj9jBLN6Wuwd210Y/4l+gkO/1YdKDPAOnN0A53TpVifVA2hwCqpBfsitZoTzuSe921Tb7rRFwTogUS/zmoH1tfp+LsGHNSwdOOnhxVuUmVcMaXQ5KKpOrnrULZAfMZ16qVJKWpvY4c2rAt6vZLVfVVMEsXzsUfm+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4725fdd5-8cc0-473f-e71a-08dc76bc52eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 21:57:20.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1I1XPikvt4kl5WrcH5FJv5F3o8Nromgfj255HL4w1J78mIP67v+lzDx19dXK5hodYQUnRzWctttrrNhYM7B9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_10,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170170
X-Proofpoint-GUID: 9H8qRiACkqKK8iJhJoh-Tsccp_OorFUt
X-Proofpoint-ORIG-GUID: 9H8qRiACkqKK8iJhJoh-Tsccp_OorFUt

On 5/17/24 06:12, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> There are some btrfs tests that do _scratch_pool_mkfs in a loop.
> Sometimes this fails with EBUSY.  Tracing revealed that udevd will
> sometimes write to /sys/block/device/uevent to make sure an event
> triggers to rules get written.  However these events will not get sent
> to user space until after an O_EXCL open as been closed.  The general
> flow is something like
> 
> mkfs.btrfs /dev/sda /dev/sdb /dev/sdc /dev/sdd
> mount /dev/sda /mnt/test
> <things>
> umount /mnt/test
> 
> in a loop.  The problem is udevd will add uevents for the devices and
> they won't get delivered until after the umount.  If we're doing the
> above sequence in a loop the next mkfs.btrfs will fail because udev is
> touching the devices to consume the KOBJ_CHANGE event.
> 
> Fix this by doing a udev settle before _scratch_pool_mkfs.
> 



> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   common/rc | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 0fe56382a6a497..5d38571ffe87eb 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -903,6 +903,12 @@ _scratch_pool_mkfs()
>   {
>       case $FSTYP in
>       btrfs)
> +	# For multi-disk file systems udev can queue up events on the device
> +	# when we mkfs the device, and thus tie up the device after we've
> +	# unmounted.  Tests that _scratch_pool_mkfs() in a loop can sometimes
> +	# trip over udev trying to do the updates after the umount, so make sure
> +	# we settle before we try mkfs'ing so we don't get an EBUSY
> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
>           $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
>           ;;


Just curious: have we seen this issue even after the btrfs-progs commit 
below?

   e54514aaeab6 btrfs-progs: fix stray fd close in open_ctree_fs_info()

Thanks, Anand

>       *)

