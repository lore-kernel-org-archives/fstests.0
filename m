Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBFEC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 22:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351540AbiC3Wap (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiC3Wao (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 18:30:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE95AA5F
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 15:28:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ULS0iJ027896;
        Wed, 30 Mar 2022 22:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GHZLb8mg1RPJjVedMI9XZNfatEnw6ReU9VS9EULuatI=;
 b=tPStftEqQabIrGfAtZiCDgUF3TG3XOmCYGCn+prFzOwJk6pROFcBY0UNQ4O5XxH0kovx
 vmioX1J4+ZatUF59fWAKHZcjb+89Vjob0z8SiOB8+3dBKWulNrj2tSle4vjvu8olbZzO
 ZaGFyLKXLimzqN88vxDhC8cJ+ilgF+JuiDWmLzvYy8tWE+eQqFUO1ZE42WIR/A2Zlk9E
 r/eFGT9Rm0NRerlt7nQwMgHO0ilHFx/BhVjqZXqpNX6nKMCmLHlD9F+GAS+0+lfjLXi9
 aLFhPxQCU85i7Ja/+1vR4gZyhmizlHQuacQVPm5Tqo+s8taqbBOLp0yDwY5rjHvBdD/b AA== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2juu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 22:28:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22UMHPhZ077736;
        Wed, 30 Mar 2022 22:28:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3f1rv8fue1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 22:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6na3D3L5LkV9rC/7U9FptldSgLCw1exoPrNQGK2obSduZb2AQr0IQ30jTaQEe0tNiDFRi8O0SoPKIJV0oBPlDXctvFaZznIMz6OoLQcVTDt9/jXBOWMkX4mPf2fL5f2BOTWFOA6fkP3nFm+yJXmZNoGQbQc1Np14Foqq0tcP1taQgyR26/3SKj+vssX2SKmMWElEhIUWrpZLNwvZoIplMbpYYWt0ln4f7uF6iYPcITYHC7kfuFODUe/AmB8ok9kW9bM4ALMLBCX+eHzl5FV++etn/Plm0nWjy8I8QOP44zRsX6dlQkl1oGp2+m47QgPtMmOObMqYgoZBQfjXtVhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHZLb8mg1RPJjVedMI9XZNfatEnw6ReU9VS9EULuatI=;
 b=f7h4IFjDkqwssOCL2/7twMeOev8u0689UtCT11wVRPqk10s1tKXGo/Xhr/yU0vKnEwugLoaJL1PGbwLRHD9EYL6P6aF+MKWkCVrQPU93I+kmczX/sTQjfLd24oH4UHBJjbgv7+xB/0VDlJyAFl3Gh6gQFqOV7ne2cLA6rCm0Pd45IayiU0fG0q6Nq5C4fogNw1uS3IFhdIlRtFmkHW+ejnPMNKJtBaw/Zy+ZGH5CUXdp+y1/MvQXoWto4iTvKPouux5gsSXIZNaJer6/3tTpjKUuRBDtkQUbe2qPFWHsqK5j8WVFl4hTkQPkf7OO9y4CrWKyvtru15u5H7zsBBco9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHZLb8mg1RPJjVedMI9XZNfatEnw6ReU9VS9EULuatI=;
 b=XTZNqX4toVKmRAbET+5F2NPP1r3DZtlqx4sSVgex46dCqQJDhONdRiHQ6MgunB/LPDPuILAjb7GRjbiirR1McclYiCfkhHoMxIeTU3OefHUswPY/xkR3mAI9+rZgXlMYYxkxlTgcwjwUNOXxRrMfCVsr7Yy2z9GzMRriLRTK11g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 22:28:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::54da:72:aa08:9a8e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::54da:72:aa08:9a8e%6]) with mapi id 15.20.5123.016; Wed, 30 Mar 2022
 22:28:52 +0000
