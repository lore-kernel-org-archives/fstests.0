Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3B28BA9B
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428357; cv=fail; b=THxhbZBvxTRFxEz2vR8iWhMp8h6XTJaTUir24Cv/Aez74ckE2/KmOoQHCghZdToTKNzVqGOTZ4HCiJ63kGfjmz1E/Walb9i+/7FIW4z53OiVuYR53fVtYixSefKIDeJvco74TD/+6vJ0SGq+3S6xiBDXvu1fxptLIKTf8WAm+e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428357; c=relaxed/simple;
	bh=GdGLUgqTLursrrEENw0hU7rhEnip2MB6tzLmUGgs7Ko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fjvGAX80/yfhY/MEsCmQ/R6OrbxNCW/MOM8sz81/oTv7b0d8smDapccGzQKE17uH944U+rTzBBMl2fJK8N/tYgSEWWReVyta/mnNpCpQN+wMdA64d3STD3MK4ZhfChE+SBPE6wZ3jmJ+pIBHzay6yyiyOctBRDJunzzr6Tz8sqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y3yx4sq4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i5F6nrgC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y3yx4sq4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i5F6nrgC"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KDWS3R031845;
	Fri, 20 Jun 2025 14:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l0OnWTHYcWq4ui+o76dJAIdmuyqVUIrPA8yW2QWkTAU=; b=
	Y3yx4sq4tzWqoSwWyBsd3/3NTqMMNgbrsWyfifjibP5uXat3Q8zOSBbcxQNYknDY
	+XYMlyenLK8Hpp45aNjIKYLyBT5AjfIpzP7XRZaiO0Fl3OeTk4H0Hdr+em60EvRx
	KeDGo/jAg8ZUziJfkxLDjefVyyM5ecoKZJPDmUHEoxMxohdZSz/yfqK5mV0Pt5ke
	XLrIDVLR7RmyZIZy6biQtH5aPk1em+T+kNc7uD0IMIBjDR4bolClHcrQC7rm4GnB
	97WyQjcjltyCr8JVw4rx5ekT855CLfuqWb3BtTjs4+AqEBxRIo1ooh+vAXxhw8su
	cUgaroooaXytGb9dCvUpeg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47b23xy951-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 14:05:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCSCuq021547;
	Fri, 20 Jun 2025 14:05:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhcqkch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 14:05:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMZ8YK41kd+1Jjbi5rb7/B+Rnlr+RkxVKMstmgC5D8+7vu3DgLw5dQYJajpN6xRwPtQz94f4CVwVxDI/+KyvlRWyLcxI8P8z4zZHozKAejWb8ldFLLAXoXPLULkO+ns2vp25DbJGRHyqDR3sPhwt7KbuZ31RrjABI5g0PRvYP/tgWaXGuItYJt8uv7S+oeBD7bcaARQnv2uNFUPvxqcyy5CsFrONxn1yPhwq6UoGGiG4eqmnxL3+M8x+VLNaBHIHgZ4BIk25O+pOMSlcWDPcA+z8Y10pFFTYZwmtRp8RNsexF4585lNsUjCoN1SdVaj4R3uMawSdqwlCxBJqgx2VLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0OnWTHYcWq4ui+o76dJAIdmuyqVUIrPA8yW2QWkTAU=;
 b=obbZIcZPgg4l+dtkBl8gbu8vHQJsT4l6aW/I6Nq6tlJCmpiUJJj+YesrC/v6XKh4NspFN7a4btk6q4/EWlqEoDLuM42gkNBHHnB72ScJP6LGjsfWtOIxRyYSwgy7Cfra+Fy4J0KDbYndllaBIjeAOy3XJNU8xqoUJyyPoH9kbsCa3NofEdNY3rpPk7QpfxxkY9JFBhlkd/evCqVHE3FpHyxadOKsREwLafCZhe3uqNkbpkDZXAW9UD8lg+k3kDLaMQd7SYLEdaokW5SEs8jekkGT/KDfw6URpYyC007/acnxG7RRnyYw5NHFy4rzZxv9nAIUbevk5rpqO5WcMeXVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0OnWTHYcWq4ui+o76dJAIdmuyqVUIrPA8yW2QWkTAU=;
 b=i5F6nrgCwssjH6L+mgiO87X97dIlznifts5PkYVdB1z5PHv5tn2xK7NUmHT+yKWGi6a+bfQdnovB43Pc/bB37y8rRrYQCykZFiz1XlHc8i3Hx2xYUDLDRpEvyYCWaByE7cnORmHKxyzyZ3VjCShLszTo5aDK2fmuh0qVSyt93jE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 14:05:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 14:05:46 +0000
