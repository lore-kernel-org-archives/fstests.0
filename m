Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DED41DFCF
	for <fstests@vger.kernel.org>; Mon, 16 Sep 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497224; cv=fail; b=C/8ESNJsnm2eojVlEBsxE15Yyy5aLJiJK0XNHLwPVKB/NBey5tI9s2WuJiUQQv3Zb7oAUL6a3cPjC9hTBNSVkKML8wi/TNNO9KoV73aX0cuK8iLsh9bbI8SJ3kvoOITttsQrcUGPNmKGJY9ySVmX/CGwCj+32NDq2+qTYjl7U5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497224; c=relaxed/simple;
	bh=Ctu3Tqgdz3lhVtIsKe4JOCSnXvp3wyhbrFXlAeucmQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JGr+lOkVzmt5Ew6tFlluexUcv7MkVQNxZMNH+6RQhi0pcSeoIploB2Geq/Po7Qe0+wk1CetqLNOnpWnpWJeAODz53lKk0aiLfYAc15zuj5+QXTphNe5GTgil3PUpGwzf6lvpWDhRT6tjH4K6iZeTFMiVh08rfH2OR+h02iEfiRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FffCx9ca; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=srI20osp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FffCx9ca";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="srI20osp"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEMY90030163;
	Mon, 16 Sep 2024 14:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=3l9NTrMT9PKPbF0BAYNbGyzW8RnsF73yHY8PwJx1nWI=; b=
	FffCx9caINTizas//kqSRxejxJr99RvuhZNT1OM+cLmYIgOSsCZet+/u30zBnB6R
	2fqDNrZ1IHkSDvfHHbAdT+uzSPl6Tl8qtorxA7WZMf4/m5gtYrDRnsIKGnVogH2J
	v3fuWA+H1257LzzNy5J2z04MVbBFFx6866xVqshs6iAXzONi7D2ufe5gA26pDEqu
	4d5AuojUwQ4yaxc3gW0yUS2QA5RTIej8/MVYVhFUROBsPTZcucViFcjAX3GwOejP
	PBGLxdpD3BrZ0q6S4x8HYD9WgiYg85T5196nixoCeQaGm0kq7QvE1jKJ7QoBDN9N
	KLH4KotYraNLJHj8qOQliQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3bgtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 14:33:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GDcpW1008173;
	Mon, 16 Sep 2024 14:33:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyfapet3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 14:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iseQhEQFn04Z/NHI5QR7p+fxSz1d3duYn9QMo1dYquCQQ9H9xmWEfeDczd2aNjaUep1MKhLPJZ4IMdmNb4VN93Oh69TN0uKgbdoAB5L5PIjA4ghNWDaA5durjD9MoDIJAevWxyoGuU0EzJ3EjlRLClhfLeaYlWJSiJQwncL0Y1XTc/x2yDm6J2HlaMDFHjs5QYplVulOmn4ENPPRRzmSCcj2XfVNHNzYSPZgRbL+VfW1Fe3kU653auk2dd7uSCCKHZgfTulT9TBP4znPDFkTzhGtrkmi/qGwjaJzqcv7P2Lrh8iAg42ywvNNgS1Pik2eAfNMZhUFoWeh0QpMf0RoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l9NTrMT9PKPbF0BAYNbGyzW8RnsF73yHY8PwJx1nWI=;
 b=COvGTwysXbeZTPM+yiA0Ao8ZXZDg6B5yBkKIgm5LCOqg6Gd3eLiuB5e32ZmUqyIUUnWOvHIrCXHS/x/ngJbxMNjZTq9nEQ0zfW9yF194wPcGDMoeMrH+YR8FaCQeik9p8wkXkO7h4RDvm4iGyE0/AhaV4q0d6o9ncfGftqmGEhtpjG+6+IGbE5BJgfbM0zQ/WsGTpzwSgNYAd7C7TX5PHatHj/4x/hvMncjJg03Hnd0Vqvq0S8NepNdShQjYAkwEq83gn5IulK2SSIf8vk+wmwEkKdv1w9lx5FN5ybWr75t/pUFwb3j3+2IznkL8iTJgxlL7MYf1vHe2udjQW8dmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l9NTrMT9PKPbF0BAYNbGyzW8RnsF73yHY8PwJx1nWI=;
 b=srI20ospl9Jod2KpW9gYCjmb2nbEFPEgr4yZnGS5TIxyKmQForaVCFcFM1BU1F3qtqGMX+1IvMre+R7dabp3aOHw0ooZZRjozBm9PQEiW/KrVSBX0l4CyWwDy+NN6LRLe/TNkOVW4JMmrWsR6tmbL/nveWFcibJE6afxl0tkASc=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by DM4PR10MB7392.namprd10.prod.outlook.com (2603:10b6:8:10c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Mon, 16 Sep
 2024 14:33:35 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%4]) with mapi id 15.20.7982.012; Mon, 16 Sep 2024
 14:33:35 +0000
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
Thread-Index: AQHbBEo0MBQpzMClx0yHgrbqKHh3h7JTpl7wgAMRZICAA8o7sA==
Date: Mon, 16 Sep 2024 14:33:35 +0000
Message-ID:
 <DM6PR10MB43472AFEFD2DACDEC30D0588A0602@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240911102045.71870-1-srivathsa.d.dara@oracle.com>
 <20240911125734.44wtifmoyvd74ptq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <DM6PR10MB43477AC7B8B80A38A7155898A0642@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240914044005.k2ruita22xevrefy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20240914044005.k2ruita22xevrefy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|DM4PR10MB7392:EE_