Message-ID: <9cdff0dc-0bf9-47ed-0598-f782daa8f2e8@oracle.com>
Date:   Thu, 31 Mar 2022 06:28:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: drop no-op count=$(( count-- ))
Content-Language: en-US
To:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
References: <20220330114540.1539-1-ddiss@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220330114540.1539-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963c68e9-a7b5-4ec9-7f45-08da129cab00
X-MS-TrafficTypeDiagnostic: BYAPR10MB3158:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3158D77C0884A8668D77F264E51F9@BYAPR10MB3158.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5F5rwbyRWiik8heWAVXJVrCNZBeN1Yu+5mfXz79GLM3wWYrU3kv7EEJ1FXGP+NdQ47CoyiyZfjcwyyN/+oboiGTE2WwkqPbns8BcG9DB/dRafpb1VXvWdtFjE4pif5cl5u4TEboeGKxLdQPuGQloMq3v39hErhhKvDXJo/re/7T+KZ0z9DykfaR6CcVgYqWJtSMlNb+yyhDM1PmA3iC++JoO6HuH7PVDWWztee/GvIzQyYci+m8k70sRI1JjWOrsZMJCcJ6nabdBzEvS/eniPRMGHn8ofZ64UT6NemgBC50rqA1czElUxXiT7VbIK3bk+0fHxpXB4sTFVUWaq4aZFeE0Fr5+RUXInBV1Fy4WlF6IgwhFsukGGcDETR6GXLvIYCNboTilb0eQhwvj31dEU3l6pijRar6d9c9a1PqzexL8Janr2JcdI5EQ34hVD5WX8cWUDpYRO0qouEK8fUmFD7IM33Bl5lnRQUL7GIO9lFhjhzzHq2ILw+qbmGIyBtWGtLzS/3Hd6YzFEXFp7xXZYUU0Ov+1onGaGBLGJhgcEN5M/CybRw1DrEsCbvqfchClOlisqhBIiZUe9Srwk6tkzfJb450rjFIVE/rM6/7IkD2xOVdzmQvXipPVtC4+RwqdP5HBaQ/FuoFoYtIpHMNG2JHHREuOgTmrbGaktgByJWCt7g472tGMDe0us5078lADZvar5IXKXMFiGlvzaem6wi5csYI2nBMCv7dd9J6krSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(316002)(83380400001)(53546011)(508600001)(6506007)(6666004)(6512007)(2616005)(26005)(186003)(66556008)(8676002)(66476007)(6486002)(2906002)(8936002)(66946007)(36756003)(44832011)(31696002)(5660300002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0szemswZFkzR1N5cHRZQnpLOXc4UVo3RG5HTUh3Y3R1djA4dWRlN1RtUEhT?=
 =?utf-8?B?aGlGVFl0Qi8yREE4WTNqUGZUUlFnV0xteUs2cFhXZ09wTURQejg3MGFQaDZP?=
 =?utf-8?B?T1JpanV4UC81UWlPRWRUL2RKOTlzcjN3b01rMWNrWFZKWmRyVGJ0ZVM1SzNv?=
 =?utf-8?B?c3VMaDJ5SVNOOU5ORjRTUmJ2VERRR0EvT0pvZC8wdURJdW5LOEo4WDhVaDhv?=
 =?utf-8?B?eUZXdVA1OTRSWFR4MC9JZmxEVUJIRVQ1Yld1WTk2YW0rdFZKbEpUZEpNM3FC?=
 =?utf-8?B?bU5lY2pIQXJIbGNteWNWMFNzOWw4YzJpdEJwU3Z2WGcwNjQ2RnovSUhBckhv?=
 =?utf-8?B?bjZvQzFZYUNXVm9XQTkxSk9qNzRqQU93N1B0bTYxVis2UXRyS0JuOHVVUUNI?=
 =?utf-8?B?emNQWnlheHV0ZmRNRE82dElGQnFKZlJRRzdVT0s5eE1PbHZqbzJ0QnJzMWwz?=
 =?utf-8?B?em11dExUOEhUaktMRXYxU2dHMC9VM1FWVngydHMyZG1CR0F5Q0d3TGVJV1k5?=
 =?utf-8?B?aFV1MnVZdEloRUFzQ1g2VUdKNzQ0MjlSZlBBb1UxeDIxWkRWRmhVbnRtRHFl?=
 =?utf-8?B?LzVSWWNSREFGVjgyQ0VNc21IaE1TOUxKV0pTWlhiOFBURzhvVklPaUxkclk2?=
 =?utf-8?B?VENsakxtZnNET2l2UGVLNEFyQWV0MkZWWnRiRGxlUFZzTE1oeHBNT21HRHVH?=
 =?utf-8?B?ZVhZb1FGRmRPN0Z2VzNQSC9PSWZDYlJKSWhGbnZ0aGhYUUl2WjE4UFMyL3pX?=
 =?utf-8?B?QlI2RWZ2YzViWGpBcHdkSVdIZXdhYnUzY2JpbUZ1TmFRQkJPMVRkSFBOb2o5?=
 =?utf-8?B?QTV2U3VvYWdHbDQ3dHE3ZmI0ZzB2M3U2N3duNTkxaUlBYkRMdmhJRzkvUG9m?=
 =?utf-8?B?THkxQlNWUkEzd1ZMdFVKY0NsUUtoQzBza21mUEJHNkN0N1JkOHVSSm53bzhC?=
 =?utf-8?B?ZFRvNnZxbU1va0dYUDlKUFVTLzdXd1hZNTFSY2RCUWp3WkZHb0piNlRWSlVX?=
 =?utf-8?B?K0xucytXQ0huelB3b2h6Y1NpTG5naXEwTy9vL2JDWExCUU9tcDN2REhVR3ZU?=
 =?utf-8?B?TmNkZkhRcFEvckpZanFXL245MzJHVXE3U0VjMTA2SGw2ZWYxOFBSLy85VzRx?=
 =?utf-8?B?OFJaVFgvazBmYWIyUW1FSUNFTS9sQ216aFVQWWdEUGxhTkxGdXBqVTkvWENa?=
 =?utf-8?B?Y1RITVBmQXZTQnhDWUlkb0NDS28ramEvb1pWWlhVMTc1Wnd3N3VCSFZkbHZx?=
 =?utf-8?B?cFFtRmV0d2lNcXNNYk9DcGxGUmxTcnVtbWRkdlRGNkZ1VjJSblprNEtmQjVp?=
 =?utf-8?B?WXRBVTRnSXA2OHRIV2ZZNi9tSmFFQ0VYTnIxbDIvRllMRnIxSmFWZG4xSkRT?=
 =?utf-8?B?Z2JDRmhYOWkwSTN5MC93K3lVUWg0VzB6Nm50QzhiQ1ZHTVRnbkRzc294QUxB?=
 =?utf-8?B?RzVHWHkrNzMzK2FRclZGZWs5MnpHaGZ3SnJreSsybC9iZEtJd0QxODloMEVa?=
 =?utf-8?B?OFhlY0NZb2NuYmRIdGZUV3IzT0p3Njg4VVFySERUMWRwU0RnbnkveitKU21w?=
 =?utf-8?B?ai9FTVRKSGY3N256RWczbE51N3B1ZVVDclNOeTgyTlp6amtxeVJoMXpWWDdI?=
 =?utf-8?B?RDRCNTFiL3dDSnBzODFzUm04UDZ0T1JTczhLbXhQd0cydk8vSTk2YStMMnYv?=
 =?utf-8?B?dFVtSFlGL3oyVnhTR1FzZFRWUGFqTWg3MVl1WVZFY0xDODg0UlFCUlZkcGZj?=
 =?utf-8?B?d1d4ckFKVnpMVGovNDZ1ejFYRk5sbTFOS0xIUkIreDRGc1VjT1l4ZXBmcisx?=
 =?utf-8?B?dEp1OCtFcjFZTHNKOU1qK0RBYzZtTzJ3b29TVkVPbUZrandtSC9aaWlZbmw3?=
 =?utf-8?B?a0RqQTBiUGFDVndnNUI2a1RrSXN4NVl0RS9MRlpqR001UGl6YkhWVXlpaUJo?=
 =?utf-8?B?RUozRW83bXkyUEV5dkJvekdwblIwYWFDODhCQ2JVVDhBbThlaUhUM29USDNY?=
 =?utf-8?B?akdYZWd0d1VOUitYVlQrMnlvSGJ6ZU5kMXhoVFlTODg1VWVidVIvZ1hoNlpr?=
 =?utf-8?B?WnNROHoyZWpXdXBwL2FFU1RzdjcwcStmVjNYY1Y0VmRsaEtKc3pnVTRMUUg5?=
 =?utf-8?B?bWw4K3FjSzRsYXNEa09zTDl5VThnRU93SWRNWDlWMkZLeHArNENnSEJJOEZ5?=
 =?utf-8?B?MEN3Mis4bXlqMVpnT05sb2VxbURuR21UelBZL1dTZG9mSDkwQXNGNm55TXo5?=
 =?utf-8?B?Qi9DajBGVzFsc3cycmN1U3dRNFkwN0hIaXdGM3BtS0hwWXlVTHZialhyRmxw?=
 =?utf-8?B?TzF3empZajZuSlVHUHFxK3B6V0ZUb3FGSWQzNitrYjhkckQ4NkVtNW9vV2ox?=
 =?utf-8?Q?MGU2AEzi7hIbdmT0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963c68e9-a7b5-4ec9-7f45-08da129cab00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 22:28:52.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/steuhq7qfHNi/goz5XowVKznjRn9NZUVmeh/hp8t5QhyLTOZkubIeCbB/+/A9rWvTZ1UxQEsF+P8AnVZsJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3158
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10302 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300108
X-Proofpoint-ORIG-GUID: WHPuIyekeHJXPjjkEP5xmOMfiZXpyqo1
X-Proofpoint-GUID: WHPuIyekeHJXPjjkEP5xmOMfiZXpyqo1
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


Thanks for the fix.

Reviewed-by: Anand Jain <anand.jain@oracle.com>




On 30/03/2022 19:45, David Disseldorp wrote:
> This line doesn't result in a changed count value. The tests don't
> appear to rely on a decremented value, so remove the line.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>   tests/btrfs/124 | 1 -
>   tests/btrfs/125 | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/tests/btrfs/124 b/tests/btrfs/124
> index e8d77aaa..3d8141a1 100755
> --- a/tests/btrfs/124
> +++ b/tests/btrfs/124
> @@ -74,7 +74,6 @@ _scratch_mount >> $seqres.full 2>&1
>   _run_btrfs_util_prog filesystem show
>   dd if=/dev/zero of="$SCRATCH_MNT"/tf1 bs=$bs count=1 \
>   					>>$seqres.full 2>&1
> -count=$(( count-- ))
>   echo "unmount" >> $seqres.full
>   echo "clean btrfs ko" >> $seqres.full
>   _scratch_unmount
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index 44ba49ec..b58f2aa2 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -80,7 +80,6 @@ dd if=/dev/zero of="$SCRATCH_MNT"/tf1 bs=$bs count=1 \
>   					>>$seqres.full 2>&1
>   _run_btrfs_util_prog filesystem show
>   _run_btrfs_util_prog filesystem df $SCRATCH_MNT
> -count=$(( count-- ))
>   
>   #-------------degraded-init-------------------
>   echo >> $seqres.full
