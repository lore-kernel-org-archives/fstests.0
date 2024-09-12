Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D463CB
	for <fstests@vger.kernel.org>; Thu, 12 Sep 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120406; cv=fail; b=Ij24TwdX8hCV1RwD6GPyz5+NZzaGPMADgxDtSWCR3GOASeJfnBmNu9vum5GEwBY4mxEquFUK9ZFQ8607P5HIJdVBdwsS9HIXaFUcKAbXT/jDwlVh1QGOTbwcQ+e9FpdIQbjkQ1i7h13qBYI9CccA45/Gzk5qn/XgZ0pFFqUGmI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120406; c=relaxed/simple;
	bh=OuHUPo7kEFh05b0Vfo92nsUkce/qImUzWOWCfFyVd+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ggYLCWDVGI/3iLzlezChXFPqBOP98f8voI6q26fEQcW1mFlppTCKU4wtjXcMcrbxs3JzPEbfKSGOy7wLrvA7MJncFOFtPgRK50Mpg0qpdrduM0xmkj/hMoTKa6QLLm12BRspf01R4MCHlkDSz0SWu3IAqNLA9KExspMcsZzYWBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V4lBKlNj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wMDe0lFp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V4lBKlNj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wMDe0lFp"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BMfWci020062;
	Thu, 12 Sep 2024 05:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=42UCg9m6epIWO7xvXP+9vb4CzXWHG/jmc7NAot7GYYA=; b=
	V4lBKlNjqKx0zht30hWn36T0i9GVqmQOnDbxr3mDEMjRBxDDyg9VbCMB9gaZbVOT
	RHtOERKV+ciphM4OnStQutfuq39xDCHa5jDEj4FVpBRa7uCX8aGC7XZkshmlUDaF
	Jd7jHe5NiWtMnxLv2kTToqgDexouDcQ+wRzcNWR2IbpbCn6eEq+elBxX24BTA3P3
	MXZbFbW6rHOgRbvexg546zFwHlnV3yaSu2m1KvmOaZbfIYr0h0NVLnPwLPAouDRu
	T6UTMrcTqAmwTJCP54JSgAVCXjeZZg3ZBOJJChy3dYg6Glt3qrrz1STfR6/YWSK3
	JEh6CrfDafEAn8Spu+ZfSA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gde09w7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 05:53:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48C3UXFo034216;
	Thu, 12 Sep 2024 05:53:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9bb5tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 05:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBsTGh+aZfqgDCmQSRa79tE/7O91KFYIG1xtx6sq/fAwdaez5oqPyjjacDwmzo1iMR2pyB9ig6R6t0Sffo08dd/IM8IMK1SzBCJiC+QmWt/thzNd1g5tW0gS0XvJyzi4lY8VmcrR5iFZI1AjNQgV7n93DafXDdFHlBG6uGxLAWQFHBzHZsGTKzK5Jr0qvZaaUeGe1u16+9ZINYSdxbY+O7kP1EhDjIKieKORNzBz9JCTaggqQlNEKBMWgryaUuv0BtuOFuhFLsf5V29LbQH6r2Dj2i42NdV6xUn4+C4b7Ampi+44LLQIu+Hejt5gfv61z1F5HpT4Lv4MyfWy0SCaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42UCg9m6epIWO7xvXP+9vb4CzXWHG/jmc7NAot7GYYA=;
 b=yx88H/4yie4yEKXN5O3lH4nym82+DMb1ErNog+PeDOHAATV81zDM15D5h/no+wjgYmSeaWb/pWvvQXNUu2Q8DdXhD+QDNkwO3liBkbStnQTpBY77MxFMbLxZcqsAoG5UkbS8tFXB6Dds7UgLFyDOf7v3IS/etu3xTD/wbyWZNkxyIWnay9XQNvhIwwU/ghI1NyXmDXHfo/C9Dd3+sF3a4zaW8PAdhMvVa9KTYJlqanwFBTG8O9cN6Tj12M9gmSzvEMO0dYtwZ8mI2WHvSkR3D9YwIhXuN2JtmS8PkWxUrZQMuONH3KnMfA4BPAKYz8v7dlPqU4RMhxR3kfMRiXP28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42UCg9m6epIWO7xvXP+9vb4CzXWHG/jmc7NAot7GYYA=;
 b=wMDe0lFpvech81Yq5ayhCSmzHJBeE5lUMkvLlXYuhrjFZZ0f2Ct/qDYPOZkrKnkoqmIGKt+2iF/Fmj29eg/29T8T8AoBWcu37KUyQOFqfBuSlMqzCaiKvGYEKFa+UtEN+igXnWpZVfHMk2cg49Bz3dcC/zrn3Uj4uavqxJKNc/M=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by IA0PR10MB6747.namprd10.prod.outlook.com (2603:10b6:208:43d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Thu, 12 Sep
 2024 05:53:18 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%4]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 05:53:17 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: Zorro Lang <zlang@redhat.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>
