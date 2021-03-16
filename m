Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7BCC433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AFC65064
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 13:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCPNtY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:49:24 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:44294 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhCPNtM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Mar 2021 09:49:12 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 09:49:11 EDT
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 12GDf2PJ120268;
        Tue, 16 Mar 2021 15:41:43 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 378kbrtekv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 15:41:43 +0200
Received: from [192.168.108.50] (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar
 2021 15:41:43 +0200
Subject: Re: [PATCH] common/rc: virtiofs does not support atime options
To:     Max Reitz <mreitz@redhat.com>, <fstests@vger.kernel.org>
References: <20210316130131.11792-1-mreitz@redhat.com>
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
Message-ID: <1396243e-a0ed-aaa4-e005-ecaa44870524@tuxera.com>
Date:   Tue, 16 Mar 2021 15:41:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210316130131.11792-1-mreitz@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_04:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160094
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/16/21 3:01 PM, Max Reitz wrote:
> As documented in Documentation/filesystems/virtiofs.rst (in the Linux
> tree), virtiofs ignores atime-related mount options.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

The change is correct.

Reviewed-by: Vladimir Zapolskiy <vladimir@tuxera.com>

--
Best wishes,
Vladimir
