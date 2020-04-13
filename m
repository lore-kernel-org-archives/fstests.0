Return-Path: <SRS0=mI6p=55=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB1C2BA19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B0120737
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Apr 2020 07:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B0120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=fstests-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgDMHXm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDMHXl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Apr 2020 03:23:41 -0400
Received: from mgw-02.mpynet.fi (mgw-02.mpynet.fi [82.197.21.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D0C008651
        for <fstests@vger.kernel.org>; Mon, 13 Apr 2020 00:23:41 -0700 (PDT)
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 03D7NVY0090193;
        Mon, 13 Apr 2020 10:23:31 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 30b1k1j3f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 10:23:31 +0300
Received: from [192.168.10.55] (88.112.128.128) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Apr
 2020 10:23:30 +0300
Subject: Re: [PATCH 0/4] Assign a few generic tests to additional groups
To:     Eryu Guan <guan@eryu.me>
CC:     Eryu Guan <guaneryu@gmail.com>, <fstests@vger.kernel.org>
References: <20200408135648.5824-1-vladimir@tuxera.com>
 <20200412111601.GA3923113@desktop>
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
Message-ID: <17e5fc18-8f08-3048-9378-b7b390ec31a5@tuxera.com>
Date:   Mon, 13 Apr 2020 10:23:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200412111601.GA3923113@desktop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.112.128.128]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_02:2020-04-12,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=875 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130065
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 4/12/20 2:16 PM, Eryu Guan wrote:
> On Wed, Apr 08, 2020 at 04:56:44PM +0300, Vladimir Zapolskiy wrote:
>> The rationale behind the proposed changes is to correct and improve
>> granularity of some generic tests, so it becomes possible to control
>> lists of run tests better, if there is given additional information
>> about a test environment and tested filesystems.
> 
> Thanks for doing this! I think we could group these changes in a single
> patch. Could you please resend with a single patch that does all the
> group changes?

Sure, will do.

Thank you for review!

--
Best wishes,
Vladimir