Message-ID: <170476dd-846e-4884-b185-f65ec46aa34c@oracle.com>
Date: Fri, 20 Jun 2025 15:05:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 08/12] generic/772: Add sudden shutdown tests for multi
 block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfad791-49cd-455b-6a6c-08ddb0038d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3VRS1FjczgweE1DbGRRYVJUeTgxRGR3aU4vQUx2Unh2Y1NxTEdiMGhMdlhW?=
 =?utf-8?B?N0JHeUJwR3RLalh1VVRHYWhzTm9kZFJxVURRTGlaMUxPYWlNMS9nWVlpcE5m?=
 =?utf-8?B?d2hZR2wrNTYyYlNwT3p2VG1GSG9NL2dQVE54dC9Ma3p6eUdYM0Fva0YvUzNV?=
 =?utf-8?B?c2lnZW11dTJpTVlISlB5d1JzZlM3ZXZ1UHNSU0tyc0tld0toTDVQblBUUHg4?=
 =?utf-8?B?T2RsVHg1c21hOFhFUDcxNGdyaExwWTFzUzd0aWtyWGRCd2NpeXFJQWZ1VVoy?=
 =?utf-8?B?ZlRzTTRVd05yY3hsZjBQYVdYUkRycVZuaEYvV21LWXpnSm9EclNxWmFKZzAw?=
 =?utf-8?B?amgzbklWbjZScXNtR0k5YW91bzNtM2F6ZHRLUVY2dlNpZ1laL0VZMXh5Q2k2?=
 =?utf-8?B?UHJxOHdyaSs2Z01jL0VQK1VhTGtGUVVwWjExMTNJazFva3VQUzNPditGTGNa?=
 =?utf-8?B?cjBNR2FQWExkVURCR3Q4cVJRc0hocHd4TnpzZmxtWmRta2R4UDlLeUJKQ1Y0?=
 =?utf-8?B?TTYvN3NuRlcvNjBqZWlEUmZ6VDJtOUhnTTE2UTRKeTJJUk9Id0dvclcwaTZm?=
 =?utf-8?B?bEgyeTE0Mnd5elJIUU5Xb2NzVENXalR2SjJLSWRBbi9XWnd2ZldubTJ0MnQ1?=
 =?utf-8?B?Z3lLWlV6WU9iRmF2STBoTHdKbnJ5OXpuWmk2ZGVjUUM5TUc0ZGdWTGJvNjFM?=
 =?utf-8?B?WXM3cWduNmdjMHlYenovRFVZQ0JDYVNPVTU0QVpYMEEwN1N6Q3NUQmpPWkN0?=
 =?utf-8?B?UHh2N3h6bFd1dEVoU3BHcnJ5TkR4VzdxS2N1cC9TT1RvcG93NExwNC9HbmVp?=
 =?utf-8?B?RDdCbDN5bnI4ZXYzUDFhUm1XaTFMOWdCRUtubkJha2FEekFXaGsvd2k1cFhF?=
 =?utf-8?B?QjZ1Zmhvb2JvQnFHRWtmQkxBeERLbkcxd3dkUXE3bDhjMXJ6dzh2ajhzRktr?=
 =?utf-8?B?b0lFM1ROOU4ydCtKWFBTN0ZHRVlzK1BtTkJSYWtqNTRVOGFncnRkNEp5RlVj?=
 =?utf-8?B?YTQ0eFl5MkpqOXlmbHdiVTBndkQ2eGs1UnFzWUVvQzJGeHQ0dXo4VUhnVzJp?=
 =?utf-8?B?a2hCVW4vSUJiSVh2YjZVN25CRlc0ZHU1bEpKekVNdldhRy9SMlRjUzQ0MWJQ?=
 =?utf-8?B?dnRQMGhHcVN5cVFCczFZT1RxMkVYTWp4RktJWDB6dnFjL2tXZjdUckk2OXhw?=
 =?utf-8?B?SzU4MFBlRERxSng1di9JVld1WXVUR1hCNjQ5VGJQWGdjRGZLMFhSQTM4eDFF?=
 =?utf-8?B?bE9DN2t5SGp1NkV6S0hRbFNxR1NaZTdZRlVmd0QrUGIvd2Z2ckNQaTJscks1?=
 =?utf-8?B?aURWUzBiK0d3emg0YWJXcWFpVUlVdVBRalFOdUh5RklSNFc5SWVqK05nb3dT?=
 =?utf-8?B?SlNKZXVWMlg2dzZQbWdWR0xRWW1vRVdiMzdYL0NLV1I5U2MxdHMwYlB1aWxa?=
 =?utf-8?B?SExWaVNaYmt6ZVJNWERoemhHdlBOTHpwbWNZNjkwc2U0T0RkWk1QdFBmQ0R5?=
 =?utf-8?B?ejYxOVlVY2d0R0gvK2hyeWpVRmdyeFNaTitWZjlKTndYck9uNE93cGE0YTAv?=
 =?utf-8?B?MFVDWjBnWDY2bzAwTndUU0hCeS9xSWg4b1hqZUdGTGVWUmlKN0pMMnRhZmh4?=
 =?utf-8?B?clVzdVd2U1Q3SjJmK2Y1OUI4VkRFa3ZQUmtlZUFxN2gzMGhwc0hOazZKTGpI?=
 =?utf-8?B?QTR5R2lOeVJFa0pvTjZpUDZVeC9ReXNZUEx4T21WSWloc1RJMFpaMXErWUI4?=
 =?utf-8?B?eEJwY2grSWlDMjBDZ2VIUFpxWmV4N3l5WTB6WTlzRmJSV1BGa3pJdXJ3M3Vm?=
 =?utf-8?B?eUJQK0lwMUpScWtvTytYbmZTbVRBeGxiMXIvZkptU0RpYUx6Nnk2d0FKSTJM?=
 =?utf-8?B?NWxnblJWWnMzb3JUUzlBQXpOZUNlN204bmhIUy9KNmFkbkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk0vZms4a0VKTmlVaXhpNlpZU2JoakpqVTJoSmQwZEIzMjYwcEsveTh1Yytn?=
 =?utf-8?B?bUNMV0NZUFlKV1RDSTlHeXBobHplajc1aVk5WHNYYi85VTRYSXlkdVUzS3Ru?=
 =?utf-8?B?eE9FOW42SEdRQnlWbUZCMW0zRzF4VDRRb05YT0tlUENIL215SGtzNHVvVFRs?=
 =?utf-8?B?OGRjRHdqQUVwdWpWVVlQejE1YTNIY3AwNy80Z3NSbU1sdERObDJoRFNDdG9E?=
 =?utf-8?B?SS9hR25LakhoVWtYcEV1aGY5eEppdndMMGdMb1NTN0VGN0d2WGJacHpzZmJO?=
 =?utf-8?B?V0FsK1dOaCtCWXNWcFozRVJrZU04elI0YWVKbGdLR0lzbUNrZzUvdFFtZ3oz?=
 =?utf-8?B?b0gvek1HNzdoNk9GbVNiUzQ1TThneFJnb1FVdXlQeXlUTzVqc3RUd1k2Y1hS?=
 =?utf-8?B?N3MyTGNENXM4a2tPbWJFZlB6L3oyS1U2YkliRFhYeFI4cldIS2h0cFJ5K1NS?=
 =?utf-8?B?dEFRVVpWVG9NcHNRR3BYSy9vUWZobTdCQTVCb2Q0NU1iSVpuek1zeXBxTUxK?=
 =?utf-8?B?cW9kTm9CSmswaGFqd0pYNk1BTXhyWEJUUU5RbkRsUm5jTXMrU3dGMUNWT1o0?=
 =?utf-8?B?U3d4MGxodWwwR1dkTDRkMFprSFdPUDBCVkJnSHU2R09PSFZFRmtVU2Rma0NT?=
 =?utf-8?B?YWhHWXlNWXJDcy9aMzZabVBjL2JodjBTV3lvdlRmQ2QxRjN6NEE3Wml2cU8v?=
 =?utf-8?B?Tm5udlVhbnhUQ01LMllrdDZDK0dOSmpDWFB5bWp5QjN4YVhyUXYweDBMOEc0?=
 =?utf-8?B?WUZkei8ybG85Wm53TGt6dXJVV3IrempPMnk1blNkNEgveGJOZkwyVFRHV0JX?=
 =?utf-8?B?Q3dsbysvWFFuUkdWUEFONTVoeFhJWU5Wam02UUt3Nkp5R2NyK1lVYTRQYjQ1?=
 =?utf-8?B?MWFVRWd3eVE2Q1VrU1BpaUhtL1Qzb1FLaUd3THM5M3ZWL3ZtT3puaTBqeEFi?=
 =?utf-8?B?SFJnbGkyYWNNK09vb2tHdnRoS0tjQmgyRFhhc3BvQkdzaFp0NHpIU3FLNDQ5?=
 =?utf-8?B?a2xGVjE1TjVkQUZpcDFKQThvV2hhTG9KNkQvNnAxTHpQN1djOEc5R3I2WmFi?=
 =?utf-8?B?SUdoblBna1VNWGtBZkZjdzRtd2JaQ3BkN1dMMERESW1pcHdweXJhT1h3cUgy?=
 =?utf-8?B?MUpoZzI2SEpUOStJSWN5eFdYNHB1cmRTdGk2L2pTU2xUM3Racy9LRmNaczZK?=
 =?utf-8?B?MHZnbDJ1bnJhKzNXZGVVSmRjUFdXeHlUcEkrOGlpOGZ6THQxUTlXV0s4dS96?=
 =?utf-8?B?SVJXOFI0WktMcFQ0NVpiOEhvck93Y1dla0JBaDdlZnFkYnJZZ1pUOWd0eG8r?=
 =?utf-8?B?S1FSWU8zci9oTEVOT2hvNFZkOS9ib2dtUnFHd05RNU9wV1ZuczVUMCsrU2hi?=
 =?utf-8?B?TWowcWZuaHc0bUpGOEJvU0RnZE1ReEs1aSt1TnBabnNEdFBKeUdEN1NNN25W?=
 =?utf-8?B?RWp0VXpCb01Ea0VXT1Z6dzRqRDhkUno0UVNjNzgvbUxnVzYzV1ZBZUJIb0RX?=
 =?utf-8?B?NHhoa05mazFYc3FsTW5MZ3ZwUTRFMk51MFl3ckhDbndRSng2Rlpjc1pTWmtJ?=
 =?utf-8?B?OSszZ3VLb3cwK05HVFFMRXpDTFJVZTZZSlRpQ0JJaGlNVnJTaUQ0YjZ5cFBL?=
 =?utf-8?B?VVE2UWN2K05zUjhSa3FQdHJ5eFkwS1pqa3RmZk02cGIwY1d1cFZQYWpYNDNw?=
 =?utf-8?B?Q1E1dGttY1J0cy9zdkszY2UveU1mUkVEbDA4OUJFYUJLbFRTOUhLT0IyKzdK?=
 =?utf-8?B?UE9xWTFYQWVXNkl5VHp5TXVqaXEyL1BielBTeFZ4b21SS2dnVUdOQU9UYmpo?=
 =?utf-8?B?Qm4vWVZVS1c2OHUyMDNPczdoaGsyUWtsSWJzZmoyR2dnS3V2NnNENU5Wdm5s?=
 =?utf-8?B?dytEY3JiUENBSnpZTkNtVG5EeldMM1VUVjNXTENFbmJ5UGpHL1dhN3ZZYU83?=
 =?utf-8?B?Y045SUREN0E4M2w3MVcvMGs3b3RWVEY3SkQ4cTdWbitDWXdKSDlSUmwrV3VH?=
 =?utf-8?B?Zk0veGg2OUVaaDVuV3R4YXJyY0ROd1Z3Y1d1ZnBrbWVvZUtlbEc2aEhKVU1W?=
 =?utf-8?B?bHErRXBkUm5sS3ZvZDNkWGk1cklLZkw3K0dybWhBVU9YOUx3ejJSVVU2eEFt?=
 =?utf-8?B?VFJBTGJlck1OK0JzTFN5QmNnV0M4aStHNjI2OExDRFVDbENQL0tFY3ZvZmRM?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y6oZRk9o1uPlf6iPe0rfvJ2K9mSou2xjG57FJshnhBoHawkuTEnhKNf3NGPlJad4FARImLYZ1WnUP4+VvAuNeuOOFTaz9WBrb9xezasmLbJFB206T61DvbFUVCyUAPLWZNYAnCipRnCxGeygoqG4O9LYjalYLPRCvuNZ9o05Q9WzpBN0U65BHMsPEnFMtpVZh6RXvr59/pPR8725xc4U5keilxo41+not2MTERfnEL3o71G5kHAdOGPL6bPhXdkbCeg4qkeAsq/mW8wrT3j9RG+hfVE9qUHQ9ztD9DYWSKSLWcRbKlEJQ6o292vggzF/O2GONMb5oBv0asA2UoX2xTcK4TmkODwgPI9vH5o/9fes/t55FQkmio+HChFW5H5Kr8y4yEPyMLCnGUgGBX3zzP20aswuHiQl+feQ+nvchcexdOveZMpIh5oqIyrEKdKxp1rqnkmsAj+rjPpokYaUrgWx7+bmnGx/5jRRA6+tsEvBDGGpYqhVjP2LQrV0/Yic9Ey5AtY/UV38vzAaRjMI0NX2Oxy9TbD5LCAoixQ8UoxqKFdGDz2+a8e4u970yDCz9KmOXFZ5pGasnbUG6n/Rm5ChzbFAjGV0VKaANFk9tDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfad791-49cd-455b-6a6c-08ddb0038d94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 14:05:46.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywMmTkpHL1lYd18ket8knh4QBl5+YnsEAZP28yKWD/wXEiVlgiHQ7EeYv4cFbcQKUye+4fH4qewH3EDjsE/fkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506200100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEwMCBTYWx0ZWRfX7XJEKkDiLTI6 3suDJA/WcnFBVeVzp1R/ZZAOOgFwIgHZmxqVfK/CcDNrv7RP4wIrT9hm282EQ8/Ul4TeTIGovuR Y8rHCSHcO657ciwh3GGIAUnwdk15F8Xy/qXUVsyGUgoUxbGxiORAiG/0/75Jsyps3oUSqV0ruyq
 pyCAxE5CVCFeLyVoToTtmNIpql9Y27cnAaE9cFrmvlOUr0oVk4C0PaNZJ2ujJ4MBDrXkyCKMZKR LtNRYjzbz4Fhlh3jF0HeUb9/djD4UTg4gPLu7WNAIbmUnlmU5DuJ+RtF2PRwfTAbJ8NtUSedCaN p09JF2gBIIh0SAFLGiOuwQopCQiZs32VzIrfqwl6N7le9QFwskg7qYL2tTBzC5Fq7iQ/19fL9dz
 EJOfacD9VbgDGqo5ZrC/jxX/qBqUuWQ0JdjINmWN13y1dGtlPyTOgmWHlVw2IxR1f8zZFYAZ
X-Authority-Analysis: v=2.4 cv=DM2P4zNb c=1 sm=1 tr=0 ts=68556abf cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=2fkFZ8y_QW_1LmUHcNEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 5ttGa5ffH4WSN9IzDpUtIuuygUDcnc6j
X-Proofpoint-ORIG-GUID: 5ttGa5ffH4WSN9IzDpUtIuuygUDcnc6j

On 11/06/2025 10:34, Ojaswin Mujoo wrote:
> This test is intended to ensure that multi blocks atomic writes
> maintain atomic guarantees across sudden FS shutdowns.

This looks like an interesting test. Can you please consider writing a 
fuller commit message describing how it works?

And do you verify that the test would fail for a non-atomic writes 
(before proving that it works for atomic writes)?

I've had a lot of difficulty testing atomic write behavior for system 
crash/unexpected shutdown, so it would be interesting to see how this works.

In the meantime, I'll try to understand the code...

Thanks,
John
