Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01434C61DA4
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Jan 2023 02:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjA2CnD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjA2Cm7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 28 Jan 2023 21:42:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB976A1
        for <fstests@vger.kernel.org>; Sat, 28 Jan 2023 18:42:55 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30T1REXo016229;
        Sun, 29 Jan 2023 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8nG7wHmx01SMcshV/KfoyqtTMTNjtawhrsWDntjSngA=;
 b=I1xcN8UDXr5Jhj850qGHvs6xXOhuYJrUPA/XuLgsLV3qPVnuIXfazY+fahjYxKBsqhbJ
 tv9syIM6mtdyjMdB6HMVZILB+BwsXnIP5wh/yPXMASneW3KdfllBa1UbyEfT9iJ6gmd0
 WLZ+tiOw0zagMRmXnXsadR9Vc6ft6fdd2NH6mlrzksZxoeS1vguJz8wfyVPH5vudrKly
 yjJYlZEVCxvaqqW6gUlj26UIPQ3fAJT+azePloNGIGM98E+b9P5AQy5gUutGtTzqxLre
 O3EhMi39mbZQwAMoI7NyGTPuxONPniAMR1ATGsG4djWW8mi+NDAVbal921iquH2amR7G 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8gwum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:42:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30SLEt7a037461;
        Sun, 29 Jan 2023 02:42:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59hp38-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Jan 2023 02:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L42b+1QBvnevUo+yaHmwDHw0wRlLOxMCl/75ZTahIW8auQyY8xMNXyviAuIKVnKb1pD5m3UYlqz7x1+N2OtGhj3akAvmiwJP1A1aRpsV9S9qEJXD5O1u/4hpnY1NwYf1Ys+gMnpYvV8ZfR2j98AIvtitVP8ai6hUc6rJ+e7l2eHZVtrrMnCm84mhDjDra25EHpnwt79nBwuh4l+sR0ACaX+jbmisaji1B0JKyU/z1RMn2p4DEULr6w2xxn3KWZJQZmnPf8cUvHXNswUCAMrYh7rdlrckO9RMH9xwNVMmBGWH7COUk9KO0mGNCinO0YzKfjZPqigLrI9w43Q84ueJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nG7wHmx01SMcshV/KfoyqtTMTNjtawhrsWDntjSngA=;
 b=X+yyIZxHaj5ZtZ1SfOOtO3lquwU5N6IFBFoxWqVw6cD2xvKf+DRnaUdyrVZdXWYbdJVnE8lHmnyOchEDs8KpOckjgZT/z55fYngxvu1nrOkDgl6BXARk0hQeYG7t+eVU0sShrv17KZsXvq+lJMe67m0DYTJGw7lr3YU6+58izKW7NwwT30kffq3knPWg37PI4KeIxkADXACS+Vlsh/AuPct8lDty4HTNo/6pyn050kJOk2bj6UQbkw/HJ3HFjm3+oF7r1IQB8M+nu3mJydR2qw8ax99U5ki2vCLbBLxF2mcOFvrIFy9nSqhcxM7KtMap5xJfOQbWP4PdYUkIHW+gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nG7wHmx01SMcshV/KfoyqtTMTNjtawhrsWDntjSngA=;
 b=uun1GOXKQ8qxYexBki8cD+7tEjVsNi1fJOmrE0IUFRdJXFToHEJ0DDy//zCYn3jLoGvbFd5q6HrAvPTufrAY6pZASHZN1CED6O7mWdmdcmCSdVFD/rt2S8Gc9z+YYRDDpixRVVt8pSM/KoIEwzj9ZiFRHCYmSjcwJZP/8taVvGY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Sun, 29 Jan
 2023 02:42:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.017; Sun, 29 Jan 2023
 02:42:48 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org
