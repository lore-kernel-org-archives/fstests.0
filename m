Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF43C38142
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Jan 2023 02:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjA2CnU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjA2CnR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Jan 2023 21:43:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC8E3AD
        for <fstests@vger.kernel.org>; Sat, 28 Jan 2023 18:43:14 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30SNmFR0012560;
        Sun, 29 Jan 2023 02:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JRnKKT0Z1zyFA4p7LYoG+U6K3t2v1Xn5BKeBAEwdg9A=;
 b=F3+pJzaqiJ5kys7jzuU91g8yCp1QJ7NagKA3hBd8cARJf9zFMKD9p6aCzbVfhs+Pg0Ln
 EuguLUNwyYvmhiEi1rptwmS/k6jYie/CejhChkOzPhdqaOOh1enecl9I1ZCrXF5ATsJ2
 BtjaiwnFhRKsaXDwym/NRWn+cajNoE6bwTWZo2vpMLhl8BOpXE8UhKsi2zTGUNLD157z
 rYQAo794AoggElYV2PsIwlzXI1i+YmIsiN+LhIuq1nVY0TxjAPK/oKbh3lI2PaDcsv0u
 t0haL0iP+hefnaWO6axwFHAd258tI9H6nJO8ShSFXWo2+i5TROKBZvZlmrf0ULTNKfyC SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvq9gwwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:43:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30SKYoCw000791;
        Sun, 29 Jan 2023 02:43:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct52sj71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su6uP0e0JWoNTslzAPwBSLkx6QfxQiOMF6XoIP7O+vRMeunA1Upa9gR3F1Xsi3rBHZOY19HoCWif8dYL35qUmbgR5NdSm9e8AMhlRfkIWdC8/1F6JiMvjlr6PzGK4Xn7JnPa2NnIzxKOejzgKmzDMDG3Bs4bOy3iP+6rsrS4FmGZqBdiPOpGi9Uy4yGn0EAGYTh1eb6wqWEbejYQfwqBaqxCMnssnHKOAwrYugnYh5SsaR4NAA0fv+3Uzr7fbKPAZubXEHhAWtu4MFb88H6Qr+jkJQv22Aj91dyniOG9Qu+Scf5w/NohGHauhPzlNF5LwbWy9hp6vT/SR/n5Ig1RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRnKKT0Z1zyFA4p7LYoG+U6K3t2v1Xn5BKeBAEwdg9A=;
 b=HPiUjLCrfuUzyXm0ORSUz2gN2Hft6RWHioUjLFEQgeAShLf5UFSGP+4BZldVJotgZTYGHVUUzDE47dBWVzTDlPprMMG83Ru423JbiHU2Pvto3H0fl6XPMde9jCTmptanVkn7LMygiukePqPqTqMj6bL8KRF2REZVOYbUmR/9QpQiCg0o4vn+6PYKOOeE6zOizisQTKCVih2WsQ75KFzw98wGNRS6RUCLnXvQOyZHrHcQRNWUaS8xUaR6IkzDGgSXoleaEQwxnQ8fFPl0adgR09USF3J6WjkxX/GjEomNMxLwTcM+n+rCNixEw7AOl2m62MmcjsWlrZlEo5Bli57iCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRnKKT0Z1zyFA4p7LYoG+U6K3t2v1Xn5BKeBAEwdg9A=;
 b=qofAl/3Cec0z8TZSHzGjgbMTO9KD3LRJg3+lfpSig6GO2CXerz2t6wDhCdczztcA72moLjWUPWtWojdntNtcc0TcjkXrVILui76Mlns0AONuc/nxsE88oTnp6s+H8nbIgQE3q9YIbogQvABHsZ/hXNph7HOk71NVlZN1qGUy0v0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Sun, 29 Jan
 2023 02:43:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.017; Sun, 29 Jan 2023
 02:43:08 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org
