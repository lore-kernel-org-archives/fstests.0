Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D296EC07E95
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A5361935
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 07:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhGDHbt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:31:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229492AbhGDHbt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Jul 2021 03:31:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164741jb061689;
        Sun, 4 Jul 2021 03:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lQjKCaYSDdnMuEs+ahV43BNkH1ZuUJOYtg+GBO8Kfys=;
 b=FgkIRT8NpGzjo4fbMoJfv3HB9isctvaCVgynNlcW5pE3g4KWXMEp/iiSbMp4ktuXh7tG
 gEAX7VltYrNwJdXR/qjErlO4cWvLoOrOlhi8S80wUlXjM3jUr/yzvx3yx3bqNJEaW0vi
 9wPqd9F5BFb+GOUiHtQx5mJXdsKVFvvRe2hWD3EtDoNSKhacnU2m6n/UFnx7mBY9GTvw
 fNynoU61dT11qzVc3I4ZKbb93Z4JfgfO6IuF0RqUYlFvpkE4cUohETZjwENyswBqEHbZ
 /XHEoqrf0a8aKVkQD/StFF3BwQpkL1gMcJkVdHcaY3dlJ0ljllmmrq+7etkDgdbvojr5 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39k5h4jv5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Jul 2021 03:29:12 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16478MZT074120;
        Sun, 4 Jul 2021 03:29:12 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39k5h4jv50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Jul 2021 03:29:12 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1647BjGU011356;
        Sun, 4 Jul 2021 07:29:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 39jfh8g5h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Jul 2021 07:29:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1647T7gB31719788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Jul 2021 07:29:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7E9611C058;
        Sun,  4 Jul 2021 07:29:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D33E611C054;
        Sun,  4 Jul 2021 07:29:06 +0000 (GMT)
Received: from li-00db19cc-1f39-11b2-a85c-fed2f2ec2619.ibm.com (unknown [9.85.75.107])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  4 Jul 2021 07:29:06 +0000 (GMT)
Subject: Re: [PATCH 2/3] xfs/514: Check xfsprogs version for verifying the
 xfs_db commands
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, zlang@redhat.com
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
 <20210628085259.120666-3-anju@linux.vnet.ibm.com>
 <20210628153524.GB13767@locust>
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
Message-ID: <35562276-aece-fb81-ad2c-ceeb3decade9@linux.vnet.ibm.com>
Date:   Sun, 4 Jul 2021 12:59:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628153524.GB13767@locust>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6JvG0gXh9yptQJO2YPF8xMB-eunbhC79
X-Proofpoint-GUID: 6c9-EZAL_VXFBnQ3mGRe3WTndw3x9Udk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-04_05:2021-07-02,2021-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040045
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

On 6/28/21 9:05 PM, Darrick J. Wong wrote:
> On Mon, Jun 28, 2021 at 02:22:58PM +0530, Anju T Sudhakar wrote:
>> xfs_db commands like `attr_remove, attr_set, btheight, and logformat`,
>> are documented only in xfsprogs version v5.5 and later. So skip checking
>> for these commands in xfs_db manpage,if the test is running with
>> xfsprogs version less than v5.5.
>>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> ---
>> Query: The reason to add this check is, while running xfstest with an
>> older version of xfsprogs, this test case flags as failure, though
>> xfs_db is not expected to have those commands. Otherwise upon failure we
>> should ask the user to use the latest version of xfsprogs.
>> OR is there any better solution for this?
> If you're shipping xfsprogs 5.5 in a product, why not update the manpage
> to document the functionality that's in your product?  If you aren't
> shipping 5.5, then why run such an old version?
>
> --D


OK. Then I think we can drop patch 2/3 and 3/3 in this series, as both 
checks for the

xfsprogs version to run the test.



Thanks,

Anju


