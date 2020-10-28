Return-Path: <SRS0=Sugc=ED=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83BC4363A
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354B52245A
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="REM2dT7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgJ1VvW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:51:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727766AbgJ1VvO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Oct 2020 17:51:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09SDWnVK059838;
        Wed, 28 Oct 2020 09:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ph1GMM+eP9yubj5/QofuuMz1DnRLzq2F8gvBeQdLjO0=;
 b=REM2dT7k0mnU6ctnMU5MjEIxmPXE2jWZeZdtmWohjWcM5eE4+HTBWWfLXBS2byyh4Agq
 ZIozcm8Kpf7nREHmTvDViRG/aoxhhiacDlRawJPxIj7+WIdpDGb8hJzFZG56sT34RlXc
 oShkPiHNsz/i1Afh77/97mWyoEZDBYr+ozzAzmLe9iqsvP4yO3jIw5CBNUG7L/ITj1iy
 ny6BNouitrk8VoALnDtiSYJiuxM7EoN+JWlZVSE9ienepXdAyhXA4knKmcP0mJrNtzmG
 sj7Cp9JZMrleOlrYIWiqiMWBNr8DvmhIuSJgbFNQ5kfkqCfsZoGI4UbvlgjiIL0Wsxgv XA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34dcqfjj1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 09:56:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09SDnZtS017181;
        Wed, 28 Oct 2020 13:56:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 34dwh0h8s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 13:56:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09SDuIQb27656482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:56:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E003DA405D;
        Wed, 28 Oct 2020 13:56:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B2DA405B;
        Wed, 28 Oct 2020 13:56:17 +0000 (GMT)
Received: from [9.199.33.247] (unknown [9.199.33.247])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 13:56:17 +0000 (GMT)
Subject: Re: [RESEND PATCH v2] ext4/047: Add a test for inline_data vs. DAX
 inode flag
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
References: <20201027025211.575303-1-yangx.jy@cn.fujitsu.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <8d0a0440-ef91-e580-7e25-5ded117555d8@linux.ibm.com>
Date:   Wed, 28 Oct 2020 19:26:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201027025211.575303-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_06:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010280092
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 10/27/20 8:22 AM, Xiao Yang wrote:
> Inline_data is mutually exclusive to DAX inode flag so enabling both
> of them is not expected and triggers some errors.  It's a regression
> test for kernel patch:
> commit aa2f77920b74 ("ext4: disallow modifying DAX inode flag if inline_data has been set")

Looks good to me. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
