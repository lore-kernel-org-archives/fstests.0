Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72069C4361B
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Dec 2020 05:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A5D2332A
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Dec 2020 05:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgLPFWX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Dec 2020 00:22:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725274AbgLPFWX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Dec 2020 00:22:23 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BG52Bav154999;
        Wed, 16 Dec 2020 00:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lGLlsMl1IWO4zYdBDloo/64NxAJhTc/zyCLP4aYE+Aw=;
 b=CROUzyZ4WEIreKo+Js//CF8rBQI+9RB/0xoprh88oyvF1I8vOFG6y7uoCRwMvcqlfidq
 5S2n2SdukJNnwSALbpCIWYJeEroWgxOpYUmWAIrzeCOkRiW2TPWMh2d9QV+4jhTa9ANg
 gYhFsdHQqGUMcwjfLnJUKp3Ywd2klvaU5um14qn9jZtgVfqvjv8+gQNm8ojI9ImP0+Tc
 kYHDTEql+8w84Z5DAvxO8gHbkW6jt6MMgxqIwkKoIshcXTR5RbGe/9BMimq/Ukzs8tF8
 Sn0c3S2s/0s1Oc16CK51D/rwKM6GlBP2TqqUzDyCXAzQMHOQ/HikV5hUR41Ka5+EpMXt jQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35fb0s1cvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:21:29 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BG5ILUM026814;
        Wed, 16 Dec 2020 05:21:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 35d3109rwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 05:21:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BG5LPQI19464694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 05:21:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDED34C052;
        Wed, 16 Dec 2020 05:21:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AEF54C044;
        Wed, 16 Dec 2020 05:21:24 +0000 (GMT)
Received: from [9.199.42.232] (unknown [9.199.42.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Dec 2020 05:21:24 +0000 (GMT)
Subject: Re: [PATCH] src/t_enospc.c: Fix an error for the loop initialization
 declaration
To:     Feiyu Zhu <zhufy.jy@cn.fujitsu.com>, fstests@vger.kernel.org
References: <1607569194-25989-1-git-send-email-zhufy.jy@cn.fujitsu.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <73b0fefd-bfd1-1f1d-a714-cb2b42b479f6@linux.ibm.com>
Date:   Wed, 16 Dec 2020 10:51:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1607569194-25989-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_01:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=955 clxscore=1011 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160028
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 12/10/20 8:29 AM, Feiyu Zhu wrote:
> When I compiled xfstests using the gcc(version 4.8.5), the following error occurred:
> t_enospc.c: In function 'enospc_test':
> t_enospc.c:88:2: error: 'for' loop initial declarations are only allowed in C99 mode
>    for (int i = 0; i < size; i++) {
>    ^
> 
> Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>

Thanks for your patch. LGTM, please feel free to add.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