Subject: [PATCH 4/4] fstests: aiodio_sparse2.c, fix compiler warning buffer overflow
Date:   Sun, 29 Jan 2023 10:42:33 +0800
Message-Id: <54868fe929ac17553747e0eb941192c85b4fe172.1674870429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1674870429.git.anand.jain@oracle.com>
References: <cover.1674870429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 93616692-a24a-4801-4ba6-08db01a28df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCk+uvnLpP1ow9DX/DsbGd/W6/tFDy5vGRWE63bFsSYDryanrGx20Y0M0bqETPn0mfDm+jyWJrtMgtkK8XFx2RyTJLgl2pqTQPDbKdIOWFAjr4BihHdvr8P2nujSIyGG+fNsWImUig+uvZDLHzt0DuE0dcpUx5Mu/Bn3fl0Op74S18MDzfZoHPFo5247+E5vvZpWbKdxCGyPSm/LSSBPpO/X4UlLcIe5BK7jwOITJB+mp8QijDjGcyrdKwj2ix9ztiwqM2gMs6oPX9a/CroeBsFEr2m7fau3JwPPPg6fed5PrvLcYf1EQJqQoXKqfMhdoRcPGlIrjNt+FQj31tRduHi6ERYGBAjm59lScL/BWOAPeC0tUM4IzzWRZfjhjvuVp481ifdAWkDzgydaA2FBy5zfgj4s5qFbVfD3zl0UyFdYcis8RfmxvTxiFhjjXWILuBTWTQHKiPz8syWN+2ye4j8YK4/LWdEgTNcNPHCiFbqiVOm/n9cCCTSs1Fl+2gFNAH2iSrQkizgcxc9T8ETsTkH2KeOfWqX+s0YpXeDEurCKLhiabIp0vE5ynPZWDv2t4vEeodjh6mbTKB+OuNahO0GksJ7IoeWkYx65nK34RECZdaUqZYvWqcSNqN0+DO4zULNlJRB/HTnt2oLJyOPTZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6486002)(478600001)(26005)(83380400001)(86362001)(38100700002)(186003)(6512007)(36756003)(2616005)(6666004)(6506007)(4326008)(6916009)(8676002)(66476007)(66946007)(66556008)(4744005)(5660300002)(316002)(8936002)(41300700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBcdUZGJK3nODIfJH9SB3kTUMrfrCYB/Ydj1+Fz7PzHKBBNlK/8cMqPLG2MF?=
 =?us-ascii?Q?G0DHle2QvCE9xRvugvozno5YOVpS5khnbuj7tt+U/fY9uUZWuUqNLFG1ijZg?=
 =?us-ascii?Q?ebxDMAztGjYbaen6O+VgcTwzqdT1zKe0PaM2lifDBJXUQY0D3d/3aNsrtyO+?=
 =?us-ascii?Q?WK4DXlne4KYrebcvjZsFZ4ZdgttaudH9SMyBuE1PTFTPxVnlDwoZhppULaAJ?=
 =?us-ascii?Q?T+l10NfMlTqK/+KJygo5uv5aE7B7syyVnYBtrkHtqjcgYPowytSVnQwwZ6bs?=
 =?us-ascii?Q?vWYQCbcyvv0AwsQpTT9Dr4YiaIYsIdzJg/Ysuue+s4mGjqb91jMioZyl0Qb0?=
 =?us-ascii?Q?VcJBhg70g/Emm94NCTRB8ovFKk9j58dy1NaAq2fjYkp1zmHusWq07OMimb5F?=
 =?us-ascii?Q?cwfoVGrRa3aZBpiahGf/wQKhI3YfEtjrH0F4LVWZ8hxB8QTTQB0dwoJTxFlA?=
 =?us-ascii?Q?Tcf8ql38Au3eH+KgyGzVJoS+eCMrzZWFlJvwODx3roVpGV/vku2zWxiZtibA?=
 =?us-ascii?Q?+VgMkLhPp7Ni5cQwPzxx4U+C1WZV3ScVOVd7ntPKU5WbreCb5ySU4TsDw8ND?=
 =?us-ascii?Q?frcUHCfujQCbl9mamNcHy6zvzNQzxo3oammSCyrHV20BuM83K0BL6IOyPkzl?=
 =?us-ascii?Q?yifcA4+9xRU2e6B99daqPIO7cjofuHB9jLgJfAN4/qB7X0vPqXr5jTMBpTgI?=
 =?us-ascii?Q?3y3o0oe7+RxrsYFJdkvqIQnQA84qqmPaGv27OXqFZDPW6PyMs4aGjNCGH9Ze?=
 =?us-ascii?Q?hUbTuJ7UzYCggLAc7A5pPayeojL4X/QfPx1+lyIDtlWgz4IY2OKJ61AmE56h?=
 =?us-ascii?Q?Ug8kEJbIkMRFn6fX5NBTj8xuoKvi12d69vYs648ROg2d2aP2TfWkl04rEYNc?=
 =?us-ascii?Q?0WeyYz6ZBR4si4M8uatCfkmosEz0tuboNF8DupTOa4zSSkmT5KR86s+5u1Y1?=
 =?us-ascii?Q?TFfWYchU69M2BwOo8ykOtAqNzjC0CeaFRk4WH62bLiOnr1WKe5EB4hlfQIZw?=
 =?us-ascii?Q?hdXXtdhA8RPlWhMgzlT8vbPttmW8DS0JiAaDdFnCFIkG5uc7RFDmPyQDsxFD?=
 =?us-ascii?Q?vQi4LAllyZKzxlSnE5lxsoa/3gizad0T+NYZmRoEcEY8nymeAE18GmPkGjqX?=
 =?us-ascii?Q?BmuyrdMyV15Sl/Nwt8npudB8m3NRvcSej2sAL6B9MDvvf8hlqKR7hOvNMYr4?=
 =?us-ascii?Q?4WBBWDAJjmTMdq61fuPoBWwfkho3qX4rQ9OgE45eCyr+043xnxQQxsOXPEY5?=
 =?us-ascii?Q?sHIic4+1l27lIAY2xx0OV0TfyFCbrHuDYzuVyzSjTK+ugi2FGyu5RLU8EAYa?=
 =?us-ascii?Q?h2TUYg45wptphutRk6NUhPX8pnWR3OcGYBsCCZqE94rP3QGPK75xiV+L51xm?=
 =?us-ascii?Q?VRC6W1qcMOp7B50MM5rwE8/otsfkCGE8+4jkMXvNaalgINgrl82hwkt/FsYv?=
 =?us-ascii?Q?gfYcEoKU473d+N7gsLOaO1R2gssrzCDex1XWXCGuFAydX5Wo44tNeOb7sKo4?=
 =?us-ascii?Q?Z/f+R5zB9sddIhGc0G1gjyoAPGyKdLYnR+Wi/MlJtD4/W12zp9zsSvh37V8W?=
 =?us-ascii?Q?KXOk+sCQVkYKO29mMnOiy2lHKUYr0taOpVOlfjFaQBsMDcZGEzGnI1ImHDQS?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tpee/28umwiqC8cZxLHbJaEWSQLZkINbPExUQm3IrBDxKIRnfizezNAXlrYKcr0F7bekeJHlUIOuz8CjW6bmf/2EXxGD+7+sX/QOdPZZTy9cTYGXAVxUQ91Wp2OTspTZZghwNV7icFMzqdVfAAm0gkmnntMwcwNWttpyOcHyiAPvW4pGzA+Nhu0ngBBYnA3l5YS7xsLoGlS8RqS0K7VwPZNGQbbsdkSM0uuwPaXuMt2uOyY+QV4h3VuAte5sLYqxyC3j5+U6FQC0hroEIvlJ3PzPtogjyXJ2LwiIARBqEvQhJTuNAlf58/778tycvFtB61DPbpvRG94ouwJQiq+gxiUr2F5Vl60rL3lcLW/O/BYJZg0Vj49FiuB6ihMgXWovzYH26MnDMP/5wjtaUtlOKGVovtZfqIFabEFDUugXjj5yZdFpHIn5bzMXXamTxYREaeYHgXzh5t5VOaYqm3nOUFToe4YeJ1VYsBcFg+twVpfmO0IBPR9oSVPR3asu7k6PVgdZBSiUKLxuJO2eCUFDlgIsBaZnQBFTmpvf5g0aj4IwIIEF4r0sj6Ttmq5DrGeqHVF/DgVPlwvCg4KiXfXHdkIUY1POzKor13YHNyO9v609bL0ahOPwUX48CHy7ZDHLg/PL49vSdYzm/xMgSOYnMn6Om7ApBAdM7jrk8B+qBbb+ZKWvFgZswYoIKd2pwDGPV2ZOMKKgz/pf2g26239vvQjZayo6FoTHhCE4dW4J56LSQZ6XHSGo36UVwY3hkd8D6DRL5kYZfmITR2yEq1rq/Atm0nr/2Wu0DXnblnLJJ2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93616692-a24a-4801-4ba6-08db01a28df4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 02:43:08.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CnZyqC68dvTkCnsoyludoX3wTd+988XAa0ObP9SG4BsL8Ov2ljClPxB5tpFT7fsW/Ythnp/T2cNUNZ7VFvL/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301290025
X-Proofpoint-ORIG-GUID: gxMDh1hL8ZzWCa21z09o6iFbdCUvY8c4
X-Proofpoint-GUID: gxMDh1hL8ZzWCa21z09o6iFbdCUvY8c4
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The warning is due to 'strncpy' with a maximum number of characters
equal to the destination buffer size, without space for null termination.

aiodio_sparse2.c: In function 'main':
aiodio_sparse2.c:404:9: warning: 'strncpy' specified bound 4096 equals destination size [-Wstringop-truncation]
  404 |         strncpy(filename, argv[argc-1], PATH_MAX);

However, PATH_MAX is including null termination at the end. Anyways, fix
warning by setting NULL.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 src/aio-dio-regress/aiodio_sparse2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/aio-dio-regress/aiodio_sparse2.c b/src/aio-dio-regress/aiodio_sparse2.c
index 51ede5bb6c8b..685e3b9dce48 100644
--- a/src/aio-dio-regress/aiodio_sparse2.c
+++ b/src/aio-dio-regress/aiodio_sparse2.c
@@ -402,6 +402,7 @@ int main(int argc, char **argv)
 	}
 
 	strncpy(filename, argv[argc-1], PATH_MAX);
+	filename[PATH_MAX - 1] = '\0';
 
 	if (alignment == 0)
 		alignment = get_logical_block_size(filename);
-- 
2.38.1

