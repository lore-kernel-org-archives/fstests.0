Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0C7F
	for <fstests@vger.kernel.org>; Tue, 21 May 2024 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250196; cv=fail; b=YAwFOLAzYOkaoal00tpTyOgnC26M9/v2kWJIb2AsBoyolLLv2hoAA/btpgQrzZTGvfr1PuCzab/3R5Hj+UvVqz7NK64br28lw2+uDkbTf9yYyxImgn6dSiKqDNtbpsCOoop1tx97zPNXwrb2mCcIn3Xfv+JdwNost6P3sbIYeqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250196; c=relaxed/simple;
	bh=hCmUbdqpS0L//7ZMSsTFDkjro+Iwa2UhY2TZfejt/BQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IrLooAhfxWPMJ+Lpk0rzKc3xDFtYKiNvTdNvStIQ+2w73azNE6hLXU1VFtcUhZKVM+93H7HN57VAghvH6aikM9pbbDVxEYZvdoQDMPvEeONNO3vN4xVxYBEPrKr1n/9FaBKusPh1umudzTn/a6ogEqanZ99on025dARnZBB+WIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XP/gZbRR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HSqRwBzn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XP/gZbRR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HSqRwBzn"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMxQ0v004804;
	Tue, 21 May 2024 00:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2bX6+Blbg2o6uRb+MJkkwPNYoI6Qqu2F30N86TwJTP0=;
 b=XP/gZbRRbTM3jr7HEIgQjEBMt09IejlyuvvE1ATelAE6cuFzi95jLmtysauA2RdKGtvh
 zWqI/64m765sbrHT/R1w4bVC6o1W3j6I8PyZLBypSruL96zkXM7q69LCCPRCB6lX2blY
 cG4D/H+h/KhxwAfXleP8tqttwasDHh0Snt+UR8RTdgTp+gDVtZg5TITZ/9bS+HTDbCOO
 abiFtqntuQtXGZk0OqB330QFNO3WJa/rYXcVHFCWeXi1QMInPxmPgmFRb8ntD2fG5FFf
 AYEJI6VWBHyp71mtzziBn4pp9HwAIyOeIDv4gFsM9SL8Gca8oxG/QQBGA1gStRr+b7WA xQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx2bu71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:09:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KMVKcp038458;
	Tue, 21 May 2024 00:09:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jscysv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 00:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTm9gSwv92DXGUhW/R7Qb74Vg7xhVxNDjVnLZiXAkQKC1GLXxGtMpMIoySccDW3t6fkhGc/5ThFJ5ECSLOEVkb0vZI6VrmicCqmbuCENjrE2qunamZNgkJNCUiWd35EX/g+Ow710k5L2k3RSvEAmsbI5Mi+us0hA6J1m59c+mEXCM8u6ZDrzFyOx9XMAcp1iR0YaG7ry2PrTCCY/Qdd4J/UjitM7Z8+A+zmgnN4p012KkyQG5dEhOXVGh863qY2pyH0DvQKOMakDpZYhSvX/+opdPrfcCHkPiPbLGBwCTwrKYEMAXiYcEr0SOe2t37kwEzVWGk8m7pKxDODYXGC1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bX6+Blbg2o6uRb+MJkkwPNYoI6Qqu2F30N86TwJTP0=;
 b=eUs1zeT8LB0+KW3vg07vx5DEVHP4PEVgQhJHnwW/r/qrfl8wEoCuIwClhbcXwP3ii259fhRD7jTzM1yxk4Eq4sUWaAlUmhzmNRgSp2e0rCiWLJN6WWkZs2N8C9bFQpoMXcL3Mvr6M1j/XaYcZ9Y8BJd/sufPsSva+oKeJVlqAmOP/DmdC/FX9q42XOCPGTYLeiH81EcSynHijXlnXvgs+IisbRgS0vHqXDIgGLHb9oyODxMw1NHXvWoo3wjHFwPVJHaFjtvkeenuSHzKNEE/Qxcwzev3gsIKnL/HYJDTyQsWJifX6kx1v6G9RCQxHsn+Es74mnnIiRqHtcnNVtCfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bX6+Blbg2o6uRb+MJkkwPNYoI6Qqu2F30N86TwJTP0=;
 b=HSqRwBznhHDR5zucmwf1d/0/NjZGKNRjuBR0vM1jgH2V/DW/z+2aNXDirLwekXZSzgIgtdnwl7T/8jRInRiBzYL5Vi3fqsvS9NbpG4BC84s8+UuFx3AenYqZCNSrZ7RnzabhowBYIRPJxetc7kpNWDWpk1/bOEYI+6WBTD+ha8A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4866.namprd10.prod.outlook.com (2603:10b6:208:325::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 00:09:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 00:09:44 +0000
Message-ID: <3f713bf6-6b5b-44c6-b03c-1c1ca2973fce@oracle.com>
Date: Tue, 21 May 2024 08:09:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] generic/027: require no compression
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: josef@toxicpanda.com
References: <cover.1715896529.git.dsterba@suse.com>
 <9d61a72884ab0c7233ebfcc172407b465e372735.1715896529.git.dsterba@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 xsFNBGQG2+MBEAC42714sRj0ptcjHWMJgkltgglCKCpcjdLTyoFY9dljqJdvrOeojl4N1Ztb
 qMwsnsoFkPiVMUnnU/FgypRlPOzaB4w0R9MTzfvpHKAUNMbaYLquldGJhfuYpTgikr5GztZU
 VGKGsKc4NJzWh6Mfqit2jwurS18RmjxR2dBDKKb5+M5xQ66M5Of2SuuzaM6UnT1vctDN/hWr
 MDqx3CNeQ8Va0i1iCStsdS3ExG6nBVZkL9ZCHHZHi/oqe4bG4vvevRlx57s+uS4WKpAsjlKD
 Z/WHxer9bffB9GuOCngrOTWiXtf1qmgXNs5kXlfb6O3uRv1xnfqTAHdxJ8/pwSShl2aDScdW
 7S265QZ92+ygEJeoviTc8FyrhKkV5c4hAMa9QeiuP6Sk7Mk1G0D/d/DlHQCncQZ/St6q5ESX
 M1LbFLp4amx2yELX0/2lLBXj5s0vQd4mbyz29K5TfiYB/BsEWzSA0gTM9MPdJL3FhIei5VsD
 SQ197dkp3pzqII7/rw77sQs6TFin555Q4DSMsKvKvm/vULpknXMe0DdrHw8ybrY2AjWiTs2W
 1Re7VPORkKxEK7prZ62hghiEvGyZHh0RpnI0aD57R8P3RLJ5P7mCMKimK46SC9fw+zWfWZJA
 EIDccuxTfaLdGPMO8GJ2HnKbvAFbI+nMoSYRvJ6ULvcsH9bPPwARAQABzTJBbmFuZCBTdXZl
 ZXIgSmFpbiAoT3JhY2xlKSA8YW5hbmQuamFpbkBvcmFjbGUuY29tPsLBmAQTAQgAQhYhBKPX
 ZMgfwKRZ10YTjD2+pVga3ljYBQJkBtvjAhsDBQkSzAMABQsJCAcCAyICAQYVCgkICwIEFgID
 AQIeBwIXgAAKCRA9vqVYGt5Y2EAVD/98XUcG+lHTLFvrBn/l+egW5BiJUiUuLIti9wMmj3lg
 Ndv6myanBwjK+v0+RZJ6Vr+oazwTiki6RgnxT3LN9u79T4C7vGuVjqZ205a1vGVN309oMPDm
 +rF4qstsNBMTyE6FfLD1n4ONqgMLATRuk5rPAyfIXQyKy5UomLZo+ISHjpDUt4sXnrsYMz/N
 Ht5w7LRQMmKva92T5cReAvyU8guCHTiG6oN3RCQKlyRmZnFCXa2ov+hYhBrpNikFtPOojGnQ
 JZ/i7RHIU7/ku0/NCGLe+3osdjxaItjkcLP6U7R+WrViweSKocwrtqVIlizSvaDv4MxYM2oM
 aHoAcolFcrpUaqgnUAjhwYRc6CNdB5MroTzrzGnacJ4y7xBlql0+HlrlNho2AVLqvXmar5fp
 uwUHYTeUwsixVHfJL+1sow3Ky7Q5SknDQKd7V7X9X1qs862fuuBD3iPLR4YY5SstF1P0lFrr
 QjNS85TaHFkFhKrXGvhe1WGhum5Fc0hVx88gQBZ2gdw8z4GWKC5esxbvv0lI2UhP89q2ClsY
 ZFS0/Odo0eGgfyxqUGtrouK4cMVXVP+LJb168xt6yOuPMTOLJH/CT9/b3LygcWxn4m/2+XbY
 w1aLKoaO1cKAMSObubp1nQIy+idTnQeY69oKQpxYp97EH7bhYBWfLp/kKJEB98hJeM7BTQRk
 BtvjARAA6w/uFi14uDJ1jAlGWYUpBELdj1NgSAWw6CR6GiS9XPlvtn1uApa80cy/Hm1mqYQJ
 FtC+H3Q0uJRZYol2dvDRJYfDmC4bwoO/mru8ZpHVF2c2rVehDvgzxYJeqH9fJi6fymr9rOa6
 tjX0v8FGKD2pnU8yPXsMNeADdl2lL+XPwVoVhAxx8bpotl8nG14TXQcBNuKxbU4oWRjUZif2
 32CAXkngOnE/dwo68L6tfwBaKNCtXXjv7BMXylXjByMciW1hsR+wwOObWioW8R9uQEDWSNv1
 EwXre7VnuIksrt53Ohfuz458eF5Lg6qKGMYYuLmNwRbFPBeZvx6989P2zKuQn3I6YxzA2sdo
 YIhwJHbJNsf971H3CMFORqiLZY9OQ3Ef6FaLW+KM0p9ezuT9bAomQm6xGJDWC93hM/xLXAd7
 LJxhhxj9rQTwSwxm5eQg0ODntYXeEVfJw/gW0eMf5ivTjzKEF22oTswsEKjnsaZ2UZNPi9Pj
 WbPTEWCzGe4jHLqgY70F7f+OgCoI6Qyvb4+UfXyKez+zuo05Q8TxSFa3diFP5/mRokFMzrmF
 lgnUIyPYrHJWAhizZQveSNQ/5M0C9cVykxhaGaF6r0z8JRxhXi0hAlFIDaGye1k+UB8ZoENq
 JVOcjH5uVcXjdqzEXCa9OCDCJrHYCTu+dxyvR6iFXZUAEQEAAcLBfAQYAQgAJhYhBKPXZMgf
 wKRZ10YTjD2+pVga3ljYBQJkBtvjAhsMBQkSzAMAAAoJED2+pVga3ljYwXIP/2B74x/gNE4c
 5/TGzX3oKEdflBGadVjkirOGM1yjIEqstnCF1UIABhyLJYv9IRaNzhx+ieBDD8knEVAAXvp+
 3b0cnmct+kyvOnXwYpCDJSZcJRE25f8fyTyvo17rUCdP8CennzfB0CFMeis7JhyC3b4ZRaLm
 M87gx9ZJA6z5SLarw5zeI5rHmpQ8FK4hGH82AJeedHKcE+RR8rNOyHpdKDHIEtTxWXTZAC+q
 TxCzgLS6y0OOXDGPifcHjSkW7mSrnVXb/FTIqxVC8ClHwSomp2IQLwqPaew+QNFT3RII7QbK
 vQyq+V0TMXGo7zQQ23SN1N08Nj7E6m/hHffFZvRJ1ibZdHaDDCeDXEZoklttj78325i8yV/C
 XDL6MeirxiJyB8P+Y9eSrIDTQP0jKBPQa6N66QeBSJnMFuDBbP82lovdszeCJq5XhwjDgQ3b
 zAKqel0LTK4JTAlKeYjX678eVUcDAkdfurkLDbYcPd6sOveHr1Wuz3aFgtPVVnVzg3rwi5oH
 rffHVDSAu23bB/YgL+OHJ+EzKIqR+qLaYt0Y+e12zhFBSazVC6NFFQY0A+BV7PPnOLdKF1IE
 kbRwSOU3mzvks433LMKj9vmt5TyRU99OsAIn/BY2nCP3FURwQ1NKQ2vpJ8KnkLCGePkjefcQ
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <9d61a72884ab0c7233ebfcc172407b465e372735.1715896529.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5ed05b-0750-4a78-ea51-08dc792a517e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2NscmFaQjQ3V0FHeDBEbkpwOEk3Y0l1bk02VlY4dXMvSHlwWHlPMWQwR3Bi?=
 =?utf-8?B?MjJINVk5ck12UUpRWThMVUYrZGhaQXNJNVpOa1h4bERQY2RGZDBqYlJRT3c4?=
 =?utf-8?B?UkIvMmw0RXFjcEZKVXNRMnZFK2NJaGhQV0VRTzY1YkxhYnRmV3FVbFNsSldy?=
 =?utf-8?B?bTJtRzNIZ0Q4MGYwRmxVQUF1Z0FCK2M0RUVmQVJkUWJ2bDErM3J4bFV4RDJB?=
 =?utf-8?B?TnBGT2lRM1VaYUJ5a3puT0dHNVRnNGduRm5rSXdneDlPcGlYZ2ZHbnljdkY1?=
 =?utf-8?B?VzNrcGJhWHgySUFmNEN0RCs1UjRsUEVseVFRWGNKTGNpY1YrdXprWFluNGFn?=
 =?utf-8?B?RkkvcUhDUlpHelI5cFJaWkRWcXJla3c2dHdjeHovb3NmbjBJYllJdlE5dzho?=
 =?utf-8?B?VFZZZm1uSTVoM0JmWlg0akNnN3greUtTWm9YcVZYVzV1NGZsVEJOMERsVHFC?=
 =?utf-8?B?WGpmblpMVVc4bWUvR0ZhdjZUSVZrNHFqOWRRa2JHQ1ZDeUJ1MnErODkxRDZE?=
 =?utf-8?B?dCtFYldDa3k3M1BVZitPS0lBVlNvQmxGQVV4ck1CT2Y5eG8vY1hTNVFLMXE2?=
 =?utf-8?B?RUhnTjVSdTc5LzY0c2dsRmFvZ1h5STg0d0dUMFM1RWdQS1FwSTJCNk1ENi9Y?=
 =?utf-8?B?Q3RpbGc1K3pTc2I0OFlEbU9Ob04ycWhUWGd5aEY3TGNwM3N1SWUyVlJ3bm45?=
 =?utf-8?B?ZVNIb1dJa0ZOcExjenNxQUhtMThLMm9DVE5XSmRJUGFTaWg5b2sxTThlUEFj?=
 =?utf-8?B?VHdiWks2TlY3OUtSOHloeERSYjBTN2ZmRWZVcVpoMlVnMVpXREx5OTJtamNS?=
 =?utf-8?B?dXNPeEFwcVBwM0EvNk4yYWRMMGNPWVkrTkg3VkdQeHpsL0RNMW5pUFVYQTkr?=
 =?utf-8?B?MGo0eHEzeFRMREJYSExoNnhmUno5MHk0cFpOdkl0RldBVVBUREQ2RDgwa2J0?=
 =?utf-8?B?NHJ3QmVOSXoxRjNBem84Mllmcm53Z1p6WWRIMDdUZ3crSUdwZTZGY3RJNzRQ?=
 =?utf-8?B?ZHhHQzlYU29lQjVWNnQxZVlTRzV3dTR1QWs2M3ZXTkNLNDlGSHBpOHhZS1V6?=
 =?utf-8?B?WnEvQ3Qyd2lhdEhXcThnMExZNmF1RkVmRVM1VEtSQlZ6bmtMMCtnd3pBcDlB?=
 =?utf-8?B?Qkt2YlpiRjdOcDRRbTdGaU5HSXo5bDRSa01lVU1lSTd1TTA0WTQ3Mzdabkk4?=
 =?utf-8?B?UnBJVmswNkphL2Y0ZGQ4YWQyUjQ1dnZielJ6MVpxYWFUdnJwMUx1NkNZWlFR?=
 =?utf-8?B?aTdIWTZkTUJPNlJBejlYQ0FIUG1jY1U2ZDZ3UGJhZERFNlpjRlhIVk5JWVBH?=
 =?utf-8?B?dXNzMmorZEh3TkcxZ083SWVDekErQTlwNzd1eHFCbitZOElXT244N2VnaXRB?=
 =?utf-8?B?YUltR3FMUHJiaDhoVTNMM1c4VTJIQU1RVHozUHdqN1VpR293R205S1JicTlt?=
 =?utf-8?B?aU9meFpteWx4Uzcvd3dYVWJRYldNd1FmQlpFSnNscEsyaFZSSVdnNWNJOWty?=
 =?utf-8?B?VjJKVEdEdGFEUmZQcXZGZ1lMWVlOZW5KOU1ac21wRFJnSnFqOVRGR1dCYUh5?=
 =?utf-8?B?NmQ2SThaSG5tUVUrTjNtTjVIWjIvcFZpNG1VQk1qSHIxWkxKUS8rdjVzbmRR?=
 =?utf-8?B?eS8wL09nNE1NZ0RKeWR2SWVBeGtVN0l4ZXFDMCtncTFXd1NhNHZQZWJ3cjEy?=
 =?utf-8?B?eUdNRjdjL3k4TEFvMXFnRVoxOGgvODlTaW9sdzRZYTd2NmhjeWQ2TldnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3ZGdXRnWnhZZkh6SXZWbmNJVlRtSThlYTdtSE43RHcvT1ZHMXcxcG5mM3Yx?=
 =?utf-8?B?RDN0RDJKSi9oZXUyZ1g1N3l2ZUUxTi9CTTVRRnlKNVVIaDZjTVdhU1Q2SC9J?=
 =?utf-8?B?THNWVCtPdzREVFJ1VTBmb0lnSDFtZTlxZEswNWpEUzJHUnV3Tk1zUnpWZTNK?=
 =?utf-8?B?cjJQN29abTNLTHFscCtLS2xXZEJQNCthcnluQ2Qrd0h4MEpZRVA4SVc2VndW?=
 =?utf-8?B?ME0wMThEQ05KRjRkcVBKTzNHT0VvYXNZK3EzUG9aQ2FIeE5UU0daamhETkVW?=
 =?utf-8?B?V3JlTzE1Ky8wbHB3ejJGVGtUeHUwM2Q3a3JMOHhTR0NnMGUvOHJxeTAvRU9h?=
 =?utf-8?B?QXNUSm5janBoK0xUL3ZCL3VuY1ByakliM1ZRcjZDT2o1cytSa1hta05pNXZM?=
 =?utf-8?B?UVdoaVpaQmRpMFE0azdMTFI3bUc1dmo4OFdiSEtURlo5dU96UHZmOG0vaDZW?=
 =?utf-8?B?V0VpNEFKSjN5bmxyTDBkRUF6WktvMHdTdktIekxrMVhNajdwSWRWcDVac1hv?=
 =?utf-8?B?cTYzcDlkd1pDdTJMeWM2dFFTVGh1L2lTSlNIcmVtRDFWaDNhZHVMTzVvVnVm?=
 =?utf-8?B?ZWh2d01FbG5QUHVoVGIrS0c5VDJlTW5lcE1ka1JIY3p5Y21ZcmxmYUROM3N5?=
 =?utf-8?B?Qzgrd1I1bFlmL3N6eUd4emJwelBHai9YbENmVmFmVUJTbGdaYlZ1bWptN3kx?=
 =?utf-8?B?ZWtNSXUvY1FLeWZGT3pkUXJSTnpXQkRQc21oMHlzRDJONGNBSy9OMFVZditu?=
 =?utf-8?B?S2xaRXlBeEJESzZpUmhFWHMyaTNvSlcwQ3N6MEpUbmk5REh4Zko2TEd0Qklk?=
 =?utf-8?B?akFkRGpZNGdIVHlIcGExcUMxcE9teFA4MHkzVUN0dTB2N3ptZFBpZzVrUUcx?=
 =?utf-8?B?VTBmcU5RdVRITGlKY2dQS2lGVVI3dmM2K0NPSUpRK0t5R3YyT1ZiS2ZCUllO?=
 =?utf-8?B?dzB1V3ltSnNxV0tZS0szM0hFTFZkajNFWnJGQ3plS1NuN0QzeGFuTUZOcU9m?=
 =?utf-8?B?eHpWY01iNEhJRDlZblFvblFLVWRBT2VyeDAybG1DNVh1L2VDVFpWbithR052?=
 =?utf-8?B?czZ4MFkyK3hucmtGYzkwNGMveDdER2w5dUprSktOaC9ERHJHODRLaTgxbXBj?=
 =?utf-8?B?ZFlTWXJ5R2dnV0pyT3RibUM2UG0zZTdiMEhLQUJTc2tvVVlzYkdLRktCdGcw?=
 =?utf-8?B?WjF1SDB2MDcxSlViWE0xOWdKMCtNaVNCSm1kWFpHMU1pMTk3dmE2VENUbm15?=
 =?utf-8?B?ZHNhYlI1NXh2cjJFYUg3WFF3VG1ya1hKYU1SRm5lMkp2N0srTDhDenlvUkxk?=
 =?utf-8?B?TUloeFFhdXBhTVVnNG5pY2wweitkOG55OHdVODBndk15Z3V0cm8wZHViajV3?=
 =?utf-8?B?SldxRHRpUGNITjNUWDRQeTExeTBnUFNiZzFDNUh1aWpkQkRLcXB5Rlh0SHFK?=
 =?utf-8?B?SWxRNWRsQmtpOWhvMFRKenBtN2hPM3VrSDl1Tzg2Y1RiY3Z4c1MyNWQ3ejNk?=
 =?utf-8?B?eUhaKzc5dWxjcHR2cEdMYVh1a0h2bFhPR0puUnk3aW1OMExuOCs4OTNRZmtC?=
 =?utf-8?B?cmIvbm5FUUFKU3d4NThMdkJUU1QxVlIvc2l0aFc1NHZqU085eXlyaGUrYnZM?=
 =?utf-8?B?ejhUL2lyWDRTQ3RWWWxIeHErd0RWOUh6WDhkU0JGSDZCSmNjU1hKOFpzbWdq?=
 =?utf-8?B?dDkrVldBZzBKdEhDd0JMc29tREhFQ0hXWVorY0ZIdVdjMnVkVnBaVEIybkUw?=
 =?utf-8?B?UVcrcUx0clhzYkRiZlpZNXJjOE5WaSt3N3VacXlUMDdpdFh1S3h2WlJpVG9q?=
 =?utf-8?B?QjBUSEVXeVpPUFhUVUMyWW1Xb0NRcm1VZFE1RjI0aGgrQ3JiTGgwaWlJd0tH?=
 =?utf-8?B?dFNFWXFkUVB5OERYSWxISmtHRnlvdVVNcWh5NU8wWVUyN0FBQVQ4ZVJWZURa?=
 =?utf-8?B?UTA4SkNNdE85VGg4ZyttUC9JdGxDN0tLWE13NFpocVlpRXN4ZUhJOW42N2Vw?=
 =?utf-8?B?eUc4OHJMb3JCRCs5ZGgwdFM0eGMvQnF3SXhycEdLWUJZL0o3OVZRS0NRWU9U?=
 =?utf-8?B?aEpvZ2trYkpqY1hrWDkvZjNvQmdnVWxsby9sUk4wTGlWUENIMjhabStSM0or?=
 =?utf-8?B?ZEZCUmpWTzE4YUFOTE5Zem5KV3FFSTVlYjUxN2NnMHVuV1dnTStVUTdJaEpT?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0QLTWMLh7MHPl7kjT2KSAqVmYl7+Sj13SeXJ59AJDcDekkFauuRv1BvEFdKOAi8Eai/+DPswnqdOAk2B+iMSLs9+7RFk03tJpgNzJtQQWFAXvshwR1qSs84u+Xc8LSPuSev6RHEPZHYbiFRbJruxK3hSVLzYsIQYt3aOZK744rDt2ltCoii4VbfpnFD1LxFM4/L7gQxOu8OX/mwm71weA6OoS5+7J4Ob4V4RnTFWD6ue3u3K8oWL6vcv+HVBiK3DAKo7QhD14maajV/hQ/fPM4UZ+vKPFIzLFW8zFUnf9jr27Uz7JQ5hDH3emNSluoekzwu0ed9rTEuClxItZcyeshn+T9oY9eR0DSF4Qbi/wpzA4ZKUMv33yzW+pm6dtAUkxxcPm49BWS/ECY/To639KithevxKYSVxs4M3G2Pvosdk0hdQt+H+aj/8vbV2dWUk9tcgCaBDMD9yBYP3n/Z/XrhUlf1RWPT8YQtlOGvn4YgWErcz1tms4vlkr0w5rzxqp1C5WMj96QT0Z03kBgDWu1CTWsK4ogmCfpePv5kAgr8J0lkVqWLBpJ6gutDM4HJsAh39xBYJ8TBY2es3tQqYoXg+IZBFkBpdQcPIt8RBmDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5ed05b-0750-4a78-ea51-08dc792a517e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 00:09:44.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93O63yx2HO8d99v0oqAcr4GlSSy24OPx+fMcWezC6ybjtmvOXmAyFkHb/cvU2wTuzhYC0xPLT2718ZqO9dk0fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_13,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200192
X-Proofpoint-GUID: fcAiwg6MS2mudsksHwpztaAJEVJm-MMs
X-Proofpoint-ORIG-GUID: fcAiwg6MS2mudsksHwpztaAJEVJm-MMs

On 5/17/24 06:12, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> This test creates a small file and then a giant file and then tries to
> create a bunch of small files in a loop to exercise ENOPSC.  The problem
> is that with compression the giant file isn't actually giant, so it can
> make this test take forever.  Simply disable it for compression.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   tests/generic/027 | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/027 b/tests/generic/027
> index 47f1981d4e51b7..eace1b358cdf34 100755
> --- a/tests/generic/027
> +++ b/tests/generic/027
> @@ -33,6 +33,10 @@ _supported_fs generic
>   
>   _require_scratch
>   
> +# This takes forever with compression because we don't actually fill up the
> +# disk, simply disable it if we have compression enabled.
> +_require_no_compress
> +
>   echo "Silence is golden"
>   
>   _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