x-ms-office365-filtering-correlation-id: 804482c8-3808-4e2a-a40b-08dcd65c8bcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GELxk330A5ILOIoLidLziVK2J0F85JQLgP8xNK6ZH3yVWHWh/J1WnxYODlCS?=
 =?us-ascii?Q?Yq11FEHjOYhCQGVIZlZAXLiMNDQuqqSByv6aQ00lCKY82HHFJIs8of7lRd42?=
 =?us-ascii?Q?GHK7iijHVi86G6avbvtia+jd3qd+MQDfD/VYHgc2CiPwoLUAkcY0q9Y7jdbJ?=
 =?us-ascii?Q?SlvIKVgES7XqoZ2HSxq/TvHByAJ3mZ36ryTDdR9/Y5U7uHU5dGTV32dSVspZ?=
 =?us-ascii?Q?fh+vLTbpccDayfUJcyrkfSHkqqzK7jLgp0yJo2e/1uD9cobZHpoFli6dcfuZ?=
 =?us-ascii?Q?DhfBa3KfKyEdCVZNfLTDRMH/lV042YXJbEUf2RNIFvE7NdY00O2jGFPKfRGW?=
 =?us-ascii?Q?ihXrSB8IH8/LVDmh7lM8KOsX0JpQev91CgbMXurpr/pGd+9J9ayF3eMDqSlp?=
 =?us-ascii?Q?6wKYNQildokvpep1CjqOOGYwamoFjhTy7x+5OW3b7Wm0psg4LTXecdc2XMCG?=
 =?us-ascii?Q?XE8E9qdtGNlXtqOHewxyqrJOM5TxosTIywZkxZIN9DGPz4VNQtWvKU6HD42L?=
 =?us-ascii?Q?O8NYLdQ/1vXmCHNqEv0go5xVEqxTr9bKQp7lHon1FcdHwQe4NZ52SoHO9lKm?=
 =?us-ascii?Q?C4ClQn53HMSUsMR3juMY5jf0o8UFyB/WO8HLvGF2/PF70HZ3r02Bzune8Eb2?=
 =?us-ascii?Q?OLpblRPiuRrVWh3LM0BMlGbG1fnz8Xe9od7iylekz/9qITuSEjE4AhQsGS8l?=
 =?us-ascii?Q?F0WYNy02+mK39IAfNye9QXkNldbbUfr4HP5pjwiw6e6wgpFgfRJVPfWfbkvZ?=
 =?us-ascii?Q?+EtGa/AO/p1G4+4nQxQxkdUpdTIAz2L3Un8ICcKSEqAl6OxGVcehXWPIRczb?=
 =?us-ascii?Q?7xUf+nnKWc61mfIKVbAD7CK225qj08K9fOyWbA/VLKlPvnb81W0FWGzuOwYg?=
 =?us-ascii?Q?Vkgc9mi83GC+lnyr6qeTlyGiYv9Af2Z2Fs7gFPEUsTeb4qgDZi0iwGEnJR32?=
 =?us-ascii?Q?Mvcpjxy0ML4BskQM7NMhYbUpknukub9UmK+AEG/+IbiEzZZ7dIgntGUZsuN/?=
 =?us-ascii?Q?BGipCfOsHFNaDEr+xZO1xGlVZGosID19/dsK9C+xP2D/sogemtvMkuJu/sEf?=
 =?us-ascii?Q?gzrlu+/gpAUtV798pBse+G/UPEtiTqMyZyzNFxqFmnCC+WzoktSUa4tF4THN?=
 =?us-ascii?Q?OrigCEKqO3KvDfQ5qMNOPSsJwN4eL0VnNK0yC7GHtUBLB+t8TWCBh/i897Cv?=
 =?us-ascii?Q?sv8cZb7dGpdlKqA69GhOradP14gWsk+W7gipBKJ2H3N7vSU3g6yK++SJB1bG?=
 =?us-ascii?Q?86ts9Yr6osRmou4ojYqXDFaaLA6JDNj5I5kLIzIQC+8k2107QVt6B6G8OTRw?=
 =?us-ascii?Q?1rnqfNMwarAvTCFm58rIeOiSIDXRvx3uWfelfPk5xt2keOJGm7LMySdUZQm/?=
 =?us-ascii?Q?xvQQAQa/gJ7U1jSyfx/SdJjZ4v0AXM++QjXRL5MRWkO5mMx1kA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SHAgHnAZQwbXzCuDfW2d0JNZZZ0xeIAVNbZ0zb2mfxpbWPI6BkqQfN35P4kT?=
 =?us-ascii?Q?4L3119g0QDF7t8ACHZN0Mcgr7+h9eBEPMydUaUheKh7bN6UJ3vD45qWo7UaW?=
 =?us-ascii?Q?Q/Nb7klex/UaAJDBHLxbYbOfSxwmosj9NIJggXaVjOO4PDKIdmtqAZKgSPyN?=
 =?us-ascii?Q?0uToyvpkr1rQtkrq2Uy02FfXu8Bs1pGgr4tqNN9Cd38HAMlqxr4z8b59EHF9?=
 =?us-ascii?Q?ttHmJFGAmfbsJ+huPsi+mB8mj2/FrhpC/JF9/0kJ5KLo4+EVr894dqhzsfrZ?=
 =?us-ascii?Q?PHSqlQNG7PEvy51PJ39eClN6+XzRmCo872iQzB91HqEEmykFQk580advT5gQ?=
 =?us-ascii?Q?Vjcc5Lpljvf6q2BWHnOGXuiuKVygcGwB2lBzhGqJdLyPOgor5f0LwIF+oW/E?=
 =?us-ascii?Q?EDzcTomjnmRih/+YSdfgDD0dMeW7DWlscbi/zsJQ1zYUZy1EdP+laJEeBoyw?=
 =?us-ascii?Q?xy7+bL7WCIsyHbiNgG68bj529zzzMcKNXkI4Y5YS4AmF6EtdSKT4o9y2qS31?=
 =?us-ascii?Q?EBbFrE0nJYX31+HeDGvhUDH68Yai4MFFc0SUdm0IavOtqY+j5YEXjATQEaRa?=
 =?us-ascii?Q?AyfTP+NF9uino4JTg3MN7YnL31vjloHFauBpDz40FryAUF8V+JjiKSvA1/w6?=
 =?us-ascii?Q?qWAqPXFor8V7DOdaLGYzoOuNiLsylcN9tRRObcVoq5W7IQuIQbe6lrPE8DTh?=
 =?us-ascii?Q?UAJ3eSIT/y8G4Fyp+MHgEkZR0W0Hwds/F6oatWWQDSeICDbd773weD5r5om3?=
 =?us-ascii?Q?N0Ky1GODEVRVA5H2TXGRa6s5vMoSSIl2pgxJyXDHJ6xcVWRzKbVydjah9Q00?=
 =?us-ascii?Q?u3GK9/Mu//rTexOBrnX5hEId0L2nuxsLmYFPBw+oN/LNnby8VuE6M2UyypRV?=
 =?us-ascii?Q?FsKa3Le4MIX8hxgPSR41L4SanBOiziX/5yC+S31cw1ZLtTsMlDDQX19JXxIO?=
 =?us-ascii?Q?V6eHmdULMT8hU+378eePoBd/KLmBQA130tROKios4z39K0TyqyT+jo+g4LrO?=
 =?us-ascii?Q?EQhKYQEwa0qDBe1SKn460xT/WP5IrfAJLRJBNmo9ghXZtRZbbs+dPvkWpWqj?=
 =?us-ascii?Q?+6Vg9YZycKmszDRPtqzK1u2L2er7do4CMmdXNFZk/x39WgFIP4MS5RiUBK55?=
 =?us-ascii?Q?W2Gz4NRNuQyvXsi4RzSvxiiKLD4n7q3ucw/RyqrwZJLDzfy/2kkP/l7XvH5U?=
 =?us-ascii?Q?EWRVAKawbPrCVB0U/XnfGz5oA19IiWEanXYeq3zXlcYYmTnmiCFWLZsoLaNi?=
 =?us-ascii?Q?trhThg2Tq/0gEdyHnM4Vouy6am2nsGrilkxY8k0YoPHOyT9mWyQo8Z/E2QjK?=
 =?us-ascii?Q?OgB1wX4HaPDicjPWDb9IarJ0ozUXgl6o027w0zBT8e0opyOaD3G9wOTrij20?=
 =?us-ascii?Q?dPnqygewZc5QB/kBnqF3mNJzfk+Z0VzNVsp77WKY9nU0YQzRl01cBt6+eCx5?=
 =?us-ascii?Q?eUtUY9KVgY1t49u3zW85u/car8fYeNN9Piu/1DBOKWF5okuAsiSANoOqrmna?=
 =?us-ascii?Q?PctqFBO5ZTX3B/yhYN2J3kHmYbTac+iuBDb3QTUd1u4mDbmJyro4Soj6BFBv?=
 =?us-ascii?Q?Y3cHoUNTlRSTcUh7ioLOGoatLkXakTa9bhEOWTLM?=
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
	pAaLDw84nbr2BMbAqc7dhVcs3CDpldJlzMHOEjXqyYHAriHovKy4KjEGx3KefVC1nzqJjpdJGl1yuYbkQ1ksC7mNfcNIN9FbR/jcrzCNQiSpWlsdxZOH15CApf75eK0snILj41zC561zEyjVnThyekPbs6qnjNJjmqoy0MYgKkKQ7cMN3qGPXblu7DtFIh9XYcV9XuaDABYNzx/i4zyLewBMuSXUEVUMJQGCnRZ9bGnYK0/NfCymwu7sgF9luBBeTA8569JQ8tFKh40tHg2ssUq5/Qk2C8p/aUa7ODUpZ86pPzpPZi88qqN4OcHVpWcCf50pwDdzgCEKA6wt+d99FPgHd7T7utIWEEmp0HFFgP/Ze5k1aKgHXJ1vm4fWHAsR6YdmdT+fJTBX/UzR2uv3OcKAIEkfhHd2A0WIUI3FMji2zhIBCRuN34/BPc/fkA2HWCYE6VPrdcf1AebAJYaOKFrQdnq/Xbf+3l3VzZLuPjwNRN2Xt0eJvBi87OhVEkxh4LaDuJn871ajNnq3JolsNWTb3ITkK0oGWncXZah78maMgix4eg42DcsbmG2D7P5A30v2T5DOTre3nIS5j7/ufQ4yqWxJ20Sc6lwtStFnW9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804482c8-3808-4e2a-a40b-08dcd65c8bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 14:33:35.0607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+9vjcuho0wbI8pvPOOxMvmUjlAhgjaPyPDn3S9W7UDcIXe1M98bwO8Xv2me/9gwbi0BXFxPamT7fHDN7xF1j4F1rtz3kVr1y9G4+p1c81U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160092