Subject: [PATCH 1/4] fstests: doio.c, fix missing initialization of -C arg
Date:   Sun, 29 Jan 2023 10:42:30 +0800
Message-Id: <d8627cbdfff4554bcc1442845726ef7119b8ada6.1674870429.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1674870429.git.anand.jain@oracle.com>
References: <cover.1674870429.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 075e6227-53db-4d0a-e3bd-08db01a281f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kah05SSAeQ3d46NsBjaXQofzushigv5e5A0svIB9HFB25c6AFEVQRyor8uzE9CbaI4vQ20en/BbL/pgPeLih9QKPGAg9xbIqI1W54w7HFQpONoSsxE2hX7JJvllp45xzCIBcTTcy5EVJZhBbUZY7goR5Nl4Tt7PSIvqpS2jSLhpNlwroWePi11SkIrBeKhmOVTp13jxIaIQ+DU6+lysYSZTkqEz8TPbLbEhL7FqZy2mMmKUAn9IkFqpw5z/n7CWFhDhS+W7SSE4bGf0HIa6cTSEdKc9kxVThuwkvpObNn/QL4epKsL5s+FynNx+yAByRQk4hikmOcm75VSDSyjVep7habnDMc+BwAT4ARBvQVQsqkL9wHY/atlUsOdTTbL4yDI4fxtMDEM8+n+7msx2oa+1K1Fc5v6CghHa7VR14cCUuIIli+8e0Ovy0y/DGCpg6O1mtd99vSgqcCH3okjxebHxTfThBX+No/jB8RpGQkaYjlGY0SvMNh6wmS7CmTZxLaKpbcirLeX/n1OC6F+AJNr8KThm6oeT7F2OSoxjc1EaN4402keqq0tTTvaEG4tn2YC/USi830a9VZuj+g+SO0APOrjhq4L8JLLWJo5c8ejJwy4XqO3lH4xpElqf4p4GFQkNkIbqhUCocpaeEWLHogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6486002)(478600001)(26005)(83380400001)(86362001)(38100700002)(186003)(6512007)(36756003)(2616005)(6666004)(6506007)(4326008)(6916009)(8676002)(66476007)(66946007)(66556008)(4744005)(5660300002)(316002)(8936002)(41300700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1y4fGAGKQoRYWogqzWOiLjWNuT5ilTTDb8/lV7t0Dldz9oflRhCO1b0j4C65?=
 =?us-ascii?Q?jq7oI8+mTbiG+iWbZ+OimfjXw7E5d5LOgCaUQZCmRFh8kSjfCWuu1xqNh9Fs?=
 =?us-ascii?Q?GCXgB2Svj+OOQYs/0TYXTGJCV6Xkfin0LUejl8Dt1qZ1Zc5hWQSa2N46wRmz?=
 =?us-ascii?Q?9HayWWnlj9LLrrOX7HeUjxDaWvra4+WBTDbPc0kFHj6mlcHInIenQhF9Feo2?=
 =?us-ascii?Q?dRNWG5vaa6dTDHYdVYYzyck9kTu+K13RVVidKE00lx/ws1KtAbxyOlLH1wK1?=
 =?us-ascii?Q?FJYCTSnFzIYB/8oVA/N3XErQlLE032NSf3OSpV0yZiYwYc9+bgtssxFoxTJ/?=
 =?us-ascii?Q?2a8kotEoaObLhsFIKSdm7MHRTEzKgTw1VL8vvaSOKiRZ5IjTYhWpTPSTjdHT?=
 =?us-ascii?Q?V8VGVSAQ69q8wgcSyyvnZj4tl4uCchxt/scIUI+xhGwabwg8K5TbzOHuP8oL?=
 =?us-ascii?Q?49K2GYNzvyOglKIZldL/bIDXb2jTocjETQ93+9H+Gvcy5q7VrFeVNe64resz?=
 =?us-ascii?Q?q2QiRVJsJUcQSsWbWCdFFF+du3AkbfUEhQimTUvQOTVoKiRZMz7puQ2RqV5U?=
 =?us-ascii?Q?DY2kQkUO6wNoU8ciLJfYbIXmEQ6zgIDaJjV4nm+yyiTHnOZ3h4epq/OlqoJh?=
 =?us-ascii?Q?29a6WNAsfXtlpwnIi9v3Xw4JJOPAkiUeFv0tjeyiEDK5s4Ij100yMxXQU0AR?=
 =?us-ascii?Q?DLENdEWvVv80gX8R0PhWdU+Eb7OctrctSLurAH3t8ZuxtPyn6mgxv5J+U8AC?=
 =?us-ascii?Q?xzBHBC0F3fzGCT0MZ26bD4ocgC8Jux+jpp6ZSarYh0lSuE4wEkESdD9iDYGF?=
 =?us-ascii?Q?+Pz/SmfBXKFUvhqO2F8DQTT7Q0zHSDTMmDVh94XkmM88MgPtpHGktTmDHOAb?=
 =?us-ascii?Q?DXFdT1riFSYCn07KdC7+KU/QsXr40o8PRfJNFmZVI/RfhsPcpQ3ge2Grf8YC?=
 =?us-ascii?Q?nSrJlm3xryKo/kebnzXWMTIApvI3TX6SJp9nPBylFQDtA+LFjPNbCpuSniAe?=
 =?us-ascii?Q?f+PT5Ne5T36MW2t30CwtUK8hZ5pu1ppu+lJUA8lNPfECyioGiR0hoA2vEXO8?=
 =?us-ascii?Q?4iOO8eXQRPVXkygA54/yhldQp7bWuK6sZ3CYXgauQTHsAdbG5b5YZVEjhOMw?=
 =?us-ascii?Q?tgUvAy24a1cnjSsR+4hOTOBiCyWvGDri93WzSfFE6YSvJa4C3vdIXc+D+t6x?=
 =?us-ascii?Q?IRsuU+zVwI/WlHC5Ri7pj+1yRLVD90WBcAQEYXoSo25E/riZdWKHssEjokj1?=
 =?us-ascii?Q?NFQdSAKhqQOUItJpquBmitRChTo+8JvDn2vfPqjTjGKfbJZDcWhIt1iXla/R?=
 =?us-ascii?Q?OMvnfgrRIHOPIgG5WrTKCD6LsxvbwMoBa96MDPAMJQqwFHaWShYngVwwOSWK?=
 =?us-ascii?Q?Y27kev9Wy/+OF3QkpWRQHFoH3hT0f7amaswFojf+MH3G7nn73FBSTtOq22N/?=
 =?us-ascii?Q?bae1hl+jQ7jD4CMB4U4+7T6S9RN5ifSwFYfOo1BHMQOEX1E2lMAWZst9RqBc?=
 =?us-ascii?Q?n423Xi4H7XqZJXyt+r8qpWHXGtXzRhtVtlwy0ZDV+RhBJ9vzdOF3MXLREAQG?=
 =?us-ascii?Q?EevIH/KFmlCfWwbEue3n10HOubAq/kKVHT/MXn4oRLTeQRBeS+olR5z6fVZ6?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jy8TxgmbubBMP/j4IUPn/wnsoJS8HNLKKsdAvdBvtxhDYjSnZwjWXX9ysYBMCG0kIv2byYkRNiuJInAF+XVprPl7mI2pgay69XRvDj38aEniWyJrDJZKHkd201c9giHC1onjtfvrUCizBV3kDkAITuGgsBL2Ht/WcHEKihpRTYnsqi/i/bziWncy7VAbrTy7BOF8/AWpYBRsN6hWVEC+NqK/mT1Tk0nXAR/tqalp+TkGJqyIBjXgAz8v/WfjfSa+m8tyNnIy6qLy9wHAJnDrdAqI6GRlnj4nxpTXPjlAJ0eazpET0ESrv6IU2zR2j8bh4DtbzT4yq7Pj11W9Rsq4rUaKy5DZyhSd3pjlEHTBSSU6Kr+OzIqVNhvt3qKwrGg+QTiyismMYXKdf5U4FG4hkjdh8AWQloVw4y39FSQ8kENwPYVf0B7zhzMjvMFDtl61x02A1QfItqJ82of0Vqyz+UfJezL01i1xYeUuGen8tPz/pGF31bTkJvVAfb/8aCTLQTPTtqtegOVT1gEXb5g/39C0BHqqL0ZPvVUFJWPnunyrf6707w/wNst9aIf2rdVtJOYhM5VVuq9exakDtF7DhcxaHSbEjLdQ7gRx30iIHdWTBU1Q/+toh1jHQxQRJt8qb6tXF7S7tRY8q9cXtV3n2EpM0fLeG5hPy9RDYd4SgjBUMhPU9mxA7YyYUaIW3CtKm4joIzENeSwgDEd/OMyLtWX/efrOe2KTRkEKSe22oYTRVMutEpRm+etQMh4lVGPG38oP9vK1Z56GCIFnDBZQQnd+7fOt0cNOSCuYIgG6egI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075e6227-53db-4d0a-e3bd-08db01a281f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 02:42:48.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToR+siovgzbFCce8BkJG31E9eoxglpk0SQLuXarvYGOfB5tBTpiGI0CnkO3li0FhnOrbYFanwXh/zTwgOzH6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-29_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301290024
X-Proofpoint-GUID: 07dtQ0-8X-aXENLGXnVDWEvVVklJK7uB
X-Proofpoint-ORIG-GUID: 07dtQ0-8X-aXENLGXnVDWEvVVklJK7uB
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Resolves GCC warnings on null values for %tok.

doio.c: In function 'parse_cmdline':
doio.c:3113:33: warning: '%s' directive argument is null [-Wformat-overflow=]
3113 |			fprintf(stderr,
     |				^~~~~~~~~~~~~~~
3114 |				"%s:  Illegal -C arg (%s).  Must be one of: ",
     |				~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3115 |				Prog, tok);
     |				~~~~~~~~~~

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 ltp/doio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ltp/doio.c b/ltp/doio.c
index 83f8cf556325..fd64df0f674e 100644
--- a/ltp/doio.c
+++ b/ltp/doio.c
@@ -3106,6 +3106,7 @@ char	*opts;
 
 		case 'C':
 			C_opt++;
+			tok = strtok(optarg, ",");
 			for(s=checkmap; s->string != NULL; s++)
 				if(!strcmp(s->string, optarg))
 					break;
-- 
2.38.1

