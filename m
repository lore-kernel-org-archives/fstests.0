Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD23CC4338F
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 06:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20DF61374
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 06:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhHYGR1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:17:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238328AbhHYGR0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Aug 2021 02:17:26 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17P649oC118200;
        Wed, 25 Aug 2021 02:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IVsLcRBc0x/H0VPCSaOyqpgePakwOQ7/wrz1tuvWzYM=;
 b=j0xyowoTzUGQ1XEu7lwms09/Z02FSIVhHeuBLsJd4lI3FpzSbqsLE+suxJMbPOg83d0S
 jtrdP7Od5aq6J+iuyOPJoCIdI4IKtBNmtcBKOuEC0LNWzGnwkmA+/l5dQI9jtGWy+Ev/
 /qOh7b0FA5FeihDq6dxrUS7omUQzgORloWPrftlFCm5El5/pZioKENDqGpQGTqyqp/14
 0JaB5V2AAB8iBOZ2ZmdlKZ0HvT7KYy7xNjz13t+1xHKZPC52Xzfu/+EnxWwVWF4BKeEo
 BYrv3mh4rz9r11slAX5piHMwbFbq3HfXkE0KuATGFjCQ4CPeCXKw8s4ouT9XG73WeZti Jw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ane0rufnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 02:16:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17P67s7o009761;
        Wed, 25 Aug 2021 06:16:32 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ajrrheeq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 06:16:32 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17P6GUoL36569542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 06:16:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA814C073;
        Wed, 25 Aug 2021 06:16:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 197334C04A;
        Wed, 25 Aug 2021 06:16:29 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com (unknown [9.43.109.130])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Aug 2021 06:16:28 +0000 (GMT)
Subject: Re: [PATCH] idmap: override btrfs_ioctl_vol_args_v2 if system header
 doesn't have subvolid
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
References: <20210823182138.GF12612@magnolia>
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
Message-ID: <35f0a5ad-fa17-d149-28a6-d16bcde0b4ec@linux.vnet.ibm.com>
Date:   Wed, 25 Aug 2021 11:46:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823182138.GF12612@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gTWYYOZjrPDQQZhLKRxr_0GAy9S6qNlz
X-Proofpoint-ORIG-GUID: gTWYYOZjrPDQQZhLKRxr_0GAy9S6qNlz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_02:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250033
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 8/23/21 11:51 PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> The struct btrfs_ioctl_vol_args_v2 in /usr/include/linux/btrfs.h on my
> system predates the inclusion of the "subvolid" field.  This causes the
> following build failure:
>
> idmapped-mounts.c: In function 'btrfs_delete_subvolume_id':
> idmapped-mounts.c:9730:6: error: 'struct btrfs_ioctl_vol_args_v2' has no member named 'subvolid'
>   9730 |  args.subvolid = subvolid;
>        |      ^
>
> Since this source file contains its own more uptodate copy of that
> structure, add some more autoconf/cpp magic so that we can override the
> struct definition if the system header doesn't have the desired field.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

LGTM. Thanks for fixing this issue. I too hit this issue in my system and

this patch helped me.

Reviewed-by: Anju T Sudhakar<anju@linux.vnet.ibm.com>