X-Proofpoint-GUID: BSPRUtSxpTMfZ_gisHZ_ovHtfvJDgFTh
X-Proofpoint-ORIG-GUID: BSPRUtSxpTMfZ_gisHZ_ovHtfvJDgFTh

> > Hi Zorro,
> >=20
> > > > Regression test for:
> > > > 	a6b3bfe176e8 ext4: fix corruption during on-line resize
> > > >=20
> > > > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > > > ---
> > > >  tests/ext4/060     | 43 ++++++++++++++++++++++++++++++++++++++++++=
+
> > > >  tests/ext4/060.out |  2 ++
> > > >  2 files changed, 45 insertions(+)  create mode 100755=20
> > > > tests/ext4/060  create mode 100644 tests/ext4/060.out
> > > >=20
> > > > diff --git a/tests/ext4/060 b/tests/ext4/060 new file mode 100755=20
> > > > index 00000000..440748ea
> > > > --- /dev/null
> > > > +++ b/tests/ext4/060
> > > > @@ -0,0 +1,43 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0 # Copyright (c) 2024 Oracle. =20
> > > > +All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 060
> > > > +#
> > > > +# This test ensures that kernel avoids FS corruption while online=
=20
> > > > +# resizing an ext4 filesystem with disabled resize_inode feature.
> > > > +#
> > > > +# The commit a6b3bfe176e8 ("ext4: fix corruption during on-line
> > > > +resize") # stops the corruption.
> > > > +#
> > > > +
> > > > +. ./common/preamble
> > > > +_begin_fstest auto resize quick
> > > > +
> > > > +_supported_fs ext4
> > > > +_fixed_by_kernel_commit a6b3bfe176e8 \
> > > > +	"ext4: fix corruption during on-line resize"
> > > > +
> > > > +_require_command "$RESIZE2FS_PROG" resize2fs _require_command=20
> > > > +"$E2FSCK_PROG" e2fsck _require_scratch_size_nocheck $((9* 1024 *
> > > > +1024))
> > > > +
> > > > +# Initialize an EXT4 filesystem with the resize_inode feature=20
> > > > +disabled, # and a size of 128MiB less than 8GiB, i.e., short of 1=
=20
> > > > +block group in # an 8GiB filesystem.
> > > > +
> > > > +dev_size=3D$((8* 1024 * 1024 * 1024 - 128 * 1024 * 1024))=20
> > > > +MKFS_OPTIONS=3D"-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_size=
d $dev_size \
> > > > +	>>$seqres.full 2>&1
> > >=20
> > > Just for sure, is the 8G fs size a necessary requirement to reproduce=
 the bug?
