Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86633F9EB
	for <fstests@vger.kernel.org>; Thu, 23 May 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478560; cv=fail; b=QghaA8Hb5E3C4dFSbxrmHUgLZ4x28Ta1qem8/X0Nf+s0yM8mZsKb/OVhCVhZnuyB5lM8ijJg81/EmqNJIJfH9+Mz1RH3C3YJoTtu136dbup77OautwKOUxt1lswl7e11EUkmhqNPeT2F3dcn+h5crBXBOMLDUmXa8VA6R9+cnG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478560; c=relaxed/simple;
	bh=nKAPx4R0VlZCB0obNUhAtlLcw7sQP4oL88k4vEqAVug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rNdD5b562+60wRIVWZ4e6P3LWGwuaE+4FtvBnWIErqoiv27PQVyMj9puavfr997QLWJUJhsMGyDJvQHy/zozT6+CLjtFJJsmiCyGvql1hkwrvn6sgHx8T2AgeNdGw5Eqea37FMU6Us0hKyhiNStIBLkfwvk0uo0VILYLXzcoEjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HsGiT/Pf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hwCdJM7b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HsGiT/Pf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hwCdJM7b"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NEi08X004385;
	Thu, 23 May 2024 15:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zM27y97z43oJkr4/iwos6+wFsFhm6RZGXv4I2xuOvyg=;
 b=HsGiT/PfPc29VEpwBU6o/Q6DvVod1l1KCVNfzUyRUgXnpk+NJYq9m+tYQHOYBJXETmqY
 dAViy8kJhECIn4vVoeWyaCqsbe0D85cyn6o4T+CNds5UCTMyTTvpU//lz0JBo5FiQ8To
 iBL+wEAbbD1kq9PJgpiEs+JVElp6YZX2//i2x80Tk48xQ6kGW/1KkpJEHhlxDaaK+G/v
 BhwZ20dmYZmBrTYRUNv+G2A8NsHRxxY+6KnSov3dtTRH/OxAH0TVmzmXzJEVy7WxeOiN
 Dgih6SPls0s7zpBLiVteImS/D9/ka/5qESl1yyf9tZBFdZPBjBh2RdcKWdgFR3Y3OcD3 Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxvaj5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 15:35:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NEsW3X013690;
	Thu, 23 May 2024 15:35:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsa5yyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 15:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+p9MQ8wqk+68eaiRt7nURPHnj1PNhln6VXX2vfzTYUcJvnBAYXgmj5puKVjYX5XtthxcpDIJF+55RnGTxNuBsQvKPUF0U8IS7HrGy8AEmKVIHcbCMQwFffmHSOYpoTnYy2fcsw0qhw5+pjLJkNUbVbVV5F9PKl41bOdtKv9JuVS5wqfKP8+cbbTOkVmr4JyTJrJnK2ioDwvsN7r9aA/cSBhIkjL9p0rJv79Sjd6BIYOy42j5G4BgU28yUqiA41XWCZnJ0G6l/Y3F9/kKuLIwo46+8rx8rURJd81OPugRDy/7jaWVvJFzjgVjqISDb3u26BlzOAtScDMjXSiwl7oKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM27y97z43oJkr4/iwos6+wFsFhm6RZGXv4I2xuOvyg=;
 b=L+8VSYL/OPiLPFmT8s6FtKXYIEysGDsgd3f6Z4w27KvRWLO9LuAtTTjN5d8ma9Sp61hYWA1gIVVJnijJtN9L0sFYzlKuYUDr24uK8ZTHZrcy/TrdoeeIefRDnoOfDc8+U2S3CMPLq/cSh+TJ7ROXjdNTpbQQDa/Fxx4595UKJZjK9e5N0fsJHXEiwylN7sQvQEraORQKzHEo6GG0WboEXFl150fEFqn/MdGnsjK8CXvY4ydIHnopAvNyI7N9KhYdwbmEZnAv77EIWBJV3f3XP0WTp5s5I+fqSLGtD9uLuntx9J9p7/Q191T0xYradzVe+ctT9ZQJThVhHZ9x+VnutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM27y97z43oJkr4/iwos6+wFsFhm6RZGXv4I2xuOvyg=;
 b=hwCdJM7bVsfnCLUC9CK386zuIThpdh2/Tglviomci0qwFRznFKlLnQwCwXxXg72mFQ8KytSfe5L0lvuqXel05mWyqJpHVg5yjC+u325Lt4dJ6pFTPbKZjZGXPagqIQE5FapztS6H4WW3Id6LoHzmQP2mJvV43aV98Ghbl6+hoDg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 15:35:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:35:48 +0000
