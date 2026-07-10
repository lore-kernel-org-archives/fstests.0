Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250733260F;
	Fri, 10 Jul 2026 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710651; cv=fail; b=Zuly0+xuuCyRhwGB9JuplkVUDFXfK8mA87ce5L65feCMoLi4y1zgpUcKmCFRdkbYl2s+OVQobyqY6UrJaAobGBKmKhm7+l46NMmdEyoYWwMbLKiyTz3pkh2ZbZdOl5bJm4JzDO6JYhKWgXR3MAvFo7Y9pHg6PfkwgF19zGsaF4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710651; c=relaxed/simple;
	bh=GLM+o/A2kR9tcGvUTqYha6k1V3nvhsP//rAG67jpRis=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Or39T1aAl1qUqrlpi4PKHj0oeXXV4fvfcH92PLNxtJW5NwY+0mTi6m69d2tQ8YyueuiFXTMoeEwiHTp1wFc/B2uRhBQXBA7J5t1oXG/bvsy9kj9aW+11fj+xNWd45Eky30j+BKuvc9KLcp4FhGJz/cVG2aeK+wszt2Q8s8cBlEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tRpn0UQc; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tRpn0UQc"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AHIQUk1482369;
	Fri, 10 Jul 2026 19:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=pp1; bh=GLM+o/A2kR9tcGvUT
	qYha6k1V3nvhsP//rAG67jpRis=; b=tRpn0UQcZju9eqAKf5gRidIf9qRktCCKg
	Ifb8BV13OUom+pjYW7SIa4xkWDlnd5TTt8ZTKUJQl/p+0ztjerjcsJPFdv4zo5cZ
	yYZzbr/59s8IXKaSc7KbQvi29KZpagBLIFhWJNDq6EI+4HA94y4RPYxVsIhT7o4k
	Kyz7kyz+2EkVrNFG/dXU8KyW4Al2fT8n/pp0Pg0OC5UauriKT9jgOnWbaFgtF/pT
	uTlNN920FFmrm8w0MVy25jng0mArkPbfqX2PoiGizeezHfe76IYa/miMu512ty9v
	jzEn77a4il2cOeZt/8t2UcNAxv2or8KyL15ss4W5xr3JUV51BynWQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw58fqm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 19:10:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcam0XPVpOMXeKODnGMdWURSW3tnfibeIFZs2B1tSozgyB5T0Ycl8soBMkQwdo9iV2V/Tei+eJlATaM/SNGgWlKSUXI98pJFgsT8PaJp7ki+vPyGYtNy4yWRrGItBToH2TUW/m0Mbxt5ISLDyzWtXO4oVnUp/DYg5vNNngBNPVSijX3xlYnch6p5APotXupvADRqy3AXmB1iU7U7iPwN1LzUVnn60SNB6gXKxyACfTOtLrWJkLdLTA1he/UUK6dd9AYaBfnK+pmyesuDRT/UpPrYGFoKhbd0l9CIlB9WzT5ui+9qsKpui7TqY58Yt2gW1uJQTc8dpZDDzPwOvZl/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLM+o/A2kR9tcGvUTqYha6k1V3nvhsP//rAG67jpRis=;
 b=E/TzyDdSx5NoV/buQM5QN12Enp3n7aJ61MuWsIxbRFfsRwfYgegu4b+u1pyMY14hA3AK1a23gzgy8912fI569zAKI1VhFvr2M5WTgr76u1nAH/wuyl+pV7CJBQl8Bqx7p/hnxX80YsuJQ5qd7k6hAAsuFRRSENmjluzx4UbyrulJZp/PODTDW4FjsLEfMwgNxJTxzpmShXJSiA29IiBeVfTW3myNGPm02y3GMzrYbn6hLeUC0ZHxkUoZZ9vj4TXuDuumIlCJ7qjdJZ8RnRtAwQfLmONG4Ftv6jsAyeUIcxiveI1R2abUNHgJAQ48RCXbs/36MH8pQdnMe/NWeRqiJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 19:10:43 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 19:10:43 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "slava@dubeyko.com" <slava@dubeyko.com>,
        "zlang@kernel.org"
	<zlang@kernel.org>
Subject: Should we consider disable generic/563 for file systems that do not
 support cgroup2?