> > > Is it related with the block size (e.g. different blocksize need diff=
erent fs size for testing)?
> >=20
> > Yes, the issue was that, before the fix, while performing an online=20
> > resize of a filesystem with the resize_inode feature disabled, the=20
> > kernel would corrupt the first block of the last group in the 0th meta_=
bg.
> >=20
> > If the block size is 1024, each meta_bg has 16 (1024/64) block groups.
> > The last blockgroup of the 0th meta_bg is 15, and the block that gets=20
> > corrupted is the 122,880th block, which is the first block of the 15th =
block group.
> >=20
> > If the block size is 2048, each meta_bg has 32 (2048/64) block groups.
> > The last blockgroup of the 0th meta_bg is 31, and the block that gets=20
> > corrupted is the 507,904th block, which is the first block of the 31st =
block group.
> >=20
> > If the block size is 4096, each meta_bg has 64 (4096/64) block groups.
> > The last blockgroup of the 0th meta_bg is 63, and the block that gets=20
> > corrupted is the 2,064,384th block, which is the first block of the 63r=
d block group.
> >=20
> > The corruption occurred because, when updating backup group=20
> > descriptors, the kernel failed to check whether the group descriptor=20
> > being updated belonged to the meta_bg layout or not, leading to an inco=
rrect block being updated.
> > Hence, the corruption.
> >=20
> > To reproduce the issue, the initial filesystem's descriptor block must=
=20
> > have some available space, and the resize operation should increase=20
> > the filesystem size enough to cross the meta_bg boundary.
> >=20
> > In this case, the initial filesystem size was chosen as 8GiB minus=20
> > 128MiB, so that its descriptor block has space to accommodate an additi=
onal block group.
> > The filesystem is then resized to 9GiB ( 8GiB is the meta_bg boundary).
>=20
> Actually I hope to check the MKFS_OPTIONS with you, I saw you try to carr=
y on the
> MKFS_OPTIONS, MKFS_OPTIONS=3D"-O ^resize_inode $MKFS_OPTIONS". If MKFS_OP=
TIONS=3D"-b 65536" (or others),
> can this bug still be reproduced? If not, we can drop the old MKFS_OPTION=
S, just set
> MKFS_OPTIONS=3D"-O ^resize_inode". Or we can keep it.