Message-ID: <3e5fd0ec-6874-4056-9c53-05fe834c25e5@oracle.com>
Date: Thu, 23 May 2024 23:35:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Btrfs test updates and fixups
Content-Language: en-GB
To: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Cc: josef@toxicpanda.com
References: <cover.1715896529.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1715896529.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 89868b96-e09d-4a6c-08de-08dc7b3e050f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZTVxTS9DZVloR050YXRIekdSRnFVUnk3bmpOY1Z1QnlWZ2wyVFI1SDVTM1Ji?=
 =?utf-8?B?Nk14UlA2c0lES25ub3FBd2tDUWdKMlNtcEdtVTFCalcvNzZvWWJmUmxBbVZQ?=
 =?utf-8?B?WEFkbkw2SVJDVDJNc3JDVWVOYm9WUXNteHBXZ1hZUWo0YjZMeTRrQ3VLT0Q0?=
 =?utf-8?B?M0FUaStqWk9kcTVzb1ZkQnJHYytLQ252Zjdpb1JWZ3JwTVhES3JUTVFHekhZ?=
 =?utf-8?B?RC9nVUw2QitlRStueEZRYS93ZVFVQlA5aEgzenJqSW5Mc05BUXhPSmlKT0hj?=
 =?utf-8?B?M1JEdlJETDJaTVZNbmxYSWtLdG42dGp6cVNzYTdXeEhvMm1jc29mTHpVRHhB?=
 =?utf-8?B?eHJUeDF6ajJiQ3FRYjFpamw5a0kySXJUMCtOeHd1Q3dIR1FCb1RNRkFac0lN?=
 =?utf-8?B?WklDaWx4ajlaWWU1NnpnblNDOFlMYlM1ZmVnV0x0WDdDZVQwczRDMzNadnZD?=
 =?utf-8?B?RHdwTGJaU0NXTzR4bkdWQnFXUmZ5N3V5c3Y4bWpSZG1Lc3NHbnJhUnBkMTl6?=
 =?utf-8?B?aG1VbEtOeHJ6bEUwbWRZSGVOYkxkeithZHFrR0pLc1p2R2RmditYV0cvb3B1?=
 =?utf-8?B?aXEyS1pONXhpUVNidG9jZHFSNzdRWmxoQXVjbk9UZmhWd2RENStVNEdUOUFL?=
 =?utf-8?B?VkFuT3prckZDbHNteTlGMEltbkx1SjNSZUdIbWNJay9qbEZacXMvd0pqRGRV?=
 =?utf-8?B?S0JsS3pycmZJRmE1QnhFeXg2MXhrd0tjUzBmMHB0aUNmSTJWTXBKY0p6SVFI?=
 =?utf-8?B?MG10Z1FweFVZQVRBQ25FTCs3dUxnS2Q3a205VjZKWmtVUldNNW5ZOGYxaC9D?=
 =?utf-8?B?WGp2ZUI0c0o0YSs1WHNKdFUzMGR5b0tEZWhMTkdDQzBSemRibzdma1NjKzR2?=
 =?utf-8?B?Rm5kK2dvakx5ZHhkZ1pOZGJsbTFteVpwck1vQ3BPUGJmRmtES09IWlJ0aDV4?=
 =?utf-8?B?S0JqSFo0TndnOXNQZFNoUWgrSFVRUGx1cTZleDZmRVZoSXdoR0VULzNoOUtY?=
 =?utf-8?B?WEJ4aUhiRWRmVVNYVUVsY1pPbmQwelhjMDd6dUJQelhUTzZNRkN1MkhKdjA5?=
 =?utf-8?B?OFFOQ0dkbkp1U1BCa1NCTlY3Vm1zTW5OcDFFQWlZdCtSOHRiaUxRajcxN09D?=
 =?utf-8?B?RWlkdWVBSnFJc3pPZWdLV3Frd1VFSjBJVGF1TlhGS2d3b2VUS3hkM09VaUJL?=
 =?utf-8?B?UDRYeHo4MGhhU09BSUFZWjNaYmdWK0dkSk1rcWFCNFZUUFYxeW9abzVZckJp?=
 =?utf-8?B?MDNlalY2NEpxRVVkNk9hbGlLSkZkTHFxdVBLMHo4SGdLejU0T2NaS05HNEJL?=
 =?utf-8?B?S3J4NEtJanNsdVRIalRDUE9UWFMxQWpsbE1vMTRkYXNLRm8vUFo0TFpwUkdZ?=
 =?utf-8?B?ayt5d1QrVjB4K0xIOGZoNEFMQ05hZC84V3FjSE1yQm1qUUVsTFk3TVZNcVQz?=
 =?utf-8?B?ZHNnbTRUUy9BSUxkRE9Mc3V2Mk9IbmI4aHJGME15WjBxRnRueDBZOU53OEx1?=
 =?utf-8?B?WGVRVTNmdDdTa1NyMktWTHQwWW1xd1pKczVGTVVzNFZoMzVSMEw0dmoyNVky?=
 =?utf-8?B?OEYrSzg3anYvK1R0UEpEK2VtaXVOTTV1bFUwMlpCUHZNSmRxR2FYTUhjWEpI?=
 =?utf-8?B?R05kZ2s3Mk8zclRVMkFjTFhvSWJmSmRvYlozaTdEdkJVWnZSZU96K0xud2M0?=
 =?utf-8?B?UmZYY2huYTdHTU9mZHpxY0s4cFN6bzdlZGFLOXNwbnhobE96c0s0ZlNRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eUdvS3pLYzdTY2llYWJaeUpwbExtUmtBOE1lOElqeE1ScW9ZaVh1UUxtTFNu?=
 =?utf-8?B?TzdhTUFZWC9XQis5emJNeFpjSEE0M0pUVVpOem03K1Y4R3BVQlpGU1JjaFRv?=
 =?utf-8?B?ek14Vis1aHgzSW1panpkUldGWUVOZnh5ck1USW9HcGJLdmg2akV1VTMvcURH?=
 =?utf-8?B?RUtDYmJRSFlreEM4NVQ5ZnVhUjJ2MDZhc0xvRzA0NlZRQi9hRXo0MWtDVHJR?=
 =?utf-8?B?cTBOTVBSU0JmNUtjMjRCOUtIMU5icXhua0pKdzd2VnRVaURDT093U3FocWw3?=
 =?utf-8?B?YVN6Mmt4MDJ5MHA4ZjBoNlBqalpkMGlCYUxNc0lnbmpHenVUQlU1ZU1PenI2?=
 =?utf-8?B?TnNYUlhVVitZTFd6ckpXekY5c09OeTJiS2U4cFhlQ0xnZlU2MCtLbTl5U3hE?=
 =?utf-8?B?UHZVRUV4bTBmSzNtOHdqdUlZRXd1NmlKYTBLME9QbmZiZlpwdGhEenNEdFE5?=
 =?utf-8?B?K0FwMkMzSFV4c0lIQ05vYnlRbmxLbU0ycWpsTXJENG9UdDRrQWxtaEJZdlJn?=
 =?utf-8?B?bmxKWmpqY3NYRmNWQk9ibzVLUU5ZOWN3blJkUFpZR29wZ3FSRUt2YUpnK0pC?=
 =?utf-8?B?UGE1WU9kYm02V3ZtcVFCQU83eFRkL1d2YmxteXFsZm9JTjA2aG4zRjZWUmdN?=
 =?utf-8?B?OTRZUmVSUUpaRE5sWlZXVmJRS1J2eUVxUXA3ZmlaT0FOWDBhRk5QUTJBWkNH?=
 =?utf-8?B?UUZCTEoyc0RQNFE3S1VOeGZpUXRqL3g5aXM5OWN6QXVvMFQrWXlYTE8rRHMy?=
 =?utf-8?B?TnFxRUUwYm5CQjFrNDZibmNNdmRNQjdpS1hETDQxMVBuYjY3MW4wOWxQQ2tt?=
 =?utf-8?B?WGlrYWcyNHpoditjSmk0eEhRM0xmTWF6NitieWZrYWI0bERpR2xRUTdJVFB2?=
 =?utf-8?B?alFRUkdGRlR6OUhjemN6S2l3TDE2RGVjbTFpbksrVGZsbDBBRHV6V3ZDTkxN?=
 =?utf-8?B?Nm5xMktsbzRsZXZUQ1MvaERRRjIzNlIxV2xzZFpCd3Y4ZFdEUllvMUpzeDRS?=
 =?utf-8?B?UVUwcU9rSzJ6bmpXaVJPUUtUS0Vkc2RkRGNrTDFKSjJLbVFyNWpneWRpam96?=
 =?utf-8?B?YUZGQ3AzdjZVcUEvckJycmZjNFoyQjFWOGNJOTNJNjlSYVU5RWtLUDE2QVIw?=
 =?utf-8?B?Snpsa3dvTEZoejFaU3FOcmx1UWJpcWREeGRHOStoRHppSjd0ZVd5Q1RJeVdU?=
 =?utf-8?B?ZmMvWUQreXZCQTcvSUJKODNrN1ZGcHlMem1PM2FIVHZiZGs3d3JqQ0FtRkxQ?=
 =?utf-8?B?UTZQdDhTRXpSZTdFNzRkMkZoOVUrbFhZUU5nMWlyelRFRkVraml5OVJ1aHJO?=
 =?utf-8?B?aDBYM1JuNVdSUWVvWnZrMm1mQm1rRUtyeWVxNUFpZ2xpQVh0QXJTbk8rK1Ji?=
 =?utf-8?B?RitlbnNCSEpYaUtqYjBUZlZGNUxXcUZuT2FuaDZsemEzcDhLeWg4aWlmUlRX?=
 =?utf-8?B?MHByemJUaFNwWXRBRXo4Y0M3d1Jwai8wdXhPeXZQaDB3SzJySE1hdUZWKzkv?=
 =?utf-8?B?ZW9mTG9xelpNVVEvVmFLQWVFa0I3MkJheUFGZTk5MkJlZDh1dGtiY3F5ODFL?=
 =?utf-8?B?elhJVE5LK0VPMzhzbWlEMG9RNjF6eXBraEZ3ZnVWUGg2R2hjYVhvRkV4TlIz?=
 =?utf-8?B?bGdQV3dCWTMxZElORUw3QWFMc0d3UXc2QnZZTXY5QmFUNnhoSk1PL3RJTDdk?=
 =?utf-8?B?S1luMC9TYzByR0t0dkFLd25NbExDS09kZW5KM05yYTQ5T3I0L2RaNWp5S1lO?=
 =?utf-8?B?Wlk1T1g2ZTc1NkV0U1VvRTlnZFF4MWt0ell2MHFqUHJDSUliSVg3Z0tlcXJn?=
 =?utf-8?B?VVJXbi9hVnIxMjdVUHpnS0s2bGh2QnUzNGs0b1VHdG5vNVRjb0owbkJJQys0?=
 =?utf-8?B?dkFaYW4wUzJ5KzJTUGJpVGE2QzVXRDBHQ2dJSDlGSW14N2VVWVRlUjZVRzFz?=
 =?utf-8?B?YnRHd3Bna2pVdDMxYmE0c25YMmFYRFByaWlLbmtQU2RpUUtBcXJtVjV2WEVh?=
 =?utf-8?B?aVMwUXJoT2tFblAvQk9sVVo1YXdreFNIbFl2YXRGZ3JVUThrWFJYcjZGWUtu?=
 =?utf-8?B?bHNjL2RtQUk4Y2JkWi9wT1djSy9uN2JVMjY1OGh5eDJGclkrUmpwNVNmdExG?=
 =?utf-8?B?dU0xUUllZ09DSFN5NXpEdVllY3NOM1F5WTJUZGpncXh0azRvSXlGOGV1dTY4?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f5LS6rThErflSBE3ouT/qOAKvA5oaUEcxr8JPK0/2KrU1Tv57XFQ9v1ZpciBzLyl5DabyKxZWRwLIwNH4wKewREVq0GuCPqkVEehEMZ4SgZk+Ap5xsZgReuPt2j9TeGbsPErig4SwS8fWDe/dFVUge5fR6BHObRzxZ+XE0Yf0t2jS1Iod3ikjsrSlPsfubADjxt9f1Vz9xhtxnPEtZwdDmBJout5ymNiF0aBUGVL7Ky/hnx6lHztP61WbNNNVkvsi17dNQJtOdTGAesG0rknwwV8aMZYEr3c4QxNdA7O86OpSWI8eXVYqSueoqx2xqiFE6q5Qn0PO0WwgHetEAIvjCG1jCHDotm8USb7Y4+xXb/l4NMo4XEmbN+Cf69nEJcmyQG+Cqoi10jJi8vhR2wv8blDV1SufAjWz5gliE/ZUiT5zkcXMOjFGXEF7w4SzEFMSeg7xb6leSMhi5FHtz5/fvX0/XF+d4Yd8nP3QNWHbDGUQ9vPK8doJ0lO5ehN93uLbWTTzrGY/FVkOZyAwm1R133K4P5+hpkVVPZIgci/kMZDAubiupsmRJS1cK5k9ZngrAujqc65U2xjSudGl03egFmnZ/Qx/D31meiXdRwywyI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89868b96-e09d-4a6c-08de-08dc7b3e050f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:35:48.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVkDF4W6VrpdAfKvkX4zuklqpXWQIi3W9xPCtrDOjk7GDU5Bq3L2bxG05OwpNHjXMaZnJgeKTEA9ww72izy3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=998
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405230107
X-Proofpoint-GUID: 8ylzbOPr2DQD0dnxL6ClngoEWJ4V4GmQ
X-Proofpoint-ORIG-GUID: 8ylzbOPr2DQD0dnxL6ClngoEWJ4V4GmQ

On 17/05/2024 06:12, David Sterba wrote:
> Hi,
> 
> another batch of changes that we had for our CI. This adds requirements
> for some test cases or adjusts conditions for running them successfuly
> on btrfs (no affecting other filesystems).
> 
> Please add them to fstests, thanks.
> 


> Josef Bacik (6):
>    common: udev settle before _scratch_pool_mkfs
>    generic/352: require no compression
>    generic/027: require no compression
>    generic/269: require no compression
>    btrfs/011: mkfs the scratch dev before exiting
>    btrfs/{140,141}: verify read-repair test data by md5sum

Applied without 1/6 and 5/6.

Thanks, Anand

> 
>   common/rc           |  6 ++++++
>   tests/btrfs/011     |  5 +++++
>   tests/btrfs/140     | 15 ++++++++++++++-
>   tests/btrfs/140.out | 34 ----------------------------------
>   tests/btrfs/141     | 16 +++++++++++++++-
>   tests/btrfs/141.out | 34 ----------------------------------
>   tests/generic/027   |  4 ++++
>   tests/generic/269   |  3 +++
>   tests/generic/352   |  4 ++++
>   9 files changed, 51 insertions(+), 70 deletions(-)
> 