Thread-Topic: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
Thread-Index: AQHdEJ/O+lrzwUgrBUumP3Nefj9nOQ==
Date: Fri, 10 Jul 2026 19:10:43 +0000
Message-ID: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW5PR15MB5218:EE_
x-ms-office365-filtering-correlation-id: a23b44f5-35f0-4594-547f-08dedeb6f0bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|10070799003|376014|1800799024|38070700021|18002099003|56012099006|11063799006|6133799003|3023799007;
x-microsoft-antispam-message-info:
 nMTpWnzAnSk9/LFX16FP3cjgXUdFYgiGb1otsQAnUP4/UB6mwBeFf0iB53WAHHybJA/o1IV68tDjf3ASZrK2Y0/bU4AEMD/SivjsMoKMsUFKlt8T2z9rL+LYWEej6SNJrNivkobvPw2CvttXfzCXXGTUng3Jp564dwZChag1dNWgwNPtTip3g1YgeobilzBNB1w+Hd4Q695TqnZmByRMrhZ1vb0AQNbDcEhikOza3X1sHo/ZISUSC4DbVM+g6xiWlOmk3NnkZuaXvEvxq9RSPr/l3n3xqeQjz/U6x77YIKZxgcvVX7Az/frYC04yb1RF2/AQw3JrDzNTjg+835HfKvtIh571K8S5TKylVCxK4VLnw98OMV2miBhL2vRGegrc1u3CyRfwUghARMcuTXs/0nRjueL8StHBAbYY173N1eEBMSmyw1w/jW0S0DHt3e0EAksppCbpFuh6Z0bZ1FKoY4lpaQIpPqK3bx5QtV2NGxNzmZuu4fG8wGMobD/TY/Z3SHJjsVMwFSTARQZqx2xU6EFlnuCv+Zk+kDTUgwIlNZJerze9cL3YA9bxnsHSfntOPF3UmkLyrRhmjtObX49bMGsDr1ems09N9/en7U9WKhQyzGnJkjYAdb07YVcsEeHuGqrJR49t50KhUM+SroZvWlRJZf8kFUFIKvQQd6QFF3Vt+wzqenXxkyZlvw1SPDqty0fiwrLxaj4F39dOgjGVGlZO9gvJuYZnPsBSFFu8X1s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(1800799024)(38070700021)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2dSRDVjR2U4WUNlVkV3RWhMbVhBTUFZMWdkU2dFclBZTkkrejc4YlpqWjZV?=
 =?utf-8?B?VXRhOUE1aU8vSDBYditSVTNkcHFZdUc0dHVxazF6eXN3L3dIL0hNNUxRbFQw?=
 =?utf-8?B?dEdxaFJpNkQzTmRpeEVVMmpBUThJTjU4Vk9sQUNOd0VxQjh1K2h1VCt1Z280?=
 =?utf-8?B?UXRNYkUyR3dnK3l1bElOMGozdER2Y0dCSHBmUDhNc1Vqb3M3Q3N6Z2hNK3Ar?=
 =?utf-8?B?aExPeUNuY08wQm5PWFFZVVk0L1pZS09ESVlid1BNQTVtaTB3UTltUWxqeitq?=
 =?utf-8?B?ZW9kL1Znclo3aWg5QWkrRFRoQkVXaXFRMDhNT3pUeWJyT0doeHdvMGxESGsy?=
 =?utf-8?B?ZXVRMVlqckRLTDVWQ3dYVGEzako3Z0hydFlhQ3A3aHdONTNxMm9DcUdXUHFQ?=
 =?utf-8?B?MGU4WVdNUUtTekg5bjQwRnFVSTRkNms3ZGFDd0w0Y2ZSRW9FV0VqV01GeU5Y?=
 =?utf-8?B?UnJXWk9yZHEwMTJYeGNJUU5kdHJHWG9hRTI0NEM0NU5kV3AxMGJHV1V6MnBv?=
 =?utf-8?B?bnNJZlJ2VzYwOWYzWlVZUkVScXZzdDZ5RFRMK2lYWDJLQ2JkdWM1TlF3NUdS?=
 =?utf-8?B?TmVmeVZrU1V5anhPbUJkUFd3SlNxOHNsNzJpRW9ONTcvZGFhSDlEM1QzTFNB?=
 =?utf-8?B?M0tzeHJLWDN5N3VDS1pRN3ZXWlhGUFZIWmNyS0FHSjlSS0lFQnN3ZzM2SmI5?=
 =?utf-8?B?SzU4OG9TcWJMQUR2b3pqWVljRU1oOHo1Znp5SWhIdk5DVnloZFJnUGlYZ2dv?=
 =?utf-8?B?ZWdzbEVGeWY5dW9CMS9UM3hFSU53dFo0WHF4LzFXYWN2MVFoVVdXWG93UEhG?=
 =?utf-8?B?RGRMU0MyRWxnOFVZVTY4ZkFBKzV6ak5hdDZQS0FxME5TcHFMdm1WNVNvSDVy?=
 =?utf-8?B?UEJNc3ZOSGNacEx1Q2ZZQ1JpSWZCOURyQ2diQ2haU0RJellGYVBaYm4zNm1o?=
 =?utf-8?B?dUxoZWwyYVp3UnpXZytHYVVkdkN2V0padk5JRFBLTXI4c2NJakxzWGtJdzRK?=
 =?utf-8?B?OXJOamdqbVc4aDVtc2VxR3RvZXdFcEJMdnN1MHpjRHJXZUtBZHI3dllmeFY3?=
 =?utf-8?B?a0Njek1sQkNvOCtHd1BKckw0bC9jU2tWTmxvRjRSUUs5dE9pcldCM00zSHZ1?=
 =?utf-8?B?VmQ3bmJxQXQrOTFQUm5IcklCTG1IZ0hLUmdoaVdQZzdNWEhSRTY5TENndzFC?=
 =?utf-8?B?NWZhU0dYcDZMd1hvbStFemJxNnJIclBlQjNVc2Q5eUJySmExMDdjTTQrZU9U?=
 =?utf-8?B?MElqRkhtR0hDWnpSUjFFQVZpWVhGSnk3NFliRTNNL1RlVGJhVUFCeVZTZFdF?=
 =?utf-8?B?Zzl6cjlhcGRmUGpDTHBtTExMNGQ4cnZjRlJ5YW0zNVdDZUFrdGN1b1duaFdz?=
 =?utf-8?B?Nm9DRXhXNVNCcG8waEZFdDhkN2JRdVVZa3hmZVgrVTBnL2xhUkh4V2s5eWZK?=
 =?utf-8?B?bk5rU2MrZG5SdWdydEptK1BQQTREMmN1VC9LeFNjN29CMzB0M2RNWHdNVXVt?=
 =?utf-8?B?aWVGNkNSN0luYUUyYjRlVk13L1hLR0VTUHF1bmhmU2ZFbkRHMVord01sT09I?=
 =?utf-8?B?TWNQTUN2UW92V1hhS0RUVGFXa2dFdTZVWkNEQUpBaEpSWng4NFVLc1hXd3kz?=
 =?utf-8?B?WTBCTklMVVdSSW4xTTlYUEFqUG55NVltK2xya01scERnM0l2Vk1wM0ZXMmh6?=
 =?utf-8?B?SXM0a1EvcjdMRmJVQVpHaWhmblFFWTluL2MyN2xkVTdRMkNITUJyTnJOM293?=
 =?utf-8?B?MzZ4alpPMUNKNEVUcDk1WTNwMDlieXdQVERyQlVWTUt3MUpDWmtZak5lbW9r?=
 =?utf-8?B?dDRsUWZFSUJ6eWg2bDdzU1lvYjV1RWhpQTUxUkJIbmcyb2hwZmQxM0YzMk05?=
 =?utf-8?B?VmZtMWtBbnVFWkNsZW9VcU1aNU0zQmlnQlAxakYzMGJkelM4ampUT0tpNm1Y?=
 =?utf-8?B?czJrL3ZycFNBelNCdkxuUzZxZDFtQXQ1V2E5ekpOZkR0RlYwaUZsWEtoL29E?=
 =?utf-8?B?a1JqSGRnK24wUXBQVElBckx5RzdoS1pweDdWd3dadEZSclBmSHN2bXd4RTR0?=
 =?utf-8?B?bVNUVjAwdVdES3d2Qmt1aHZLN0dJSnRVenRKOFM2VjhIbTZhdXVCTXgrbU1T?=
 =?utf-8?B?VllVS0lVaGs2bDFlY1FoMkJaRitYUSt2ZXhjc3lLWFY3VW4wa3FsKzVzd2Rt?=
 =?utf-8?B?cVR5WVNmU1JtN1hPcXZ5N1o1ekJtZVRmQUMvRlgzUmFBMXhKb0N1SDZLV1Ay?=
 =?utf-8?B?bTJwRS9aU01rZTlMemdFK0pwM1lFUDcxcFVmSHZubTdkTzQvN21pWnB4cTMx?=
 =?utf-8?B?TkVEUDB1ZngvMmhYR3grOW10MjNGOFdoNW5aVTVaUm5sa2dXcmExNW11dFd6?=
 =?utf-8?Q?T2M08XmwOEvh3GbWbbBCzWR8KmlYwtEh2lykP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8962CA49CAD94439B4DCDF2E125209D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AXCZx4bmlvqJFcOBORuGwXp9rc8E+q8iXSto87wq4UopyNToBNM4clrH3GL1uUFfJ1fH26ZvtOS6hRyOm2hU/8x/LZypBdlsFLGhdVISBXyg5vskuc+m4Nkmr17659QlPWvhduUPLupM/14Dj4BjIIZ14cy/SImszIFTf4/KcqAoCuC1yGXYihvPEQy4ahzq1VCH7hp6QaNARfrztEt5MEKBEAnc1WX5LVwlXbZZaoYmqcepY6P2A5HEQJQDkWsiZJzGklNQ5XLYVDNc+KOgefILmY5wuivsrqsH4f34m9qdS8zmWhAT2ONcHObHixoOjBZq6wBXl5iVzO+TIr/B2w==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23b44f5-35f0-4594-547f-08dedeb6f0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 19:10:43.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDtvcCF9dKM43JmIg8OgtL52+KsmczmLEx3K3LKQBs7FjS1iMvRiqBsTMmLACkNJiUiEylaKZM2tUDPAArmPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5218