Subject: RE: [External] : Re: [PATCH] ext4: Regression test for corruption
 during on-line resize
Thread-Topic: [External] : Re: [PATCH] ext4: Regression test for corruption
 during on-line resize
Thread-Index: AQHbBEo0MBQpzMClx0yHgrbqKHh3h7JTpl7w
Date: Thu, 12 Sep 2024 05:53:17 +0000
Message-ID:
 <DM6PR10MB43477AC7B8B80A38A7155898A0642@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240911102045.71870-1-srivathsa.d.dara@oracle.com>
 <20240911125734.44wtifmoyvd74ptq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20240911125734.44wtifmoyvd74ptq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|IA0PR10MB6747:EE_
x-ms-office365-filtering-correlation-id: bd6130cc-36e2-424f-cd68-08dcd2ef331d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cYWpK74DWvjIkxxCVIn4D33fr5xklrLlanECThLywyqo9xCi3qWfTsyy4vLe?=
 =?us-ascii?Q?JmG/1PoGG1W/f6XAz5/CPMe6t9ygIgl5fhHzML7RMuFeJBfoipIw/pEOZTEi?=
 =?us-ascii?Q?YiAX768pxGt4ptfCEZUtZFSPlYQyIjyR358O+5q+29UHeSObN24AdF2oOXrS?=
 =?us-ascii?Q?VfVMbuAbEfB9prYdKGtRNJIQ3Gy4jfmURymqio1j3sLct77X3MaiJdXyYDAv?=
 =?us-ascii?Q?CL8mA9+yTM37sF84OzipN686ZKlrKfn1ho/TEb1ZIR9fbqX7itg/vjK6JRS6?=
 =?us-ascii?Q?5Kd96eBVqWApBgpkQGKcPQGeWo6wiZ5IMm3wI8jV+1V0WDEIGqtkaWLJ4hfL?=
 =?us-ascii?Q?VlMgZatXRzZ2+UXRdUbrL+oHboV46j/IvDXgYiOG1DBZkht9VwLRVCSfCxFE?=
 =?us-ascii?Q?VL4c3EbZWHOL3AilfJwFVDGt15oa+5SJfBAJlop5atLfYv30IDxrOYGyLAXt?=
 =?us-ascii?Q?sgYQcWAq/t1AwwFiOtgK53FkvKqFtnRw9kIDLysz/ICiYeqadGWCAX+VQcCm?=
 =?us-ascii?Q?Z+inq36UjW+kASdSNi58J8mR9WcvgrJIiiU9ipYoYUIwWg+ulumjqO+3ZBQI?=
 =?us-ascii?Q?bFCTbr4ljkAzTG/bNjypdYtfUOv92TO7Y/iOGLuCOnRhoC043l85c7m3Rlcu?=
 =?us-ascii?Q?EC51+jBmG3OHX+wxTDpvdnY8bMK/ZJrZvvzXYuWQ7KTrWtAYlHa7IIWtVIMA?=
 =?us-ascii?Q?cwbikeVwbYHlYnAgwjbV6GxauGvKO3JOB8Y2jV+b86aCe/akUOyvMfrwuMxm?=
 =?us-ascii?Q?dAHETwxhtDbndN6rkmPpq4SOql2zeL/W/lOU9hYZBSoIKJsnmwKaonpOPHft?=
 =?us-ascii?Q?XXMQxhiiMNV7YRRbS/nZNjObD2vQzrNDg343b7B4NuvuuG8olx7Y+JDr2Sxg?=
 =?us-ascii?Q?yBSYZXiGbZZnu1rrEWBYVn3Wq81Y0qMDQoeREw2lim4hU5goqdpckpGogHUi?=
 =?us-ascii?Q?CH9QCPN0s08GdbkEl2aYvcZujMjNr0sc3d0IMpPUNQL8ucVlzbvnl5PIrw2+?=
 =?us-ascii?Q?QcNiO3xQZOSwZsSR4vqOe4+VTCEOi0mHXLOqaRGVXHEN+iQz4FRIep2SdmN/?=
 =?us-ascii?Q?8cM5GXmMnEc6sqe8wxuLk6uDeXpemM+nMYr9ZyzysRj1XfzQae51HoDXeSmU?=
 =?us-ascii?Q?kssULIZdq5/Er+DhB7uA6irZMxEaRQoTjn+SNcspevGHYQr//sdOqLThMsj8?=
 =?us-ascii?Q?p20zPmhjUHn9HwS/WXrwDjuKi6IWLTFdp9Z7Scpq/9rUjI5vop5BSeiR8k4N?=
 =?us-ascii?Q?lfCEDNo/98Q2qfxtTBDs3+pHTCyx/ajLHcEcDQyDynsjuSWlOmkNztRfqQGN?=
 =?us-ascii?Q?vtTnLwXl+w4qBwSTQQ6XoaapxYhH+QeujUBFgjvijmSSpIxoLYvfGlT1ZCi+?=
 =?us-ascii?Q?sPQHIEzsG6FVA/awrHEb4BRtvo9kHrE15Knhs2CM9YlzxJMq6g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yx0M0mbzaa63eDiCn4Dzlqf5+3u7tUZaFZp+fPHsJQkGP6ELkrrRCXdtIVjK?=
 =?us-ascii?Q?kXPok2oLpj/q2C3v5wXwDuxiUaisphcrtsrgG2/gPGLdj82xQ5HdaQe6wnpd?=
 =?us-ascii?Q?ErDPjgYMYBikGtqW3GsCnMU1UkZqHHYfXp0HRxrzqZRXKxtsfVmhGbPpPUAz?=
 =?us-ascii?Q?L+H9XpIp5zfl0cV33dhYIopeU1HoxRdFttzdMRZy8q+D6PoILPTTRU3SaJPW?=
 =?us-ascii?Q?Rmg2y/paSwjhK+T7/2EW7xJx/xyUdEH76ErtVADqHEdJLuaTsQeAU18e7zpE?=
 =?us-ascii?Q?c56EOxaHuSd7WXh+0XMXzBLR6fYgKSv08N+gLpQAeqGQcN5p85XuKVMTFNa8?=
 =?us-ascii?Q?V/EaE/m8P24GctOrkje0Sbd0o8oWJ6HtIXCAT3rGEBwrjF3d3hIUfv/oZkqD?=
 =?us-ascii?Q?jAuIahoCva16A6q+xckrJMKvNl7rYygveZvck9q9fyThuVNpwHbMBW80KEzF?=
 =?us-ascii?Q?EtdeboYN+tFKJU26inJEY49ISjkQ2h5LxQ4cXU1WybcJvHD8DBq/cQRWsSU0?=
 =?us-ascii?Q?y3bd/IUXh034jcYW3Qd5WYiX2BndlpV2Obgzcy/pN/eqV8wPysfSR5/jM7Dy?=
 =?us-ascii?Q?xJ7yh6bGyHHrA9nroNV0tCGjsQDgMkVQBGzpPw++1KQasJFC4GhCe55wowt7?=
 =?us-ascii?Q?AFWkqK2MOnag5KYVyuH+6BsOvCbTO2IWqVw6+mojeulKeCLbe69F+sJVvHkD?=
 =?us-ascii?Q?qR8JAPemexNspcybU2fG7C5jppJWzI7Bv7PUgg1zO7PC60R0l9Mp9AJDZdPa?=
 =?us-ascii?Q?gelUjma4VcHLep5eremKbrvxyRQLAvSZ0ITw3qWHdw0BZN4f+S5e4JpYehtI?=
 =?us-ascii?Q?912YzzE6DGzAzBiT3LNr9VRbui8EKvzwta0TG/y/Vn/gf804IEATctjPZ74W?=
 =?us-ascii?Q?Y2LxL3ho0/bZnG6UxsYhqNaCu9g1cSD/tP/Ubca1ZhfLkEjsIvARbDqxL/Ec?=
 =?us-ascii?Q?oqLMNgb3l+PFe6VR0CT/a9CmxxoQBjWQOLE1pX5VnEhL7A77MNeXCLe3XT4i?=
 =?us-ascii?Q?UOJiqRrFOkvhlQ1iUl+lB+dqpTfmQMiujZbZaI8+ztX0qjJJBQn199Y9v9sG?=
 =?us-ascii?Q?0Nxprq53Nu+qFd1k9iNW1wBzVXwQji5h/GYruSHDazdg+8TJKrDTIxfCyrYA?=
 =?us-ascii?Q?1fk0GmSC8545WPjLnOZkYQ/Ev+s0dyCmNhq7TvX1+e2A2AbhGV88esXATRUE?=
 =?us-ascii?Q?BTN754zXimBSsT2fA2aIphPllZkwAei2qhzMgetDW+9kck0M89LwylolyjH6?=
 =?us-ascii?Q?/Unn6hcS++VPKtt69W8BSAJIse/SZnf22J2I0uP4VXTbGlAEi1tRbjmWtdj7?=
 =?us-ascii?Q?pNpNUuLL4A8GO9k9EoNgkgG2aNFQm5RBRotZ9/syQYr1/flUOHld6uWIEp+M?=
 =?us-ascii?Q?9BUhVZBx6HdEtHQmrZOZLgqsXW5YDKKLFgBwo+ygeN4L7smncJSPhHcfFq1p?=
 =?us-ascii?Q?wlzNG0uBEZ/aRqyKl3oIq5aoTt+yMzf6oGc6T0AYMhQhYx/zyzn2XvToiWpC?=
 =?us-ascii?Q?k9DpDvQVpDwOFq0pzHl1vKJnVUzgmWzA6vRTU1VKDg8NNn9RCLvqRwxEF1cx?=
 =?us-ascii?Q?KEQpOLvLWx1jiwezlOLeA8yARV99CguewllAcTthOJ8L7BmgWoXB/3KvF03t?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TpWKVq7gpePOkuS/Cr+e/ZKk3OJEmaz75ehC9HUM3C/MjkfJG1jAesT31Ahmvf7lBSGEG+KNlnFUucfoJJHKkTwVezAkZHGA/74l112z/MUFr6fd+vwfsHeqf4+Zk6IsMXGeMXs1Ft7l6HQXFJNkA/NX/FJkcUc/MVdmRRPUYMbzaFvV5begI9HrbxD138EZ7ODZdnpx20HwG6W3Dz7MIGFt+v3H8zV/h+iQ8jBBSrckJrSbsKeSma2kuAbWq/wb4riTL1Q77h9GxtA50d9AY1f44M5Ml5Zbew2IEW1pkHM4xi67+PesnVqzDtlPQjFf5XUfF4nby9GLs6hcQ92DJZPuTENs71+4tiUxufBIs2tQ/yzJ8vPNI8rV2T4Zgfz+rPQ2ex3hcwRJ5kbh6Y5F87GK7iZ5srKu2W5sjxoUVLSvnuGXiEfPM8FJkEyJFt06WFLKi2kii2SRaZNGMkqD85/09oYH3uYDMJAUPwhg4MTYvs+fw/Pm9w8muNNhOLaUx4DiJc7MZ4zvwEDTeG3HxLwYNrHdyQ/c1fDyooV+sKybPnYAiKVljFZYniB9Y6qQsO0ar3qsuY8cBAQ4TNsnBLhOLa0ZnBiHTnnQtTFr1HQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6130cc-36e2-424f-cd68-08dcd2ef331d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 05:53:17.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JFOQaKJSSCSiwMmppFYCuX0WlIi873sHRoeosSjCCkePjchZfjA+zFeA6p9mwGnVa1WAnfySPnnq5MvjY5x0VeHE0lAx88CkHJfNnL9Ruk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409120041
