Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4500CC433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 06:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5B8613D8
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhD1Gva (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Apr 2021 02:51:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhD1Gva (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Apr 2021 02:51:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13S6YVMU113317;
        Wed, 28 Apr 2021 02:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8d+7Y2R4nSFQ36ArtiYC1U8cbvx5JI51aJ5be9ktRIs=;
 b=omkverR9Eam43+D1V+cDTf0uAUXhcU1qoTcOoFLvcUwLAB/irrffhK97awLYlX8EFqD/
 x01CAvHxPFus3nNws1SlYrnuoLKrL2g2lCiod7ugvPs90jLUzPPa3rb+P2d3nvNBuGL5
 OLtQZFlxNBsHAzSWlWLn40g/us9vUTLkG539U+jH9icgV1UMc+gWGl3McpZZDFNJvWPg
 vLb/+fUXDyvfKYoahd4L/EulbV1ZJLyN/suViTTc2DMTBvyKEYljlTGH+pUPvm4NAzC1
 WZf/J/L7B2Nl7/9J0N+7pJjvtkzedB2Kx7aLc/SEWJmTNa4opmHYC6N6c6Slq/RLNjeV IQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3872dh8ks2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 02:50:43 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13S6mHtL000742;
        Wed, 28 Apr 2021 06:50:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 384ay80y55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 06:50:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13S6ockY45154698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 06:50:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C4FC42045;
        Wed, 28 Apr 2021 06:50:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9808F42047;
        Wed, 28 Apr 2021 06:50:37 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com (unknown [9.85.96.232])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 28 Apr 2021 06:50:37 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] idmapped-mounts.c: Use renameat instead of
 renameat2
To:     Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org
References: <1619418187-19951-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1619418187-19951-2-git-send-email-xuyang2018.jy@fujitsu.com>
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
Message-ID: <153ef5a1-a0fe-57c9-c00e-ec1224b2b1d3@linux.vnet.ibm.com>
Date:   Wed, 28 Apr 2021 12:20:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1619418187-19951-2-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XFimGWnnlxWA3xNFcoz4HTZ6435F1woB
X-Proofpoint-ORIG-GUID: XFimGWnnlxWA3xNFcoz4HTZ6435F1woB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_03:2021-04-27,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=965 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280042
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 4/26/21 11:53 AM, Yang Xu wrote:
> We don't add fallback for renameat2, so it build failed on old kernel.
> Also, renameat2() man-pages said as below:
> "renameat2() has an additional flags argument.  A renameat2() call with
> a zero flags argument is equivalent to renameat()."
>
> In this src file, it uses zero flag for all renameat2 call. So we can use
> renameat directly.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---


Looks good. This fixes the build error.

Reviewed-by:Anju T Sudhakar<anju@linux.vnet.ibm.com>