X-Proofpoint-GUID: 7G6nQDOp41EjqBRSAN9OVNNBFZIgBpS_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX/sMPWmhgE3CU
 F4VokmzuUMDMxolzkMcNWt7dGqBh/SJf/9UesQL36bj4HtPO8kJhcc18C5A5coG5g8RWaYaG3N4
 eMwX/lxL5NIxxCVK4KI4Tes+MOD62RNN/eL9gLG1ZEZgpyDH7SU3+0q34eqozc/2Ogz8bg0QTli
 gvtio5z/WimjnqH9q7Yj54q5QKwMMwrKmv6oOdxzD/Tx1c7/IVcAyY/+xoGJ6kANGNcBkkf5i6x
 NfcIhyF0w4xCsw0HP++ysURqinjVI6oClgk26zcMosmjhQYbzKh1WD7hIw/ENeAoQUX8QyCtQoO
 FDXvMmW4gO7d28vyxApBayn1EeXrj1kQH/qnxtxdWtSRaA0I96XOwpy8P9RPTplweR7YJ0JJpBM
 rtDd1q6yU6Fc26+Kcx8ZBT5kJclektY5a+kfObGm1ksGjEv/7JXyv46mYDmIuw2Eum8eio9XkmK
 AePHmdBpYVDyC3KxJ/g==