X-Proofpoint-ORIG-GUID: m1fOvY08RQ_AO9FVjhJFxu510deI4SqE
X-Proofpoint-GUID: m1fOvY08RQ_AO9FVjhJFxu510deI4SqE

Hi Zorro,

> > Regression test for:
> > 	a6b3bfe176e8 ext4: fix corruption during on-line resize
> >=20
> > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > ---
> >  tests/ext4/060     | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/060.out |  2 ++
> >  2 files changed, 45 insertions(+)
> >  create mode 100755 tests/ext4/060
> >  create mode 100644 tests/ext4/060.out
> >=20
> > diff --git a/tests/ext4/060 b/tests/ext4/060 new file mode 100755=20
> > index 00000000..440748ea
> > --- /dev/null
> > +++ b/tests/ext4/060
> > @@ -0,0 +1,43 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> > +#
> > +# FS QA Test 060
> > +#
> > +# This test ensures that kernel avoids FS corruption while online #=20
> > +resizing an ext4 filesystem with disabled resize_inode feature.
> > +#
> > +# The commit a6b3bfe176e8 ("ext4: fix corruption during on-line=20
> > +resize") # stops the corruption.
> > +#
> > +
> > +. ./common/preamble
> > +_begin_fstest auto resize quick
> > +
> > +_supported_fs ext4
> > +_fixed_by_kernel_commit a6b3bfe176e8 \
> > +	"ext4: fix corruption during on-line resize"
> > +
> > +_require_command "$RESIZE2FS_PROG" resize2fs _require_command=20
> > +"$E2FSCK_PROG" e2fsck _require_scratch_size_nocheck $((9* 1024 *=20
> > +1024))
> > +
> > +# Initialize an EXT4 filesystem with the resize_inode feature=20
> > +disabled, # and a size of 128MiB less than 8GiB, i.e., short of 1=20
> > +block group in # an 8GiB filesystem.
> > +
> > +dev_size=3D$((8* 1024 * 1024 * 1024 - 128 * 1024 * 1024))=20
> > +MKFS_OPTIONS=3D"-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $d=
ev_size \
> > +	>>$seqres.full 2>&1
>=20
> Just for sure, is the 8G fs size a necessary requirement to reproduce the=
 bug?
