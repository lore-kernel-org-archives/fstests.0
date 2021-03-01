Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CE7C433DB
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 06:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D81E64E3F
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Mar 2021 06:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCAGCC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Mar 2021 01:02:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229955AbhCAGCA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Mar 2021 01:02:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1215X5CV119775;
        Mon, 1 Mar 2021 01:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PidSYhlAi9d66nXRGbFFCAjGXq7cGl0M0lgNNfTuHO8=;
 b=j/M8cd9N56Ar76/2AnF1i+/qWS8XWma1dGUKdN/4i7Azmlbg1gHMieOB3DvQjchtZy4v
 quXCHad/dQ3sK9wHc7VeLLeEa+j1q7UBkehK6rijPtp/aKMgIfV5STKgnoU6V4Td2vyk
 +o/YTpnIjFpvhXEDc56io/8EXWpfHi4fTB15jGOFr7s05MZAHAF6LL2myS6B+4By0tb8
 EP1dyVpZN52J+YjE5osO3bof021vBr+pDMfL02+MTh1+sEmsrkVf/wfpA2TYesAwjBvR
 +TByS4NXtC0s5SP2L2rEcbk5iOu4qEBVwpQSdORggqiv25tMi7NyC3glcWhY7Xktxhiz Fg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 370s40t80p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 01:01:18 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1215lhsY012479;
        Mon, 1 Mar 2021 06:01:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 36ydq88skc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 06:01:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12161Ds539321996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Mar 2021 06:01:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78DC8A4040;
        Mon,  1 Mar 2021 06:01:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF14FA404D;
        Mon,  1 Mar 2021 06:01:12 +0000 (GMT)
Received: from [9.199.35.194] (unknown [9.199.35.194])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Mar 2021 06:01:12 +0000 (GMT)
Subject: Re: [PATCH 0/3] fstests: -I <n> CLI option and some random fixes
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, anju@linux.vnet.ibm.com
References: <cover.1612951443.git.riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <8af6b368-1044-4e6d-0470-5e4de18e9a16@linux.ibm.com>
Date:   Mon, 1 Mar 2021 11:31:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1612951443.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_01:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=631 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010046
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2/11/21 9:01 AM, Ritesh Harjani wrote:
> Patch-1: is a v2 with comments addressed from Eryu.
> Patch-{2,3}: are random fixes found during testing.
> 
> Ritesh Harjani (3):
>    check: add CLI option to repeat and stop tests in case of failure
>    common/rc: Add _require_get_hugepagesize and fix
>      _require_label_get_max
>    generic/{413/605}: Add _require_get_hugepagesize check
> 
>   check             | 8 ++++++++
>   common/rc         | 8 +++++++-
>   tests/generic/413 | 1 +
>   tests/generic/605 | 1 +
>   4 files changed, 17 insertions(+), 1 deletion(-)
> 

Ping.

-ritesh