X-Proofpoint-ORIG-GUID: 7G6nQDOp41EjqBRSAN9OVNNBFZIgBpS_
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a5143b7 cx=c_pps
 a=cLTib2BoJD1e+Gs0wkBYAA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=K24tBCbv3-QYUbuk:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Ti9n-hIBJIIOhUXgKzoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfXwPQQ2Jyn9OPV
 hxOmkksMPxsnVxniei7wugWBYNVGC7cAzFPZ/G4vKmsgumehG7bbKHT0dPgoadvf0dNerVjlwTo
 9YdJ2udhdpApAVrEXebaF3dfdmNK0fg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100189

SGVsbG8sDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZSBnZW5lcmljLzU2MyB0ZXN0IGlzIGRl
ZGljYXRlZCB0byBjZ3JvdXAgdjINCmZ1bmN0aW9uYWxpdHkuIEFuZCBzZXZlcmFsIGZpbGUgc3lz
dGVtcyBmYWlscyB0byBleGVjdXRlIHRoZSB0ZXN0Og0KDQpzdWRvIC4vY2hlY2sgZ2VuZXJpYy81
NjMNCkZTVFlQICAgICAgICAgLS0gaGZzcGx1cw0KUExBVEZPUk0gICAgICAtLSBMaW51eC94ODZf
NjQgaGZzcGx1cy10ZXN0aW5nLTAwMDEgNy4yLjAtcmMxKyAjNTUgU01QDQpQUkVFTVBUX0RZTkFN
SUMgRnJpIEp1bCAxMCAxMToyMTozOCBQRFQgMjAyNg0KTUtGU19PUFRJT05TICAtLSAvZGV2L2xv
b3A1MQ0KTU9VTlRfT1BUSU9OUyAtLSAvZGV2L2xvb3A1MSAvbW50L3NjcmF0Y2gNCg0KZ2VuZXJp
Yy81NjMgICAgICAgIC0gb3V0cHV0IG1pc21hdGNoIChzZWUgeGZzdGVzdHMtDQpkZXYvcmVzdWx0
cy8vZ2VuZXJpYy81NjMub3V0LmJhZCkNCiAgICAtLS0gdGVzdHMvZ2VuZXJpYy81NjMub3V0CTIw
MjYtMDQtMDcgMTQ6MTk6MDQuNzg1MDc5OTQwIC0wNzAwDQogICAgKysrIHhmc3Rlc3RzLWRldi9y
ZXN1bHRzLy9nZW5lcmljLzU2My5vdXQuYmFkCTIwMjYtMDctMTANCjExOjMzOjE0LjIzMTU2Mjk1
NSAtMDcwMA0KICAgIEBAIC00LDExICs0LDEzIEBADQogICAgIHdyaXRlIGlzIGluIHJhbmdlDQog
ICAgIHdyaXRlIC0+IHJlYWQvd3JpdGUNCiAgICAgcmVhZCBpcyBpbiByYW5nZQ0KICAgIC13cml0
ZSBpcyBpbiByYW5nZQ0KICAgICt3cml0ZSBoYXMgdmFsdWUgb2YgMA0KICAgICt3cml0ZSBpcyBO
T1QgaW4gcmFuZ2UgMTU5MzgzNTUuMiAuLiAxNzYxNjA3Ni44DQogICAgIHJlYWQgaXMgaW4gcmFu
Z2UNCiAgICAuLi4NCiAgICAoUnVuICdkaWZmIC11IHhmc3Rlc3RzLWRldi90ZXN0cy9nZW5lcmlj
LzU2My5vdXQgeGZzdGVzdHMtDQpkZXYvcmVzdWx0cy8vZ2VuZXJpYy81NjMub3V0LmJhZCcgIHRv
IHNlZSB0aGUgZW50aXJlIGRpZmYpDQpSYW46IGdlbmVyaWMvNTYzDQpGYWlsdXJlczogZ2VuZXJp
Yy81NjMNCkZhaWxlZCAxIG9mIDEgdGVzdHMNCg0Kc3VkbyAuL2NoZWNrIGdlbmVyaWMvNTYzDQpG
U1RZUCAgICAgICAgIC0tIHZmYXQNClBMQVRGT1JNICAgICAgLS0gTGludXgveDg2XzY0IGhmc3Bs
dXMtdGVzdGluZy0wMDAxIDcuMi4wLXJjMSsgIzU1IFNNUA0KUFJFRU1QVF9EWU5BTUlDIEZyaSBK
dWwgMTAgMTE6MjE6MzggUERUIDIwMjYNCk1LRlNfT1BUSU9OUyAgLS0gL2Rldi9sb29wNTENCk1P
VU5UX09QVElPTlMgLS0gL2Rldi9sb29wNTEgL21udC9zY3JhdGNoDQoNCmdlbmVyaWMvNTYzICAg
ICAgICAtIG91dHB1dCBtaXNtYXRjaCAoc2VlIHhmc3Rlc3RzLQ0KZGV2L3Jlc3VsdHMvL2dlbmVy
aWMvNTYzLm91dC5iYWQpDQogICAgLS0tIHRlc3RzL2dlbmVyaWMvNTYzLm91dAkyMDI2LTA0LTA3
IDE0OjE5OjA0Ljc4NTA3OTk0MCAtMDcwMA0KICAgICsrKyB4ZnN0ZXN0cy1kZXYvcmVzdWx0cy8v
Z2VuZXJpYy81NjMub3V0LmJhZAkyMDI2LTA3LTEwDQoxMTozNjowMi4yMjEzMjAyMzkgLTA3MDAN
CiAgICBAQCAtMSwxNCArMSwxOSBAQA0KICAgICBRQSBvdXRwdXQgY3JlYXRlZCBieSA1NjMNCiAg
ICAgcmVhZC93cml0ZQ0KICAgIC1yZWFkIGlzIGluIHJhbmdlDQogICAgK3JlYWQgaGFzIHZhbHVl
IG9mIDIyMDE0NDY0DQogICAgK3JlYWQgaXMgTk9UIGluIHJhbmdlIDE1OTM4MzU1LjIgLi4gMTc2
MTYwNzYuOA0KICAgICB3cml0ZSBpcyBpbiByYW5nZQ0KICAgICB3cml0ZSAtPiByZWFkL3dyaXRl
DQogICAgLi4uDQogICAgKFJ1biAnZGlmZiAtdSB4ZnN0ZXN0cy1kZXYvdGVzdHMvZ2VuZXJpYy81
NjMub3V0IHhmc3Rlc3RzLQ0KZGV2L3Jlc3VsdHMvL2dlbmVyaWMvNTYzLm91dC5iYWQnICB0byBz
ZWUgdGhlIGVudGlyZSBkaWZmKQ0KUmFuOiBnZW5lcmljLzU2Mw0KRmFpbHVyZXM6IGdlbmVyaWMv
NTYzDQpGYWlsZWQgMSBvZiAxIHRlc3RzDQoNCnN1ZG8gLi9jaGVjayBnZW5lcmljLzU2Mw0KRlNU
WVAgICAgICAgICAtLSBuaWxmczINClBMQVRGT1JNICAgICAgLS0gTGludXgveDg2XzY0IGhmc3Bs
dXMtdGVzdGluZy0wMDAxIDcuMi4wLXJjMSsgIzU1IFNNUA0KUFJFRU1QVF9EWU5BTUlDIEZyaSBK
dWwgMTAgMTE6MjE6MzggUERUIDIwMjYNCk1LRlNfT1BUSU9OUyAgLS0gL2Rldi9sb29wNTENCk1P
VU5UX09QVElPTlMgLS0gL2Rldi9sb29wNTEgL21udC9zY3JhdGNoDQoNCmdlbmVyaWMvNTYzICAg
ICAgICAtIG91dHB1dCBtaXNtYXRjaCAoc2VlIHhmc3Rlc3RzLQ0KZGV2L3Jlc3VsdHMvL2dlbmVy
aWMvNTYzLm91dC5iYWQpDQogICAgLS0tIHRlc3RzL2dlbmVyaWMvNTYzLm91dAkyMDI2LTA0LTA3
IDE0OjE5OjA0Ljc4NTA3OTk0MCAtMDcwMA0KICAgICsrKyB4ZnN0ZXN0cy1kZXYvcmVzdWx0cy8v
Z2VuZXJpYy81NjMub3V0LmJhZAkyMDI2LTA3LTEwDQoxMTozNzo1Ny42MzMyODA3NDMgLTA3MDAN
CiAgICBAQCAtMSwxNCArMSwxOCBAQA0KICAgICBRQSBvdXRwdXQgY3JlYXRlZCBieSA1NjMNCiAg
ICAgcmVhZC93cml0ZQ0KICAgICByZWFkIGlzIGluIHJhbmdlDQogICAgLXdyaXRlIGlzIGluIHJh
bmdlDQogICAgK3dyaXRlIGhhcyB2YWx1ZSBvZiAwDQogICAgK3dyaXRlIGlzIE5PVCBpbiByYW5n
ZSAxNTkzODM1NS4yIC4uIDE3NjE2MDc2LjgNCiAgICAgd3JpdGUgLT4gcmVhZC93cml0ZQ0KICAg
IC4uLg0KICAgIChSdW4gJ2RpZmYgLXUgeGZzdGVzdHMtZGV2L3Rlc3RzL2dlbmVyaWMvNTYzLm91
dCB4ZnN0ZXN0cy0NCmRldi9yZXN1bHRzLy9nZW5lcmljLzU2My5vdXQuYmFkJyAgdG8gc2VlIHRo
ZSBlbnRpcmUgZGlmZikNClJhbjogZ2VuZXJpYy81NjMNCkZhaWx1cmVzOiBnZW5lcmljLzU2Mw0K
RmFpbGVkIDEgb2YgMSB0ZXN0cw0KDQpTaG91bGQgZmlsZSBzeXN0ZW0gKGxpa2UgSEZTL0hGUyss
IGZvciBleGFtcGxlKSBpbXBsZW1lbnQgY2dyb3VwMiBzdXBwb3J0IHRvDQpwYXNzIHRoZSAgZ2Vu
ZXJpYy81NjMgc3VjY2Vzc2Z1bGx5PyBJcyBpdCBnZW5lcmljIGVub3VnaCB0ZXN0LWNhc2U/IFNo
b3VsZCB3ZQ0KY29uc2lkZXIgZGlzYWJsZSBnZW5lcmljLzU2MyBmb3IgZmlsZSBzeXN0ZW1zIHRo
YXQgZG8gbm90IHN1cHBvcnQgY2dyb3VwMj8NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