> Is it related with the block size (e.g. different blocksize need differen=
t fs size for testing)?

Yes, the issue was that, before the fix, while performing an online
resize of a filesystem with the resize_inode feature disabled, the
kernel would corrupt the first block of the last group in the 0th meta_bg.

If the block size is 1024, each meta_bg has 16 (1024/64) block groups.
The last blockgroup of the 0th meta_bg is 15, and the block that gets
corrupted is the 122,880th block, which is the first block of the 15th bloc=
k group.

If the block size is 2048, each meta_bg has 32 (2048/64) block groups.
The last blockgroup of the 0th meta_bg is 31, and the block that gets
corrupted is the 507,904th block, which is the first block of the 31st bloc=
k group.

If the block size is 4096, each meta_bg has 64 (4096/64) block groups.
The last blockgroup of the 0th meta_bg is 63, and the block that gets
corrupted is the 2,064,384th block, which is the first block of the 63rd bl=
ock group.

The corruption occurred because, when updating backup group descriptors,
the kernel failed to check whether the group descriptor being updated belon=
ged
to the meta_bg layout or not, leading to an incorrect block being updated.
Hence, the corruption.

To reproduce the issue, the initial filesystem's descriptor block must have
some available space, and the resize operation should increase the filesyst=
em
size enough to cross the meta_bg boundary.

In this case, the initial filesystem size was chosen as 8GiB minus 128MiB,
so that its descriptor block has space to accommodate an additional block g=
roup.
The filesystem is then resized to 9GiB ( 8GiB is the meta_bg boundary).

>=20
> > +
> > +_scratch_mount
> > +
> > +# Perform online-resize
> > +$RESIZE2FS_PROG $SCRATCH_DEV 9G >> $seqres.full 2>&1
> > +
> > +$E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "Filesyste=
m corrupted"
>=20
> Do you want to test online resize or online fsck or both? (Does ext4 supp=
ort online fsck?)

I want to test only the online resize. No, EXT4 doesn't support online fsck=
.
However, e2fsck with the -fn option reports corruption even if the device
is mounted.

Thanks,
Srivathsa

>=20
> > +
> > +echo "Silence is golden"
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/ext4/060.out b/tests/ext4/060.out new file mode=20
> > 100644 index 00000000..8ffce4de
> > --- /dev/null
> > +++ b/tests/ext4/060.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 060
> > +Silence is golden
> > --
> > 2.39.3
> >=20
> >