I think using just MKFS_OPTIONS=3D"-O ^resize_inode" is a better choice,
thanks for the input.

>=20
> >=20
> > >=20
> > > > +
> > > > +_scratch_mount
> > > > +
> > > > +# Perform online-resize
> > > > +$RESIZE2FS_PROG $SCRATCH_DEV 9G >> $seqres.full 2>&1
> > > > +
> > > > +$E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "Files=
ystem corrupted"
> > >=20
> > > Do you want to test online resize or online fsck or both? (Does ext4=
=20
> > > support online fsck?)
> >=20
> > I want to test only the online resize. No, EXT4 doesn't support online =
fsck.
> > However, e2fsck with the -fn option reports corruption even if the=20
> > device is mounted.
>=20
> As EXT4 doesn't support online fsck, better to unmount before fscking. To=
 avoid other interference.

Sure, will send a v2 with the suggested changes.

>=20
> Thanks,
> Zorro
>=20
> >=20
> > Thanks,
> > Srivathsa
> >=20
> > >=20
> > > > +
> > > > +echo "Silence is golden"
> > > > +
> > > > +status=3D0
> > > > +exit
> > > > diff --git a/tests/ext4/060.out b/tests/ext4/060.out new file mode
> > > > 100644 index 00000000..8ffce4de
> > > > --- /dev/null
> > > > +++ b/tests/ext4/060.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 060
> > > > +Silence is golden
> > > > --
> > > > 2.39.3
